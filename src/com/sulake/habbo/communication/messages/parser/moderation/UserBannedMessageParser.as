package com.sulake.habbo.communication.messages.parser.moderation
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class UserBannedMessageParser implements IMessageParser 
    {

        private var _message:String;


        public function get message():String
        {
            return (_message);
        }

        public function flush():Boolean
        {
            _message = "";
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _message = _arg_1.readString();
            return (true);
        }


    }
}