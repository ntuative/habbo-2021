package com.sulake.habbo.communication.messages.incoming.moderation
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class RoomVisitData 
    {

        private var _roomId:int;
        private var _roomName:String;
        private var _enterHour:int;
        private var _enterMinute:int;

        public function RoomVisitData(_arg_1:IMessageDataWrapper)
        {
            _roomId = _arg_1.readInteger();
            _roomName = _arg_1.readString();
            _enterHour = _arg_1.readInteger();
            _enterMinute = _arg_1.readInteger();
        }

        public function get roomId():int
        {
            return (_roomId);
        }

        public function get roomName():String
        {
            return (_roomName);
        }

        public function get enterHour():int
        {
            return (_enterHour);
        }

        public function get enterMinute():int
        {
            return (_enterMinute);
        }


    }
}