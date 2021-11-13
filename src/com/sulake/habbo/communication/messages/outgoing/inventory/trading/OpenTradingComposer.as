package com.sulake.habbo.communication.messages.outgoing.inventory.trading
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class OpenTradingComposer implements IMessageComposer 
    {

        private var _SafeStr_1899:int;

        public function OpenTradingComposer(_arg_1:int)
        {
            _SafeStr_1899 = _arg_1;
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            return ([_SafeStr_1899]);
        }


    }
}

