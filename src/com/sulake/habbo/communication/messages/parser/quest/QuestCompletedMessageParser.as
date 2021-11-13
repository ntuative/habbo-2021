package com.sulake.habbo.communication.messages.parser.quest
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.quest.QuestMessageData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class QuestCompletedMessageParser implements IMessageParser 
    {

        private var _questData:QuestMessageData;
        private var _showDialog:Boolean;


        public function flush():Boolean
        {
            _questData = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _questData = new QuestMessageData(_arg_1);
            _showDialog = _arg_1.readBoolean();
            return (true);
        }

        public function get questData():QuestMessageData
        {
            return (_questData);
        }

        public function get showDialog():Boolean
        {
            return (_showDialog);
        }


    }
}