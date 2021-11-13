package com.sulake.habbo.communication.messages.parser.help
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class ChatReviewSessionOfferedToGuideMessageParser implements IMessageParser 
    {

        private var _acceptanceTimeout:int;


        public function flush():Boolean
        {
            _acceptanceTimeout = -1;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _acceptanceTimeout = _arg_1.readInteger();
            return (true);
        }

        public function get acceptanceTimeout():int
        {
            return (_acceptanceTimeout);
        }


    }
}