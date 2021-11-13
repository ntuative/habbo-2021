package com.sulake.habbo.session.events
{
    import com.sulake.habbo.session.IRoomSession;

    public class RoomSessionPetCommandsUpdateEvent extends RoomSessionEvent 
    {

        public static const PET_COMMANDS:String = "RSPIUE_ENABLED_PET_COMMANDS";

        private var _petId:int;
        private var _allCommands:Array;
        private var _enabledCommands:Array;

        public function RoomSessionPetCommandsUpdateEvent(_arg_1:IRoomSession, _arg_2:int, _arg_3:Array, _arg_4:Array, _arg_5:Boolean=false, _arg_6:Boolean=false)
        {
            super("RSPIUE_ENABLED_PET_COMMANDS", _arg_1, _arg_5, _arg_6);
            _petId = _arg_2;
            _allCommands = _arg_3;
            _enabledCommands = _arg_4;
        }

        public function get petId():int
        {
            return (_petId);
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