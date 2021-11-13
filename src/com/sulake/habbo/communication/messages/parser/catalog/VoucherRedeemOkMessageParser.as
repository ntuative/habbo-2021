package com.sulake.habbo.communication.messages.parser.catalog
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class VoucherRedeemOkMessageParser implements IMessageParser 
    {

        private var _productName:String = "";
        private var _productDescription:String = "";


        public function flush():Boolean
        {
            _productDescription = "";
            _productName = "";
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _productDescription = _arg_1.readString();
            _productName = _arg_1.readString();
            return (true);
        }

        public function get productName():String
        {
            return (_productName);
        }

        public function get productDescription():String
        {
            return (_productDescription);
        }


    }
}