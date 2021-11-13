package com.sulake.habbo.catalog.navigation
{
    public class RequestedPage 
    {

        public static const REQUEST_TYPE_NONE:int = 0;
        public static const REQUEST_TYPE_ID:int = 1;
        public static const REQUEST_TYPE_NAME:int = 2;

        private var _requestType:int;
        private var _requestId:int;
        private var _requestedOfferId:int;
        private var _requestName:String;

        public function RequestedPage()
        {
            _requestType = 0;
        }

        public function set requestById(_arg_1:int):void
        {
            _requestType = 1;
            _requestId = _arg_1;
        }

        public function set requestByName(_arg_1:String):void
        {
            _requestType = 2;
            _requestName = _arg_1;
        }

        public function resetRequest():void
        {
            _requestType = 0;
            _requestedOfferId = -1;
        }

        public function get requestType():int
        {
            return (_requestType);
        }

        public function get requestId():int
        {
            return (_requestId);
        }

        public function get requestedOfferId():int
        {
            return (_requestedOfferId);
        }

        public function set requestedOfferId(_arg_1:int):void
        {
            _requestedOfferId = _arg_1;
        }

        public function get requestName():String
        {
            return (_requestName);
        }


    }
}