package com.sulake.habbo.roomevents.userdefinedroomevents.actiontypes
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
    import com.sulake.core.window.components.IRadioButtonWindow;
    import com.sulake.core.window.components.ISelectorWindow;

    public class GiveScoreToPredefinedTeam extends GiveScore 
    {


        override public function get code():int
        {
            return (_SafeStr_226.GIVE_SCORE_TO_PREDEFINED_TEAM);
        }

        override public function onEditStart(_arg_1:IWindowContainer, _arg_2:Triggerable):void
        {
            super.onEditStart(_arg_1, _arg_2);
            var _local_3:int = _arg_2.intParams[2];
            getTeamSelector(_arg_1).setSelected(getTeamRadio(_arg_1, _local_3));
        }

        override public function readIntParamsFromForm(_arg_1:IWindowContainer):Array
        {
            var _local_2:Array = super.readIntParamsFromForm(_arg_1);
            _local_2.push(getTeamSelector(_arg_1).getSelected().id);
            return (_local_2);
        }

        private function getTeamRadio(_arg_1:IWindowContainer, _arg_2:int):IRadioButtonWindow
        {
            return (IRadioButtonWindow(_arg_1.findChildByName((("team_" + _arg_2) + "_radio"))));
        }

        private function getTeamSelector(_arg_1:IWindowContainer):ISelectorWindow
        {
            return (ISelectorWindow(_arg_1.findChildByName("team_selector")));
        }


    }
}

