package com.sulake.habbo.ui.widget.infostand
{
    import com.sulake.habbo.ui.widget.events.RoomWidgetRentableBotInfoUpdateEvent;

    public class InfoStandRentableBotData 
    {

        private var _userId:int = 0;
        private var _name:String = "";
        private var _SafeStr_2111:Array = [];
        private var _carryItem:int = 0;
        private var _userRoomId:int = 0;
        private var _amIOwner:Boolean;
        private var _amIAnyRoomController:Boolean;
        private var _botSkills:Array;


        public function set userId(_arg_1:int):void
        {
            _userId = _arg_1;
        }

        public function set name(_arg_1:String):void
        {
            _name = _arg_1;
        }

        public function set badges(_arg_1:Array):void
        {
            _SafeStr_2111 = _arg_1;
        }

        public function set carryItem(_arg_1:int):void
        {
            _carryItem = _arg_1;
        }

        public function set userRoomId(_arg_1:int):void
        {
            _userRoomId = _arg_1;
        }

        public function set amIOwner(_arg_1:Boolean):void
        {
            _amIOwner = _arg_1;
        }

        public function set amIAnyRoomController(_arg_1:Boolean):void
        {
            _amIAnyRoomController = _arg_1;
        }

        public function get userId():int
        {
            return (_userId);
        }

        public function get name():String
        {
            return (_name);
        }

        public function get badges():Array
        {
            return (_SafeStr_2111.slice());
        }

        public function get carryItem():int
        {
            return (_carryItem);
        }

        public function get userRoomId():int
        {
            return (_userRoomId);
        }

        public function get amIOwner():Boolean
        {
            return (_amIOwner);
        }

        public function get amIAnyRoomController():Boolean
        {
            return (_amIAnyRoomController);
        }

        public function get botSkills():Array
        {
            return (_botSkills);
        }

        public function set botSkills(_arg_1:Array):void
        {
            _botSkills = _arg_1;
        }

        public function setData(_arg_1:RoomWidgetRentableBotInfoUpdateEvent):void
        {
            userId = _arg_1.webID;
            name = _arg_1.name;
            badges = _arg_1.badges;
            carryItem = _arg_1.carryItem;
            userRoomId = _arg_1.userRoomId;
            amIOwner = _arg_1.amIOwner;
            amIAnyRoomController = _arg_1.amIAnyRoomController;
            botSkills = _arg_1.botSkills;
        }


    }
}

