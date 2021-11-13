package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetUserActionMessage extends RoomWidgetMessage 
    {

        public static const WHISPER_USER:String = "RWUAM_WHISPER_USER";
        public static const IGNORE_USER:String = "RWUAM_IGNORE_USER";
        public static const _SafeStr_4211:String = "RWUAM_IGNORE_USER_BUBBLE";
        public static const UNIGNORE_USER:String = "RWUAM_UNIGNORE_USER";
        public static const KICK_USER:String = "RWUAM_KICK_USER";
        public static const BAN_USER_HOUR:String = "RWUAM_BAN_USER_HOUR";
        public static const BAN_USER_DAY:String = "RWUAM_BAN_USER_DAY";
        public static const BAN_USER_PERM:String = "RWUAM_BAN_USER_PERM";
        public static const MUTE_USER_2MIN:String = "RWUAM_MUTE_USER_2MIN";
        public static const MUTE_USER_5MIN:String = "RWUAM_MUTE_USER_5MIN";
        public static const MUTE_USER_10MIN:String = "RWUAM_MUTE_USER_10MIN";
        public static const SEND_FRIEND_REQUEST:String = "RWUAM_SEND_FRIEND_REQUEST";
        public static const GIVE_STAR_GEM_TO_USER:String = "RWUAM_GIVE_STAR_GEM_TO_USER";
        public static const GIVE_RIGHTS:String = "RWUAM_GIVE_RIGHTS";
        public static const TAKE_RIGHTS:String = "RWUAM_TAKE_RIGHTS";
        public static const START_TRADING:String = "RWUAM_START_TRADING";
        public static const OPEN_HOME_PAGE:String = "RWUAM_OPEN_HOME_PAGE";
        public static const REPORT:String = "RWUAM_REPORT";
        public static const PICK_UP_PET:String = "RWUAM_PICKUP_PET";
        public static const MOUNT_PET:String = "RWUAM_MOUNT_PET";
        public static const TOGGLE_PET_RIDING_PERMISSION:String = "RWUAM_TOGGLE_PET_RIDING_PERMISSION";
        public static const TOGGLE_PET_BREEDING_PERMISSION:String = "RWUAM_TOGGLE_PET_BREEDING_PERMISSION";
        public static const DISMOUNT_PET:String = "RWUAM_DISMOUNT_PET";
        public static const SADDLE_OFF:String = "RWUAM_SADDLE_OFF";
        public static const TRAIN_PET:String = "RWUAM_TRAIN_PET";
        public static const RESPECT_PET:String = " RWUAM_RESPECT_PET";
        public static const TREAT_PET:String = "RWUAM_TREAT_PET";
        public static const REQUEST_PET_UPDATE:String = "RWUAM_REQUEST_PET_UPDATE";
        public static const START_NAME_CHANGE:String = "RWUAM_START_NAME_CHANGE";
        public static const PASS_CARRY_ITEM:String = "RWUAM_PASS_CARRY_ITEM";
        public static const _SafeStr_4212:String = "RWUAM_DROP_CARRY_ITEM";
        public static const GIVE_CARRY_ITEM_TO_PET:String = "RWUAM_GIVE_CARRY_ITEM_TO_PET";
        public static const GIVE_WATER_TO_PET:String = "RWUAM_GIVE_WATER_TO_PET";
        public static const GIVE_LIGHT_TO_PET:String = "RWUAM_GIVE_LIGHT_TO_PET";
        public static const REQUEST_BREED_PET:String = "RWUAM_REQUEST_BREED_PET";
        public static const HARVEST_PET:String = "RWUAM_HARVEST_PET";
        public static const REVIVE_PET:String = "RWUAM_REVIVE_PET";
        public static const COMPOST_PLANT:String = "RWUAM_COMPOST_PLANT";
        public static const GET_BOT_INFO:String = "RWUAM_GET_BOT_INFO";
        public static const REPORT_CFH_OTHER:String = "RWUAM_REPORT_CFH_OTHER";
        public static const AMBASSADOR_ALERT_USER:String = "RWUAM_AMBASSADOR_ALERT_USER";
        public static const AMBASSADOR_KICK_USER:String = "RWUAM_AMBASSADOR_KICK_USER";
        public static const AMBASSADOR_MUTE_USER_2MIN:String = "RWUAM_AMBASSADOR_MUTE_2MIN";
        public static const AMBASSADOR_MUTE_USER_15MIN:String = "RWUAM_AMBASSADOR_MUTE_15MIN";
        public static const AMBASSADOR_MUTE_USER_10MIN:String = "RWUAM_AMBASSADOR_MUTE_10MIN";
        public static const AMBASSADOR_MUTE_USER_60MIN:String = "RWUAM_AMBASSADOR_MUTE_60MIN";
        public static const AMBASSADOR_MUTE_USER_18HOUR:String = "RWUAM_AMBASSADOR_MUTE_18HOUR";
        public static const AMBASSADOR_MUTE_USER_36HOUR:String = "RWUAM_AMBASSADOR_MUTE_36HOUR";
        public static const AMBASSADOR_MUTE_USER_72HOUR:String = "RWUAM_AMBASSADOR_MUTE_72HOUR";
        public static const AMBASSADOR_UNMUTE_USER:String = "RWUAM_AMBASSADOR_UNMUTE";

        private var _userId:int = 0;

        public function RoomWidgetUserActionMessage(_arg_1:String, _arg_2:int=0)
        {
            super(_arg_1);
            _userId = _arg_2;
        }

        public function get userId():int
        {
            return (_userId);
        }


    }
}

