package com.sulake.habbo.communication.messages.parser.users
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class InClientLinkMessageParser implements IMessageParser 
    {

        private var _link:String;


        public function get link():String
        {
            return (_link);
        }

        public function flush():Boolean
        {
            _link = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _link = _arg_1.readString();
            return (true);
        }


    }
}