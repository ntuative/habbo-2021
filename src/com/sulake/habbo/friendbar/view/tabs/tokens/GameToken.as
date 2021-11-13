package com.sulake.habbo.friendbar.view.tabs.tokens
{
    import com.sulake.habbo.friendbar.data.IFriendEntity;
    import com.sulake.habbo.friendbar.data.IFriendNotification;

    public class GameToken extends Token 
    {

        public function GameToken(_arg_1:IFriendEntity, _arg_2:IFriendNotification)
        {
            super(_arg_2);
            var _local_3:String = _arg_2.message;
            var _local_4:String = (("${gamecenter." + _local_3) + ".name}");
            prepare("${friendbar.notify.game}", _local_4, "message_piece_xml", "snowball_notification_icon");
        }

    }
}