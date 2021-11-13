package com.sulake.habbo.avatar.structure
{
    import flash.geom.Point;

    public class AvatarCanvas 
    {

        private var _id:String;
        private var _width:int;
        private var _height:int;
        private var _offset:Point;
        private var _regPoint:Point;

        public function AvatarCanvas(_arg_1:XML, _arg_2:String)
        {
            _id = String(_arg_1.@id);
            _width = parseInt(_arg_1.@width);
            _height = parseInt(_arg_1.@height);
            _offset = new Point(parseInt(_arg_1.@dx), parseInt(_arg_1.@dy));
            if (_arg_2 == "h")
            {
                _regPoint = new Point(((_width - 64) / 2), 0);
            }
            else
            {
                _regPoint = new Point(((_width - 32) / 2), 0);
            };
        }

        public function get width():int
        {
            return (_width);
        }

        public function get height():int
        {
            return (_height);
        }

        public function get offset():Point
        {
            return (_offset);
        }

        public function get id():String
        {
            return (_id);
        }

        public function get regPoint():Point
        {
            return (_regPoint);
        }


    }
}