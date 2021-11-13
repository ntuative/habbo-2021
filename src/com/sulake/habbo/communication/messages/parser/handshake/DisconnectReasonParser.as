package com.sulake.habbo.communication.messages.parser.handshake
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class DisconnectReasonParser implements IMessageParser 
    {

        private var _reason:int;

        public function DisconnectReasonParser()
        {
            _reason = -1;
        }

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            if (_arg_1.bytesAvailable)
            {
                _reason = _arg_1.readInteger();
            };
            return (true);
        }

        public function get reason():int
        {
            return (_reason);
        }


    }
}