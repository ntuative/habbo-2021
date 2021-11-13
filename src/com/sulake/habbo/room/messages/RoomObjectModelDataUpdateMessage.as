package com.sulake.habbo.room.messages
{
    import com.sulake.room.messages.RoomObjectUpdateMessage;

    public class RoomObjectModelDataUpdateMessage extends RoomObjectUpdateMessage 
    {

        private var _numberKey:String;
        private var _numberValue:int;

        public function RoomObjectModelDataUpdateMessage(_arg_1:String, _arg_2:int)
        {
            super(null, null);
            _numberKey = _arg_1;
            _numberValue = _arg_2;
        }

        public function get numberKey():String
        {
            return (_numberKey);
        }

        public function get numberValue():int
        {
            return (_numberValue);
        }


    }
}