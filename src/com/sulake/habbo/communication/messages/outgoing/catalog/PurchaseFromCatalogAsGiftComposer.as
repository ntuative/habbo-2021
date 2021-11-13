package com.sulake.habbo.communication.messages.outgoing.catalog
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class PurchaseFromCatalogAsGiftComposer implements IMessageComposer 
    {

        private var _SafeStr_690:Array = [];

        public function PurchaseFromCatalogAsGiftComposer(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:String, _arg_5:String, _arg_6:int, _arg_7:int, _arg_8:int, _arg_9:Boolean)
        {
            _SafeStr_690.push(_arg_1);
            _SafeStr_690.push(_arg_2);
            _SafeStr_690.push(_arg_3);
            _SafeStr_690.push(_arg_4);
            _SafeStr_690.push(_arg_5);
            _SafeStr_690.push(_arg_6);
            _SafeStr_690.push(_arg_7);
            _SafeStr_690.push(_arg_8);
            _SafeStr_690.push(_arg_9);
        }

        public function dispose():void
        {
            _SafeStr_690 = [];
        }

        public function getMessageArray():Array
        {
            return (_SafeStr_690);
        }


    }
}

