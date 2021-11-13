package com.sulake.habbo.communication.messages.incoming.quest
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.quest.QuestCancelledMessageParser;

        public class QuestCancelledMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function QuestCancelledMessageEvent(_arg_1:Function)
        {
            super(_arg_1, QuestCancelledMessageParser);
        }

        public function getParser():QuestCancelledMessageParser
        {
            return (_SafeStr_816 as QuestCancelledMessageParser);
        }


    }
}

