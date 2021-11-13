package com.sulake.habbo.communication.messages.parser.help
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.parser.help.data.PendingGuideTicket;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class GuideReportingStatusMessageParser implements IMessageParser 
    {

        public static const _SafeStr_2037:int = 0;
        public static const _SafeStr_2038:int = 1;
        public static const _SafeStr_2039:int = 2;
        public static const _SafeStr_2040:int = 3;

        private var _statusCode:int;
        private var _pendingTicket:PendingGuideTicket;


        public function flush():Boolean
        {
            _pendingTicket = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _statusCode = _arg_1.readInteger();
            if (_statusCode == 1)
            {
                _pendingTicket = new PendingGuideTicket(_arg_1);
            };
            return (true);
        }

        public function get statusCode():int
        {
            return (_statusCode);
        }

        public function get pendingTicket():PendingGuideTicket
        {
            return (_pendingTicket);
        }

        public function get localizationCode():String
        {
            switch (_statusCode)
            {
                case 2:
                    return ("blocked");
                case 3:
                    return ("tooquick");
                default:
                    return ("");
            };
        }


    }
}

