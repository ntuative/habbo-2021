package com.sulake.habbo.session.handler
{
    import com.sulake.habbo.communication.messages.incoming.navigator.GetGuestRoomResultEvent;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.session.IRoomHandlerListener;
    import com.sulake.habbo.communication.messages.parser.navigator.GetGuestRoomResultMessageParser;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
    import com.sulake.habbo.session.events.RoomSessionPropertyUpdateEvent;
    import com.sulake.habbo.session.events.RoomSessionEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

    public class RoomDataHandler extends BaseHandler 
    {

        public function RoomDataHandler(_arg_1:IConnection, _arg_2:IRoomHandlerListener)
        {
            super(_arg_1, _arg_2);
            if (_arg_1 == null)
            {
                return;
            };
            _arg_1.addMessageEvent(new GetGuestRoomResultEvent(onRoomResult));
        }

        private function onRoomResult(_arg_1:IMessageEvent):void
        {
            var _local_5:GetGuestRoomResultEvent = (_arg_1 as GetGuestRoomResultEvent);
            if (_local_5 == null)
            {
                return;
            };
            var _local_2:GetGuestRoomResultMessageParser = _local_5.getParser();
            if (_local_2.roomForward)
            {
                return;
            };
            var _local_3:IRoomSession = listener.getSession(_SafeStr_586);
            if (_local_3 == null)
            {
                return;
            };
            var _local_4:GuestRoomData = _local_2.data;
            _local_3.tradeMode = _local_4.tradeMode;
            _local_3.isGuildRoom = (!(_local_4.habboGroupId == 0));
            _local_3.doorMode = _local_4.doorMode;
            _local_3.arePetsAllowed = _local_4.allowPets;
            _local_3.roomModerationSettings = _local_2.roomModerationSettings;
            listener.events.dispatchEvent(new RoomSessionPropertyUpdateEvent("RSDUE_ALLOW_PETS", _local_3));
            listener.events.dispatchEvent(new RoomSessionEvent("RSE_ROOM_DATA", _local_3));
        }


    }
}

