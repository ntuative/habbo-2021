package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class CatalogPageMessageProductData 
    {

        public static const PRODUCT_TYPE_ITEM:String = "i";
        public static const PRODUCT_TYPE_STUFF:String = "s";
        public static const PRODUCT_TYPE_EFFECT:String = "e";
        public static const PRODUCT_TYPE_BADGE:String = "b";

        private var _productType:String;
        private var _furniClassId:int;
        private var _extraParam:String;
        private var _productCount:int;
        private var _uniqueLimitedItem:Boolean;
        private var _uniqueLimitedItemSeriesSize:int;
        private var _uniqueLimitedItemsLeft:int;

        public function CatalogPageMessageProductData(_arg_1:IMessageDataWrapper)
        {
            _productType = _arg_1.readString();
            switch (_productType)
            {
                case "b":
                    _extraParam = _arg_1.readString();
                    _productCount = 1;
                    return;
                default:
                    _furniClassId = _arg_1.readInteger();
                    _extraParam = _arg_1.readString();
                    _productCount = _arg_1.readInteger();
                    _uniqueLimitedItem = _arg_1.readBoolean();
                    if (_uniqueLimitedItem)
                    {
                        _uniqueLimitedItemSeriesSize = _arg_1.readInteger();
                        _uniqueLimitedItemsLeft = _arg_1.readInteger();
                    };
                    return;
            };
        }

        public function get productType():String
        {
            return (_productType);
        }

        public function get furniClassId():int
        {
            return (_furniClassId);
        }

        public function get extraParam():String
        {
            return (_extraParam);
        }

        public function get productCount():int
        {
            return (_productCount);
        }

        public function get uniqueLimitedItem():Boolean
        {
            return (_uniqueLimitedItem);
        }

        public function get uniqueLimitedItemSeriesSize():int
        {
            return (_uniqueLimitedItemSeriesSize);
        }

        public function get uniqueLimitedItemsLeft():int
        {
            return (_uniqueLimitedItemsLeft);
        }


    }
}