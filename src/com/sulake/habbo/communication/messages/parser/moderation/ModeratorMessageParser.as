package com.sulake.habbo.communication.messages.parser.moderation
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class ModeratorMessageParser implements IMessageParser 
    {

        private var _message:String;
        private var _url:String;


        public function get message():String
        {
            return (_message);
        }

        public function get url():String
        {
            return (_url);
        }

        public function ModerationCautionParser():*
        {
        }

        public function flush():Boolean
        {
            _message = "";
            _url = "";
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _message = _arg_1.readString();
            _url = _arg_1.readString();
            return (true);
        }


    }
}