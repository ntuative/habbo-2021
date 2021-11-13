package com.sulake.habbo.roomevents.userdefinedroomevents.triggerconfs
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.core.window.components.IRadioButtonWindow;
    import com.sulake.core.window.components.ISelectorWindow;
    import com.sulake.core.window.events.WindowEvent;

    public class AvatarEntersRoom extends DefaultTriggerConf 
    {

        private var _cont:IWindowContainer;


        override public function get code():int
        {
            return (_SafeStr_194.AVATAR_ENTERS_ROOM);
        }

        override public function readStringParamFromForm(_arg_1:IWindowContainer):String
        {
            var _local_2:String = getInput().text;
            return ((getCertainAvatarRadio().isSelected) ? _local_2 : "");
        }

        override public function onInit(_arg_1:IWindowContainer, _arg_2:HabboUserDefinedRoomEvents):void
        {
            _cont = _arg_1;
            getCertainAvatarRadio().addEventListener("WE_SELECT", onCertainAvatarSelect);
            getCertainAvatarRadio().addEventListener("WE_UNSELECT", onCertainAvatarUnselect);
        }

        override public function onEditStart(_arg_1:IWindowContainer, _arg_2:Triggerable):void
        {
            if (_arg_2.stringParam != "")
            {
                getSelector().setSelected(getCertainAvatarRadio());
                getInput().text = _arg_2.stringParam;
                getInput().visible = true;
            }
            else
            {
                getSelector().setSelected(getAnyAvatarRadio());
                getInput().text = "";
                getInput().visible = false;
            };
        }

        override public function get hasSpecialInputs():Boolean
        {
            return (true);
        }

        private function getInput():ITextFieldWindow
        {
            return (ITextFieldWindow(_cont.findChildByName("avatar_name_txt")));
        }

        private function getCertainAvatarRadio():IRadioButtonWindow
        {
            return (IRadioButtonWindow(_cont.findChildByName("certain_avatar_radio")));
        }

        private function getAnyAvatarRadio():IRadioButtonWindow
        {
            return (IRadioButtonWindow(_cont.findChildByName("any_avatar_radio")));
        }

        private function getSelector():ISelectorWindow
        {
            return (ISelectorWindow(_cont.findChildByName("avatar_radio")));
        }

        private function onCertainAvatarSelect(_arg_1:WindowEvent):void
        {
            getInput().visible = true;
        }

        private function onCertainAvatarUnselect(_arg_1:WindowEvent):void
        {
            getInput().text = "";
            getInput().visible = false;
        }


    }
}

