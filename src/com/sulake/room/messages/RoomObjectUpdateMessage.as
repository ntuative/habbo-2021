package com.sulake.room.messages
{
    import com.sulake.room.utils.IVector3d;

    public class RoomObjectUpdateMessage 
    {

        protected var _SafeStr_3181:IVector3d;
        protected var _SafeStr_1925:IVector3d;

        public function RoomObjectUpdateMessage(_arg_1:IVector3d, _arg_2:IVector3d)
        {
            _SafeStr_3181 = _arg_1;
            _SafeStr_1925 = _arg_2;
        }

        public function get loc():IVector3d
        {
            return (_SafeStr_3181);
        }

        public function get dir():IVector3d
        {
            return (_SafeStr_1925);
        }


    }
}

