package com.sulake.habbo.communication.messages.parser.navigator
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class CanCreateRoomMessageParser implements IMessageParser 
    {

        public static const _SafeStr_2069:int = 0;
        public static const _SafeStr_2070:int = 1;

        private var _resultCode:int;
        private var _roomLimit:int;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._resultCode = _arg_1.readInteger();
            this._roomLimit = _arg_1.readInteger();
            return (true);
        }

        public function get resultCode():int
        {
            return (_resultCode);
        }

        public function get roomLimit():int
        {
            return (_roomLimit);
        }


    }
}

