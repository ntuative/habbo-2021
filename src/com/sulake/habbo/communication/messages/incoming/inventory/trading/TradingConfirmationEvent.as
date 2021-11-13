package com.sulake.habbo.communication.messages.incoming.inventory.trading
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingConfirmationParser;

        public class TradingConfirmationEvent extends MessageEvent 
    {

        public function TradingConfirmationEvent(_arg_1:Function, _arg_2:Class)
        {
            super(_arg_1, _arg_2);
        }

        public function getParser():TradingConfirmationParser
        {
            return (_SafeStr_816 as TradingConfirmationParser);
        }


    }
}

