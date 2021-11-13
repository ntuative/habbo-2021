package com.sulake.habbo.communication.messages.parser.navigator
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.RoomModerationSettings;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.RoomChatSettings;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class GetGuestRoomResultMessageParser implements IMessageParser, IDisposable 
    {

        private var _enterRoom:Boolean;
        private var _roomForward:Boolean;
        private var _staffPick:Boolean;
        private var _data:GuestRoomData;
        private var _isGroupMember:Boolean;
        private var _roomModerationSettings:RoomModerationSettings;
        private var _chatSettings:RoomChatSettings;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._enterRoom = _arg_1.readBoolean();
            this._data = new GuestRoomData(_arg_1);
            this._roomForward = _arg_1.readBoolean();
            this._staffPick = _arg_1.readBoolean();
            this._isGroupMember = _arg_1.readBoolean();
            var _local_2:Boolean = _arg_1.readBoolean();
            this._roomModerationSettings = new RoomModerationSettings(_arg_1);
            this._data.allInRoomMuted = _local_2;
            this._data.canMute = _arg_1.readBoolean();
            this._chatSettings = new RoomChatSettings(_arg_1);
            return (true);
        }

        public function dispose():void
        {
            _roomModerationSettings = null;
        }

        public function get disposed():Boolean
        {
            return (_roomModerationSettings == null);
        }

        public function get enterRoom():Boolean
        {
            return (_enterRoom);
        }

        public function get data():GuestRoomData
        {
            return (_data);
        }

        public function get roomForward():Boolean
        {
            return (_roomForward);
        }

        public function get staffPick():Boolean
        {
            return (_staffPick);
        }

        public function get isGroupMember():Boolean
        {
            return (_isGroupMember);
        }

        public function get roomModerationSettings():RoomModerationSettings
        {
            return (_roomModerationSettings);
        }

        public function get chatSettings():RoomChatSettings
        {
            return (_chatSettings);
        }


    }
}