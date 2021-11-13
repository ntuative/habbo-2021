package com.sulake.habbo.communication.messages.parser.room.session
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class CantConnectMessageParser implements IMessageParser 
    {

        public static const _SafeStr_2082:int = 1;
        public static const _SafeStr_2083:int = 2;
        public static const _SafeStr_2084:int = 3;
        public static const _SafeStr_2085:int = 4;

        private var _reason:int = 0;
        private var _parameter:String = "";


        public function flush():Boolean
        {
            _reason = 0;
            _parameter = "";
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _reason = _arg_1.readInteger();
            if (_reason == 3)
            {
                _parameter = _arg_1.readString();
            }
            else
            {
                _parameter = "";
            };
            return (true);
        }

        public function get reason():int
        {
            return (_reason);
        }

        public function get parameter():String
        {
            return (_parameter);
        }


    }
}

