package com.sulake.habbo.roomevents.userdefinedroomevents.conditions
{
    import com.sulake.habbo.roomevents.userdefinedroomevents.UserDefinedRoomEventsCtrl;

    public class _SafeStr_203 extends DefaultConditionType 
    {


        override public function get code():int
        {
            return (_SafeStr_228.TRIGGERER_IS_ON_FURNI);
        }

        override public function get negativeCode():int
        {
            return (_SafeStr_228.NOT_TRIGGERER_IS_ON_FURNI);
        }

        override public function get requiresFurni():int
        {
            return (UserDefinedRoomEventsCtrl.STUFF_SELECTION_OPTION_BY_ID);
        }


    }
}

