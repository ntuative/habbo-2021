package com.sulake.habbo.communication.messages.parser.camera
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class CameraPublishStatusMessageParser implements IMessageParser 
    {

        private var _SafeStr_1953:Boolean = false;
        private var _SafeStr_1954:int = 0;
        private var _SafeStr_1955:String;


        public function isOk():Boolean
        {
            return (_SafeStr_1953);
        }

        public function getSecondsToWait():int
        {
            return (_SafeStr_1954);
        }

        public function getExtraDataId():String
        {
            return (_SafeStr_1955);
        }

        public function flush():Boolean
        {
            _SafeStr_1953 = false;
            _SafeStr_1954 = 0;
            _SafeStr_1955 = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _SafeStr_1953 = _arg_1.readBoolean();
            _SafeStr_1954 = _arg_1.readInteger();
            if (((_SafeStr_1953) && (_arg_1.bytesAvailable)))
            {
                _SafeStr_1955 = _arg_1.readString();
            };
            return (true);
        }


    }
}

