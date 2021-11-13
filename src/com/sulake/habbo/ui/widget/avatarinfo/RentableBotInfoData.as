package com.sulake.habbo.ui.widget.avatarinfo
{
    import com.sulake.habbo.ui.widget.events.RoomWidgetRentableBotInfoUpdateEvent;
    import com.sulake.habbo.communication.messages.parser.room.bots.BotSkillData;

    public class RentableBotInfoData 
    {

        private var _id:int = -1;
        private var _roomIndex:int;
        private var _isIgnored:Boolean = false;
        private var _amIOwner:Boolean = false;
        private var _amIAnyRoomController:Boolean = false;
        private var _carryItemType:int = 0;
        private var _botSkills:Array;
        private var _botSkillsWithCommands:Array = new Array(0);
        private var _name:String;


        public function set id(_arg_1:int):void
        {
            _id = _arg_1;
        }

        public function set roomIndex(_arg_1:int):void
        {
            _roomIndex = _arg_1;
        }

        public function get id():int
        {
            return (_id);
        }

        public function get roomIndex():int
        {
            return (_roomIndex);
        }

        public function get isIgnored():Boolean
        {
            return (_isIgnored);
        }

        public function get amIOwner():Boolean
        {
            return (_amIOwner);
        }

        public function get amIAnyRoomController():Boolean
        {
            return (_amIAnyRoomController);
        }

        public function get carryItemType():int
        {
            return (_carryItemType);
        }

        public function set isIgnored(_arg_1:Boolean):void
        {
            _isIgnored = _arg_1;
        }

        public function set amIOwner(_arg_1:Boolean):void
        {
            _amIOwner = _arg_1;
        }

        public function set amIAnyRoomController(_arg_1:Boolean):void
        {
            _amIAnyRoomController = _arg_1;
        }

        public function set carryItemType(_arg_1:int):void
        {
            _carryItemType = _arg_1;
        }

        public function get botSkills():Array
        {
            return (_botSkills);
        }

        public function set botSkills(_arg_1:Array):void
        {
            _botSkills = _arg_1;
        }

        public function get botSkillsWithCommands():Array
        {
            return (_botSkillsWithCommands);
        }

        public function set botSkillsWithCommands(_arg_1:Array):void
        {
            _botSkillsWithCommands = _arg_1;
        }

        public function get name():String
        {
            return (_name);
        }

        public function populate(_arg_1:RoomWidgetRentableBotInfoUpdateEvent):void
        {
            if (_arg_1.webID != id)
            {
                _botSkillsWithCommands = new Array(0);
            };
            id = _arg_1.webID;
            roomIndex = _arg_1.userRoomId;
            amIOwner = _arg_1.amIOwner;
            amIAnyRoomController = _arg_1.amIAnyRoomController;
            carryItemType = _arg_1.carryItem;
            botSkills = _arg_1.botSkills;
            _name = _arg_1.name;
        }

        public function cloneAndSetSkillsWithCommands(_arg_1:Array):void
        {
            _botSkills = [];
            for each (var _local_2:BotSkillData in _arg_1)
            {
                botSkills.push(_local_2.id);
            };
            _botSkillsWithCommands = _arg_1.concat();
        }


    }
}