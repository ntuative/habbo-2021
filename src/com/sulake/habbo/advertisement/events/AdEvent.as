package com.sulake.habbo.advertisement.events
{
    import flash.events.Event;
    import flash.display.BitmapData;

    public class AdEvent extends Event 
    {

        public static const ROOM_AD_IMAGE_LOADED:String = "AE_ROOM_AD_IMAGE_LOADED";
        public static const ROOM_AD_IMAGE_LOADING_FAILED:String = "AE_ROOM_AD_IMAGE_LOADING_FAILED";
        public static const ROOM_AD_SHOW:String = "AE_ROOM_AD_SHOW";

        private var _image:BitmapData;
        private var _roomId:int;
        private var _imageUrl:String;
        private var _clickUrl:String;
        private var _adWarningL:BitmapData;
        private var _adWarningR:BitmapData;
        private var _objectId:int;
        private var _objectCategory:int;

        public function AdEvent(_arg_1:String, _arg_2:int, _arg_3:BitmapData=null, _arg_4:String="", _arg_5:String="", _arg_6:BitmapData=null, _arg_7:BitmapData=null, _arg_8:int=-1, _arg_9:int=-1, _arg_10:Boolean=false, _arg_11:Boolean=false)
        {
            super(_arg_1, _arg_10, _arg_11);
            _image = _arg_3;
            _roomId = _arg_2;
            _imageUrl = _arg_4;
            _clickUrl = _arg_5;
            _adWarningL = _arg_6;
            _adWarningR = _arg_7;
            _objectId = _arg_8;
            _objectCategory = _arg_9;
        }

        public function get image():BitmapData
        {
            return (_image);
        }

        public function get roomId():int
        {
            return (_roomId);
        }

        public function get imageUrl():String
        {
            return (_imageUrl);
        }

        public function get clickUrl():String
        {
            return (_clickUrl);
        }

        public function get adWarningL():BitmapData
        {
            return (_adWarningL);
        }

        public function get adWarningR():BitmapData
        {
            return (_adWarningR);
        }

        public function get objectId():int
        {
            return (_objectId);
        }

        public function get objectCategory():int
        {
            return (_objectCategory);
        }


    }
}