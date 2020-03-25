//
//  LMURLProtocol.m
//  MainApp
//
//  Created by apple on 2019/11/6.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LMURLProtocol.h"

@interface LMURLProtocol()
@property (nonatomic, strong) NSURLSessionDataTask *sessionTask;
@property (nonatomic, strong) NSString* injectionJavaScriptContent;
@end

static id<NSURLSessionDataDelegate> sDelegate;

NSString* const URLProtocolHandledKey  = @"URLProtocolHandledKey";

@implementation LMURLProtocol

+ (NSURLSession*) sharedSession {
    
    static dispatch_once_t onceToken;
    static NSURLSession *staticSharedSession;
    dispatch_once( &onceToken, ^{
        staticSharedSession = [NSURLSession sessionWithConfiguration:NSURLSessionConfiguration.defaultSessionConfiguration];
    });
    
    return staticSharedSession;
}

+ (BOOL) canInitWithRequest:(NSURLRequest *)request {
        
    NSString *scheme = [[request URL] scheme];
    
    if ( [scheme caseInsensitiveCompare:@"http"] == NSOrderedSame ||
         [scheme caseInsensitiveCompare:@"https"] == NSOrderedSame ) {
        return YES;
    }
    
    return NO;
}

+ (NSURLRequest *) canonicalRequestForRequest:(NSURLRequest *)request {
    return request;
}

- (instancetype) initWithRequest:(NSURLRequest *)request cachedResponse:(NSCachedURLResponse *)cachedResponse client:(id<NSURLProtocolClient>)client {
    
    self = [super initWithRequest:request cachedResponse:cachedResponse client:client];
    
    return self;
}

- (void) startLoading {

    NSLog(@"LMURLProtocol");
    
    NSMutableURLRequest *mutableRequest = self.request.mutableCopy;
    
    [NSURLProtocol setProperty:@YES forKey:URLProtocolHandledKey inRequest:mutableRequest];
    
    self.sessionTask = [LMURLProtocol.sharedSession dataTaskWithRequest:mutableRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       
        if (!error) {
            
            [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageAllowedInMemoryOnly];
            
//            if ( [response.MIMEType isEqualToString:@"text/html"] ) {
//
//                NSMutableString *htmlContent = [[NSMutableString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//                NSRange headTagRange = [htmlContent rangeOfString:@"</head>" options:0];
//
//                if ( headTagRange.location != NSNotFound ) {
//
//                    printf("Injection To URL: %s\n", mutableRequest.URL.absoluteString.UTF8String);
//
//                    [htmlContent insertString:self.injectionJavaScriptContent atIndex:headTagRange.location];
//                    [self.client URLProtocol:self didLoadData: [htmlContent dataUsingEncoding:NSUTF8StringEncoding]];
//
//                } else {
//
//                    [self.client URLProtocol:self didLoadData:data];
//                }
//
//            } else {
            
//            }
            
            [self.client URLProtocolDidFinishLoading:self];
        }
        
    }];
    
    [self.sessionTask resume];
}

- (void) stopLoading {
    
    [self.sessionTask suspend];
}

@end
