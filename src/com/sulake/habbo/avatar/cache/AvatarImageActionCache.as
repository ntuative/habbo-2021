package com.sulake.habbo.avatar.cache
{
    import com.sulake.core.utils.Map;
    import flash.utils.getTimer;

    public class AvatarImageActionCache 
    {

        private var _cache:Map;
        private var _lastAccessTime:int;

        public function AvatarImageActionCache()
        {
            _cache = new Map();
            setLastAccessTime(getTimer());
        }

        public function dispose():void
        {
            debugInfo("[dispose]");
            if (_cache == null)
            {
                return;
            };
            for each (var _local_1:AvatarImageDirectionCache in _cache)
            {
                _local_1.dispose();
            };
            _cache.dispose();
        }

        public function getDirectionCache(_arg_1:int):AvatarImageDirectionCache
        {
            var _local_2:String = _arg_1.toString();
            return (_cache.getValue(_local_2) as AvatarImageDirectionCache);
        }

        public function updateDirectionCache(_arg_1:int, _arg_2:AvatarImageDirectionCache):void
        {
            var _local_3:String = _arg_1.toString();
            _cache.add(_local_3, _arg_2);
        }

        public function setLastAccessTime(_arg_1:int):void
        {
            _lastAccessTime = _arg_1;
        }

        public function getLastAccessTime():int
        {
            return (_lastAccessTime);
        }

        private function debugInfo(_arg_1:String):void
        {
        }


    }
}