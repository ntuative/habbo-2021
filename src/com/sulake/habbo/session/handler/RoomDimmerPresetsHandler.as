package com.sulake.habbo.session.handler
{
    import com.sulake.habbo.communication.messages.incoming.room.furniture.RoomDimmerPresetsMessageEvent;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.session.IRoomHandlerListener;
    import com.sulake.habbo.communication.messages.incoming.room.furniture.RoomDimmerPresetsMessageData;
    import com.sulake.habbo.communication.messages.parser.room.furniture.RoomDimmerPresetsMessageParser;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.habbo.session.events.RoomSessionDimmerPresetsEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

    public class RoomDimmerPresetsHandler extends BaseHandler 
    {

        public function RoomDimmerPresetsHandler(_arg_1:IConnection, _arg_2:IRoomHandlerListener)
        {
            super(_arg_1, _arg_2);
            if (_arg_1 == null)
            {
                return;
            };
            _arg_1.addMessageEvent(new RoomDimmerPresetsMessageEvent(onRoomDimmerPresets));
        }

        private function onRoomDimmerPresets(_arg_1:IMessageEvent):void
        {
            var _local_4:int;
            var _local_6:RoomDimmerPresetsMessageData;
            var _local_5:RoomDimmerPresetsMessageEvent = (_arg_1 as RoomDimmerPresetsMessageEvent);
            if (((_local_5 == null) || (_local_5.getParser() == null)))
            {
                return;
            };
            var _local_2:RoomDimmerPresetsMessageParser = _local_5.getParser();
            var _local_3:IRoomSession = listener.getSession(_SafeStr_586);
            if (_local_3 == null)
            {
                return;
            };
            var _local_7:RoomSessionDimmerPresetsEvent = new RoomSessionDimmerPresetsEvent("RSDPE_PRESETS", _local_3);
            _local_7.selectedPresetId = _local_2.selectedPresetId;
            _local_4 = 0;
            while (_local_4 < _local_2.presetCount)
            {
                _local_6 = _local_2.getPreset(_local_4);
                if (_local_6 != null)
                {
                    _local_7.storePreset(_local_6.id, _local_6.type, _local_6.color, _local_6.light);
                };
                _local_4++;
            };
            if (((listener) && (listener.events)))
            {
                listener.events.dispatchEvent(_local_7);
            };
        }


    }
}

