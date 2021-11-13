package com.sulake.habbo.session.handler
{
    import com.sulake.habbo.communication.messages.parser.room.chat.ChatMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.chat.WhisperMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.chat.ShoutMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.users.RespectNotificationMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.users.PetRespectNotificationEvent;
    import com.sulake.habbo.communication.messages.incoming.users.PetSupplementedNotificationEvent;
    import com.sulake.habbo.communication.messages.parser.room.chat.FloodControlMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.users.HandItemReceivedMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.chat.RemainingMutePeriodEvent;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.session.IRoomHandlerListener;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.habbo.communication.messages.parser.room.chat.ChatMessageParser;
    import com.sulake.habbo.session.events.RoomSessionChatEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.session.IUserData;
    import com.sulake.habbo.communication.messages.parser.users.PetRespectNotificationParser;
    import com.sulake.habbo.communication.messages.parser.users.PetSupplementedNotificationParser;
    import com.sulake.habbo.communication.messages.parser.room.chat.FloodControlMessageParser;

    public class RoomChatHandler extends BaseHandler 
    {

        public function RoomChatHandler(_arg_1:IConnection, _arg_2:IRoomHandlerListener)
        {
            super(_arg_1, _arg_2);
            if (_arg_1 == null)
            {
                return;
            };
            _arg_1.addMessageEvent(new ChatMessageEvent(onRoomChat));
            _arg_1.addMessageEvent(new WhisperMessageEvent(onRoomWhisper));
            _arg_1.addMessageEvent(new ShoutMessageEvent(onRoomShout));
            _arg_1.addMessageEvent(new RespectNotificationMessageEvent(onRespectNotification));
            _arg_1.addMessageEvent(new PetRespectNotificationEvent(onPetRespectNotification));
            _arg_1.addMessageEvent(new PetSupplementedNotificationEvent(onPetSupplementedNotification));
            _arg_1.addMessageEvent(new FloodControlMessageEvent(onFloodControl));
            _arg_1.addMessageEvent(new HandItemReceivedMessageEvent(onHandItemNotification));
            _arg_1.addMessageEvent(new RemainingMutePeriodEvent(onRemainingMutePeriod));
        }

        private function onRoomChat(_arg_1:IMessageEvent):void
        {
            var _local_2:ChatMessageEvent;
            var _local_4:IRoomSession;
            var _local_5:String;
            var _local_6:int;
            var _local_3:ChatMessageParser;
            if (((listener) && (listener.events)))
            {
                _local_2 = (_arg_1 as ChatMessageEvent);
                if (((_local_2) && (_local_2.getParser())))
                {
                    _local_4 = listener.getSession(_SafeStr_586);
                    if (_local_4 == null)
                    {
                        return;
                    };
                    _local_5 = "RSCE_CHAT_EVENT";
                    _local_6 = 0;
                    _local_3 = _local_2.getParser();
                    if (_local_3.trackingId != -1)
                    {
                        _local_4.receivedChatWithTrackingId(_local_3.trackingId);
                    };
                    listener.events.dispatchEvent(new RoomSessionChatEvent(_local_5, _local_4, _local_3.userId, _local_3.text, _local_6, _local_3.styleId, _local_3.links));
                };
            };
        }

        private function onRespectNotification(_arg_1:IMessageEvent):void
        {
            var _local_4:IRoomSession;
            var _local_5:String;
            var _local_7:int;
            var _local_3:IUserData;
            var _local_6:String;
            var _local_2:RespectNotificationMessageEvent = (_arg_1 as RespectNotificationMessageEvent);
            if (((listener) && (listener.events)))
            {
                _local_4 = listener.getSession(_SafeStr_586);
                if (_local_4 == null)
                {
                    return;
                };
                _local_5 = "RSCE_CHAT_EVENT";
                _local_7 = 3;
                _local_3 = _local_4.userDataManager.getUserData(_local_2.userId);
                if (_local_3 == null)
                {
                    return;
                };
                _local_6 = "";
                listener.events.dispatchEvent(new RoomSessionChatEvent(_local_5, _local_4, _local_3.roomObjectId, _local_6, _local_7, 1));
            };
        }

        private function onPetRespectNotification(_arg_1:PetRespectNotificationEvent):void
        {
            if ((((_arg_1 == null) || (listener == null)) || (listener.events == null)))
            {
                return;
            };
            var _local_3:PetRespectNotificationParser = _arg_1.getParser();
            if (_local_3 == null)
            {
                return;
            };
            var _local_4:IRoomSession = listener.getSession(_SafeStr_586);
            if (_local_4 == null)
            {
                return;
            };
            var _local_5:String = "RSCE_CHAT_EVENT";
            var _local_6:int = 4;
            if (_local_3.isTreat())
            {
                _local_6 = 6;
            };
            var _local_2:IUserData = _local_4.userDataManager.getPetUserData(_local_3.petData.id);
            if (_local_2 == null)
            {
                return;
            };
            listener.events.dispatchEvent(new RoomSessionChatEvent(_local_5, _local_4, _local_2.roomObjectId, "", _local_6, 1));
        }

        private function onPetSupplementedNotification(_arg_1:PetSupplementedNotificationEvent):void
        {
            if ((((_arg_1 == null) || (listener == null)) || (listener.events == null)))
            {
                return;
            };
            var _local_3:PetSupplementedNotificationParser = _arg_1.getParser();
            if (_local_3 == null)
            {
                return;
            };
            var _local_4:IRoomSession = listener.getSession(_SafeStr_586);
            if (_local_4 == null)
            {
                return;
            };
            var _local_7:String = "RSCE_CHAT_EVENT";
            var _local_8:int = 7;
            switch (_local_3.supplementType)
            {
                case 2:
                    _local_8 = 7;
                    break;
                case 3:
                    _local_8 = 8;
                    break;
                case 4:
                    _local_8 = 9;
                default:
            };
            var _local_2:IUserData = _local_4.userDataManager.getPetUserData(_local_3.petId);
            if (_local_2 == null)
            {
                return;
            };
            var _local_6:int = -1;
            var _local_5:IUserData = _local_4.userDataManager.getUserData(_local_3.userId);
            if (_local_5 != null)
            {
                _local_6 = _local_5.roomObjectId;
            };
            listener.events.dispatchEvent(new RoomSessionChatEvent(_local_7, _local_4, _local_2.roomObjectId, "", _local_8, 1, null, _local_6));
        }

        private function onHandItemNotification(_arg_1:HandItemReceivedMessageEvent):void
        {
            var _local_2:IRoomSession;
            if (((listener) && (listener.events)))
            {
                _local_2 = listener.getSession(_SafeStr_586);
                if (_local_2)
                {
                    listener.events.dispatchEvent(new RoomSessionChatEvent("RSCE_CHAT_EVENT", _local_2, _arg_1.giverUserId, "", 5, 1, null, _arg_1.handItemType));
                };
            };
        }

        private function onRemainingMutePeriod(_arg_1:RemainingMutePeriodEvent):void
        {
            var _local_2:IRoomSession;
            if (((listener) && (listener.events)))
            {
                _local_2 = listener.getSession(_SafeStr_586);
                if (_local_2)
                {
                    listener.events.dispatchEvent(new RoomSessionChatEvent("RSCE_CHAT_EVENT", _local_2, _local_2.ownUserRoomId, "", 10, 1, null, _arg_1.secondsRemaining));
                };
            };
        }

        private function onRoomWhisper(_arg_1:IMessageEvent):void
        {
            var _local_2:WhisperMessageEvent;
            var _local_4:IRoomSession;
            var _local_5:String;
            var _local_6:int;
            var _local_3:ChatMessageParser;
            if (((listener) && (listener.events)))
            {
                _local_2 = (_arg_1 as WhisperMessageEvent);
                if (((_local_2) && (_local_2.getParser())))
                {
                    _local_4 = listener.getSession(_SafeStr_586);
                    if (_local_4 == null)
                    {
                        return;
                    };
                    _local_5 = "RSCE_CHAT_EVENT";
                    _local_6 = 1;
                    _local_3 = _local_2.getParser();
                    listener.events.dispatchEvent(new RoomSessionChatEvent(_local_5, _local_4, _local_3.userId, _local_3.text, _local_6, _local_3.styleId, _local_3.links));
                };
            };
        }

        private function onRoomShout(_arg_1:IMessageEvent):void
        {
            var _local_2:ShoutMessageEvent;
            var _local_4:IRoomSession;
            var _local_5:String;
            var _local_6:int;
            var _local_3:ChatMessageParser;
            if (((listener) && (listener.events)))
            {
                _local_2 = (_arg_1 as ShoutMessageEvent);
                if (((_local_2) && (_local_2.getParser())))
                {
                    _local_4 = listener.getSession(_SafeStr_586);
                    if (_local_4 == null)
                    {
                        return;
                    };
                    _local_5 = "RSCE_CHAT_EVENT";
                    _local_6 = 2;
                    _local_3 = _local_2.getParser();
                    listener.events.dispatchEvent(new RoomSessionChatEvent(_local_5, _local_4, _local_3.userId, _local_3.text, _local_6, _local_3.styleId, _local_3.links));
                };
            };
        }

        private function onFloodControl(_arg_1:IMessageEvent):void
        {
            var _local_3:FloodControlMessageParser;
            var _local_4:IRoomSession;
            var _local_2:int;
            if (((listener) && (listener.events)))
            {
                _local_3 = (_arg_1 as FloodControlMessageEvent).getParser();
                _local_4 = listener.getSession(_SafeStr_586);
                if (_local_4 == null)
                {
                    return;
                };
                _local_2 = _local_3.seconds;
                Logger.log((("received flood control event for " + _local_2) + " seconds"));
                listener.events.dispatchEvent(new RoomSessionChatEvent("RSCE_FLOOD_EVENT", _local_4, -1, ("" + _local_2), 0, 0, null));
            };
        }


    }
}

