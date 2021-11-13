package com.sulake.habbo.communication.messages.incoming.help
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.help.QuizDataMessageParser;

        public class QuizDataMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function QuizDataMessageEvent(_arg_1:Function)
        {
            super(_arg_1, QuizDataMessageParser);
        }

        public function getParser():QuizDataMessageParser
        {
            return (_SafeStr_816 as QuizDataMessageParser);
        }


    }
}

