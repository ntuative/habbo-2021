package com.sulake.core.window.utils
{
    public class _SafeStr_177 
    {

        public static const NORMAL:String = "normal";
        public static const ITALIC:String = "italic";
        public static const BOLD:String = "bold";
        public static const _SafeStr_1190:String = "underline";
        public static const _SafeStr_617:String = "none";
        public static const ADVANCED:String = "advanced";
        public static const TOP_LEFT:String = "top-left";
        public static const TOP:String = "top";
        public static const TOP_RIGHT:String = "top-right";
        public static const _SafeStr_1033:String = "left";
        public static const RIGHT:String = "right";
        public static const BOTTOM_LEFT:String = "bottom-left";
        public static const BOTTOM:String = "bottom";
        public static const BOTTOM_RIGHT:String = "bottom-right";

        public var name:String;
        public var color:Object;
        public var fontFamily:String;
        public var fontSize:Object = null;
        public var fontStyle:String = null;
        public var fontWeight:String = null;
        public var kerning:Object = null;
        public var leading:Object = null;
        public var letterSpacing:Object = null;
        public var textDecoration:String = null;
        public var textIndent:Object = null;
        public var antiAliasType:String = null;
        public var sharpness:Object = null;
        public var thickness:Object = null;
        public var etchingColor:Object = null;
        public var etchingPosition:Object = null;


        public function toString():String
        {
            var _local_1:String = "";
            _local_1 = (_local_1 + (name + " {\n"));
            if (color)
            {
                _local_1 = (_local_1 + (("\tcolor: #" + color.toString()) + ";\n"));
            };
            if (fontFamily)
            {
                _local_1 = (_local_1 + (("\tfont-family: " + fontFamily) + ";\n"));
            };
            if (fontSize)
            {
                _local_1 = (_local_1 + (("\tfont-size: " + fontSize) + ";\n"));
            };
            if (fontStyle)
            {
                _local_1 = (_local_1 + (("\tfont-style: " + fontStyle) + ";\n"));
            };
            if (fontWeight)
            {
                _local_1 = (_local_1 + (("\tfont-weight: " + fontWeight) + ";\n"));
            };
            if (kerning)
            {
                _local_1 = (_local_1 + (("\tkerning: " + kerning) + ";\n"));
            };
            if (leading)
            {
                _local_1 = (_local_1 + (("\tleading: " + leading) + ";\n"));
            };
            if (letterSpacing)
            {
                _local_1 = (_local_1 + (("\tletter-spacing: " + letterSpacing) + ";\n"));
            };
            if (textDecoration)
            {
                _local_1 = (_local_1 + (("\ttext-decoration: " + textDecoration) + ";\n"));
            };
            if (textIndent)
            {
                _local_1 = (_local_1 + (("\ttext-indent: " + textIndent) + ";\n"));
            };
            if (antiAliasType)
            {
                _local_1 = (_local_1 + (("\tanti-alias-type: " + antiAliasType) + ";\n"));
            };
            if (sharpness)
            {
                _local_1 = (_local_1 + (("\tsharpness: " + sharpness) + ";\n"));
            };
            if (thickness)
            {
                _local_1 = (_local_1 + (("\tthickness: " + thickness) + ";\n"));
            };
            if (etchingColor)
            {
                _local_1 = (_local_1 + (("\tetching-color: #" + etchingColor.toString()) + ";\n"));
            };
            if (etchingPosition)
            {
                _local_1 = (_local_1 + (("\tetching-direction: " + etchingPosition) + ";\n"));
            };
            return (_local_1 + "}");
        }

        public function equals(_arg_1:_SafeStr_177):Boolean
        {
            return (((((((((((((((color == _arg_1.color) && (fontFamily == _arg_1.fontFamily)) && (fontSize == _arg_1.fontSize)) && (fontStyle == _arg_1.fontStyle)) && (fontWeight == _arg_1.fontWeight)) && (kerning == _arg_1.kerning)) && (leading == _arg_1.leading)) && (letterSpacing == _arg_1.letterSpacing)) && (textDecoration == _arg_1.textDecoration)) && (textIndent == _arg_1.textIndent)) && (antiAliasType == _arg_1.antiAliasType)) && (sharpness == _arg_1.sharpness)) && (thickness == _arg_1.thickness)) && (etchingColor == _arg_1.etchingColor)) && (etchingPosition == _arg_1.etchingPosition));
        }

        public function clone():_SafeStr_177
        {
            var _local_1:_SafeStr_177 = new _SafeStr_177();
            _local_1.name = name;
            _local_1.color = color;
            _local_1.fontFamily = fontFamily;
            _local_1.fontSize = fontSize;
            _local_1.fontStyle = fontStyle;
            _local_1.fontWeight = fontWeight;
            _local_1.kerning = kerning;
            _local_1.leading = leading;
            _local_1.letterSpacing = letterSpacing;
            _local_1.textDecoration = textDecoration;
            _local_1.textIndent = textIndent;
            _local_1.antiAliasType = antiAliasType;
            _local_1.sharpness = sharpness;
            _local_1.thickness = thickness;
            _local_1.etchingColor = etchingColor;
            _local_1.etchingPosition = etchingPosition;
            return (_local_1);
        }


    }
}

