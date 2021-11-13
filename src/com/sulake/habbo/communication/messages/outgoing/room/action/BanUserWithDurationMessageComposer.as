package com.sulake.habbo.communication.messages.outgoing.room.action
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class BanUserWithDurationMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_1887:int;
        private var _SafeStr_1907:int = 0;
        private var _SafeStr_1908:String;

        public function BanUserWithDurationMessageComposer(_arg_1:int, _arg_2:String, _arg_3:int=0)
        {
            _SafeStr_1887 = _arg_1;
            _SafeStr_1907 = _arg_3;
            _SafeStr_1908 = _arg_2;
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            return ([_SafeStr_1887, _SafeStr_1907, _SafeStr_1908]);
        }


    }
}

