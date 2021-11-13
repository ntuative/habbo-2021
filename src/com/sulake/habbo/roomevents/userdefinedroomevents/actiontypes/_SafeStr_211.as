package com.sulake.habbo.roomevents.userdefinedroomevents.actiontypes
{
    import com.sulake.habbo.roomevents.userdefinedroomevents.UserDefinedRoomEventsCtrl;

    public class _SafeStr_211 extends DefaultActionType 
    {


        override public function get code():int
        {
            return (_SafeStr_226._SafeStr_652);
        }

        override public function get requiresFurni():int
        {
            return (UserDefinedRoomEventsCtrl.STUFF_SELECTION_OPTION_BY_ID_OR_BY_TYPE);
        }


    }
}

