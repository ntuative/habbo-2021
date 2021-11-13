package com.sulake.habbo.communication.messages.parser.catalog
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPageMessageOfferData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class ProductOfferMessageParser implements IMessageParser 
    {

        private var _offerData:CatalogPageMessageOfferData;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _offerData = new CatalogPageMessageOfferData(_arg_1);
            return (true);
        }

        public function get offerData():CatalogPageMessageOfferData
        {
            return (_offerData);
        }


    }
}