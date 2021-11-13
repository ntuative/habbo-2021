package com.sulake.habbo.catalog.event
{
    public class CatalogUserEvent extends CatalogEvent 
    {

        private var _userId:int;
        private var _userName:String;

        public function CatalogUserEvent(_arg_1:String, _arg_2:int, _arg_3:String, _arg_4:Boolean=false, _arg_5:Boolean=false)
        {
            super(_arg_1, _arg_4, _arg_5);
            _userId = _arg_2;
            _userName = _arg_3;
        }

        public function get userId():int
        {
            return (_userId);
        }

        public function get userName():String
        {
            return (_userName);
        }


    }
}