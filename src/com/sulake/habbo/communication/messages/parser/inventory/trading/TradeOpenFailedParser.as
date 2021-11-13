package com.sulake.habbo.communication.messages.parser.inventory.trading
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class TradeOpenFailedParser implements IMessageParser 
    {

        public static const _SafeStr_2059:int = 7;
        public static const _SafeStr_2060:int = 8;

        private var _reason:int;
        private var _otherUserName:String;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _reason = _arg_1.readInteger();
            _otherUserName = _arg_1.readString();
            return (true);
        }

        public function get reason():int
        {
            return (_reason);
        }

        public function get otherUserName():String
        {
            return (_otherUserName);
        }


    }
}

