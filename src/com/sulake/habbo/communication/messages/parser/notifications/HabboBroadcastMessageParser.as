package com.sulake.habbo.communication.messages.parser.notifications
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class HabboBroadcastMessageParser implements IMessageParser 
    {

        private var _messageText:String = "";


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _messageText = _arg_1.readString();
            return (true);
        }

        public function get messageText():String
        {
            return (_messageText);
        }


    }
}