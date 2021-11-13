package com.sulake.habbo.communication.messages.parser.help
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class ChatReviewSessionStartedMessageParser implements IMessageParser 
    {

        private var _votingTimeout:int;
        private var _chatRecord:String;


        public function flush():Boolean
        {
            _votingTimeout = -1;
            _chatRecord = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _votingTimeout = _arg_1.readInteger();
            _chatRecord = _arg_1.readString();
            return (true);
        }

        public function get votingTimeout():int
        {
            return (_votingTimeout);
        }

        public function get chatRecord():String
        {
            return (_chatRecord);
        }


    }
}