package com.sulake.habbo.communication.messages.parser.help
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class CallForHelpDisabledNotifyMessageParser implements IMessageParser 
    {

        private var _infoUrl:String;


        public function flush():Boolean
        {
            return (false);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _infoUrl = _arg_1.readString();
            return (true);
        }

        public function get infoUrl():String
        {
            return (_infoUrl);
        }


    }
}