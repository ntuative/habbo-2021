package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class SetRandomStateMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_1922:int;
        private var _SafeStr_1226:int = 0;

        public function SetRandomStateMessageComposer(_arg_1:int, _arg_2:int=0)
        {
            _SafeStr_1922 = _arg_1;
            _SafeStr_1226 = _arg_2;
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            return ([_SafeStr_1922, _SafeStr_1226]);
        }


    }
}

