package com.sulake.habbo.communication.messages.parser.error
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class ErrorReportMessageParser implements IMessageParser 
    {

        private var _errorCode:int;
        private var _messageId:int;
        private var _timestamp:String;


        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _messageId = _arg_1.readInteger();
            _errorCode = _arg_1.readInteger();
            _timestamp = _arg_1.readString();
            return (true);
        }

        public function flush():Boolean
        {
            _errorCode = 0;
            _messageId = 0;
            _timestamp = null;
            return (true);
        }

        public function get errorCode():int
        {
            return (_errorCode);
        }

        public function get messageId():int
        {
            return (_messageId);
        }

        public function get timestamp():String
        {
            return (_timestamp);
        }


    }
}