package com.sulake.habbo.communication.messages.parser.users
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class EmailStatusParser implements IMessageParser 
    {

        private var _email:String;
        private var _isVerified:Boolean;
        private var _allowChange:Boolean;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _email = _arg_1.readString();
            _isVerified = _arg_1.readBoolean();
            _allowChange = _arg_1.readBoolean();
            return (true);
        }

        public function get email():String
        {
            return (_email);
        }

        public function get isVerified():Boolean
        {
            return (_isVerified);
        }

        public function get allowChange():Boolean
        {
            return (_allowChange);
        }


    }
}