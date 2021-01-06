/*
 This file is part of web3.js.

 web3.js is free software: you can redistribute it and/or modify
 it under the terms of the GNU Lesser General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.

 web3.js is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU Lesser General Public License for more details.

 You should have received a copy of the GNU Lesser General Public License
 along with web3.js.  If not, see <http://www.gnu.org/licenses/>.
 */
/** @file WebsocketProvider.js
 * @authors:
 *   Fabian Vogelsteller <fabian@ethereum.org>
 * @date 2017
 * @modify : LMCoreSDK Project Team 2019-11-18
 */

"use strict";

var _ = require('underscore');
var errors = require('web3-core-helpers').errors;
var Ws = require('websocket').w3cwebsocket;

var isNode = Object.prototype.toString.call(typeof process !== 'undefined' ? process : 0) === '[object process]';

var _btoa = null;
var parseURL = null;
if (isNode) {
    _btoa = function(str) {
        return Buffer.from(str).toString('base64');
    };
    var url = require('url');
    if (url.URL) {
        // Use the new Node 6+ API for parsing URLs that supports username/password
        var newURL = url.URL;
        parseURL = function(url) {
            return new newURL(url);
        };
    } else {
        // Web3 supports Node.js 5, so fall back to the legacy URL API if necessary
        parseURL = require('url').parse;
    }
} else {
    _btoa = btoa;
    parseURL = function(url) {
        return new URL(url);
    };
}
// Default connection ws://localhost:8546




var WebsocketProvider = function WebsocketProvider(url, options) {
    if (!Ws) {
        throw new Error('websocket is not available');
    }

    var _this = this;
    this.responseCallbacks = {};
    this.notificationCallbacks = [];

    options = options || {};
    this._customTimeout = options.timeout;

    // The w3cwebsocket implementation does not support Basic Auth
    // username/password in the URL. So generate the basic auth header, and
    // pass through with any additional headers supplied in constructor
    var parsedURL = parseURL(url);
    var headers = options.headers || {};
    var protocol = options.protocol || undefined;
    if (parsedURL.username && parsedURL.password) {
        headers.authorization = 'Basic ' + _btoa(parsedURL.username + ':' + parsedURL.password);
    }

    // Allow a custom client configuration
    var clientConfig = options.clientConfig || undefined;

    // Allow a custom request options
    // https://github.com/theturtle32/WebSocket-Node/blob/master/docs/WebSocketClient.md#connectrequesturl-requestedprotocols-origin-headers-requestoptions
    var requestOptions = options.requestOptions || undefined;

    // When all node core implementations that do not have the
    // WHATWG compatible URL parser go out of service this line can be removed.
    if (parsedURL.auth) {
        headers.authorization = 'Basic ' + _btoa(parsedURL.auth);
    }
    this.connection = new Ws(url, protocol, undefined, headers, requestOptions, clientConfig);

    this.addDefaultEvents();


    // LISTEN FOR CONNECTION RESPONSES
    this.connection.onmessage = function(e) {
        /*jshint maxcomplexity: 6 */
        var data = (typeof e.data === 'string') ? e.data : '';

        _this._parseResponse(data).forEach(function(result) {

            var id = null;

            // get the id which matches the returned id
            if (_.isArray(result)) {
                result.forEach(function(load) {
                    if (_this.responseCallbacks[load.id])
                        id = load.id;
                });
            } else {
                id = result.id;
            }

            // notification
            if (!id && result && result.method && result.method.indexOf('_subscription') !== -1) {
                _this.notificationCallbacks.forEach(function(callback) {
                    if (_.isFunction(callback))
                        callback(result);
                });

                // fire the callback
            } else if (_this.responseCallbacks[id]) {
                _this.responseCallbacks[id](null, result);
                delete _this.responseCallbacks[id];
            }
        });
    };

    // make property `connected` which will return the current connection status
    Object.defineProperty(this, 'connected', {
        get: function() {
            return this.connection && this.connection.readyState === this.connection.OPEN;
        },
        enumerable: true,
    });
};

/**
 Will add the error and end event to timeout existing calls

 @method addDefaultEvents
 */
