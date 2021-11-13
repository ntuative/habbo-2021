package com.sulake.habbo.communication.messages.incoming.inventory.trading
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingNotOpenParser;

        public class TradingNotOpenEvent extends MessageEvent 
    {

        public function TradingNotOpenEvent(_arg_1:Function, _arg_2:Class)
        {
            super(_arg_1, _arg_2);
        }

        public function getParser():TradingNotOpenParser
        {
            return (_SafeStr_816 as TradingNotOpenParser);
        }


    }
}

