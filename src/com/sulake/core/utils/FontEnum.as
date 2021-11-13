package com.sulake.core.utils
{
    import flash.text.Font;
    import flash.utils.getQualifiedClassName;

    public class FontEnum 
    {

        private static const _systemFonts:Map = new Map();
        private static const _embeddedFonts:Map = new Map();

        private static var _SafeStr_868:Boolean = false;

        {
            init();
        }


        public static function isSystemFont(_arg_1:String):Boolean
        {
            return (!(_systemFonts.getValue(_arg_1) == null));
        }

        public static function isEmbeddedFont(_arg_1:String):Boolean
        {
            return (!(_embeddedFonts.getValue(_arg_1) == null));
        }

        public static function get systemFonts():Map
        {
            return (_systemFonts);
        }

        public static function get embeddedFonts():Map
        {
            return (_embeddedFonts);
        }

        public static function registerFont(_arg_1:Class):Font
        {
            var _local_2:Font;
            var _local_5:int;
            Font.registerFont((_arg_1 as Class));
            var _local_3:String = getQualifiedClassName(_arg_1);
            var _local_6:Array = Font.enumerateFonts(false);
            var _local_4:int = _local_6.length;
            _local_5 = _local_4;
            while (_local_5 > 0)
            {
                _local_2 = _local_6[(_local_5 - 1)];
                if (getQualifiedClassName(_local_2) == _local_3) break;
                _local_5--;
            };
            _embeddedFonts.add(_local_2.fontName, _local_2);
            return (_local_2);
        }

        private static function init():void
        {
            var _local_2:Array;
            var _local_1:Array;
            if (!_SafeStr_868)
            {
                _local_2 = Font.enumerateFonts(true);
                _local_1 = Font.enumerateFonts(false);
                for each (var _local_3:Font in _local_2)
                {
                    if (_local_1.indexOf(_local_3) == -1)
                    {
                        _systemFonts.add(_local_3.fontName, _local_3);
                    };
                };
                _SafeStr_868 = true;
            };
        }

        public static function refresh():void
        {
            var _local_1:Font;
            var _local_5:Font;
            var _local_3:int;
            var _local_4:Array = Font.enumerateFonts(false);
            var _local_2:int = _local_4.length;
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _local_1 = _local_4[_local_3];
                _local_5 = _embeddedFonts.getValue(_local_1.fontName);
                if ((((!(_local_5)) || (!(_local_5.fontType == _local_1.fontType))) || (!(_local_5.fontStyle == _local_1.fontStyle))))
                {
                    _embeddedFonts.add(_local_1.fontName, _local_1);
                };
                _local_3++;
            };
        }


    }
}

