package com.sulake.habbo.communication.messages.parser.help
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class GuideSessionMessageMessageParser implements IMessageParser 
    {

        private var _chatMessage:String;
        private var _senderId:int;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _chatMessage = _arg_1.readString();
            _senderId = _arg_1.readInteger();
            return (true);
        }

        public function get chatMessage():String
        {
            return (_chatMessage);
        }

        public function get senderId():int
        {
            return (_senderId);
        }


    }
}