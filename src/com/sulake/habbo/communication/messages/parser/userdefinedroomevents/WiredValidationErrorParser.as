package com.sulake.habbo.communication.messages.parser.userdefinedroomevents
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class WiredValidationErrorParser implements IMessageParser 
    {

        private var _info:String;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _info = _arg_1.readString();
            return (true);
        }

        public function get info():String
        {
            return (_info);
        }


    }
}