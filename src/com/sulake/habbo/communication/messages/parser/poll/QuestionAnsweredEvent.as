package com.sulake.habbo.communication.messages.parser.poll
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class QuestionAnsweredEvent extends MessageEvent implements IMessageEvent 
    {

        public function QuestionAnsweredEvent(_arg_1:Function)
        {
            super(_arg_1, QuestionAnsweredParser);
        }

        public function getParser():QuestionAnsweredParser
        {
            return (_SafeStr_816 as QuestionAnsweredParser);
        }


    }
}

