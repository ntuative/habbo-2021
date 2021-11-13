package com.sulake.core.window.dynamicstyle
{
    import flash.utils.Dictionary;

    public class DynamicStyleManager 
    {

        private static var _styles:Dictionary;


        public static function getStyle(_arg_1:String):DynamicStyle
        {
            if (!_styles)
            {
                fillStyleTable();
            };
            if ((_arg_1 in _styles))
            {
                return (_styles[_arg_1]);
            };
            return (new DynamicStyle());
        }

        private static function fillStyleTable():void
        {
            _styles = new Dictionary();
            var _local_1:DynamicStyle = new DynamicStyle("lifted_hover");
            _local_1.defaultStyles = {};
            _local_1.pressedSyles = {
                "offsetX":1,
                "colorTransform":[1, 0.7, 0.7, 0.7, 0, 0, 0, 0]
            };
            _local_1._SafeStr_640 = {
                "offsetY":-1,
                "offsetX":-1
            };
            var _local_4:DynamicStyle = new DynamicStyle();
            _local_4.defaultStyles = {
                "etchingColor":0x48000000,
                "etchingPoint":[1, 1]
            };
            _local_4._SafeStr_640 = {
                "etchingColor":0x80000000,
                "etchingPoint":[2, 2]
            };
            _local_4.pressedSyles = {
                "etchingColor":0x48000000,
                "etchingPoint":[-1, -1]
            };
            _local_1._SafeStr_641["#icon"] = _local_4;
            var _local_2:DynamicStyle = new DynamicStyle("brightness_and_shadow_under");
            _local_2.defaultStyles = {};
            var _local_5:DynamicStyle = new DynamicStyle();
            _local_5.defaultStyles = {
                "etchingColor":0x48000000,
                "etchingPoint":[0, 1]
            };
            _local_5.pressedSyles = {
                "etchingColor":0x80000000,
                "etchingPoint":[0, -1],
                "offsetY":-1,
                "colorTransform":[0.7, 0.7, 0.7, 1, 0, 0, 0, 0]
            };
            _local_5._SafeStr_640 = {
                "etchingColor":0x48000000,
                "etchingPoint":[0, 1],
                "colorTransform":[1, 1, 1, 1, 77, 77, 77, 0]
            };
            _local_2._SafeStr_641["#icon"] = _local_5;
            var _local_3:DynamicStyle = new DynamicStyle();
            _local_3.defaultStyles = {
                "etchingColor":0x48000000,
                "etchingPoint":[0, 1]
            };
            _local_3.pressedSyles = {
                "etchingColor":0x80000000,
                "etchingPoint":[0, 0],
                "colorTransform":[0.9, 0.9, 0.9, 1, 0, 0, 0, 0]
            };
            _local_3._SafeStr_640 = {
                "etchingColor":0x48000000,
                "etchingPoint":[0, 1],
                "colorTransform":[1, 1, 1, 1, 77, 77, 77, 0]
            };
            _local_3._SafeStr_642 = {"colorTransform":[0.5, 0.5, 0.5, 0.7, 0, 0, 0, 0]};
            _local_2._SafeStr_641["#bg"] = _local_3;
            _styles["lifted_hover"] = _local_1;
            _styles["brightness_and_shadow_under"] = _local_2;
        }


    }
}

