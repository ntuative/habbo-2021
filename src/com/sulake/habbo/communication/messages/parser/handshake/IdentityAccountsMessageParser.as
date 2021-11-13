package com.sulake.habbo.communication.messages.parser.handshake
{
    import com.sulake.core.communication.messages.IMessageParser;
    import flash.utils.Dictionary;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class IdentityAccountsMessageParser implements IMessageParser 
    {

        private var _accounts:Dictionary;


        public function flush():Boolean
        {
            if (_accounts)
            {
                _accounts = null;
            };
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_3:int;
            _accounts = new Dictionary();
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _accounts[_arg_1.readInteger()] = _arg_1.readString();
                _local_3++;
            };
            return (true);
        }

        public function get accounts():Dictionary
        {
            return (_accounts);
        }


    }
}