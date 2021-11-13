package com.sulake.habbo.messenger.events
{
    import flash.events.Event;

    public class MiniMailMessageEvent extends Event 
    {

        public static const _SafeStr_2800:String = "MMME_new";
        public static const _SafeStr_2801:String = "MMME_unread";

        private var _unreadCount:int;

        public function MiniMailMessageEvent(_arg_1:String, _arg_2:int=-1)
        {
            super(_arg_1);
            _unreadCount = _arg_2;
        }

        public function get unreadCount():int
        {
            return (_unreadCount);
        }


    }
}

