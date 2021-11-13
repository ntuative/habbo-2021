package com.sulake.habbo.room.object.visualization.data
{
    public class LayerData 
    {

        public static const DEFAULT_TAG:String = "";
        public static const DEFAULT_INK:int = 0;
        public static const DEFAULT_ALPHA:int = 0xFF;
        public static const DEFAULT_IGNORE_MOUSE:Boolean = false;
        public static const DEFAULT_X_OFFSET:int = 0;
        public static const DEFAULT_Y_OFFSET:int = 0;
        public static const DEFAULT_Z_OFFSET:int = 0;
        public static const INK_ADD:int = 1;
        public static const INK_SUBTRACT:int = 2;
        public static const INK_DARKEN:int = 3;

        private var _tag:String = "";
        private var _ink:int = 0;
        private var _alpha:int = 0xFF;
        private var _ignoreMouse:Boolean = false;
        private var _xOffset:int = 0;
        private var _yOffset:int = 0;
        private var _zOffset:Number = 0;


        public function set tag(_arg_1:String):void
        {
            _tag = _arg_1;
        }

        public function get tag():String
        {
            return (_tag);
        }

        public function set ink(_arg_1:int):void
        {
            _ink = _arg_1;
        }

        public function get ink():int
        {
            return (_ink);
        }

        public function set alpha(_arg_1:int):void
        {
            _alpha = _arg_1;
        }

        public function get alpha():int
        {
            return (_alpha);
        }

        public function set ignoreMouse(_arg_1:Boolean):void
        {
            _ignoreMouse = _arg_1;
        }

        public function get ignoreMouse():Boolean
        {
            return (_ignoreMouse);
        }

        public function set xOffset(_arg_1:int):void
        {
            _xOffset = _arg_1;
        }

        public function get xOffset():int
        {
            return (_xOffset);
        }

        public function set yOffset(_arg_1:int):void
        {
            _yOffset = _arg_1;
        }

        public function get yOffset():int
        {
            return (_yOffset);
        }

        public function set zOffset(_arg_1:Number):void
        {
            _zOffset = _arg_1;
        }

        public function get zOffset():Number
        {
            return (_zOffset);
        }

        public function copyValues(_arg_1:LayerData):void
        {
            if (_arg_1 != null)
            {
                tag = _arg_1.tag;
                ink = _arg_1.ink;
                alpha = _arg_1.alpha;
                ignoreMouse = _arg_1.ignoreMouse;
                xOffset = _arg_1.xOffset;
                yOffset = _arg_1.yOffset;
                zOffset = _arg_1.zOffset;
            };
        }


    }
}