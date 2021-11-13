package com.sulake.habbo.communication.messages.parser.users
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class AccountSafetyLockStatusChangeMessageParser implements IMessageParser 
    {

        public static const _SafeStr_2112:int = 0;
        public static const _SafeStr_2113:int = 1;

        private var _status:int;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _status = _arg_1.readInteger();
            return (true);
        }

        public function get status():int
        {
            return (_status);
        }


    }
}

