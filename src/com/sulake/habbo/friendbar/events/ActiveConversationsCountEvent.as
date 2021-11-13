package com.sulake.habbo.friendbar.events
{
    import flash.events.Event;

    public class ActiveConversationsCountEvent extends Event 
    {

        public static const ACTIVE_MESSENGER_CONVERSATION_EVENT:String = "AMC_EVENT";

        private var _activeConversationsCount:int;

        public function ActiveConversationsCountEvent(_arg_1:int=-1)
        {
            _activeConversationsCount = _arg_1;
            super("AMC_EVENT");
        }

        public function get activeConversationsCount():int
        {
            return (_activeConversationsCount);
        }


    }
}