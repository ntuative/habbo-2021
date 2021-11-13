package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class ConditionDefinition extends Triggerable 
    {

        private var _code:int;

        public function ConditionDefinition(_arg_1:IMessageDataWrapper)
        {
            super(_arg_1);
            _code = _arg_1.readInteger();
        }

        public function get type():int
        {
            return (_code);
        }

        override public function get code():int
        {
            return (_code);
        }


    }
}