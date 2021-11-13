package com.sulake.habbo.roomevents.userdefinedroomevents.actiontypes
{
    import com.sulake.habbo.roomevents.userdefinedroomevents.UserDefinedRoomEventsCtrl;

    public class _SafeStr_218 extends DefaultActionType 
    {


        override public function get code():int
        {
            return (_SafeStr_226.CHASE);
        }

        override public function get requiresFurni():int
        {
            return (UserDefinedRoomEventsCtrl.STUFF_SELECTION_OPTION_BY_ID_BY_TYPE_OR_FROM_CONTEXT);
        }


    }
}

