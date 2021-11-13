package com.sulake.habbo.communication.messages.parser.navigator
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.navigator.OfficialRoomsData;
    import com.sulake.habbo.communication.messages.incoming.navigator.OfficialRoomEntryData;
    import com.sulake.habbo.communication.messages.incoming.navigator.PromotedRoomsData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class OfficialRoomsMessageParser implements IMessageParser 
    {

        private var _data:OfficialRoomsData;
        private var _adRoom:OfficialRoomEntryData;
        private var _promotedRooms:PromotedRoomsData;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _data = new OfficialRoomsData(_arg_1);
            var _local_2:int = _arg_1.readInteger();
            if (_local_2 > 0)
            {
                _adRoom = new OfficialRoomEntryData(_arg_1);
            };
            _promotedRooms = new PromotedRoomsData(_arg_1);
            return (true);
        }

        public function get data():OfficialRoomsData
        {
            return (_data);
        }

        public function get adRoom():OfficialRoomEntryData
        {
            return (_adRoom);
        }

        public function get promotedRooms():PromotedRoomsData
        {
            return (_promotedRooms);
        }


    }
}