package com.sulake.habbo.communication.messages.outgoing.catalog
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class PurchaseVipMembershipExtensionComposer implements IMessageComposer 
    {

        private var _SafeStr_690:Array = [];

        public function PurchaseVipMembershipExtensionComposer(_arg_1:int)
        {
            _SafeStr_690.push(_arg_1);
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            return (_SafeStr_690);
        }


    }
}

