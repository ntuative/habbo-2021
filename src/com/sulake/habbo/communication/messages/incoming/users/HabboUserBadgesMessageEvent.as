package com.sulake.habbo.communication.messages.incoming.users
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.users.HabboUserBadgesMessageParser;

        public class HabboUserBadgesMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function HabboUserBadgesMessageEvent(_arg_1:Function)
        {
            super(_arg_1, HabboUserBadgesMessageParser);
        }

        public function get badges():Array
        {
            return ((_SafeStr_816 as HabboUserBadgesMessageParser).badges);
        }

        public function get userId():int
        {
            return ((_SafeStr_816 as HabboUserBadgesMessageParser).userId);
        }


    }
}

