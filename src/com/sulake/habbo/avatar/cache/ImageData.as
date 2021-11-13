package com.sulake.habbo.avatar.cache
{
    import flash.display.BitmapData;
    import flash.geom.Rectangle;
    import flash.geom.Point;
    import flash.geom.ColorTransform;

    public class ImageData 
    {

        private var _bitmap:BitmapData;
        private var _rect:Rectangle;
        private var _regPoint:Point;
        private var _flipH:Boolean;
        private var _colorTransform:ColorTransform;

        public function ImageData(_arg_1:BitmapData, _arg_2:Rectangle, _arg_3:Point, _arg_4:Boolean, _arg_5:ColorTransform)
        {
            _bitmap = _arg_1;
            _rect = _arg_2;
            _regPoint = _arg_3;
            _flipH = _arg_4;
            _colorTransform = _arg_5;
            if (_arg_4)
            {
                _regPoint.x = (-(_regPoint.x) + _arg_2.width);
            };
        }

        public function dispose():void
        {
            _bitmap = null;
            _regPoint = null;
            _colorTransform = null;
        }

        public function get bitmap():BitmapData
        {
            return (_bitmap);
        }

        public function get rect():Rectangle
        {
            return (_rect);
        }

        public function get regPoint():Point
        {
            return (_regPoint);
        }

        public function get flipH():Boolean
        {
            return (_flipH);
        }

        public function get colorTransform():ColorTransform
        {
            return (_colorTransform);
        }

        public function get offsetRect():Rectangle
        {
            var _local_1:Rectangle = new Rectangle(0, 0, _rect.width, _rect.height);
            _local_1.offset(-(_regPoint.x), -(_regPoint.y));
            return (_local_1);
        }


    }
}