WebsocketProvider.prototype.addDefaultEvents = function() {
    var _this = this;

    this.connection.onerror = function() {
        _this._timeout();
    };

    this.connection.onclose = function() {
        _this._timeout();

        // reset all requests and callbacks
        _this.reset();
    };

    // this.connection.on('timeout', function(){
    //     _this._timeout();
    // });
};

/**
 Will parse the response and make an array out of it.

 @method _parseResponse
 @param {String} data
 */
WebsocketProvider.prototype._parseResponse = function(data) {
    var _this = this,
        returnValues = [];

    // DE-CHUNKER
    var dechunkedData = data
        .replace(/\}[\n\r]?\{/g, '}|--|{') // }{
        .replace(/\}\][\n\r]?\[\{/g, '}]|--|[{') // }][{
        .replace(/\}[\n\r]?\[\{/g, '}|--|[{') // }[{
        .replace(/\}\][\n\r]?\{/g, '}]|--|{') // }]{
        .split('|--|');

    dechunkedData.forEach(function(data) {

        // prepend the last chunk
        if (_this.lastChunk)
            data = _this.lastChunk + data;

        var result = null;

        try {
            result = JSON.parse(data);

        } catch (e) {

            _this.lastChunk = data;

            // start timeout to cancel all requests
            clearTimeout(_this.lastChunkTimeout);
            _this.lastChunkTimeout = setTimeout(function() {
                _this._timeout();
                throw errors.InvalidResponse(data);
            }, 1000 * 15);

            return;
        }

        // cancel timeout and set chunk to null
        clearTimeout(_this.lastChunkTimeout);
        _this.lastChunk = null;

        if (result)
            returnValues.push(result);
    });

    return returnValues;
};


/**
 Adds a callback to the responseCallbacks object,
 which will be called if a response matching the response Id will arrive.

 @method _addResponseCallback
 */
WebsocketProvider.prototype._addResponseCallback = function(payload, callback) {
    var id = payload.id || payload[0].id;
    var method = payload.method || payload[0].method;

    this.responseCallbacks[id] = callback;
    this.responseCallbacks[id].method = method;

    var _this = this;

    // schedule triggering the error response if a custom timeout is set
    if (this._customTimeout) {
        setTimeout(function() {
            if (_this.responseCallbacks[id]) {
                _this.responseCallbacks[id](errors.ConnectionTimeout(_this._customTimeout));
                delete _this.responseCallbacks[id];
            }
        }, this._customTimeout);
    }
};

/**
 Timeout all requests when the end/error event is fired

 @method _timeout
 */
WebsocketProvider.prototype._timeout = function() {
    for (var key in this.responseCallbacks) {
        if (this.responseCallbacks.hasOwnProperty(key)) {
            this.responseCallbacks[key](errors.InvalidConnection('on WS'));
            delete this.responseCallbacks[key];
        }
    }
};


WebsocketProvider.prototype.send = function(payload, callback) {

    var _this = this;

    if (this.connection.readyState === this.connection.CONNECTING) {
        setTimeout(function() {
            _this.send(payload, callback);
        }, 10);
        return;
    }

    // try reconnect, when connection is gone
    // if(!this.connection.writable)
    //     this.connection.connect({url: this.url});
    if ( this.connection.readyState !== this.connection.OPEN ) {
        console.error('connection not open on send()');
        if (typeof this.connection.onerror === 'function') {
            this.connection.onerror(new Error('connection not open'));
        } else {
            console.error('no error callback');
        }
        callback(new Error('connection not open'));
        return;
    }

    if ( payload.method === "eth_sendTransaction" && typeof(callback) === "function" ) {

        var callbackID = "rpc_" + (new Date().getTime()).toString();

        _this.requestCallbacks[callbackID] = (err, result) => {

            if (err) {
                callback(e, null);
            } else {
                payload.method = "eth_sendRawTransaction";
                payload.params = [result];
                try {

                    _this.connection.send( JSON.stringify(payload) );
                    _this._addResponseCallback( payload, callback );

                } catch (error) {
                    callback(error);
                }
            }
        }

        xw_listen_eth_sendTransaction.postMessage(JSON.stringify({
            cbid: callbackID,
            payload: payload
        }));

        return;

    } else if ( payload.method === "eth_sign" && typeof(callback) === "function") {

        var success = function(rawTx) {
            callback(null, {
                id: payload.id,
                jsonrpc: payload.jsonrpc,
                result: rawTx
            })
        }

        var fail = function(e) {
            callback(e, null)
        }

        _xw_listen_eth_sign.postMessage(JSON.stringify(payload));

        return;

    } else {

        this.connection.send(JSON.stringify(payload));
        this._addResponseCallback(payload, callback);
    }
};

