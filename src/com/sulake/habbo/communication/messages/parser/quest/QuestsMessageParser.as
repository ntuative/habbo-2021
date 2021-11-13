package com.sulake.habbo.communication.messages.parser.quest
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.quest.QuestMessageData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class QuestsMessageParser implements IMessageParser 
    {

        private var _quests:Array;
        private var _openWindow:Boolean;


        public function flush():Boolean
        {
            _quests = [];
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_3:int;
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _quests.push(new QuestMessageData(_arg_1));
                _local_3++;
            };
            _openWindow = _arg_1.readBoolean();
            return (true);
        }

        public function get quests():Array
        {
            return (_quests);
        }

        public function get openWindow():Boolean
        {
            return (_openWindow);
        }


    }
}