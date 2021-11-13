package com.sulake.habbo.friendbar.events
{
    import flash.events.Event;

    public class FriendRequestUpdateEvent extends Event 
    {

        public static const FRIEND_REQUEST_UPDATE:String = "FBE_REQUESTS";

        public function FriendRequestUpdateEvent()
        {
            super("FBE_REQUESTS", false, false);
        }

    }
}