package com.sulake.habbo.room.messages
{
    import com.sulake.room.messages.RoomObjectUpdateMessage;
    import com.sulake.room.utils.IVector3d;

    public class RoomObjectHeightUpdateMessage extends RoomObjectUpdateMessage 
    {

        private var _height:Number;

        public function RoomObjectHeightUpdateMessage(_arg_1:IVector3d, _arg_2:IVector3d, _arg_3:Number)
        {
            super(_arg_1, _arg_2);
            _height = _arg_3;
        }

        public function get height():Number
        {
            return (_height);
        }


    }
}