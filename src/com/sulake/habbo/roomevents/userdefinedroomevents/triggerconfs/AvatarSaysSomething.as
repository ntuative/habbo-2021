package com.sulake.habbo.roomevents.userdefinedroomevents.triggerconfs
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.core.window.components.IRadioButtonWindow;
    import com.sulake.core.window.components.ISelectorWindow;

    public class AvatarSaysSomething extends DefaultTriggerConf 
    {


        override public function get code():int
        {
            return (_SafeStr_194.AVATAR_SAYS_SOMETHING);
        }

        override public function readIntParamsFromForm(_arg_1:IWindowContainer):Array
        {
            var _local_2:Array = [];
            _local_2.push(((getMeRadio(_arg_1).isSelected) ? 1 : 0));
            return (_local_2);
        }

        override public function readStringParamFromForm(_arg_1:IWindowContainer):String
        {
            return (getInput(_arg_1).text);
        }

        override public function onInit(_arg_1:IWindowContainer, _arg_2:HabboUserDefinedRoomEvents):void
        {
            _arg_1.findChildByName("me_txt").caption = _arg_2.userName;
        }

        override public function onEditStart(_arg_1:IWindowContainer, _arg_2:Triggerable):void
        {
            getInput(_arg_1).text = _arg_2.stringParam;
            if (((_arg_2.intParams.length > 0) && (_arg_2.intParams[0] == 1)))
            {
                getSelector(_arg_1).setSelected(getMeRadio(_arg_1));
            }
            else
            {
                getSelector(_arg_1).setSelected(getAnyAvatarRadio(_arg_1));
            };
        }

        override public function get hasSpecialInputs():Boolean
        {
            return (true);
        }

        private function getInput(_arg_1:IWindowContainer):ITextFieldWindow
        {
            return (ITextFieldWindow(_arg_1.findChildByName("chat_txt")));
        }

        private function getAnyAvatarRadio(_arg_1:IWindowContainer):IRadioButtonWindow
        {
            return (IRadioButtonWindow(_arg_1.findChildByName("any_avatar_radio")));
        }

        private function getMeRadio(_arg_1:IWindowContainer):IRadioButtonWindow
        {
            return (IRadioButtonWindow(_arg_1.findChildByName("me_radio")));
        }

        private function getSelector(_arg_1:IWindowContainer):ISelectorWindow
        {
            return (ISelectorWindow(_arg_1.findChildByName("avatar_radio")));
        }


    }
}

