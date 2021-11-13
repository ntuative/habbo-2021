package com.sulake.habbo.communication.messages.parser.help
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class IssueCloseNotificationMessageParser implements IMessageParser 
    {

        private var _closeReason:int;
        private var _messageText:String;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _closeReason = _arg_1.readInteger();
            _messageText = _arg_1.readString();
            return (true);
        }

        public function get closeReason():int
        {
            return (_closeReason);
        }

        public function get messageText():String
        {
            return (_messageText);
        }


    }
}