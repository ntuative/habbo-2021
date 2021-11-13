package com.sulake.core.window.graphics.renderer
{
    import com.sulake.core.window.utils.IChildEntity;
    import flash.geom.Rectangle;

    public class SkinLayoutEntity implements IChildEntity 
    {

        public static const SCALE_TYPE_FIXED:uint = 0;
        public static const SCALE_TYPE_MOVE:uint = 1;
        public static const SCALE_TYPE_STRECH:uint = 2;
        public static const SCALE_TYPE_TILED:uint = 4;
        public static const SCALE_TYPE_CENTER:uint = 8;

        private var _id:uint;
        private var _name:String;
        public var color:uint;
        public var blend:uint;
        public var scaleH:uint;
        public var scaleV:uint;
        public var region:Rectangle;
        public var colorize:Boolean;

        public function SkinLayoutEntity(_arg_1:uint, _arg_2:String)
        {
            _id = _arg_1;
            _name = _arg_2;
        }

        public function get id():uint
        {
            return (_id);
        }

        public function get name():String
        {
            return (_name);
        }

        public function get tags():Array
        {
            return (null);
        }

        public function dispose():void
        {
            region = null;
        }


    }
}