package com.sulake.habbo.room.events
{
    public class RoomEngineSoundMachineEvent extends RoomEngineObjectEvent 
    {

        public static const SOUND_MACHINE_INIT:String = "ROSM_SOUND_MACHINE_INIT";
        public static const SOUND_MACHINE_SWITCHED_ON:String = "ROSM_SOUND_MACHINE_SWITCHED_ON";
        public static const SOUND_MACHINE_SWITCHED_OFF:String = "ROSM_SOUND_MACHINE_SWITCHED_OFF";
        public static const SOUND_MACHINE_DISPOSE:String = "ROSM_SOUND_MACHINE_DISPOSE";
        public static const JUKEBOX_INIT:String = "ROSM_JUKEBOX_INIT";
        public static const _SafeStr_3158:String = "ROSM_JUKEBOX_SWITCHED_ON";
        public static const _SafeStr_3159:String = "ROSM_JUKEBOX_SWITCHED_OFF";
        public static const _SafeStr_3160:String = "ROSM_JUKEBOX_DISPOSE";

        public function RoomEngineSoundMachineEvent(_arg_1:String, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:Boolean=false, _arg_6:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6);
        }

    }
}

