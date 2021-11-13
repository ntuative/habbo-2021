package com.sulake.habbo.communication.messages.parser.gifts
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class TryVerificationCodeResultParser implements IMessageParser 
    {

        private var _resultCode:int;
        private var _millisecondsToAllowProcessReset:int;


        public function get resultCode():int
        {
            return (_resultCode);
        }

        public function get millisecondsToAllowProcessReset():int
        {
            return (_millisecondsToAllowProcessReset);
        }

        public function flush():Boolean
        {
            _resultCode = -1;
            _millisecondsToAllowProcessReset = -1;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _resultCode = _arg_1.readInteger();
            _millisecondsToAllowProcessReset = _arg_1.readInteger();
            return (true);
        }


    }
}