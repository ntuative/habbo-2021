package com.sulake.habbo.roomevents.userdefinedroomevents.actiontypes
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;

    public class Chat extends DefaultActionType 
    {


        override public function get code():int
        {
            return (_SafeStr_226.CHAT);
        }

        override public function readStringParamFromForm(_arg_1:IWindowContainer):String
        {
            return (getInput(_arg_1).text);
        }

        override public function onEditStart(_arg_1:IWindowContainer, _arg_2:Triggerable):void
        {
            getInput(_arg_1).text = _arg_2.stringParam;
        }

        override public function get hasSpecialInputs():Boolean
        {
            return (true);
        }

        private function getInput(_arg_1:IWindowContainer):ITextFieldWindow
        {
            return (ITextFieldWindow(_arg_1.findChildByName("chat_message")));
        }

        override public function validate(_arg_1:IWindowContainer, _arg_2:HabboUserDefinedRoomEvents):String
        {
            var _local_4:String;
            var _local_3:int = 100;
            if (getInput(_arg_1).text.length > _local_3)
            {
                _local_4 = "wiredfurni.chatmsgtoolong";
                return (_arg_2.localization.getLocalization(_local_4, _local_4));
            };
            return (null);
        }


    }
}

