package com.sulake.habbo.friendbar.groupforums
{
    import flash.events.Event;

    public class UnseenForumsCountUpdatedEvent extends Event 
    {

        public static const TYPE:String = "UNSEEN_FORUMS_COUNT";

        private var _unseenForumsCount:int;

        public function UnseenForumsCountUpdatedEvent(_arg_1:String, _arg_2:int)
        {
            super(_arg_1);
            _unseenForumsCount = _arg_2;
        }

        public function get unseenForumsCount():int
        {
            return (_unseenForumsCount);
        }


    }
}