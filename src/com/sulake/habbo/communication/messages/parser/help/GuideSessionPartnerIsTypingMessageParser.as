package com.sulake.habbo.communication.messages.parser.help
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class GuideSessionPartnerIsTypingMessageParser implements IMessageParser 
    {

        private var _isTyping:Boolean;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _isTyping = _arg_1.readBoolean();
            return (true);
        }

        public function get isTyping():Boolean
        {
            return (_isTyping);
        }


    }
}