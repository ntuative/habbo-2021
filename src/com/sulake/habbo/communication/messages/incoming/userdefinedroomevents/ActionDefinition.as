package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class ActionDefinition extends Triggerable 
    {

        private var _code:int;
        private var _delayInPulses:int;
        private var _conflictingTriggers:Array = [];

        public function ActionDefinition(_arg_1:IMessageDataWrapper)
        {
            var _local_3:int;
            super(_arg_1);
            _code = _arg_1.readInteger();
            _delayInPulses = _arg_1.readInteger();
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _conflictingTriggers.push(_arg_1.readInteger());
                _local_3++;
            };
        }

        public function get type():int
        {
            return (_code);
        }

        override public function get code():int
        {
            return (_code);
        }

        public function get delayInPulses():int
        {
            return (_delayInPulses);
        }

        public function get conflictingTriggers():Array
        {
            return (_conflictingTriggers);
        }


    }
}