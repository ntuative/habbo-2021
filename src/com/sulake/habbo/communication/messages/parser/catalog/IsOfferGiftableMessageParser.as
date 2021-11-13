package com.sulake.habbo.communication.messages.parser.catalog
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class IsOfferGiftableMessageParser implements IMessageParser 
    {

        private var _offerId:int;
        private var _isGiftable:Boolean;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _offerId = _arg_1.readInteger();
            _isGiftable = _arg_1.readBoolean();
            return (true);
        }

        public function get offerId():int
        {
            return (_offerId);
        }

        public function get isGiftable():Boolean
        {
            return (_isGiftable);
        }


    }
}