package com.sulake.habbo.communication.messages.outgoing.inventory.furni
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class RequestRoomPropertySet implements IMessageComposer 
    {

        private var _SafeStr_1495:int = 0;

        public function RequestRoomPropertySet(_arg_1:int)
        {
            _SafeStr_1495 = _arg_1;
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            var _local_1:Array = [];
            _local_1.push(_SafeStr_1495);
            return (_local_1);
        }


    }
}

