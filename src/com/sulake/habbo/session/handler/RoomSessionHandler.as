package com.sulake.habbo.session.handler
{
    import com.sulake.habbo.communication.messages.parser.room.session.OpenConnectionMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.session.FlatAccessibleMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.session.RoomReadyMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.session.CloseConnectionMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.FlatAccessDeniedMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.session.RoomQueueStatusMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.session.YouAreSpectatorMessageEvent;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.session.IRoomHandlerListener;
    import com.sulake.habbo.communication.messages.parser.room.session.OpenConnectionMessageParser;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.habbo.communication.messages.parser.room.session.FlatAccessibleMessageParser;
    import com.sulake.habbo.session.events.RoomSessionDoorbellEvent;
    import com.sulake.habbo.communication.messages.parser.room.session.RoomReadyMessageParser;
    import com.sulake.core.utils.ErrorReportStorage;
    import com.sulake.habbo.communication.messages.parser.navigator.FlatAccessDeniedMessageParser;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.session.RoomQueueSet;
    import com.sulake.habbo.session.events.RoomSessionQueueEvent;
    import com.sulake.habbo.communication.messages.parser.room.session.RoomQueueStatusMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.session.YouAreSpectatorMessageParser;

    public class RoomSessionHandler extends BaseHandler 
    {

        public static const _SafeStr_3698:String = "RS_CONNECTED";
        public static const _SafeStr_3699:String = "RS_READY";
        public static const _SafeStr_3700:String = "RS_DISCONNECTED";

        public function RoomSessionHandler(_arg_1:IConnection, _arg_2:IRoomHandlerListener)
        {
            super(_arg_1, _arg_2);
            if (_arg_1 == null)
            {
                return;
            };
            _arg_1.addMessageEvent(new OpenConnectionMessageEvent(onRoomConnected));
            _arg_1.addMessageEvent(new FlatAccessibleMessageEvent(onFlatAccessible));
            _arg_1.addMessageEvent(new RoomReadyMessageEvent(onRoomReady));
            _arg_1.addMessageEvent(new CloseConnectionMessageEvent(onRoomDisconnected));
            _arg_1.addMessageEvent(new FlatAccessDeniedMessageEvent(onFlatAccessDenied));
            _arg_1.addMessageEvent(new RoomQueueStatusMessageEvent(onRoomQueueStatus));
            _arg_1.addMessageEvent(new YouAreSpectatorMessageEvent(onYouAreSpectator));
        }

        private function onRoomConnected(_arg_1:OpenConnectionMessageEvent):void
        {
            var _local_2:OpenConnectionMessageParser = _arg_1.getParser();
            if (_local_2 == null)
            {
                return;
            };
            if (listener)
            {
                listener.sessionUpdate(_local_2.flatId, "RS_CONNECTED");
            };
        }

        private function onFlatAccessible(_arg_1:FlatAccessibleMessageEvent):void
        {
            var _local_3:IRoomSession;
            var _local_2:FlatAccessibleMessageParser = _arg_1.getParser();
            if (_local_2 == null)
            {
                return;
            };
            var _local_4:String = _local_2.userName;
            if (((!(_local_4 == null)) && (_local_4.length > 0)))
            {
                if (((listener) && (listener.events)))
                {
                    _local_3 = listener.getSession(_local_2.flatId);
                    if (_local_3 != null)
                    {
                        listener.events.dispatchEvent(new RoomSessionDoorbellEvent("RSDE_ACCEPTED", _local_3, _local_4));
                    };
                };
            };
        }

        private function onRoomReady(_arg_1:RoomReadyMessageEvent):void
        {
            var _local_2:RoomReadyMessageParser = _arg_1.getParser();
            if (_local_2 == null)
            {
                return;
            };
            var _local_3:int = _local_2.roomId;
            ErrorReportStorage.addDebugData("RoomID", ("Room id: " + _local_3));
            if (listener)
            {
                listener.sessionReinitialize(_local_3, _local_3);
                listener.sessionUpdate(_local_3, "RS_READY");
            };
        }

        private function onFlatAccessDenied(_arg_1:FlatAccessDeniedMessageEvent):void
        {
            var _local_3:IRoomSession;
            var _local_2:FlatAccessDeniedMessageParser = _arg_1.getParser();
            if (_local_2 == null)
            {
                return;
            };
            var _local_4:String = _local_2.userName;
            if (((_local_4 == null) || (_local_4.length == 0)))
            {
                if (listener)
                {
                    listener.sessionUpdate(_local_2.flatId, "RS_DISCONNECTED");
                };
            }
            else
            {
                if (((listener) && (listener.events)))
                {
                    _local_3 = listener.getSession(_local_2.flatId);
                    if (_local_3 != null)
                    {
                        listener.events.dispatchEvent(new RoomSessionDoorbellEvent("RSDE_REJECTED", _local_3, _local_4));
                    };
                };
            };
        }

        private function onRoomDisconnected(_arg_1:IMessageEvent):void
        {
            var _local_2:int = _SafeStr_586;
            ErrorReportStorage.addDebugData("RoomID", "");
            if (listener)
            {
                listener.sessionUpdate(_local_2, "RS_DISCONNECTED");
            };
        }

        private function onRoomQueueStatus(_arg_1:RoomQueueStatusMessageEvent):void
        {
            var _local_5:RoomQueueSet;
            var _local_6:RoomSessionQueueEvent;
            var _local_2:Array;
            if (((listener == null) || (listener.events == null)))
            {
                return;
            };
            var _local_3:RoomQueueStatusMessageParser = _arg_1.getParser();
            if (_local_3 == null)
            {
                return;
            };
            var _local_4:IRoomSession = listener.getSession(_local_3.flatId);
            if (_local_4 == null)
            {
                return;
            };
            var _local_8:Array = _local_3.getQueueSetTargets();
            var _local_9:int = _local_3.activeTarget;
            for each (var _local_10:int in _local_8)
            {
                _local_5 = _local_3.getQueueSet(_local_10);
                _local_6 = new RoomSessionQueueEvent(_local_4, _local_5.name, _local_5.target, (_local_5.target == _local_9));
                _local_2 = _local_5.queueTypes;
                for each (var _local_7:String in _local_2)
                {
                    _local_6.addQueue(_local_7, _local_5.getQueueSize(_local_7));
                };
                listener.events.dispatchEvent(_local_6);
            };
        }

        private function onYouAreSpectator(_arg_1:YouAreSpectatorMessageEvent):void
        {
            if (listener == null)
            {
                return;
            };
            var _local_2:YouAreSpectatorMessageParser = _arg_1.getParser();
            if (_local_2 == null)
            {
                return;
            };
            var _local_3:IRoomSession = listener.getSession(_local_2.flatId);
            if (_local_3 == null)
            {
                return;
            };
            _local_3.isSpectatorMode = true;
        }


    }
}

