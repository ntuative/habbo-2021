package com.sulake.habbo.communication.messages.outgoing.catalog
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class PurchaseFromCatalogComposer implements IMessageComposer 
    {

        private var _SafeStr_690:Array = [];

        public function PurchaseFromCatalogComposer(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:int)
        {
            _SafeStr_690.push(_arg_1);
            _SafeStr_690.push(_arg_2);
            _SafeStr_690.push(_arg_3);
            _SafeStr_690.push(_arg_4);
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

