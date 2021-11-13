package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetRentableBotSkillListUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const SKILL_LIST:String = "RWRBSLUE_SKILL_LIST";

        private var _botId:int;
        private var _botSkillsWithCommands:Array;

        public function RoomWidgetRentableBotSkillListUpdateEvent(_arg_1:int, _arg_2:Array, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super("RWRBSLUE_SKILL_LIST", _arg_3, _arg_4);
            _botId = _arg_1;
            _botSkillsWithCommands = _arg_2;
        }

        public function get botSkillsWithCommands():Array
        {
            return (_botSkillsWithCommands);
        }

        public function get botId():int
        {
            return (_botId);
        }


    }
}