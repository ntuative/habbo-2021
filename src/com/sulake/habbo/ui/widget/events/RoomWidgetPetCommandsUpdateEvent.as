package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetPetCommandsUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const PET_COMMANDS:String = "RWPCUE_PET_COMMANDS";
        public static const OPEN_PET_TRAINING:String = "RWPCUE_OPEN_PET_TRAINING";
        public static const CLOSE_PET_TRAINING:String = "RWPCUE_CLOSE_PET_TRAINING";

        private var _id:int;
        private var _allCommands:Array;
        private var _enabledCommands:Array;

        public function RoomWidgetPetCommandsUpdateEvent(_arg_1:int, _arg_2:Array, _arg_3:Array, _arg_4:Boolean=false, _arg_5:Boolean=false)
        {
            super("RWPCUE_PET_COMMANDS", _arg_4, _arg_5);
            _id = _arg_1;
            _allCommands = _arg_2;
            _enabledCommands = _arg_3;
        }

        public function get id():int
        {
            return (_id);
        }

        public function get allCommands():Array
        {
            return (_allCommands);
        }

        public function get enabledCommands():Array
        {
            return (_enabledCommands);
        }


    }
}