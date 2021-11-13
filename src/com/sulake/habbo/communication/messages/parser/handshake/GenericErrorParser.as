package com.sulake.habbo.communication.messages.parser.handshake
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class GenericErrorParser implements IMessageParser 
    {

        private var _errorCode:int;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _errorCode = _arg_1.readInteger();
            return (true);
        }

        public function get errorCode():int
        {
            return (_errorCode);
        }


    }
}