package com.sulake.habbo.communication.messages.outgoing.inventory.badges
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class RequestABadgeComposer implements IMessageComposer 
    {

        private var _SafeStr_1895:String;

        public function RequestABadgeComposer(_arg_1:String)
        {
            _SafeStr_1895 = _arg_1;
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            var _local_1:Array = [];
            _local_1.push(_SafeStr_1895);
            return (_local_1);
        }


    }
}

