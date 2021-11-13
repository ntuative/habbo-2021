package com.sulake.habbo.avatar
{
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.avatar.alias.AssetAliasCollection;
    import flash.display.BitmapData;

    public class PlaceholderAvatarImage extends AvatarImage 
    {

        internal static var _fullImageCache:Map = new Map();

        public function PlaceholderAvatarImage(_arg_1:AvatarStructure, _arg_2:AssetAliasCollection, _arg_3:AvatarFigureContainer, _arg_4:String, _arg_5:EffectAssetDownloadManager)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, null);
        }

        override public function dispose():void
        {
            if (!_SafeStr_1381)
            {
                if (_cache)
                {
                    _cache.dispose();
                    _cache = null;
                };
                _SafeStr_462 = null;
                _assets = null;
                _mainAction = null;
                _SafeStr_1382 = null;
                _SafeStr_1383 = null;
                _SafeStr_701 = null;
                if (((!(_SafeStr_1393)) && (_SafeStr_1384)))
                {
                    _SafeStr_1384.dispose();
                };
                _SafeStr_1384 = null;
                _SafeStr_1245 = null;
                _SafeStr_1381 = true;
            };
        }

        override protected function getFullImage(_arg_1:String):BitmapData
        {
            return (_fullImageCache[_arg_1]);
        }

        override protected function cacheFullImage(_arg_1:String, _arg_2:BitmapData):void
        {
            if (_fullImageCache.getValue(_arg_1))
            {
                (_fullImageCache.getValue(_arg_1) as BitmapData).dispose();
                _fullImageCache.remove(_arg_1);
            };
            _fullImageCache[_arg_1] = _arg_2;
        }

        override public function appendAction(_arg_1:String, ... _args):Boolean
        {
            var _local_3:String;
            if (((!(_args == null)) && (_args.length > 0)))
            {
                _local_3 = _args[0];
            };
            switch (_arg_1)
            {
                case "posture":
                    switch (_local_3)
                    {
                        case "lay":
                        case "mv":
                        case "std":
                        case "swim":
                        case "float":
                        case "sit":
                            super.appendAction.apply(null, [_arg_1].concat(_args));
                    };
                    break;
                case "fx":
                case "dance":
                case "wave":
                case "sign":
                case "cri":
                case "usei":
                case "blow":
                    super.addActionData.apply(null, [_arg_1].concat(_args));
            };
            return (true);
        }

        override public function isPlaceholder():Boolean
        {
            return (true);
        }


    }
}

