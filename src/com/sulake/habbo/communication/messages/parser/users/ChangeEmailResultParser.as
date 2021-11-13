package com.sulake.habbo.communication.messages.parser.users
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class ChangeEmailResultParser implements IMessageParser 
    {

        public static const _SafeStr_2114:int = 0;

        private var _result:int;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _result = _arg_1.readInteger();
            return (true);
        }

        public function get result():int
        {
            return (_result);
        }


    }
}

