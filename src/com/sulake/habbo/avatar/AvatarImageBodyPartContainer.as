package com.sulake.habbo.avatar
{
    import flash.display.BitmapData;
    import flash.geom.Point;

    public class AvatarImageBodyPartContainer 
    {

        private var _image:BitmapData;
        private var _regPoint:Point;
        private var _offset:Point = new Point(0, 0);
        private var _isCacheable:Boolean;

        public function AvatarImageBodyPartContainer(_arg_1:BitmapData, _arg_2:Point, _arg_3:Boolean)
        {
            _image = _arg_1;
            _regPoint = _arg_2;
            _isCacheable = _arg_3;
            cleanPoints();
        }

        public function get isCacheable():Boolean
        {
            return (_isCacheable);
        }

        public function dispose():void
        {
            if (_image)
            {
                _image.dispose();
            };
            _image = null;
            _regPoint = null;
            _offset = null;
        }

        public function set image(_arg_1:BitmapData):void
        {
            if (((_image) && (!(_image == _arg_1))))
            {
                _image.dispose();
            };
            _image = _arg_1;
        }

        public function get image():BitmapData
        {
            return (_image);
        }

        public function setRegPoint(_arg_1:Point):void
        {
            _regPoint = _arg_1;
            cleanPoints();
        }

        public function get regPoint():Point
        {
            return (_regPoint.add(_offset));
        }

        public function set offset(_arg_1:Point):void
        {
            _offset = _arg_1;
            cleanPoints();
        }

        private function cleanPoints():void
        {
            _regPoint.x = _regPoint.x;
            _regPoint.y = _regPoint.y;
            _offset.x = _offset.x;
            _offset.y = _offset.y;
        }


    }
}