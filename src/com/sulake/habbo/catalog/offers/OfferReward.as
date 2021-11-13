package com.sulake.habbo.catalog.offers
{
    public class OfferReward 
    {

        private var _name:String;
        private var _contentType:String;
        private var _classId:int;

        public function OfferReward(_arg_1:String, _arg_2:String, _arg_3:int)
        {
            _name = _arg_1;
            _contentType = _arg_2;
            _classId = _arg_3;
        }

        public function get name():String
        {
            return (_name);
        }

        public function get contentType():String
        {
            return (_contentType);
        }

        public function get classId():int
        {
            return (_classId);
        }


    }
}