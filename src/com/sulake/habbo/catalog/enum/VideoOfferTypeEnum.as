package com.sulake.habbo.catalog.enum
{
    public class VideoOfferTypeEnum 
    {

        public static const CREDIT:VideoOfferTypeEnum = new VideoOfferTypeEnum(0);
        public static const SNOWWAR:VideoOfferTypeEnum = new VideoOfferTypeEnum(1);

        private var _value:int = 0;

        public function VideoOfferTypeEnum(_arg_1:int):void
        {
            _value = _arg_1;
        }

        public function get value():int
        {
            return (_value);
        }

        public function equals(_arg_1:VideoOfferTypeEnum):Boolean
        {
            return ((_arg_1) && (_arg_1._value == _value));
        }


    }
}