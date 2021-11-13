package com.sulake.habbo.messenger.events
{
    import flash.events.Event;

    public class ActiveConversationEvent extends Event 
    {

        public static const ACTIVE_CONVERSATION_COUNT_CHANGED:String = "ACCE_changed";

        private var _activeConversationsCount:int;

        public function ActiveConversationEvent(_arg_1:String, _arg_2:int=-1)
        {
            super(_arg_1);
            _activeConversationsCount = _arg_2;
        }

        public function get activeConversationsCount():int
        {
            return (_activeConversationsCount);
        }


    }
}