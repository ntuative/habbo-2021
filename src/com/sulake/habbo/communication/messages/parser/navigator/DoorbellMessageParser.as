package com.sulake.habbo.communication.messages.parser.navigator
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class DoorbellMessageParser implements IMessageParser 
    {

        private var _userName:String;


        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _userName = _arg_1.readString();
            return (true);
        }

        public function flush():Boolean
        {
            _userName = null;
            return (true);
        }

        public function get userName():String
        {
            return (_userName);
        }


    }
}