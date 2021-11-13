package com.sulake.habbo.communication.messages.outgoing.room.action
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class UnmuteUserMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_1887:int;
        private var _SafeStr_1907:int = 0;

        public function UnmuteUserMessageComposer(_arg_1:int, _arg_2:int=0)
        {
            _SafeStr_1887 = _arg_1;
            _SafeStr_1907 = _arg_2;
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            return ([_SafeStr_1887, _SafeStr_1907]);
        }


    }
}

