package com.sulake.habbo.communication.messages.parser.room.chat
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class RemainingMutePeriodEvent extends MessageEvent implements IMessageEvent 
    {

        public function RemainingMutePeriodEvent(_arg_1:Function)
        {
            super(_arg_1, RemainingMutePeriodParser);
        }

        public function get secondsRemaining():int
        {
            return (RemainingMutePeriodParser(_SafeStr_816).secondsRemaining);
        }


    }
}

