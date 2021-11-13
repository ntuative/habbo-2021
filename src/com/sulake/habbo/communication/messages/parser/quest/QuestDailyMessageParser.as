package com.sulake.habbo.communication.messages.parser.quest
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.quest.QuestMessageData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class QuestDailyMessageParser implements IMessageParser 
    {

        private var _quest:QuestMessageData;
        private var _easyQuestCount:int;
        private var _hardQuestCount:int;


        public function flush():Boolean
        {
            _quest = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_2:Boolean = _arg_1.readBoolean();
            if (_local_2)
            {
                _quest = new QuestMessageData(_arg_1);
                _easyQuestCount = _arg_1.readInteger();
                _hardQuestCount = _arg_1.readInteger();
            };
            return (true);
        }

        public function get quest():QuestMessageData
        {
            return (_quest);
        }

        public function get easyQuestCount():int
        {
            return (_easyQuestCount);
        }

        public function get hardQuestCount():int
        {
            return (_hardQuestCount);
        }


    }
}