package com.sulake.habbo.friendbar.events
{
    import flash.events.Event;
    import com.sulake.habbo.friendbar.data.IFriendNotification;

    public class NotificationEvent extends Event 
    {

        public static const FRIEND_NOTIFICATION_EVENT:String = "FBE_NOTIFICATION_EVENT";

        public var friendId:int;
        public var notification:IFriendNotification;

        public function NotificationEvent(_arg_1:int, _arg_2:IFriendNotification)
        {
            super("FBE_NOTIFICATION_EVENT");
            this.friendId = _arg_1;
            this.notification = _arg_2;
        }

    }
}