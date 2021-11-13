package com.sulake.habbo.communication.messages.parser.quest
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.quest.QuestMessageData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class QuestMessageParser implements IMessageParser 
    {

        private var _quest:QuestMessageData;


        public function flush():Boolean
        {
            _quest = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _quest = new QuestMessageData(_arg_1);
            return (true);
        }

        public function get quest():QuestMessageData
        {
            return (_quest);
        }


    }
}