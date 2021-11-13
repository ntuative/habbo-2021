package com.sulake.habbo.communication.messages.incoming.quest
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.quest.SeasonalQuestsMessageParser;

        public class SeasonalQuestsMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function SeasonalQuestsMessageEvent(_arg_1:Function)
        {
            super(_arg_1, SeasonalQuestsMessageParser);
        }

        public function getParser():SeasonalQuestsMessageParser
        {
            return (_SafeStr_816 as SeasonalQuestsMessageParser);
        }


    }
}

