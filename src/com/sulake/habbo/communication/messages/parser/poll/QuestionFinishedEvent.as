package com.sulake.habbo.communication.messages.parser.poll
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class QuestionFinishedEvent extends MessageEvent implements IMessageEvent 
    {

        public function QuestionFinishedEvent(_arg_1:Function)
        {
            super(_arg_1, QuestionFinishedParser);
        }

        public function getParser():QuestionFinishedParser
        {
            return (_SafeStr_816 as QuestionFinishedParser);
        }


    }
}

