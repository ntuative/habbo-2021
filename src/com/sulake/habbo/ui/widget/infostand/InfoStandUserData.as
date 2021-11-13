package com.sulake.habbo.ui.widget.infostand
{
    import com.sulake.habbo.ui.widget.events.RoomWidgetUserInfoUpdateEvent;

    public class InfoStandUserData 
    {

        private var _userId:int = 0;
        private var _userName:String = "";
        private var _SafeStr_2111:Array = [];
        private var _groupId:int = 0;
        private var _groupName:String = "";
        private var _groupBadgeId:String = "";
        private var _respectLeft:int = 0;
        private var _carryItem:int = 0;
        private var _userRoomId:int = 0;
        private var _type:String;
        private var _petRespectLeft:int = 0;


        public function set userId(_arg_1:int):void
        {
            _userId = _arg_1;
        }

        public function set userName(_arg_1:String):void
        {
            _userName = _arg_1;
        }

        public function set badges(_arg_1:Array):void
        {
            _SafeStr_2111 = _arg_1;
        }

        public function set groupId(_arg_1:int):void
        {
            _groupId = _arg_1;
        }

        public function set groupName(_arg_1:String):void
        {
            _groupName = _arg_1;
        }

        public function set groupBadgeId(_arg_1:String):void
        {
            _groupBadgeId = _arg_1;
        }

        public function set respectLeft(_arg_1:int):void
        {
            _respectLeft = _arg_1;
        }

        public function set carryItem(_arg_1:int):void
        {
            _carryItem = _arg_1;
        }

        public function set userRoomId(_arg_1:int):void
        {
            _userRoomId = _arg_1;
        }

        public function set type(_arg_1:String):void
        {
            _type = _arg_1;
        }

        public function set petRespectLeft(_arg_1:int):void
        {
            _petRespectLeft = _arg_1;
        }

        public function get userId():int
        {
            return (_userId);
        }

        public function get userName():String
        {
            return (_userName);
        }

        public function get badges():Array
        {
            return (_SafeStr_2111.slice());
        }

        public function get groupId():int
        {
            return (_groupId);
        }

        public function get groupName():String
        {
            return (_groupName);
        }

        public function get groupBadgeId():String
        {
            return (_groupBadgeId);
        }

        public function get respectLeft():int
        {
            return (_respectLeft);
        }

        public function get carryItem():int
        {
            return (_carryItem);
        }

        public function get userRoomId():int
        {
            return (_userRoomId);
        }

        public function get type():String
        {
            return (_type);
        }

        public function get petRespectLeft():int
        {
            return (_petRespectLeft);
        }

        public function isBot():Boolean
        {
            return (type == "RWUIUE_BOT");
        }

        public function setData(_arg_1:RoomWidgetUserInfoUpdateEvent):void
        {
            userId = _arg_1.webID;
            userName = _arg_1.name;
            badges = _arg_1.badges;
            groupId = _arg_1.groupId;
            groupName = _arg_1.groupName;
            groupBadgeId = _arg_1.groupBadgeId;
            respectLeft = _arg_1.respectLeft;
            carryItem = _arg_1.carryItem;
            userRoomId = _arg_1.userRoomId;
            type = _arg_1.type;
        }


    }
}

