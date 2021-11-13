package com.sulake.habbo.communication.messages.parser.handshake
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class UniqueMachineIDParser implements IMessageParser 
    {

        private var _machineID:String;

        public function UniqueMachineIDParser()
        {
            _machineID = "";
        }

        public function flush():Boolean
        {
            _machineID = "";
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _machineID = _arg_1.readString();
            return (true);
        }

        public function get machineID():String
        {
            return (_machineID);
        }


    }
}