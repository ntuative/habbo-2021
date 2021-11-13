package com.sulake.habbo.friendlist.domain
{
    import com.sulake.habbo.friendlist.HabboFriendList;

    public class FriendListTabsDeps implements IFriendListTabsDeps 
    {

        private var _friendList:HabboFriendList;

        public function FriendListTabsDeps(_arg_1:HabboFriendList)
        {
            _friendList = _arg_1;
        }

        public function getFriendList():HabboFriendList
        {
            return (_friendList);
        }

        public function getWindowHeight():int
        {
            return (_friendList.view.mainWindow.height);
        }


    }
}