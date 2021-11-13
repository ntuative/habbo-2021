package com.sulake.habbo.communication.messages.incoming.users
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.users.GroupMembershipRequestedMessageParser;

        public class GroupMembershipRequestedMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function GroupMembershipRequestedMessageEvent(_arg_1:Function)
        {
            super(_arg_1, GroupMembershipRequestedMessageParser);
        }

        public function getParser():GroupMembershipRequestedMessageParser
        {
            return (GroupMembershipRequestedMessageParser(_SafeStr_816));
        }


    }
}

