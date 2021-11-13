package com.sulake.habbo.communication.messages.incoming.quest
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.quest.QuestCompletedMessageParser;

        public class QuestCompletedMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function QuestCompletedMessageEvent(_arg_1:Function)
        {
            super(_arg_1, QuestCompletedMessageParser);
        }

        public function getParser():QuestCompletedMessageParser
        {
            return (_SafeStr_816 as QuestCompletedMessageParser);
        }


    }
}

