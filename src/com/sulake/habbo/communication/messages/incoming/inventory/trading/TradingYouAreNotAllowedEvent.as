package com.sulake.habbo.communication.messages.incoming.inventory.trading
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingYouAreNotAllowedParser;

        public class TradingYouAreNotAllowedEvent extends MessageEvent 
    {

        public function TradingYouAreNotAllowedEvent(_arg_1:Function, _arg_2:Class)
        {
            super(_arg_1, _arg_2);
        }

        public function getParser():TradingYouAreNotAllowedParser
        {
            return (_SafeStr_816 as TradingYouAreNotAllowedParser);
        }


    }
}

