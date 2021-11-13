package com.sulake.habbo.communication.messages.parser.navigator
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class FlatAccessDeniedMessageParser implements IMessageParser 
    {

        private var _flatId:int = 0;
        private var _userName:String = null;


        public function get flatId():int
        {
            return (_flatId);
        }

        public function get userName():String
        {
            return (_userName);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _flatId = _arg_1.readInteger();
            if (_arg_1.bytesAvailable)
            {
                _userName = _arg_1.readString();
            };
            return (true);
        }

        public function flush():Boolean
        {
            _userName = null;
            return (true);
        }


    }
}