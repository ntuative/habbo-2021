package com.sulake.habbo.room.messages
{
    public class RoomObjectAvatarCarryObjectUpdateMessage extends RoomObjectUpdateStateMessage 
    {

        private var _itemType:int;
        private var _itemName:String;

        public function RoomObjectAvatarCarryObjectUpdateMessage(_arg_1:int, _arg_2:String)
        {
            _itemType = _arg_1;
            _itemName = _arg_2;
        }

        public function get itemType():int
        {
            return (_itemType);
        }

        public function get itemName():String
        {
            return (_itemName);
        }


    }
}