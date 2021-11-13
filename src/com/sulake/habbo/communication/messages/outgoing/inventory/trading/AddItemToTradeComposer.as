package com.sulake.habbo.communication.messages.outgoing.inventory.trading
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class AddItemToTradeComposer implements IMessageComposer 
    {

        private var _SafeStr_1898:int;

        public function AddItemToTradeComposer(_arg_1:int)
        {
            _SafeStr_1898 = _arg_1;
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            return ([_SafeStr_1898]);
        }


    }
}

