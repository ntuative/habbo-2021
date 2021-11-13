package com.sulake.habbo.communication.messages.parser.users
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class IgnoreResultMessageParser implements IMessageParser 
    {

        private var _result:int;
        private var _name:String;

        public function IgnoreResultMessageParser()
        {
            _result = -1;
        }

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _result = _arg_1.readInteger();
            _name = _arg_1.readString();
            return (true);
        }

        public function get result():int
        {
            return (_result);
        }

        public function get name():String
        {
            return (_name);
        }


    }
}