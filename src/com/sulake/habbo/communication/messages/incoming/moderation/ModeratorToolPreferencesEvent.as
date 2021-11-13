package com.sulake.habbo.communication.messages.incoming.moderation
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.moderation.ModeratorToolPreferencesMessageParser;

        public class ModeratorToolPreferencesEvent extends MessageEvent implements IMessageEvent 
    {

        public function ModeratorToolPreferencesEvent(_arg_1:Function)
        {
            super(_arg_1, ModeratorToolPreferencesMessageParser);
        }

        public function getParser():ModeratorToolPreferencesMessageParser
        {
            return (parser as ModeratorToolPreferencesMessageParser);
        }


    }
}