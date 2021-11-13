package com.sulake.habbo.communication.messages.outgoing.room.engine
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class MoveAvatarMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_954:int;
        private var _SafeStr_955:int;

        public function MoveAvatarMessageComposer(_arg_1:int, _arg_2:int)
        {
            _SafeStr_954 = _arg_1;
            _SafeStr_955 = _arg_2;
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            return ([_SafeStr_954, _SafeStr_955]);
        }


    }
}

