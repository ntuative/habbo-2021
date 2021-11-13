package com.sulake.habbo.window.enum
{
    public class _SafeStr_220 
    {

        public static const _SafeStr_4370:String = "up, left";
        public static const UP_CENTER:String = "up, center";
        public static const UP_RIGHT:String = "up, right";
        public static const DOWN_LEFT:String = "down, left";
        public static const DOWN_CENTER:String = "down, center";
        public static const DOWN_RIGHT:String = "down, right";
        public static const _SafeStr_4371:String = "left, top";
        public static const _SafeStr_4372:String = "left, middle";
        public static const LEFT_BOTTOM:String = "left, bottom";
        public static const _SafeStr_4373:String = "right, top";
        public static const _SafeStr_4374:String = "right, middle";
        public static const RIGHT_BOTTOM:String = "right, bottom";
        public static const ALL:Array = ["up, left", "up, center", "up, right", "down, left", "down, center", "down, right", "left, top", "left, middle", "left, bottom", "right, top", "right, middle", "right, bottom"];
        public static const _SafeStr_1032:String = "up";
        public static const DOWN:String = "down";
        public static const _SafeStr_1033:String = "left";
        public static const RIGHT:String = "right";
        public static const _SafeStr_4375:String = "minimum";
        public static const _SafeStr_4376:String = "middle";
        public static const MAXIMUM:String = "maximum";


        public static function directionFromPivot(_arg_1:String):String
        {
            return (_arg_1.substr(0, _arg_1.indexOf(",")));
        }

        public static function positionFromPivot(_arg_1:String):String
        {
            switch (_arg_1)
            {
                case "up, left":
                case "down, left":
                case "left, top":
                case "right, top":
                    return ("minimum");
                case "up, right":
                case "down, right":
                case "left, bottom":
                case "right, bottom":
                    return ("maximum");
                default:
                    return ("middle");
            };
        }


    }
}

