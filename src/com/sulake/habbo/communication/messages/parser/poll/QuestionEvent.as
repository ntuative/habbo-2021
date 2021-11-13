package com.sulake.habbo.communication.messages.parser.poll
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class QuestionEvent extends MessageEvent implements IMessageEvent 
    {

        public function QuestionEvent(_arg_1:Function)
        {
            super(_arg_1, QuestionParser);
        }

        public function getParser():QuestionParser
        {
            return (_SafeStr_816 as QuestionParser);
        }


    }
}

