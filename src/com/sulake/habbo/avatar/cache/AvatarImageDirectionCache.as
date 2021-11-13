package com.sulake.habbo.avatar.cache
{
    import __AS3__.vec.Vector;
    import com.sulake.habbo.avatar.AvatarImagePartContainer;
    import flash.utils.Dictionary;
    import com.sulake.habbo.avatar.AvatarImageBodyPartContainer;

    public class AvatarImageDirectionCache 
    {

        private static const KEY_SEPARATOR:String = "/";
        private static const _SafeStr_1272:String = "-";

        private var _SafeStr_1273:Vector.<AvatarImagePartContainer>;
        private var _SafeStr_1274:Dictionary;
        private var _keyCache:Dictionary;

        public function AvatarImageDirectionCache(_arg_1:Vector.<AvatarImagePartContainer>)
        {
            _SafeStr_1274 = new Dictionary();
            _SafeStr_1273 = _arg_1;
            _keyCache = new Dictionary();
        }

        public function dispose():void
        {
            for each (var _local_1:AvatarImageBodyPartContainer in _SafeStr_1274)
            {
                if (_local_1)
                {
                    _local_1.dispose();
                };
            };
            _SafeStr_1274 = null;
            _SafeStr_1273 = null;
            _keyCache = null;
        }

        public function getPartList():Vector.<AvatarImagePartContainer>
        {
            return (_SafeStr_1273);
        }

        public function getImageContainer(_arg_1:int):AvatarImageBodyPartContainer
        {
            var _local_2:String = getCacheKey(_arg_1);
            return (_SafeStr_1274[_local_2]);
        }

        public function updateImageContainer(_arg_1:AvatarImageBodyPartContainer, _arg_2:int):void
        {
            var _local_4:AvatarImageBodyPartContainer;
            var _local_3:String = getCacheKey(_arg_2);
            if (_SafeStr_1274[_local_3])
            {
                _local_4 = (_SafeStr_1274[_local_3] as AvatarImageBodyPartContainer);
                if (_local_4)
                {
                    _local_4.dispose();
                };
            };
            _SafeStr_1274[_local_3] = _arg_1;
        }

        private function getCacheKey(_arg_1:int):String
        {
            var _local_4:int;
            if (((_SafeStr_1273 == null) || (_SafeStr_1273.length == 0)))
            {
                return ("-");
            };
            var _local_2:String = _keyCache[_arg_1];
            if (_local_2)
            {
                return (_local_2);
            };
            var _local_5:AvatarImagePartContainer = (_SafeStr_1273[0] as AvatarImagePartContainer);
            _local_2 = _local_5.getCacheableKey(_arg_1);
            var _local_3:int = _SafeStr_1273.length;
            _local_4 = 1;
            while (_local_4 < _local_3)
            {
                _local_5 = (_SafeStr_1273[_local_4] as AvatarImagePartContainer);
                _local_2 = (_local_2 + ("/" + _local_5.getCacheableKey(_arg_1)));
                _local_4++;
            };
            _keyCache[_arg_1] = _local_2;
            return (_local_2);
        }


    }
}

