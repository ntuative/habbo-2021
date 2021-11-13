package com.sulake.habbo.communication.messages.parser.inventory.trading
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class TradingAcceptParser implements IMessageParser 
    {

        private var _userID:int;
        private var _userAccepts:Boolean;


        public function get userID():int
        {
            return (_userID);
        }

        public function get userAccepts():Boolean
        {
            return (_userAccepts);
        }

        public function flush():Boolean
        {
            _userID = -1;
            _userAccepts = false;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _userID = _arg_1.readInteger();
            _userAccepts = (_arg_1.readInteger() > 0);
            return (true);
        }


    }
}