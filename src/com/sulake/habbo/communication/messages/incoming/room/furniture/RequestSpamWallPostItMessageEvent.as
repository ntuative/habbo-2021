package com.sulake.habbo.communication.messages.incoming.room.furniture
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.furniture.RequestSpamWallPostItMessageParser;

        public class RequestSpamWallPostItMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function RequestSpamWallPostItMessageEvent(_arg_1:Function)
        {
            super(_arg_1, RequestSpamWallPostItMessageParser);
        }

        public function getParser():RequestSpamWallPostItMessageParser
        {
            return (_SafeStr_816 as RequestSpamWallPostItMessageParser);
        }


    }
}

