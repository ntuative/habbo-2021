package com.sulake.habbo.communication.messages.parser.help
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class GuideSessionErrorMessageParser implements IMessageParser 
    {

        public static const _SafeStr_2041:int = 0;
        public static const _SafeStr_2042:int = 1;
        public static const _SafeStr_2043:int = 2;
        public static const _SafeStr_2044:int = 3;
        public static const _SafeStr_2045:int = 4;

        private var _errorCode:int;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _errorCode = _arg_1.readInteger();
            return (true);
        }

        public function get errorCode():int
        {
            return (_errorCode);
        }


    }
}

