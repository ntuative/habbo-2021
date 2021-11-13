package com.sulake.habbo.communication.messages.incoming.inventory.trading
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingAcceptParser;

        public class TradingAcceptEvent extends MessageEvent 
    {

        public function TradingAcceptEvent(_arg_1:Function, _arg_2:Class)
        {
            super(_arg_1, _arg_2);
        }

        public function get userID():int
        {
            return (getParser().userID);
        }

        public function get userAccepts():Boolean
        {
            return (getParser().userAccepts);
        }

        public function getParser():TradingAcceptParser
        {
            return (_SafeStr_816 as TradingAcceptParser);
        }


    }
}

