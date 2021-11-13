package com.sulake.habbo.communication.messages.parser.help
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class GuideTicketResolutionMessageParser implements IMessageParser 
    {

        private static const _SafeStr_2051:int = 0;
        private static const _SafeStr_2052:int = 1;
        private static const _SafeStr_2053:int = 2;

        private var _SafeStr_2054:int = -1;


        public function flush():Boolean
        {
            _SafeStr_2054 = -1;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _SafeStr_2054 = _arg_1.readInteger();
            return (true);
        }

        public function get localizationCode():String
        {
            if (((_SafeStr_2054 == 0) || (_SafeStr_2054 == 1)))
            {
                return ("valid");
            };
            return ("invalid");
        }


    }
}

