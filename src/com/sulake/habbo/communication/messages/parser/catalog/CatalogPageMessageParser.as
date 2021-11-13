package com.sulake.habbo.communication.messages.parser.catalog
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.catalog.CatalogLocalizationData;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPageMessageOfferData;
    import com.sulake.habbo.communication.messages.incoming.catalog.FrontPageItem;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class CatalogPageMessageParser implements IMessageParser 
    {

        private var _pageId:int;
        private var _catalogType:String;
        private var _layoutCode:String;
        private var _localization:CatalogLocalizationData;
        private var _offers:Vector.<CatalogPageMessageOfferData>;
        private var _offerId:int;
        private var _acceptSeasonCurrencyAsCredits:Boolean;
        private var _frontPageItems:Vector.<FrontPageItem>;


        public function get pageId():int
        {
            return (_pageId);
        }

        public function get catalogType():String
        {
            return (_catalogType);
        }

        public function get layoutCode():String
        {
            return (_layoutCode);
        }

        public function get localization():CatalogLocalizationData
        {
            return (_localization);
        }

        public function get offers():Vector.<CatalogPageMessageOfferData>
        {
            return (_offers);
        }

        public function get offerId():int
        {
            return (_offerId);
        }

        public function get acceptSeasonCurrencyAsCredits():Boolean
        {
            return (_acceptSeasonCurrencyAsCredits);
        }

        public function get frontPageItems():Vector.<FrontPageItem>
        {
            return (_frontPageItems);
        }

        public function flush():Boolean
        {
            _pageId = -1;
            _catalogType = "";
            _layoutCode = "";
            _localization = null;
            _offers = new Vector.<CatalogPageMessageOfferData>(0);
            _offerId = -1;
            _acceptSeasonCurrencyAsCredits = false;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_3:int;
            _pageId = _arg_1.readInteger();
            _catalogType = _arg_1.readString();
            _layoutCode = _arg_1.readString();
            _localization = new CatalogLocalizationData(_arg_1);
            _offers = new Vector.<CatalogPageMessageOfferData>(0);
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _offers.push(new CatalogPageMessageOfferData(_arg_1));
                _local_3++;
            };
            _offerId = _arg_1.readInteger();
            _acceptSeasonCurrencyAsCredits = _arg_1.readBoolean();
            if (_arg_1.bytesAvailable)
            {
                _frontPageItems = new Vector.<FrontPageItem>(0);
                _local_2 = _arg_1.readInteger();
                _local_3 = 0;
                while (_local_3 < _local_2)
                {
                    _frontPageItems.push(new FrontPageItem(_arg_1));
                    _local_3++;
                };
            };
            return (true);
        }


    }
}