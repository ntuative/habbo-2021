package com.sulake.habbo.room.messages
{
    import com.sulake.room.messages.RoomObjectUpdateMessage;
    import com.sulake.habbo.room.IStuffData;

    public class RoomObjectDataUpdateMessage extends RoomObjectUpdateMessage 
    {

        private var _state:int;
        private var _data:IStuffData = null;
        private var _extra:Number = NaN;

        public function RoomObjectDataUpdateMessage(_arg_1:int, _arg_2:IStuffData, _arg_3:Number=NaN)
        {
            super(null, null);
            _state = _arg_1;
            _data = _arg_2;
            _extra = _arg_3;
        }

        public function get state():int
        {
            return (_state);
        }

        public function get data():IStuffData
        {
            return (_data);
        }

        public function get extra():Number
        {
            return (_extra);
        }


    }
}