package com.sulake.core.window.utils
{
    public class DefaultAttStruct 
    {

        public static var useRectLimits:Boolean = true;

        public var color:uint = 0xFFFFFF;
        public var background:Boolean = false;
        public var blend:Number = 1;
        public var threshold:uint = 10;
        public var width_min:int = -2147483648;
        public var width_max:int = 2147483647;
        public var height_min:int = -2147483648;
        public var height_max:int = 2147483647;


        public function hasRectLimits():Boolean
        {
            return ((useRectLimits) && ((((width_min > -2147483648) || (height_min > -2147483648)) || (width_max < 2147483647)) || (height_max < 2147483647)));
        }


    }
}