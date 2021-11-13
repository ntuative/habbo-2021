package com.sulake.habbo.friendlist.domain
{
    import com.sulake.habbo.friendlist.HabboFriendList;
    import com.sulake.habbo.friendlist.ISearchView;

    public class AvatarSearchDeps implements IAvatarSearchDeps 
    {

        private var _friendList:HabboFriendList;

        public function AvatarSearchDeps(_arg_1:HabboFriendList)
        {
            _friendList = _arg_1;
        }

        public function get view():ISearchView
        {
            return (_friendList.tabs.findTab(3).tabView as ISearchView);
        }


    }
}