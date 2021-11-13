package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetFriendRequestMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetFriendRequestUpdateEvent;
    import com.sulake.habbo.session.events.RoomSessionFriendRequestEvent;
    import com.sulake.habbo.friendlist.events.FriendRequestEvent;
    import flash.events.Event;

    public class FriendRequestWidgetHandler implements IRoomWidgetHandler 
    {

        private var _disposed:Boolean = false;
        private var _container:IRoomWidgetHandlerContainer = null;


        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get type():String
        {
            return ("RWE_ROOM_POLL");
        }

        public function set container(_arg_1:IRoomWidgetHandlerContainer):void
        {
            _container = _arg_1;
        }

        public function dispose():void
        {
            _disposed = true;
            _container = null;
        }

        public function getWidgetMessages():Array
        {
            var _local_1:Array = [];
            _local_1.push("RWFRM_ACCEPT");
            _local_1.push("RWFRM_DECLINE");
            return (_local_1);
        }

        public function processWidgetMessage(_arg_1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            var _local_2:RoomWidgetFriendRequestMessage;
            var _local_3:RoomWidgetFriendRequestMessage;
            if (((!(_arg_1)) || (!(_container))))
            {
                return (null);
            };
            switch (_arg_1.type)
            {
                case "RWFRM_ACCEPT":
                    _local_2 = (_arg_1 as RoomWidgetFriendRequestMessage);
                    if (((!(_local_2)) || (!(_container.friendList))))
                    {
                        return (null);
                    };
                    _container.friendList.acceptFriendRequest(_local_2.requestId);
                    break;
                case "RWFRM_DECLINE":
                    _local_3 = (_arg_1 as RoomWidgetFriendRequestMessage);
                    if (((!(_local_3)) || (!(_container.friendList))))
                    {
                        return (null);
                    };
                    _container.friendList.declineFriendRequest(_local_3.requestId);
            };
            return (null);
        }

        public function getProcessedEvents():Array
        {
            var _local_1:Array = [];
            _local_1.push("RSFRE_FRIEND_REQUEST");
            _local_1.push("FRE_ACCEPTED");
            _local_1.push("FRE_DECLINED");
            return (_local_1);
        }

        public function processEvent(_arg_1:Event):void
        {
            var _local_3:RoomWidgetFriendRequestUpdateEvent;
            var _local_5:String;
            var _local_2:RoomSessionFriendRequestEvent;
            var _local_4:FriendRequestEvent;
            if (((_container == null) || (_container.events == null)))
            {
                return;
            };
            switch (_arg_1.type)
            {
                case "RSFRE_FRIEND_REQUEST":
                    _local_2 = (_arg_1 as RoomSessionFriendRequestEvent);
                    if (!_local_2)
                    {
                        return;
                    };
                    _local_5 = "RWFRUE_SHOW_FRIEND_REQUEST";
                    _local_3 = new RoomWidgetFriendRequestUpdateEvent(_local_5, _local_2.requestId, _local_2.userId, _local_2.userName);
                    break;
                case "FRE_ACCEPTED":
                case "FRE_DECLINED":
                    _local_4 = (_arg_1 as FriendRequestEvent);
                    if (!_local_4)
                    {
                        return;
                    };
                    _local_5 = "RWFRUE_HIDE_FRIEND_REQUEST";
                    _local_3 = new RoomWidgetFriendRequestUpdateEvent(_local_5, _local_4.requestId);
            };
            if (_local_3)
            {
                _container.events.dispatchEvent(_local_3);
            };
        }

        public function update():void
        {
        }


    }
}