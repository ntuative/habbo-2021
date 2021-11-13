package com.sulake.habbo.communication.messages.incoming.inventory.trading
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingNoSuchItemParser;

        public class TradingNoSuchItemEvent extends MessageEvent 
    {

        public function TradingNoSuchItemEvent(_arg_1:Function, _arg_2:Class)
        {
            super(_arg_1, _arg_2);
        }

        public function getParser():TradingNoSuchItemParser
        {
            return (_SafeStr_816 as TradingNoSuchItemParser);
        }


    }
}

