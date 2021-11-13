package com.sulake.habbo.roomevents.userdefinedroomevents.conditions
{
    import com.sulake.habbo.roomevents.userdefinedroomevents.UserDefinedRoomEventsCtrl;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
    import com.sulake.core.window.components.IRadioButtonWindow;
    import com.sulake.core.window.components.ISelectorWindow;

    public class DontHaveStackedFurnis extends DefaultConditionType 
    {


        override public function get code():int
        {
            return (_SafeStr_228.NOT_HAS_STACKED_FURNIS);
        }

        override public function get requiresFurni():int
        {
            return (UserDefinedRoomEventsCtrl.STUFF_SELECTION_OPTION_BY_ID);
        }

        override public function readIntParamsFromForm(_arg_1:IWindowContainer):Array
        {
            var _local_2:Array = [];
            _local_2.push(getEvalSelector(_arg_1).getSelected().id);
            return (_local_2);
        }

        override public function onEditStart(_arg_1:IWindowContainer, _arg_2:Triggerable):void
        {
            var _local_3:int = _arg_2.intParams[0];
            getEvalSelector(_arg_1).setSelected(getEvalRadio(_arg_1, _local_3));
        }

        override public function get hasSpecialInputs():Boolean
        {
            return (true);
        }

        private function getEvalRadio(_arg_1:IWindowContainer, _arg_2:int):IRadioButtonWindow
        {
            return (IRadioButtonWindow(_arg_1.findChildByName((("eval_" + _arg_2) + "_radio"))));
        }

        private function getEvalSelector(_arg_1:IWindowContainer):ISelectorWindow
        {
            return (ISelectorWindow(_arg_1.findChildByName("eval_selector")));
        }


    }
}

