package com.sulake.habbo.messenger
{
    public class ChatQueueEntry 
    {

        private var _conversationId:int;
        private var _chatEntry:ChatEntry;
        private var _updateIndicator:Boolean;

        public function ChatQueueEntry(_arg_1:int, _arg_2:ChatEntry, _arg_3:Boolean)
        {
            _conversationId = _arg_1;
            _chatEntry = _arg_2;
            _updateIndicator = _arg_3;
        }

        public function get conversationId():int
        {
            return (_conversationId);
        }

        public function get chatEntry():ChatEntry
        {
            return (_chatEntry);
        }

        public function get updateIndicator():Boolean
        {
            return (_updateIndicator);
        }


    }
}