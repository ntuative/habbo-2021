package com.sulake.habbo.communication.messages.incoming.quest
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.quest.QuestMessageParser;

        public class QuestMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function QuestMessageEvent(_arg_1:Function)
        {
            super(_arg_1, QuestMessageParser);
        }

        public function getParser():QuestMessageParser
        {
            return (_SafeStr_816 as QuestMessageParser);
        }


    }
}

