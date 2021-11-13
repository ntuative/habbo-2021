package com.sulake.habbo.communication.messages.outgoing.room.avatar
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class PassCarryItemMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_1887:int;

        public function PassCarryItemMessageComposer(_arg_1:int)
        {
            _SafeStr_1887 = _arg_1;
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            return ([_SafeStr_1887]);
        }


    }
}

