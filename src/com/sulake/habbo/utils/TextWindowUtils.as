package com.sulake.habbo.utils
{
    import flash.text.StyleSheet;
    import com.sulake.core.window.components.ITextWindow;

    public class TextWindowUtils 
    {


        public static function setHTMLLinkStyle(_arg_1:ITextWindow, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:Boolean=true):void
        {
            if (!_arg_1)
            {
                return;
            };
            var _local_10:StyleSheet = new StyleSheet();
            var _local_6:Object = {};
            _local_6.color = toHexString(_arg_2);
            var _local_7:Object = {};
            if (_arg_5)
            {
                _local_7.textDecoration = "underline";
            };
            _local_7.color = toHexString(_arg_3);
            var _local_9:Object = {};
            _local_9.color = toHexString(_arg_4);
            var _local_8:Object = {};
            _local_8.textDecoration = "underline";
            _local_10.setStyle("a:link", _local_7);
            _local_10.setStyle("a:hover", _local_6);
            _local_10.setStyle("a:active", _local_9);
            _local_10.setStyle(".visited", _local_8);
            _arg_1.styleSheet = _local_10;
        }

        public static function toHexString(_arg_1:uint):String
        {
            var _local_2:String = _arg_1.toString(16);
            while (_local_2.length < 6)
            {
                _local_2 = ("0" + _local_2);
            };
            return ("#" + _local_2);
        }


    }
}