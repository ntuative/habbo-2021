package com.sulake.habbo.communication.messages.outgoing.users
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class DeactivateGuildMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_618:int;

        public function DeactivateGuildMessageComposer(_arg_1:int)
        {
            _SafeStr_618 = _arg_1;
        }

        public function getMessageArray():Array
        {
            return ([_SafeStr_618]);
        }

        public function dispose():void
        {
        }


    }
}

