package com.sulake.habbo.session
{
    import flash.display.BitmapData;

    public class BadgeInfo 
    {

        private var _image:BitmapData;
        private var _placeHolder:Boolean;

        public function BadgeInfo(_arg_1:BitmapData, _arg_2:Boolean)
        {
            _image = _arg_1;
            _placeHolder = _arg_2;
        }

        public function get image():BitmapData
        {
            return (_image);
        }

        public function get placeHolder():Boolean
        {
            return (_placeHolder);
        }


    }
}