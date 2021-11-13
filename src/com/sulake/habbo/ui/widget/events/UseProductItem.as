package com.sulake.habbo.ui.widget.events
{
    public class UseProductItem 
    {

        private var _id:int;
        private var _category:int;
        private var _name:String;
        private var _requestRoomObjectId:int;
        private var _targetRoomObjectId:int;
        private var _requestInventoryStripId:int;
        private var _replace:Boolean;

        public function UseProductItem(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:int, _arg_5:int, _arg_6:int=-1, _arg_7:Boolean=false)
        {
            _id = _arg_1;
            _category = _arg_2;
            _name = _arg_3;
            _requestRoomObjectId = _arg_4;
            _targetRoomObjectId = _arg_5;
            _requestInventoryStripId = _arg_6;
            _replace = _arg_7;
        }

        public function dispose():void
        {
        }

        public function get id():int
        {
            return (_id);
        }

        public function get category():int
        {
            return (_category);
        }

        public function get name():String
        {
            return (_name);
        }

        public function get requestRoomObjectId():int
        {
            return (_requestRoomObjectId);
        }

        public function get targetRoomObjectId():int
        {
            return (_targetRoomObjectId);
        }

        public function get requestInventoryStripId():int
        {
            return (_requestInventoryStripId);
        }

        public function get replace():Boolean
        {
            return (_replace);
        }


    }
}