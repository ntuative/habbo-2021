package com.sulake.habbo.communication.messages.incoming.notifications
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.notifications.HabboBroadcastMessageParser;

        public class HabboBroadcastMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function HabboBroadcastMessageEvent(_arg_1:Function)
        {
            super(_arg_1, HabboBroadcastMessageParser);
        }

        public function get messageText():String
        {
            return ((_SafeStr_816 as HabboBroadcastMessageParser).messageText);
        }

        public function getParser():HabboBroadcastMessageParser
        {
            return (_SafeStr_816 as HabboBroadcastMessageParser);
        }


    }
}

