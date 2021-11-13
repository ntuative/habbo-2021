package com.sulake.habbo.communication.messages.incoming.quest
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.quest.QuestDailyMessageParser;

        public class QuestDailyMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function QuestDailyMessageEvent(_arg_1:Function)
        {
            super(_arg_1, QuestDailyMessageParser);
        }

        public function getParser():QuestDailyMessageParser
        {
            return (_SafeStr_816 as QuestDailyMessageParser);
        }


    }
}

