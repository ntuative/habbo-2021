package com.sulake.habbo.roomevents.userdefinedroomevents.conditions
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
    import com.sulake.core.window.components.ITextFieldWindow;

    public class ActorIsWearingBadge extends DefaultConditionType 
    {


        override public function get code():int
        {
            return (_SafeStr_228.ACTOR_IS_WEARING_BADGE);
        }

        override public function get negativeCode():int
        {
            return (_SafeStr_228.NOT_ACTOR_IS_WEARING_BADGE);
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
            return (ITextFieldWindow(_arg_1.findChildByName("badge_code")));
        }


    }
}

