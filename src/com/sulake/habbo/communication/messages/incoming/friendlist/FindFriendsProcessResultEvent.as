package com.sulake.habbo.communication.messages.incoming.friendlist
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.friendlist.FindFriendsProcessResultMessageParser;

        public class FindFriendsProcessResultEvent extends MessageEvent implements IMessageEvent 
    {

        public function FindFriendsProcessResultEvent(_arg_1:Function)
        {
            super(_arg_1, FindFriendsProcessResultMessageParser);
        }

        public function get success():Boolean
        {
            return (FindFriendsProcessResultMessageParser(_SafeStr_816).success);
        }


    }
}

