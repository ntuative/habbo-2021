package com.sulake.habbo.communication.messages.parser.catalog
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPageMessageOfferData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class SeasonalCalendarDailyOfferMessageParser implements IMessageParser 
    {

        private var _pageId:int;
        private var _offerData:CatalogPageMessageOfferData;


        public function flush():Boolean
        {
            _pageId = -1;
            _offerData = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _pageId = _arg_1.readInteger();
            _offerData = new CatalogPageMessageOfferData(_arg_1);
            return (true);
        }

        public function get pageId():int
        {
            return (_pageId);
        }

        public function get offerData():CatalogPageMessageOfferData
        {
            return (_offerData);
        }


    }
}