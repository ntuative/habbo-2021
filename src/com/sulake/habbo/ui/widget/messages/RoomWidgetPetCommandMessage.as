package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetPetCommandMessage extends RoomWidgetMessage 
    {

        public static const REQUEST_COMMANDS:String = "RWPCM_REQUEST_PET_COMMANDS";
        public static const PET_COMMAND:String = "RWPCM_PET_COMMAND";
        public static const BREED_TRAIN_COMMAND_ID:int = 46;

        private var _petId:int = 0;
        private var _value:String;

        public function RoomWidgetPetCommandMessage(_arg_1:String, _arg_2:int, _arg_3:String=null)
        {
            super(_arg_1);
            _petId = _arg_2;
            _value = _arg_3;
        }

        public function get petId():int
        {
            return (_petId);
        }

        public function get value():String
        {
            return (_value);
        }


    }
}