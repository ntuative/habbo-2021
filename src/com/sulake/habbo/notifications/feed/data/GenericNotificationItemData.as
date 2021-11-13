package com.sulake.habbo.notifications.feed.data
{
    import flash.display.BitmapData;

    public class GenericNotificationItemData 
    {

        private var _title:String;
        private var _timeStamp:int;
        private var _description:String;
        private var _decorationImage:BitmapData;
        private var _iconImage:BitmapData;
        private var _buttonAction:String;
        private var _buttonCaption:String;


        public function get title():String
        {
            return (_title);
        }

        public function get timeStamp():int
        {
            return (_timeStamp);
        }

        public function get description():String
        {
            return (_description);
        }

        public function get decorationImage():BitmapData
        {
            return (_decorationImage);
        }

        public function get iconImage():BitmapData
        {
            return (_iconImage);
        }

        public function get buttonAction():String
        {
            return (_buttonAction);
        }

        public function get buttonCaption():String
        {
            return (_buttonCaption);
        }

        public function set title(_arg_1:String):void
        {
            _title = _arg_1;
        }

        public function set timeStamp(_arg_1:int):void
        {
            _timeStamp = _arg_1;
        }

        public function set description(_arg_1:String):void
        {
            _description = _arg_1;
        }

        public function set decorationImage(_arg_1:BitmapData):void
        {
            _decorationImage = _arg_1;
        }

        public function set iconImage(_arg_1:BitmapData):void
        {
            _iconImage = _arg_1;
        }

        public function set buttonAction(_arg_1:String):void
        {
            _buttonAction = _arg_1;
        }

        public function set buttonCaption(_arg_1:String):void
        {
            _buttonCaption = _arg_1;
        }


    }
}