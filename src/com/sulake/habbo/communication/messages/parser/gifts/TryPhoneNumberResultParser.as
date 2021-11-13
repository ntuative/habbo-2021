package com.sulake.habbo.communication.messages.parser.gifts
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class TryPhoneNumberResultParser implements IMessageParser 
    {

        private var _resultCode:int;
        private var _millisToAllowProcessReset:int;


        public function get resultCode():int
        {
            return (_resultCode);
        }

        public function get millisToAllowProcessReset():int
        {
            return (_millisToAllowProcessReset);
        }

        public function flush():Boolean
        {
            _resultCode = -1;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _resultCode = _arg_1.readInteger();
            _millisToAllowProcessReset = _arg_1.readInteger();
            return (true);
        }


    }
}