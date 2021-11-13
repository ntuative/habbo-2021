package com.sulake.habbo.communication.messages.parser.marketplace
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class MarketplaceCanMakeOfferResultParser implements IMessageParser 
    {

        private var _tokenCount:int;
        private var _resultCode:int;


        public function get tokenCount():int
        {
            return (_tokenCount);
        }

        public function get resultCode():int
        {
            return (_resultCode);
        }

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _resultCode = _arg_1.readInteger();
            _tokenCount = _arg_1.readInteger();
            return (true);
        }


    }
}