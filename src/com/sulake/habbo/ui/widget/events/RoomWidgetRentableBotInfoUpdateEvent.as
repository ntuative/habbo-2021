package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetRentableBotInfoUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const RENTABLE_BOT:String = "RWRBIUE_RENTABLE_BOT";
        public static const DEFAULT_BOT_BADGE_ID:String = "RENTABLE_BOT";

        private var _name:String = "";
        private var _motto:String = "";
        private var _webID:int = 0;
        private var _figure:String = "";
        private var _badges:Array = [];
        private var _carryItem:int = 0;
        private var _userRoomId:int = 0;
        private var _ownerId:int;
        private var _ownerName:String;
        private var _amIOwner:Boolean = false;
        private var _amIAnyRoomController:Boolean = false;
        private var _myRoomControllerLevel:int = 0;
        private var _botSkills:Array;

        public function RoomWidgetRentableBotInfoUpdateEvent(_arg_1:Boolean=false, _arg_2:Boolean=false)
        {
            super("RWRBIUE_RENTABLE_BOT", _arg_1, _arg_2);
        }

        public function set name(_arg_1:String):void
        {
            _name = _arg_1;
        }

        public function get name():String
        {
            return (_name);
        }

        public function set motto(_arg_1:String):void
        {
            _motto = _arg_1;
        }

        public function get motto():String
        {
            return (_motto);
        }

        public function set webID(_arg_1:int):void
        {
            _webID = _arg_1;
        }

        public function get webID():int
        {
            return (_webID);
        }

        public function set figure(_arg_1:String):void
        {
            _figure = _arg_1;
        }

        public function get figure():String
        {
            return (_figure);
        }

        public function set badges(_arg_1:Array):void
        {
            _badges = _arg_1;
        }

        public function get badges():Array
        {
            return (_badges);
        }

        public function get ownerId():int
        {
            return (_ownerId);
        }

        public function set ownerId(_arg_1:int):void
        {
            _ownerId = _arg_1;
        }

        public function get ownerName():String
        {
            return (_ownerName);
        }

        public function set ownerName(_arg_1:String):void
        {
            _ownerName = _arg_1;
        }

        public function set amIOwner(_arg_1:Boolean):void
        {
            _amIOwner = _arg_1;
        }

        public function get amIOwner():Boolean
        {
            return (_amIOwner);
        }

        public function set myRoomControllerLevel(_arg_1:int):void
        {
            _myRoomControllerLevel = _arg_1;
        }

        public function get myRoomControllerLevel():int
        {
            return (_myRoomControllerLevel);
        }

        public function set amIAnyRoomController(_arg_1:Boolean):void
        {
            _amIAnyRoomController = _arg_1;
        }

        public function get amIAnyRoomController():Boolean
        {
            return (_amIAnyRoomController);
        }

        public function set carryItem(_arg_1:int):void
        {
            _carryItem = _arg_1;
        }

        public function get carryItem():int
        {
            return (_carryItem);
        }

        public function set userRoomId(_arg_1:int):void
        {
            _userRoomId = _arg_1;
        }

        public function get userRoomId():int
        {
            return (_userRoomId);
        }

        public function get botSkills():Array
        {
            return (_botSkills);
        }

        public function set botSkills(_arg_1:Array):void
        {
            _botSkills = _arg_1;
        }


    }
}