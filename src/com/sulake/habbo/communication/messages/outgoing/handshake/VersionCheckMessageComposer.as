package com.sulake.habbo.communication.messages.outgoing.handshake
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class VersionCheckMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_1890:int;
        private var _SafeStr_1891:String;
        private var _SafeStr_1892:String;

        public function VersionCheckMessageComposer(_arg_1:int, _arg_2:String, _arg_3:String)
        {
            _SafeStr_1890 = _arg_1;
            _SafeStr_1891 = _arg_2;
            _SafeStr_1892 = _arg_3;
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            return ([_SafeStr_1890, _SafeStr_1891, _SafeStr_1892]);
        }


    }
}

