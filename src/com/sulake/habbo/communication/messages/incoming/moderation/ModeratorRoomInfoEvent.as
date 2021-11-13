package com.sulake.habbo.communication.messages.incoming.moderation
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.moderation.ModeratorRoomInfoMessageParser;

        public class ModeratorRoomInfoEvent extends MessageEvent implements IMessageEvent 
    {

        public function ModeratorRoomInfoEvent(_arg_1:Function)
        {
            super(_arg_1, ModeratorRoomInfoMessageParser);
        }

        public function getParser():ModeratorRoomInfoMessageParser
        {
            return (_SafeStr_816 as ModeratorRoomInfoMessageParser);
        }


    }
}

