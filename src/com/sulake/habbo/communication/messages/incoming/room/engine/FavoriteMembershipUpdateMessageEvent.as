package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.FavouriteMembershipUpdateMessageParser;

        public class FavoriteMembershipUpdateMessageEvent extends MessageEvent 
    {

        public function FavoriteMembershipUpdateMessageEvent(_arg_1:Function)
        {
            super(_arg_1, FavouriteMembershipUpdateMessageParser);
        }

        public function getParser():FavouriteMembershipUpdateMessageParser
        {
            return (_SafeStr_816 as FavouriteMembershipUpdateMessageParser);
        }


    }
}

