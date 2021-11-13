package com.sulake.habbo.quest.events
{
    import flash.events.Event;
    import com.sulake.habbo.communication.messages.incoming.quest.QuestMessageData;

    public class QuestCompletedEvent extends Event 
    {

        public static const QUEST_SEASONAL:String = "qce_seasonal";

        private var _questData:QuestMessageData;

        public function QuestCompletedEvent(_arg_1:String, _arg_2:QuestMessageData, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(_arg_1, _arg_3, _arg_4);
            _questData = _arg_2;
        }

        public function get questData():QuestMessageData
        {
            return (_questData);
        }


    }
}