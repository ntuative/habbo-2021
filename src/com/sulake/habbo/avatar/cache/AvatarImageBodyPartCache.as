package com.sulake.habbo.avatar.cache
{
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.avatar.actions.IActiveActionData;

    public class AvatarImageBodyPartCache 
    {

        private var _cache:Map;
        private var _currentAction:IActiveActionData;
        private var _currentDirection:int;
        private var _disposed:Boolean;

        public function AvatarImageBodyPartCache()
        {
            _cache = new Map();
        }

        public function setAction(_arg_1:IActiveActionData, _arg_2:int):void
        {
            if (_currentAction == null)
            {
                _currentAction = _arg_1;
            };
            var _local_3:AvatarImageActionCache = getActionCache(_currentAction);
            if (_local_3 != null)
            {
                _local_3.setLastAccessTime(_arg_2);
            };
            _currentAction = _arg_1;
        }

        public function dispose():void
        {
            if (!_disposed)
            {
                if (_cache == null)
                {
                    return;
                };
                if (_cache)
                {
                    disposeActions(0, 2147483647);
                    _cache.dispose();
                    _cache = null;
                };
                _disposed = true;
            };
        }

        public function disposeActions(_arg_1:int, _arg_2:int):void
        {
            var _local_3:int;
            var _local_5:AvatarImageActionCache;
            var _local_6:String;
            if (((_cache == null) || (_disposed)))
            {
                return;
            };
            var _local_4:Array = _cache.getKeys();
            for each (_local_6 in _local_4)
            {
                _local_5 = (_cache.getValue(_local_6) as AvatarImageActionCache);
                if (_local_5 != null)
                {
                    _local_3 = _local_5.getLastAccessTime();
                    if ((_arg_2 - _local_3) >= _arg_1)
                    {
                        _local_5.dispose();
                        _cache.remove(_local_6);
                    };
                };
            };
        }

        public function getAction():IActiveActionData
        {
            return (_currentAction);
        }

        public function setDirection(_arg_1:int):void
        {
            _currentDirection = _arg_1;
        }

        public function getDirection():int
        {
            return (_currentDirection);
        }

        public function getActionCache(_arg_1:IActiveActionData=null):AvatarImageActionCache
        {
            if (!_currentAction)
            {
                return (null);
            };
            if (_arg_1 == null)
            {
                _arg_1 = _currentAction;
            };
            if (_arg_1.overridingAction != null)
            {
                return (_cache.getValue(_arg_1.overridingAction) as AvatarImageActionCache);
            };
            return (_cache.getValue(_arg_1.id) as AvatarImageActionCache);
        }

        public function updateActionCache(_arg_1:IActiveActionData, _arg_2:AvatarImageActionCache):void
        {
            if (_arg_1.overridingAction != null)
            {
                _cache.add(_arg_1.overridingAction, _arg_2);
            }
            else
            {
                _cache.add(_arg_1.id, _arg_2);
            };
        }

        private function debugInfo(_arg_1:String):void
        {
        }


    }
}