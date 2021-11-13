package com.sulake.habbo.communication.messages.parser.catalog
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPageMessageProductData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class ClubGiftSelectedParser implements IMessageParser 
    {

        private var _productCode:String;
        private var _products:Array;


        public function flush():Boolean
        {
            _products = [];
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_3:int;
            _products = [];
            _productCode = _arg_1.readString();
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _products.push(new CatalogPageMessageProductData(_arg_1));
                _local_3++;
            };
            return (true);
        }

        public function get productCode():String
        {
            return (_productCode);
        }

        public function get products():Array
        {
            return (_products);
        }


    }
}