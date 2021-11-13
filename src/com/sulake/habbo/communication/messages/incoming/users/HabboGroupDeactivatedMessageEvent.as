package com.sulake.habbo.communication.messages.incoming.users
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.users.HabboGroupDeactivatedMessageParser;

        public class HabboGroupDeactivatedMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function HabboGroupDeactivatedMessageEvent(_arg_1:Function)
        {
            super(_arg_1, HabboGroupDeactivatedMessageParser);
        }

        public function get groupId():int
        {
            return (HabboGroupDeactivatedMessageParser(_SafeStr_816).groupId);
        }


    }
}

