package com.sulake.habbo.communication.messages.parser.help
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class GuideTicketCreationResultMessageParser implements IMessageParser 
    {

        private static const _SafeStr_2047:int = 0;
        private static const _SafeStr_2048:int = 1;
        private static const _SafeStr_2049:int = 2;
        private static const _SafeStr_2050:int = 3;

        private var _SafeStr_834:int = -1;


        public function flush():Boolean
        {
            _SafeStr_834 = -1;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _SafeStr_834 = _arg_1.readInteger();
            return (true);
        }

        public function get localizationCode():String
        {
            switch (_SafeStr_834)
            {
                case 0:
                    return ("sent");
                case 1:
                    return ("blocked");
                case 2:
                    return ("nochat");
                case 3:
                    return ("alreadyreported");
                default:
                    return ("invalid");
            };
        }


    }
}

