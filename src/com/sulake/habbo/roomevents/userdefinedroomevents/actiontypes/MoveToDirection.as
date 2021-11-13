package com.sulake.habbo.roomevents.userdefinedroomevents.actiontypes
{
    import com.sulake.habbo.roomevents.userdefinedroomevents.UserDefinedRoomEventsCtrl;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
    import com.sulake.core.window.components.IRadioButtonWindow;
    import com.sulake.core.window.components.ISelectorWindow;

    public class MoveToDirection extends DefaultActionType 
    {


        override public function get code():int
        {
            return (_SafeStr_226.MOVE_TO_DIRECTION);
        }

        override public function get requiresFurni():int
        {
            return (UserDefinedRoomEventsCtrl.STUFF_SELECTION_OPTION_BY_ID_BY_TYPE_OR_FROM_CONTEXT);
        }

        override public function onInit(_arg_1:IWindowContainer, _arg_2:HabboUserDefinedRoomEvents):void
        {
            _arg_2.refreshButton(_arg_1, "move_0", true, null, 0);
            _arg_2.refreshButton(_arg_1, "move_2", true, null, 0);
            _arg_2.refreshButton(_arg_1, "move_4", true, null, 0);
            _arg_2.refreshButton(_arg_1, "move_6", true, null, 0);
        }

        override public function onEditStart(_arg_1:IWindowContainer, _arg_2:Triggerable):void
        {
            var _local_4:int = _arg_2.intParams[0];
            var _local_3:int = _arg_2.intParams[1];
            getStartDirSelector(_arg_1).setSelected(getStartDirRadio(_arg_1, _local_4));
            getTurnSelector(_arg_1).setSelected(getTurnRadio(_arg_1, _local_3));
        }

        override public function readIntParamsFromForm(_arg_1:IWindowContainer):Array
        {
            var _local_2:Array = [];
            _local_2.push(getStartDirSelector(_arg_1).getSelected().id);
            _local_2.push(getTurnSelector(_arg_1).getSelected().id);
            return (_local_2);
        }

        override public function get hasSpecialInputs():Boolean
        {
            return (true);
        }

        private function getStartDirRadio(_arg_1:IWindowContainer, _arg_2:int):IRadioButtonWindow
        {
            return (IRadioButtonWindow(_arg_1.findChildByName((("startdir_" + _arg_2) + "_radio"))));
        }

        private function getTurnRadio(_arg_1:IWindowContainer, _arg_2:int):IRadioButtonWindow
        {
            return (IRadioButtonWindow(_arg_1.findChildByName((("turn_" + _arg_2) + "_radio"))));
        }

        private function getStartDirSelector(_arg_1:IWindowContainer):ISelectorWindow
        {
            return (ISelectorWindow(_arg_1.findChildByName("startdir_selector")));
        }

        private function getTurnSelector(_arg_1:IWindowContainer):ISelectorWindow
        {
            return (ISelectorWindow(_arg_1.findChildByName("turn_selector")));
        }


    }
}

