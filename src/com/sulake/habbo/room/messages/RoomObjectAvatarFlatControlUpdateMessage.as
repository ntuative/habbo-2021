package com.sulake.habbo.room.messages
{
    public class RoomObjectAvatarFlatControlUpdateMessage extends RoomObjectUpdateStateMessage 
    {

        private var _isAdmin:Boolean = false;
        private var _rawData:String;

        public function RoomObjectAvatarFlatControlUpdateMessage(_arg_1:String)
        {
            _rawData = _arg_1;
        }

        public function get isAdmin():Boolean
        {
            return (_isAdmin);
        }

        public function get rawData():String
        {
            return (_rawData);
        }


    }
}