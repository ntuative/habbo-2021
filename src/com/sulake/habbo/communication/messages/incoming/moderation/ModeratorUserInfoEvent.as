package com.sulake.habbo.communication.messages.incoming.moderation
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.moderation.ModeratorUserInfoMessageParser;

        public class ModeratorUserInfoEvent extends MessageEvent implements IMessageEvent 
    {

        public function ModeratorUserInfoEvent(_arg_1:Function)
        {
            super(_arg_1, ModeratorUserInfoMessageParser);
        }

        public function getParser():ModeratorUserInfoMessageParser
        {
            return (_SafeStr_816 as ModeratorUserInfoMessageParser);
        }


    }
}

