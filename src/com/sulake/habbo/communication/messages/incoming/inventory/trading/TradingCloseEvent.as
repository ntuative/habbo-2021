package com.sulake.habbo.communication.messages.incoming.inventory.trading
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingCloseParser;

        public class TradingCloseEvent extends MessageEvent 
    {

        public function TradingCloseEvent(_arg_1:Function, _arg_2:Class)
        {
            super(_arg_1, _arg_2);
        }

        public function get userID():int
        {
            return (getParser().userID);
        }

        public function getParser():TradingCloseParser
        {
            return (_SafeStr_816 as TradingCloseParser);
        }


    }
}

