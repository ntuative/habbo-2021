package com.sulake.habbo.communication.messages.outgoing.handshake
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class UniqueIDMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_1888:String;
        private var _SafeStr_1889:String;
        private var _flashVersion:String;

        public function UniqueIDMessageComposer(_arg_1:String, _arg_2:String, _arg_3:String)
        {
            _SafeStr_1888 = _arg_1;
            _SafeStr_1889 = _arg_2;
            _flashVersion = _arg_3;
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            return ([_SafeStr_1888, _SafeStr_1889, _flashVersion]);
        }


    }
}

