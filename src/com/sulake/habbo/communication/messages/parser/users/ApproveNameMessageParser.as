package com.sulake.habbo.communication.messages.parser.users
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class ApproveNameMessageParser implements IMessageParser 
    {

        private var _result:int;
        private var _nameValidationInfo:String;


        public function get result():int
        {
            return (_result);
        }

        public function get nameValidationInfo():String
        {
            return (_nameValidationInfo);
        }

        public function flush():Boolean
        {
            _result = -1;
            _nameValidationInfo = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _result = _arg_1.readInteger();
            _nameValidationInfo = _arg_1.readString();
            return (true);
        }


    }
}