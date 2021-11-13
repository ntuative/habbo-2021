package com.sulake.habbo.communication.messages.incoming.inventory.trading
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingCompletedParser;

        public class TradingCompletedEvent extends MessageEvent 
    {

        public function TradingCompletedEvent(_arg_1:Function, _arg_2:Class)
        {
            super(_arg_1, _arg_2);
        }

        public function getParser():TradingCompletedParser
        {
            return (_SafeStr_816 as TradingCompletedParser);
        }


    }
}

