package com.sulake.habbo.communication.messages.incoming.roomsettings
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class RoomChatSettings 
    {

        public static const _SafeStr_1823:int = 0;
        public static const _SafeStr_1824:int = 1;
        public static const _SafeStr_1825:int = 0;
        public static const _SafeStr_1826:int = 1;
        public static const _SafeStr_1827:int = 2;
        public static const _SafeStr_1828:int = 0;
        public static const _SafeStr_1829:int = 1;
        public static const _SafeStr_1830:int = 2;
        public static const _SafeStr_1831:int = 0;
        public static const _SafeStr_1832:int = 1;
        public static const _SafeStr_1833:int = 2;

        private var _mode:int = 0;
        private var _bubbleWidth:int = 1;
        private var _scrollSpeed:int = 1;
        private var _floodSensitivity:int = 1;
        private var _fullHearRange:int = 14;

        public function RoomChatSettings(_arg_1:IMessageDataWrapper)
        {
            _mode = _arg_1.readInteger();
            _bubbleWidth = _arg_1.readInteger();
            _scrollSpeed = _arg_1.readInteger();
            _fullHearRange = _arg_1.readInteger();
            _floodSensitivity = _arg_1.readInteger();
        }

        public function get mode():int
        {
            return (_mode);
        }

        public function get bubbleWidth():int
        {
            return (_bubbleWidth);
        }

        public function get scrollSpeed():int
        {
            return (_scrollSpeed);
        }

        public function get fullHearRange():int
        {
            return (_fullHearRange);
        }

        public function get floodSensitivity():int
        {
            return (_floodSensitivity);
        }


    }
}

