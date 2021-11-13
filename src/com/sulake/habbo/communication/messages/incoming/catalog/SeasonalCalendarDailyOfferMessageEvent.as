package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.catalog.SeasonalCalendarDailyOfferMessageParser;

        public class SeasonalCalendarDailyOfferMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function SeasonalCalendarDailyOfferMessageEvent(_arg_1:Function)
        {
            super(_arg_1, SeasonalCalendarDailyOfferMessageParser);
        }

        public function get offer():CatalogPageMessageOfferData
        {
            return (SeasonalCalendarDailyOfferMessageParser(parser).offerData);
        }

        public function get pageId():int
        {
            return (SeasonalCalendarDailyOfferMessageParser(parser).pageId);
        }


    }
}