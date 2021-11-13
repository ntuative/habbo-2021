package com.sulake.habbo.roomevents.userdefinedroomevents.conditions
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
    import com.sulake.core.window.components.ITextFieldWindow;

    public class ActorIsWearingEffect extends DefaultConditionType 
    {


        override public function get code():int
        {
            return (_SafeStr_228.ACTOR_IS_WEARING_EFFECT);
        }

        override public function get negativeCode():int
        {
            return (_SafeStr_228._SafeStr_645);
        }

        override public function readIntParamsFromForm(_arg_1:IWindowContainer):Array
        {
            var _local_2:Array = [];
            _local_2.push(getInput(_arg_1).text);
            return (_local_2);
        }

        override public function onEditStart(_arg_1:IWindowContainer, _arg_2:Triggerable):void
        {
            getInput(_arg_1).text = _arg_2.intParams[0];
        }

        override public function get hasSpecialInputs():Boolean
        {
            return (true);
        }

        private function getInput(_arg_1:IWindowContainer):ITextFieldWindow
        {
            return (ITextFieldWindow(_arg_1.findChildByName("effect_id")));
        }


    }
}

