package com.sulake.habbo.ui.widget.friendrequest
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.core.runtime.Component;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.ui.widget.events.RoomWidgetFriendRequestUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUserLocationUpdateEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetGetObjectLocationMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetFriendRequestMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetOpenProfileMessage;

    public class FriendRequestWidget extends RoomWidgetBase implements IUpdateReceiver 
    {

        private var _SafeStr_659:Component;
        private var _SafeStr_2147:Map;

        public function FriendRequestWidget(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary, _arg_4:IHabboLocalizationManager, _arg_5:Component)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
            _SafeStr_659 = _arg_5;
            _SafeStr_2147 = new Map();
        }

        override public function dispose():void
        {
            if (disposed)
            {
                return;
            };
            if (_SafeStr_659)
            {
                _SafeStr_659.removeUpdateReceiver(this);
                _SafeStr_659 = null;
            };
            if (_SafeStr_2147)
            {
                for each (var _local_1:FriendRequestDialog in _SafeStr_2147)
                {
                    _local_1.dispose();
                    _local_1 = null;
                };
                _SafeStr_2147.dispose();
                _SafeStr_2147 = null;
            };
            super.dispose();
        }

        override public function registerUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (!_arg_1)
            {
                return;
            };
            _arg_1.addEventListener("RWFRUE_SHOW_FRIEND_REQUEST", eventHandler);
            _arg_1.addEventListener("RWFRUE_HIDE_FRIEND_REQUEST", eventHandler);
            super.registerUpdateEvents(_arg_1);
        }

        override public function unregisterUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            _arg_1.removeEventListener("RWFRUE_SHOW_FRIEND_REQUEST", eventHandler);
            _arg_1.removeEventListener("RWFRUE_HIDE_FRIEND_REQUEST", eventHandler);
        }

        private function eventHandler(_arg_1:RoomWidgetFriendRequestUpdateEvent):void
        {
            if (!_arg_1)
            {
                return;
            };
            switch (_arg_1.type)
            {
                case "RWFRUE_SHOW_FRIEND_REQUEST":
                    addRequest(_arg_1.requestId, new FriendRequestDialog(this, _arg_1.requestId, _arg_1.userId, _arg_1.userName));
                    break;
                case "RWFRUE_HIDE_FRIEND_REQUEST":
                    removeRequest(_arg_1.requestId);
            };
            checkUpdateNeed();
        }

        public function checkUpdateNeed():void
        {
            if (!_SafeStr_659)
            {
                return;
            };
            if (((_SafeStr_2147) && (_SafeStr_2147.length > 0)))
            {
                _SafeStr_659.registerUpdateReceiver(this, 10);
            }
            else
            {
                _SafeStr_659.removeUpdateReceiver(this);
            };
        }

        public function update(_arg_1:uint):void
        {
            var _local_3:RoomWidgetUserLocationUpdateEvent;
            if (!_SafeStr_2147)
            {
                return;
            };
            for each (var _local_2:FriendRequestDialog in _SafeStr_2147)
            {
                if (_local_2)
                {
                    _local_3 = (messageListener.processWidgetMessage(new RoomWidgetGetObjectLocationMessage("RWGOI_MESSAGE_GET_OBJECT_LOCATION", _local_2.userId, 1)) as RoomWidgetUserLocationUpdateEvent);
                    if (_local_3)
                    {
                        _local_2.targetRect = _local_3.rectangle;
                    };
                };
            };
        }

        public function acceptRequest(_arg_1:int):void
        {
            if (!messageListener)
            {
                return;
            };
            messageListener.processWidgetMessage(new RoomWidgetFriendRequestMessage("RWFRM_ACCEPT", _arg_1));
            removeRequest(_arg_1);
        }

        public function declineRequest(_arg_1:int):void
        {
            if (!messageListener)
            {
                return;
            };
            messageListener.processWidgetMessage(new RoomWidgetFriendRequestMessage("RWFRM_DECLINE", _arg_1));
            removeRequest(_arg_1);
        }

        public function ignoreRequest(_arg_1:int):void
        {
            removeRequest(_arg_1);
        }

        private function addRequest(_arg_1:int, _arg_2:FriendRequestDialog):void
        {
            if (((!(_SafeStr_2147)) || (!(_arg_2))))
            {
                return;
            };
            _SafeStr_2147.add(_arg_1, _arg_2);
        }

        private function removeRequest(_arg_1:int):void
        {
            if (!_SafeStr_2147)
            {
                return;
            };
            var _local_2:FriendRequestDialog = (_SafeStr_2147.getValue(_arg_1) as FriendRequestDialog);
            if (!_local_2)
            {
                return;
            };
            _SafeStr_2147.remove(_arg_1);
            _local_2.dispose();
            checkUpdateNeed();
        }

        public function showProfile(_arg_1:int, _arg_2:String):void
        {
            messageListener.processWidgetMessage(new RoomWidgetOpenProfileMessage("RWOPEM_OPEN_USER_PROFILE", _arg_1, _arg_2));
        }


    }
}

