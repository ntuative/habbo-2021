package com.sulake.habbo.communication.messages.parser.poll
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class PollErrorEvent extends MessageEvent implements IMessageEvent 
    {

        public function PollErrorEvent(_arg_1:Function)
        {
            super(_arg_1, _SafeStr_58);
        }

        public function getParser():_SafeStr_58
        {
            return (_SafeStr_816 as _SafeStr_58);
        }


    }
}

