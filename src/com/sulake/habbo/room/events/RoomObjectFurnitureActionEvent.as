package com.sulake.habbo.room.events
{
    import com.sulake.room.events.RoomObjectEvent;
    import com.sulake.room.object.IRoomObject;

    public class RoomObjectFurnitureActionEvent extends RoomObjectEvent 
    {

        public static const _SafeStr_3161:String = "ROFCAE_DICE_OFF";
        public static const _SafeStr_3162:String = "ROFCAE_DICE_ACTIVATE";
        public static const USE_HABBOWHEEL:String = "ROFCAE_USE_HABBOWHEEL";
        public static const STICKIE:String = "ROFCAE_STICKIE";
        public static const _SafeStr_3163:String = "ROFCAE_ENTER_ONEWAYDOOR";
        public static const SOUND_MACHINE_INIT:String = "ROFCAE_SOUND_MACHINE_INIT";
        public static const SOUND_MACHINE_START:String = "ROFCAE_SOUND_MACHINE_START";
        public static const SOUND_MACHINE_STOP:String = "ROFCAE_SOUND_MACHINE_STOP";
        public static const SOUND_MACHINE_DISPOSE:String = "ROFCAE_SOUND_MACHINE_DISPOSE";
        public static const JUKEBOX_INIT:String = "ROFCAE_JUKEBOX_INIT";
        public static const _SafeStr_3164:String = "ROFCAE_JUKEBOX_START";
        public static const _SafeStr_3165:String = "ROFCAE_JUKEBOX_MACHINE_STOP";
        public static const _SafeStr_3160:String = "ROFCAE_JUKEBOX_DISPOSE";
        public static const CURSOR_REQUEST_BUTTON:String = "ROFCAE_MOUSE_BUTTON";
        public static const CURSOR_REQUEST_ARROW:String = "ROFCAE_MOUSE_ARROW";

        public function RoomObjectFurnitureActionEvent(_arg_1:String, _arg_2:IRoomObject, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
        }

    }
}

