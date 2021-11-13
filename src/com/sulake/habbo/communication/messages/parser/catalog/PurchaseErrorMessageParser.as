package com.sulake.habbo.communication.messages.parser.catalog
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class PurchaseErrorMessageParser implements IMessageParser 
    {

        private var _errorCode:int = 0;


        public function get errorCode():int
        {
            return (_errorCode);
        }

        public function flush():Boolean
        {
            _errorCode = 0;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _errorCode = _arg_1.readInteger();
            return (true);
        }


    }
}