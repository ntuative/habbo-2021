package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.UsersMessageParser;

        public class UsersMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function UsersMessageEvent(_arg_1:Function)
        {
            super(_arg_1, UsersMessageParser);
        }

        public function getParser():UsersMessageParser
        {
            return (_SafeStr_816 as UsersMessageParser);
        }


    }
}

