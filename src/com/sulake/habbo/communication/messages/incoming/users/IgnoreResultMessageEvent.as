package com.sulake.habbo.communication.messages.incoming.users
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.users.IgnoreResultMessageParser;

        public class IgnoreResultMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function IgnoreResultMessageEvent(_arg_1:Function)
        {
            super(_arg_1, IgnoreResultMessageParser);
        }

        public function get result():int
        {
            return ((_SafeStr_816 as IgnoreResultMessageParser).result);
        }

        public function get name():String
        {
            return ((_SafeStr_816 as IgnoreResultMessageParser).name);
        }


    }
}

