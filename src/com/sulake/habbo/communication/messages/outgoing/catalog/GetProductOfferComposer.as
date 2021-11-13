package com.sulake.habbo.communication.messages.outgoing.catalog
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class GetProductOfferComposer implements IMessageComposer 
    {

        private var _offerId:int;

        public function GetProductOfferComposer(_arg_1:int)
        {
            _offerId = _arg_1;
        }

        public function getMessageArray():Array
        {
            return ([_offerId]);
        }

        public function dispose():void
        {
        }


    }
}