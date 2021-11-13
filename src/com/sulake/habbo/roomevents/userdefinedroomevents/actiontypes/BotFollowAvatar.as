package com.sulake.habbo.roomevents.userdefinedroomevents.actiontypes
{
    import com.sulake.habbo.roomevents.userdefinedroomevents.UserDefinedRoomEventsCtrl;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.core.window.components.ISelectorWindow;
    import com.sulake.core.window.components.IRadioButtonWindow;

    public class BotFollowAvatar extends DefaultActionType 
    {


        override public function get code():int
        {
            return (_SafeStr_226.BOT_FOLLOW_AVATAR);
        }

        override public function get requiresFurni():int
        {
            return (UserDefinedRoomEventsCtrl.STUFF_SELECTION_OPTION_NONE);
        }

        override public function readStringParamFromForm(_arg_1:IWindowContainer):String
        {
            return (getInput(_arg_1, "bot_name").text);
        }

        override public function readIntParamsFromForm(_arg_1:IWindowContainer):Array
        {
            return ([getSelector(_arg_1, "type_selector").getSelected().id]);
        }

        override public function onEditStart(_arg_1:IWindowContainer, _arg_2:Triggerable):void
        {
            getInput(_arg_1, "bot_name").text = _arg_2.stringParam;
            getSelector(_arg_1, "type_selector").setSelected(getRadio(_arg_1, ("radio_" + _arg_2.intParams[0])));
        }

        override public function get hasSpecialInputs():Boolean
        {
            return (true);
        }

        private function getInput(_arg_1:IWindowContainer, _arg_2:String):ITextFieldWindow
        {
            return (ITextFieldWindow(_arg_1.findChildByName(_arg_2)));
        }

        private function getSelector(_arg_1:IWindowContainer, _arg_2:String):ISelectorWindow
        {
            return (ISelectorWindow(_arg_1.findChildByName(_arg_2)));
        }

        private function getRadio(_arg_1:IWindowContainer, _arg_2:String):IRadioButtonWindow
        {
            return (IRadioButtonWindow(_arg_1.findChildByName(_arg_2)));
        }


    }
}

