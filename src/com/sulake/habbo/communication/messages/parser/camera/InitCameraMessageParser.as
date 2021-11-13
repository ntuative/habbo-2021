package com.sulake.habbo.communication.messages.parser.camera
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class InitCameraMessageParser implements IMessageParser 
    {

        private var _SafeStr_1957:int = 0;
        private var _SafeStr_1958:int = 0;
        private var _SafeStr_1959:int = 0;


        public function getCreditPrice():int
        {
            return (_SafeStr_1957);
        }

        public function getDucketPrice():int
        {
            return (_SafeStr_1958);
        }

        public function getPublishDucketPrice():int
        {
            return (_SafeStr_1959);
        }

        public function flush():Boolean
        {
            _SafeStr_1957 = 0;
            _SafeStr_1958 = 0;
            _SafeStr_1959 = 0;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _SafeStr_1957 = _arg_1.readInteger();
            _SafeStr_1958 = _arg_1.readInteger();
            if (_arg_1.bytesAvailable > 0)
            {
                _SafeStr_1959 = _arg_1.readInteger();
            };
            return (true);
        }


    }
}

