package com.sulake.habbo.roomevents.userdefinedroomevents.actiontypes
{
    import com.sulake.habbo.roomevents.userdefinedroomevents.UserDefinedRoomEventsCtrl;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.core.window.components.ISelectorWindow;
    import com.sulake.core.window.components.IRadioButtonWindow;

    public class BotTalk extends DefaultActionType 
    {

        private static const STRING_PARAM_DELIMITER:String = "\t";


        override public function get code():int
        {
            return (_SafeStr_226.BOT_TALK);
        }

        override public function get requiresFurni():int
        {
            return (UserDefinedRoomEventsCtrl.STUFF_SELECTION_OPTION_NONE);
        }

        override public function readStringParamFromForm(_arg_1:IWindowContainer):String
        {
            var _local_2:String = getInput(_arg_1, "bot_name").text;
            var _local_3:String = getInput(_arg_1, "chat_message").text;
            return ((_local_2 + "\t") + _local_3);
        }

        override public function onEditStart(_arg_1:IWindowContainer, _arg_2:Triggerable):void
        {
            var _local_3:Array = _arg_2.stringParam.split("\t");
            getInput(_arg_1, "bot_name").text = ((_local_3.length >= 1) ? _local_3[0] : "");
            getInput(_arg_1, "chat_message").text = ((_local_3.length == 2) ? _local_3[1] : "");
            getSelector(_arg_1, "type_selector").setSelected(getRadio(_arg_1, ("radio_" + _arg_2.intParams[0])));
        }

        override public function readIntParamsFromForm(_arg_1:IWindowContainer):Array
        {
            return ([getSelector(_arg_1, "type_selector").getSelected().id]);
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

