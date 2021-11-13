package com.sulake.habbo.communication.messages.parser.marketplace
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class MarketplaceCancelOfferResultParser implements IMessageParser 
    {

        private var _offerId:int;
        private var _success:Boolean;


        public function get success():Boolean
        {
            return (_success);
        }

        public function get offerId():int
        {
            return (_offerId);
        }

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _offerId = _arg_1.readInteger();
            _success = _arg_1.readBoolean();
            return (true);
        }


    }
}