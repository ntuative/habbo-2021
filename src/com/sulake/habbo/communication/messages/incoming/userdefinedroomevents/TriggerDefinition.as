package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class TriggerDefinition extends Triggerable 
    {

        private var _code:int;
        private var _conflictingActions:Array = [];

        public function TriggerDefinition(_arg_1:IMessageDataWrapper)
        {
            var _local_3:int;
            super(_arg_1);
            _code = _arg_1.readInteger();
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _conflictingActions.push(_arg_1.readInteger());
                _local_3++;
            };
        }

        public function get triggerConf():int
        {
            return (_code);
        }

        override public function get code():int
        {
            return (_code);
        }

        public function get conflictingActions():Array
        {
            return (_conflictingActions);
        }


    }
}