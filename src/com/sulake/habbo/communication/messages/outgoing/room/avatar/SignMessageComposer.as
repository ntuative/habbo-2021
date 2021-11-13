package com.sulake.habbo.communication.messages.outgoing.room.avatar
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class SignMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_1916:int;

        public function SignMessageComposer(_arg_1:int)
        {
            _SafeStr_1916 = _arg_1;
        }

        public function getMessageArray():Array
        {
            return ([_SafeStr_1916]);
        }

        public function dispose():void
        {
        }


    }
}

