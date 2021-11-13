package com.sulake.habbo.communication.messages.parser.camera
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class CompetitionStatusMessageParser implements IMessageParser 
    {

        private var _SafeStr_1953:Boolean = false;
        private var _SafeStr_1956:String = null;


        public function isOk():Boolean
        {
            return (_SafeStr_1953);
        }

        public function getErrorReason():String
        {
            return (_SafeStr_1956);
        }

        public function flush():Boolean
        {
            _SafeStr_1953 = false;
            _SafeStr_1956 = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _SafeStr_1953 = _arg_1.readBoolean();
            _SafeStr_1956 = _arg_1.readString();
            return (true);
        }


    }
}

