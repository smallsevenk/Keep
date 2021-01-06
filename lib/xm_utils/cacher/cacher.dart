typedef V CacherCreateFunction<K, V>(K key, [dynamic userInfo]);

class Cacher<K,V> {

    Map<K, V> _cache = Map();

    CacherCreateFunction<K,V> createFunction;

    // 判断是否存在
    bool contains(K key) => _cache.containsKey(key) && _cache[key] != null;

    // 直接读取
    V operator [](K key) => getCache(key);

    V getCache(K key) {
        if ( !contains(key) && createFunction != null ) {
            _cache[key] = createFunction(key);
        }

        return _cache[key];
    }

    void setCache(K key, V value) {
        _cache[key] = value;
    }

    // 设置过期，实则是删除
    void expire(K key) => _cache.remove(key);

    // 删除全部
    void expireAll() => _cache.clear();
}
