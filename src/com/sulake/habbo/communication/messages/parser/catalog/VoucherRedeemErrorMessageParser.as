package com.sulake.habbo.communication.messages.parser.catalog
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class VoucherRedeemErrorMessageParser implements IMessageParser 
    {

        private var _errorCode:String = "";


        public function flush():Boolean
        {
            _errorCode = "";
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _errorCode = _arg_1.readString();
            return (true);
        }

        public function get errorCode():String
        {
            return (_errorCode);
        }


    }
}