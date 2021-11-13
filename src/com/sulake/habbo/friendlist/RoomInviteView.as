package com.sulake.habbo.friendlist
{
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowKeyboardEvent;
    import com.sulake.habbo.communication.messages.outgoing.friendlist.SendRoomInviteMessageComposer;
    import com.sulake.habbo.friendlist.domain.Friend;

    public class RoomInviteView extends AlertView 
    {

        private var _selected:Array;
        private var _inputMessage:ITextFieldWindow;

        public function RoomInviteView(_arg_1:HabboFriendList)
        {
            super(_arg_1, "room_invite_confirm");
            _selected = _arg_1.categories.getSelectedFriends();
        }

        override public function dispose():void
        {
            _selected = null;
            _inputMessage = null;
            super.dispose();
        }

        override internal function setupContent(_arg_1:IWindowContainer):void
        {
            friendList.registerParameter("friendlist.invite.summary", "count", ("" + _selected.length));
            _inputMessage = ITextFieldWindow(_arg_1.findChildByName("message_input"));
            _inputMessage.addEventListener("WKE_KEY_DOWN", onMessageInput);
            _arg_1.findChildByName("cancel").procedure = onClose;
            _arg_1.findChildByName("ok").procedure = onInvite;
        }

        private function onInvite(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            Logger.log("Invite Ok clicked");
            sendMsg();
            dispose();
        }

        private function onMessageInput(_arg_1:WindowKeyboardEvent):void
        {
            var _local_2:int;
            var _local_3:String;
            var _local_4:IWindow = IWindow(_arg_1.target);
            Logger.log(((((("Test key event " + _arg_1) + ", ") + _arg_1.type) + " ") + _local_4.name));
            if (_arg_1.charCode == 13)
            {
                sendMsg();
            }
            else
            {
                _local_2 = 120;
                _local_3 = _inputMessage.text;
                if (_local_3.length > _local_2)
                {
                    _inputMessage.text = _local_3.substring(0, _local_2);
                };
            };
        }

        private function sendMsg():void
        {
            var _local_3:String = _inputMessage.text;
            Logger.log(("Send msg: " + _local_3));
            if (_local_3 == "")
            {
                friendList.simpleAlert("${friendlist.invite.emptyalert.title}", "${friendlist.invite.emptyalert.text}");
                return;
            };
            var _local_1:SendRoomInviteMessageComposer = new SendRoomInviteMessageComposer(_local_3);
            for each (var _local_2:Friend in _selected)
            {
                _local_1.addInvitedFriend(_local_2.id);
            };
            friendList.resetLastRoomInvitationTime();
            friendList.send(_local_1);
            dispose();
        }


    }
}

