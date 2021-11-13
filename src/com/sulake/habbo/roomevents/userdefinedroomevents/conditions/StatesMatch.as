package com.sulake.habbo.roomevents.userdefinedroomevents.conditions
{
    import com.sulake.habbo.roomevents.userdefinedroomevents.UserDefinedRoomEventsCtrl;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
    import com.sulake.core.window.components._SafeStr_108;

    public class StatesMatch extends DefaultConditionType 
    {


        override public function get code():int
        {
            return (_SafeStr_228.STATES_MATCH);
        }

        override public function get negativeCode():int
        {
            return (_SafeStr_228.NOT_STATES_MATCH);
        }

        override public function get requiresFurni():int
        {
            return (UserDefinedRoomEventsCtrl.STUFF_SELECTION_OPTION_BY_ID);
        }

        override public function get hasStateSnapshot():Boolean
        {
            return (true);
        }

        override public function onEditStart(_arg_1:IWindowContainer, _arg_2:Triggerable):void
        {
            select(getStateInput(_arg_1), _arg_2.getBoolean(0));
            select(getRotationInput(_arg_1), _arg_2.getBoolean(1));
            select(getLocationInput(_arg_1), _arg_2.getBoolean(2));
        }

        private function select(_arg_1:_SafeStr_108, _arg_2:Boolean):void
        {
            if (_arg_2)
            {
                _arg_1.select();
            }
            else
            {
                _arg_1.unselect();
            };
        }

        override public function readIntParamsFromForm(_arg_1:IWindowContainer):Array
        {
            var _local_2:Array = [];
            _local_2.push(getIntState(getStateInput(_arg_1)));
            _local_2.push(getIntState(getRotationInput(_arg_1)));
            _local_2.push(getIntState(getLocationInput(_arg_1)));
            return (_local_2);
        }

        override public function get hasSpecialInputs():Boolean
        {
            return (true);
        }

        private function getStateInput(_arg_1:IWindowContainer):_SafeStr_108
        {
            return (_SafeStr_108(_arg_1.findChildByName("include_state_checkbox")));
        }

        private function getRotationInput(_arg_1:IWindowContainer):_SafeStr_108
        {
            return (_SafeStr_108(_arg_1.findChildByName("include_rotation_checkbox")));
        }

        private function getLocationInput(_arg_1:IWindowContainer):_SafeStr_108
        {
            return (_SafeStr_108(_arg_1.findChildByName("include_location_checkbox")));
        }

        private function getIntState(_arg_1:_SafeStr_108):int
        {
            return ((_arg_1.isSelected) ? 1 : 0);
        }


    }
}

