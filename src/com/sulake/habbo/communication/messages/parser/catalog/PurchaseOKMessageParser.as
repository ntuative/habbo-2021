package com.sulake.habbo.communication.messages.parser.catalog
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.catalog.PurchaseOKMessageOfferData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class PurchaseOKMessageParser implements IMessageParser 
    {

        private var _offer:PurchaseOKMessageOfferData;


        public function get offer():PurchaseOKMessageOfferData
        {
            return (_offer);
        }

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _offer = new PurchaseOKMessageOfferData(_arg_1);
            return (true);
        }


    }
}