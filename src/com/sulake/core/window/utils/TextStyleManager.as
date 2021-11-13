package com.sulake.core.window.utils
{
    import com.sulake.core.utils.Map;
    import flash.events.IEventDispatcher;
    import com.sulake.core.runtime.events.EventDispatcherWrapper;
    import flash.events.Event;
    import flash.text.StyleSheet;

    public class TextStyleManager 
    {

        public static const REGULAR:String = "regular";
        public static const ITALIC:String = "italic";
        public static const BOLD:String = "bold";
        private static const TAG_OPEN:String = "{";
        private static const TAG_CLOSE:String = "}";
        private static const CMT_OPEN:String = "/*";
        private static const CMT_CLOSE:String = "*/";

        private static var _SafeStr_1204:Map;
        private static var _SafeStr_1205:Array;
        private static var _events:IEventDispatcher;

        {
            init();
        }


        public static function get events():IEventDispatcher
        {
            return (_events);
        }

        private static function init():void
        {
            var _local_1:_SafeStr_177;
            _SafeStr_1204 = new Map();
            _SafeStr_1205 = [];
            _events = new EventDispatcherWrapper();
            _local_1 = new _SafeStr_177();
            _local_1.name = "regular";
            _local_1.color = 0;
            _local_1.fontSize = "9";
            _local_1.fontFamily = "Courier";
            _local_1.fontStyle = "normal";
            _local_1.fontWeight = "normal";
            _SafeStr_1204[_local_1.name] = _local_1;
            _SafeStr_1205.push(_local_1.name);
            _local_1 = new _SafeStr_177();
            _local_1.name = "italic";
            _local_1.color = 0;
            _local_1.fontSize = "9";
            _local_1.fontFamily = "Courier";
            _local_1.fontStyle = "italic";
            _local_1.fontWeight = "normal";
            _SafeStr_1204[_local_1.name] = _local_1;
            _SafeStr_1205.push(_local_1.name);
            _local_1 = new _SafeStr_177();
            _local_1.name = "bold";
            _local_1.color = 0;
            _local_1.fontSize = "9";
            _local_1.fontFamily = "Courier";
            _local_1.fontStyle = "normal";
            _local_1.fontWeight = "bold";
            _SafeStr_1204[_local_1.name] = _local_1;
            _SafeStr_1205.push(_local_1.name);
        }

        public static function getStyle(_arg_1:String):_SafeStr_177
        {
            return (_SafeStr_1204[_arg_1]);
        }

        public static function getStyleWithIndex(_arg_1:int):_SafeStr_177
        {
            return (_SafeStr_1204.getWithIndex(_arg_1));
        }

        public static function setStyle(_arg_1:String, _arg_2:_SafeStr_177):void
        {
            var _local_3:Boolean = (!(_SafeStr_1204.hasKey(_arg_1)));
            _arg_2.name = _arg_1;
            _SafeStr_1204[_arg_1] = _arg_2;
            if (_local_3)
            {
                _SafeStr_1205.push(_arg_1);
                _events.dispatchEvent(new Event("added"));
            }
            else
            {
                _events.dispatchEvent(new Event("change"));
            };
        }

        public static function setStyles(_arg_1:Array, _arg_2:Boolean=false):void
        {
            var _local_3:Array;
            if (_arg_2)
            {
                _local_3 = [_SafeStr_1204["regular"], _SafeStr_1204["italic"], _SafeStr_1204["bold"]];
                _SafeStr_1204.reset();
                _SafeStr_1204["regular"] = _local_3[0];
                _SafeStr_1204["italic"] = _local_3[1];
                _SafeStr_1204["bold"] = _local_3[2];
            };
            var _local_4:int = _SafeStr_1204.length;
            for each (var _local_5:_SafeStr_177 in _arg_1)
            {
                _SafeStr_1204[_local_5.name] = _local_5;
                if (_SafeStr_1205.indexOf(_local_5.name) == -1)
                {
                    _SafeStr_1205.push(_local_5.name);
                };
            };
            _events.dispatchEvent(new Event("change"));
            if (_SafeStr_1204.length != _local_4)
            {
                _events.dispatchEvent(new Event("added"));
            };
        }

        public static function findMatchingTextStyle(_arg_1:String):_SafeStr_177
        {
            var _local_2:_SafeStr_177;
            var _local_3:_SafeStr_177 = (parseCSS(_arg_1)[0] as _SafeStr_177);
            if (_local_3)
            {
                _local_2 = _SafeStr_1204[_local_3.name];
                if (((_local_2) && (_local_2.equals(_local_3))))
                {
                    return (_local_2);
                };
            };
            return (null);
        }

        public static function enumerateStyles():Array
        {
            var _local_3:int;
            var _local_1:Array = [];
            var _local_2:int = _SafeStr_1204.length;
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _local_1.push(_SafeStr_1204.getWithIndex(_local_3));
                _local_3++;
            };
            return (_local_1);
        }

        public static function enumerateStyleNames():Array
        {
            return (_SafeStr_1204.getKeys());
        }

        public static function getStyleNameArrayRef():Array
        {
            return (_SafeStr_1205);
        }

        public static function parseCSS(_arg_1:String):Array
        {
            var _local_7:Object;
            var _local_6:_SafeStr_177;
            var _local_5:StyleSheet = new StyleSheet();
            _local_5.parseCSS(_arg_1);
            var _local_3:Array = parseStyleNamesFromCSS(_arg_1);
            var _local_2:Array = [];
            for each (var _local_4:String in _local_3)
            {
                _local_7 = _local_5.getStyle(_local_4);
                _local_6 = new _SafeStr_177();
                _local_6.name = _local_4;
                _local_6.color = ((_local_7.color) ? _local_7.color.replace("#", "0x") : null);
                _local_6.fontFamily = ((_local_7.fontFamily) ? _local_7.fontFamily : null);
                _local_6.fontSize = ((_local_7.fontSize) ? parseInt(_local_7.fontSize) : null);
                _local_6.fontStyle = ((_local_7.fontStyle) ? _local_7.fontStyle : null);
                _local_6.fontWeight = ((_local_7.fontWeight) ? _local_7.fontWeight : null);
                _local_6.kerning = ((_local_7.kerning) ? (_local_7.kerning == "true") : null);
                _local_6.leading = ((_local_7.leading) ? parseInt(_local_7.leading) : null);
                _local_6.letterSpacing = ((_local_7.letterSpacing) ? parseInt(_local_7.letterSpacing.toString()) : null);
                _local_6.textDecoration = ((_local_7.textDecoration) ? _local_7.textDecoration : null);
                _local_6.textIndent = ((_local_7.textIndent) ? parseInt(_local_7.textIndent.toString()) : null);
                _local_6.antiAliasType = ((_local_7.antiAliasType) ? _local_7.antiAliasType : null);
                _local_6.sharpness = ((_local_7.sharpness) ? parseInt(_local_7.sharpness) : null);
                _local_6.thickness = ((_local_7.thickness) ? parseInt(_local_7.thickness) : null);
                _local_6.etchingColor = ((_local_7.etchingColor) ? _local_7.etchingColor.replace("#", "0x") : null);
                _local_6.etchingPosition = ((_local_7.etchingPosition) ? _local_7.etchingPosition : null);
                _local_2.push(_local_6);
            };
            return (_local_2);
        }

        private static function parseStyleNamesFromCSS(_arg_1:String):Array
        {
            var _local_2:Array = [];
            var _local_3:String = _arg_1;
            _local_3 = _local_3.split("\t").join("");
            _local_3 = _local_3.split("\n").join("");
            _local_3 = _local_3.split("\r").join("");
            var _local_4:Array = _local_3.split("}");
            if (countSubStrings(_arg_1, "{") != countSubStrings(_arg_1, "}"))
            {
                throw (new Error('Mismatching amount of "{" versus "}", please check the CSS!'));
            };
            for each (var _local_5:String in _local_4)
            {
                while (true)
                {
                    if (_local_5.indexOf("/*") == 0)
                    {
                        _local_5 = _local_5.substring((_local_5.indexOf("*/") + 2), _local_5.length);
                    }
                    else
                    {
                        break;
                    };
                };
                _local_5 = _local_5.slice(0, _local_5.indexOf("{")).split(" ").join("");
                if (_local_5.length)
                {
                    _local_2.push(_local_5);
                };
            };
            return (_local_2);
        }

        private static function countSubStrings(_arg_1:String, _arg_2:String):int
        {
            var _local_3:int;
            var _local_4:int;
            while ((_local_4 = _arg_1.indexOf(_arg_2, _local_4)) != -1)
            {
                _local_4++;
                _local_3++;
            };
            return (_local_3);
        }

        public static function toString():String
        {
            var _local_2:Array = enumerateStyles();
            var _local_1:String = "";
            for each (var _local_3:_SafeStr_177 in _local_2)
            {
                _local_1 = (_local_1 + (_local_3.toString() + "\n\n"));
            };
            return (_local_1);
        }


    }
}

