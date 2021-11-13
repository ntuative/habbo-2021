package com.sulake.habbo.communication.messages.outgoing.room.session
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class ChangeQueueMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_1942:int;

        public function ChangeQueueMessageComposer(_arg_1:int)
        {
            _SafeStr_1942 = _arg_1;
        }

        public function getMessageArray():Array
        {
            return ([_SafeStr_1942]);
        }

        public function dispose():void
        {
        }

        public function get disposed():Boolean
        {
            return (true);
        }


    }
}

