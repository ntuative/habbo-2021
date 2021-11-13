package com.sulake.habbo.roomevents.userdefinedroomevents
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;

    public class DefaultElement implements Element 
    {


        public function get code():int
        {
            return (-1);
        }

        public function get negativeCode():int
        {
            return (-1);
        }

        public function get requiresFurni():int
        {
            return (UserDefinedRoomEventsCtrl.STUFF_SELECTION_OPTION_NONE);
        }

        public function get hasStateSnapshot():Boolean
        {
            return (false);
        }

        public function readIntParamsFromForm(_arg_1:IWindowContainer):Array
        {
            return ([]);
        }

        public function readStringParamFromForm(_arg_1:IWindowContainer):String
        {
            return ("");
        }

        public function onInit(_arg_1:IWindowContainer, _arg_2:HabboUserDefinedRoomEvents):void
        {
        }

        public function onEditStart(_arg_1:IWindowContainer, _arg_2:Triggerable):void
        {
        }

        public function get hasSpecialInputs():Boolean
        {
            return (false);
        }

        public function validate(_arg_1:IWindowContainer, _arg_2:HabboUserDefinedRoomEvents):String
        {
            return (null);
        }


    }
}