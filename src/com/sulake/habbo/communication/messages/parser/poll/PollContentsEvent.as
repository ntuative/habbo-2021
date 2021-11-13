package com.sulake.habbo.communication.messages.parser.poll
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class PollContentsEvent extends MessageEvent implements IMessageEvent 
    {

        public function PollContentsEvent(_arg_1:Function)
        {
            super(_arg_1, PollContentsParser);
        }

        public function getParser():PollContentsParser
        {
            return (_SafeStr_816 as PollContentsParser);
        }


    }
}

