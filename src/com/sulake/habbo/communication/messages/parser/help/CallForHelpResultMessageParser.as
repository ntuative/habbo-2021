package com.sulake.habbo.communication.messages.parser.help
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class CallForHelpResultMessageParser implements IMessageParser 
    {

        private var _resultType:int;
        private var _messageText:String;


        public function get resultType():int
        {
            return (_resultType);
        }

        public function get messageText():String
        {
            return (_messageText);
        }

        public function flush():Boolean
        {
            _resultType = -1;
            _messageText = "";
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _resultType = _arg_1.readInteger();
            _messageText = _arg_1.readString();
            return (true);
        }


    }
}