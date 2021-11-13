package com.sulake.habbo.communication.messages.incoming.inventory.trading
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingOpenParser;

        public class TradingOpenEvent extends MessageEvent 
    {

        public function TradingOpenEvent(_arg_1:Function, _arg_2:Class)
        {
            super(_arg_1, _arg_2);
        }

        public function get userID():int
        {
            return (getParser().userID);
        }

        public function get userCanTrade():Boolean
        {
            return (getParser().userCanTrade);
        }

        public function get otherUserID():int
        {
            return (getParser().otherUserID);
        }

        public function get otherUserCanTrade():Boolean
        {
            return (getParser().otherUserCanTrade);
        }

        public function getParser():TradingOpenParser
        {
            return (_SafeStr_816 as TradingOpenParser);
        }


    }
}

