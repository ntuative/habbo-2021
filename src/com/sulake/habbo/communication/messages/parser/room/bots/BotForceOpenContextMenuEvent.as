package com.sulake.habbo.communication.messages.parser.room.bots
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class BotForceOpenContextMenuEvent extends MessageEvent implements IMessageEvent 
    {

        public function BotForceOpenContextMenuEvent(_arg_1:Function)
        {
            super(_arg_1, BotForceOpenContextMenuParser);
        }

        public function getParser():BotForceOpenContextMenuParser
        {
            return (_SafeStr_816 as BotForceOpenContextMenuParser);
        }


    }
}

