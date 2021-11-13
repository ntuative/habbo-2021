package com.sulake.habbo.communication.messages.outgoing.room.engine
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class PlaceBotMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_1917:int;
        private var _SafeStr_954:int;
        private var _SafeStr_955:int;

        public function PlaceBotMessageComposer(_arg_1:int, _arg_2:int, _arg_3:int)
        {
            _SafeStr_1917 = _arg_1;
            _SafeStr_954 = _arg_2;
            _SafeStr_955 = _arg_3;
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            return ([_SafeStr_1917, _SafeStr_954, _SafeStr_955]);
        }


    }
}

