package com.sulake.habbo.communication.messages.incoming.moderation
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.moderation.ModeratorActionResultMessageParser;

        public class ModeratorActionResultMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function ModeratorActionResultMessageEvent(_arg_1:Function)
        {
            super(_arg_1, ModeratorActionResultMessageParser);
        }

        public function getParser():ModeratorActionResultMessageParser
        {
            return (_SafeStr_816 as ModeratorActionResultMessageParser);
        }


    }
}

