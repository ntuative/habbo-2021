package com.sulake.habbo.communication.messages.parser.catalog
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class LimitedOfferAppearingNextMessageParser implements IMessageParser 
    {

        private var _appearsInSeconds:int;
        private var _pageId:int;
        private var _offerId:int;
        private var _productType:String;


        public function flush():Boolean
        {
            _appearsInSeconds = -1;
            _pageId = -1;
            _offerId = -1;
            _productType = "";
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _appearsInSeconds = _arg_1.readInteger();
            _pageId = _arg_1.readInteger();
            _offerId = _arg_1.readInteger();
            _productType = _arg_1.readString();
            return (true);
        }

        public function get appearsInSeconds():int
        {
            return (_appearsInSeconds);
        }

        public function get pageId():int
        {
            return (_pageId);
        }

        public function get offerId():int
        {
            return (_offerId);
        }

        public function get productType():String
        {
            return (_productType);
        }


    }
}