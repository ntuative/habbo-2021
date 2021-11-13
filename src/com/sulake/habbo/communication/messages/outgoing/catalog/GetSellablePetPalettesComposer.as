package com.sulake.habbo.communication.messages.outgoing.catalog
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class GetSellablePetPalettesComposer implements IMessageComposer 
    {

        private var _SafeStr_690:Array = [];

        public function GetSellablePetPalettesComposer(_arg_1:String)
        {
            _SafeStr_690 = [_arg_1];
        }

        public function dispose():void
        {
            _SafeStr_690 = null;
        }

        public function getMessageArray():Array
        {
            return (_SafeStr_690);
        }


    }
}

