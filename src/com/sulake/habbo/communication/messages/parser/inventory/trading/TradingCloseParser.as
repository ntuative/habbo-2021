package com.sulake.habbo.communication.messages.parser.inventory.trading
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class TradingCloseParser implements IMessageParser 
    {

        public static const _SafeStr_2061:int = 1;

        private var _userID:int;
        private var _reason:int;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _userID = _arg_1.readInteger();
            _reason = _arg_1.readInteger();
            return (true);
        }

        public function get userID():int
        {
            return (_userID);
        }

        public function get reason():int
        {
            return (_reason);
        }


    }
}

