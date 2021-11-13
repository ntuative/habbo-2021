package com.sulake.habbo.communication.messages.incoming.inventory.trading
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingItemListParser;

        public class TradingItemListEvent extends MessageEvent 
    {

        public function TradingItemListEvent(_arg_1:Function, _arg_2:Class)
        {
            super(_arg_1, _arg_2);
        }

        public function get firstUserID():int
        {
            return (getParser().firstUserID);
        }

        public function get secondUserID():int
        {
            return (getParser().secondUserID);
        }

        public function get firstUserNumItems():int
        {
            return (getParser().firstUserNumItems);
        }

        public function get secondUserNumItems():int
        {
            return (getParser().secondUserNumItems);
        }

        public function get firstUserNumCredits():int
        {
            return (getParser().firstUserNumCredits);
        }

        public function get secondUserNumCredits():int
        {
            return (getParser().secondUserNumCredits);
        }

        public function get firstUserItemArray():Array
        {
            return (getParser().firstUserItemArray);
        }

        public function get secondUserItemArray():Array
        {
            return (getParser().secondUserItemArray);
        }

        public function getParser():TradingItemListParser
        {
            return (_SafeStr_816 as TradingItemListParser);
        }


    }
}

