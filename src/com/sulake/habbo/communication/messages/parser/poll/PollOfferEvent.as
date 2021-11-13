package com.sulake.habbo.communication.messages.parser.poll
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class PollOfferEvent extends MessageEvent implements IMessageEvent 
    {

        public function PollOfferEvent(_arg_1:Function)
        {
            super(_arg_1, PollOfferParser);
        }

        public function getParser():PollOfferParser
        {
            return (_SafeStr_816 as PollOfferParser);
        }


    }
}

