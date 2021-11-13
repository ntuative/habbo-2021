package com.sulake.habbo.roomevents.userdefinedroomevents.conditions
{
    import com.sulake.habbo.roomevents.userdefinedroomevents.UserDefinedRoomEventsCtrl;

    public class _SafeStr_204 extends DefaultConditionType 
    {


        override public function get code():int
        {
            return (_SafeStr_228.STUFF_TYPE_MATCHES);
        }

        override public function get negativeCode():int
        {
            return (_SafeStr_228.NOT_STUFF_TYPE_MATCHES);
        }

        override public function get requiresFurni():int
        {
            return (UserDefinedRoomEventsCtrl.STUFF_SELECTION_OPTION_BY_ID_OR_BY_TYPE);
        }


    }
}

