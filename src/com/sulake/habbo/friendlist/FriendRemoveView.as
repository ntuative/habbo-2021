package com.sulake.habbo.friendlist
{
    import com.sulake.habbo.friendlist.domain.Friend;
    import flash.utils.Dictionary;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.communication.messages.outgoing.friendlist.RemoveFriendMessageComposer;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class FriendRemoveView extends AlertView 
    {

        private var _selected:Array;

        public function FriendRemoveView(_arg_1:HabboFriendList)
        {
            super(_arg_1, "friend_remove_confirm");
            _selected = _arg_1.categories.getSelectedFriends();
        }

        override public function dispose():void
        {
            _selected = null;
            super.dispose();
        }

        override internal function setupContent(_arg_1:IWindowContainer):void
        {
            _arg_1.findChildByName("cancel").procedure = onClose;
            _arg_1.findChildByName("ok").procedure = onRemove;
            var _local_4:Array = [];
            for each (var _local_2:Friend in _selected)
            {
                _local_4.push(_local_2.name);
            };
            var _local_5:String = Util.arrayToString(_local_4);
            var _local_3:Dictionary = new Dictionary();
            friendList.registerParameter("friendlist.removefriendconfirm.userlist", "user_names", _local_5);
        }

        private function onRemove(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            Logger.log("Remove Ok clicked");
            var _local_3:RemoveFriendMessageComposer = new RemoveFriendMessageComposer();
            for each (var _local_4:Friend in _selected)
            {
                _local_3.addRemovedFriend(_local_4.id);
            };
            friendList.send(_local_3);
            dispose();
        }


    }
}

