package com.sulake.habbo.communication.messages.incoming.room.furniture
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.furniture.GuildFurniContextMenuInfoMessageParser;

        public class GuildFurniContextMenuInfoMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function GuildFurniContextMenuInfoMessageEvent(_arg_1:Function)
        {
            super(_arg_1, GuildFurniContextMenuInfoMessageParser);
        }

        public function getParser():GuildFurniContextMenuInfoMessageParser
        {
            return (_SafeStr_816 as GuildFurniContextMenuInfoMessageParser);
        }


    }
}

