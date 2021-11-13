package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.UserUpdateMessageParser;

        public class UserUpdateMessageEvent extends MessageEvent 
    {

        public function UserUpdateMessageEvent(_arg_1:Function)
        {
            super(_arg_1, UserUpdateMessageParser);
        }

        public function getParser():UserUpdateMessageParser
        {
            return (_SafeStr_816 as UserUpdateMessageParser);
        }


    }
}

