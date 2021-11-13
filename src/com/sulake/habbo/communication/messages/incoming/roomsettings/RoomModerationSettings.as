package com.sulake.habbo.communication.messages.incoming.roomsettings
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class RoomModerationSettings 
    {

        public static const _SafeStr_1834:int = 0;
        public static const _SafeStr_1835:int = 1;
        public static const _SafeStr_1836:int = 2;
        public static const _SafeStr_1837:int = 4;
        public static const _SafeStr_1838:int = 5;

        private var _whoCanMute:int;
        private var _whoCanKick:int;
        private var _whoCanBan:int;

        public function RoomModerationSettings(_arg_1:IMessageDataWrapper)
        {
            _whoCanMute = _arg_1.readInteger();
            _whoCanKick = _arg_1.readInteger();
            _whoCanBan = _arg_1.readInteger();
        }

        public function get whoCanMute():int
        {
            return (_whoCanMute);
        }

        public function get whoCanKick():int
        {
            return (_whoCanKick);
        }

        public function get whoCanBan():int
        {
            return (_whoCanBan);
        }


    }
}

