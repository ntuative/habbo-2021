package com.sulake.habbo.communication.messages.outgoing.catalog
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class ShopTargetedOfferViewedComposer implements IMessageComposer 
    {

        private var _SafeStr_690:Array = [];

        public function ShopTargetedOfferViewedComposer(_arg_1:int, _arg_2:int)
        {
            _SafeStr_690.push(_arg_1);
            _SafeStr_690.push(_arg_2);
        }

        public function getMessageArray():Array
        {
            return (_SafeStr_690);
        }

        public function dispose():void
        {
            _SafeStr_690 = null;
        }


    }
}

