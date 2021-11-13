package com.sulake.habbo.room.messages
{
    public class RoomObjectAvatarUseObjectUpdateMessage extends RoomObjectUpdateStateMessage 
    {

        private var _itemType:int;

        public function RoomObjectAvatarUseObjectUpdateMessage(_arg_1:int)
        {
            _itemType = _arg_1;
        }

        public function get itemType():int
        {
            return (_itemType);
        }


    }
}