/**
 Subscribes to provider events.provider

 @method on
 @param {String} type    'notifcation', 'connect', 'error', 'end' or 'data'
 @param {Function} callback   the callback to call
 */
WebsocketProvider.prototype.on = function(type, callback) {

    if (typeof callback !== 'function')
        throw new Error('The second parameter callback must be a function.');

    switch (type) {
        case 'data':
            this.notificationCallbacks.push(callback);
            break;

        case 'connect':
            this.connection.onopen = callback;
            break;

        case 'end':
            this.connection.onclose = callback;
            break;

        case 'error':
            this.connection.onerror = callback;
            break;

        case 'accountsChanged':
            this._eventObservers.push({
                name: type,
                fun: callback
            })
            break;

        case 'networkChanged':
            this._eventObservers.push({
                name: type,
                fun: callback
            })
            break;
    }
};

// TODO add once

/**
 Removes event listener

 @method removeListener
 @param {String} type    'notifcation', 'connect', 'error', 'end' or 'data'
 @param {Function} callback   the callback to call
 */
WebsocketProvider.prototype.removeListener = function(type, callback) {
    var _this = this;

    switch (type) {
        case 'data':
            this.notificationCallbacks.forEach(function(cb, index) {
                if (cb === callback)
                    _this.notificationCallbacks.splice(index, 1);
            });
            break;

            // TODO remvoving connect missing

            // default:
            //     this.connection.removeListener(type, callback);
            //     break;
    }
};

/**
 Removes all event listeners

 @method removeAllListeners
 @param {String} type    'notifcation', 'connect', 'error', 'end' or 'data'
 */
WebsocketProvider.prototype.removeAllListeners = function(type) {
    switch (type) {
        case 'data':
            this.notificationCallbacks = [];
            break;

            // TODO remvoving connect properly missing

        case 'connect':
            this.connection.onopen = null;
            break;

        case 'end':
            this.connection.onclose = null;
            break;

        case 'error':
            this.connection.onerror = null;
            break;

        default:

            break;
    }
};

/**
 Resets the providers, clears all callbacks

 @method reset
 */
WebsocketProvider.prototype.reset = function() {
    this._timeout();
    this.notificationCallbacks = [];

    // this.connection.removeAllListeners('error');
    // this.connection.removeAllListeners('end');
    // this.connection.removeAllListeners('timeout');

    this.addDefaultEvents();
};

WebsocketProvider.prototype.disconnect = function() {
    if (this.connection) {
        this.connection.close();
    }
};

WebsocketProvider.prototype.enable = function() {
    var _this = this;
    return new Promise(function(resolve, reject) {
        var success = function(address) {
            _this.selectedAddress = address[0];
            window.web3.eth.defaultAccount = address[0];
            window.web3.eth.accounts = address;
            resolve(address);
        }
        if (window.lmdapp.lmt === 'ethereum') {
            plus.bridge.exec("LMETH", "enable", [plus.bridge.callbackId(success, reject)])
        } else {
            reject("not in lmwallet")
        }
    })
}

WebsocketProvider.prototype.isMetaMask = true;
WebsocketProvider.prototype.isLimoWallet = true;
WebsocketProvider.prototype.autoRefreshOnNetworkChange = true;
WebsocketProvider.prototype._eventObservers = [];
/// accountsChanged, returns updated account array.
/// networkChanged, returns network ID string.
WebsocketProvider.prototype._emitEvent = function(eventName, ...objs) {
    for (var index in this._eventObservers) {
        var observer = this._eventObservers[index];
        if (observer.name === eventName) {
            observer.fun(objs)
        }
    }
}

WebsocketProvider.prototype.on("networkChanged", function(netid) {
    if (this.autoRefreshOnNetworkChange === true) {
        window.location.reload()
    }
})

module.exports = WebsocketProvider;
window.WebsocketProvider = WebsocketProvider;
