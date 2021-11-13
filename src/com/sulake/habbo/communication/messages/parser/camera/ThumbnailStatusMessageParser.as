package com.sulake.habbo.communication.messages.parser.camera
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class ThumbnailStatusMessageParser implements IMessageParser 
    {

        private var _SafeStr_1953:Boolean = true;
        private var _SafeStr_1960:Boolean = false;


        public function isOk():Boolean
        {
            return (_SafeStr_1953);
        }

        public function isRenderLimitHit():Boolean
        {
            return (_SafeStr_1960);
        }

        public function flush():Boolean
        {
            _SafeStr_1953 = true;
            _SafeStr_1960 = false;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            if (_arg_1.bytesAvailable)
            {
                _SafeStr_1953 = _arg_1.readBoolean();
                _SafeStr_1960 = _arg_1.readBoolean();
            };
            return (true);
        }


    }
}

