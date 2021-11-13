package com.sulake.habbo.communication.messages.outgoing.room.action
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class MuteUserMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_1887:int;
        private var _SafeStr_1907:int = 0;
        private var _SafeStr_1909:int;

        public function MuteUserMessageComposer(_arg_1:int, _arg_2:int, _arg_3:int=0)
        {
            _SafeStr_1887 = _arg_1;
            _SafeStr_1907 = _arg_3;
            _SafeStr_1909 = _arg_2;
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            return ([_SafeStr_1887, _SafeStr_1907, _SafeStr_1909]);
        }


    }
}

