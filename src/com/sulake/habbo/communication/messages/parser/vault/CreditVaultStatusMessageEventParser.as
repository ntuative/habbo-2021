package com.sulake.habbo.communication.messages.parser.vault
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class CreditVaultStatusMessageEventParser implements IMessageParser 
    {

        private var _isUnlocked:Boolean;
        private var _totalBalance:int;
        private var _withdrawBalance:int;


        public function get isUnlocked():Boolean
        {
            return (_isUnlocked);
        }

        public function get totalBalance():int
        {
            return (_totalBalance);
        }

        public function get withdrawBalance():int
        {
            return (_withdrawBalance);
        }

        public function flush():Boolean
        {
            _isUnlocked = false;
            _totalBalance = 0;
            _withdrawBalance = 0;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _isUnlocked = _arg_1.readBoolean();
            _totalBalance = _arg_1.readInteger();
            _withdrawBalance = _arg_1.readInteger();
            return (true);
        }


    }
}