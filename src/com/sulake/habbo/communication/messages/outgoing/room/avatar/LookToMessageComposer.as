package com.sulake.habbo.communication.messages.outgoing.room.avatar
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class LookToMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_1913:int;
        private var _SafeStr_1914:int;

        public function LookToMessageComposer(_arg_1:int, _arg_2:int)
        {
            _SafeStr_1913 = _arg_1;
            _SafeStr_1914 = _arg_2;
        }

        public function getMessageArray():Array
        {
            return ([_SafeStr_1913, _SafeStr_1914]);
        }

        public function dispose():void
        {
        }


    }
}

