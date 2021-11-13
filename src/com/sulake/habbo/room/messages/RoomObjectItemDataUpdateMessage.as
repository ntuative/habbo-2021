package com.sulake.habbo.room.messages
{
    import com.sulake.room.messages.RoomObjectUpdateMessage;

    public class RoomObjectItemDataUpdateMessage extends RoomObjectUpdateMessage 
    {

        private var _itemData:String;

        public function RoomObjectItemDataUpdateMessage(_arg_1:String)
        {
            super(null, null);
            _itemData = _arg_1;
        }

        public function get itemData():String
        {
            return (_itemData);
        }


    }
}