package com.sulake.habbo.communication.messages.parser.roomsettings
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class RoomSettingsSaveErrorMessageParser implements IMessageParser 
    {

        public static const _SafeStr_2088:int = 1;
        public static const _SafeStr_2089:int = 2;
        public static const _SafeStr_2090:int = 3;
        public static const _SafeStr_2091:int = 4;
        public static const _SafeStr_2092:int = 5;
        public static const _SafeStr_2093:int = 6;
        public static const _SafeStr_2094:int = 7;
        public static const _SafeStr_2095:int = 8;
        public static const _SafeStr_2096:int = 9;
        public static const _SafeStr_2097:int = 10;
        public static const _SafeStr_2098:int = 11;
        public static const _SafeStr_2099:int = 12;
        public static const _SafeStr_2100:int = 13;

        private var _roomId:int;
        private var _errorCode:int;
        private var _info:String;


        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _roomId = _arg_1.readInteger();
            _errorCode = _arg_1.readInteger();
            _info = _arg_1.readString();
            return (true);
        }

        public function flush():Boolean
        {
            return (true);
        }

        public function get roomId():int
        {
            return (_roomId);
        }

        public function get errorCode():int
        {
            return (_errorCode);
        }

        public function get info():String
        {
            return (_info);
        }


    }
}

