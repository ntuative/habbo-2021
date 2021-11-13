package com.sulake.habbo.roomevents.userdefinedroomevents.conditions
{
    import com.sulake.habbo.roomevents.userdefinedroomevents.UserDefinedRoomEventsCtrl;

    public class FurnisHaveAvatars extends DefaultConditionType 
    {


        override public function get code():int
        {
            return (_SafeStr_228.FURNIS_HAVE_AVATARS);
        }

        override public function get negativeCode():int
        {
            return (_SafeStr_228.NOT_FURNIS_HAVE_AVATARS);
        }

        override public function get requiresFurni():int
        {
            return (UserDefinedRoomEventsCtrl.STUFF_SELECTION_OPTION_BY_ID);
        }


    }
}

