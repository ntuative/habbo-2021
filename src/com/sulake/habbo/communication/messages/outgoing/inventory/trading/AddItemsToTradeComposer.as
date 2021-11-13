package com.sulake.habbo.communication.messages.outgoing.inventory.trading
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import __AS3__.vec.Vector;

        public class AddItemsToTradeComposer implements IMessageComposer 
    {

        private var _SafeStr_875:Array = [];

        public function AddItemsToTradeComposer(_arg_1:Vector.<int>)
        {
            _SafeStr_875.push(_arg_1.length);
            for each (var _local_2:int in _arg_1)
            {
                _SafeStr_875.push(_local_2);
            };
        }

        public function getMessageArray():Array
        {
            return (_SafeStr_875);
        }

        public function dispose():void
        {
        }


    }
}

