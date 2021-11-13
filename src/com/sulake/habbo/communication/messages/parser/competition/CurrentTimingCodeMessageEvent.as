package com.sulake.habbo.communication.messages.parser.competition
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class CurrentTimingCodeMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function CurrentTimingCodeMessageEvent(_arg_1:Function)
        {
            super(_arg_1, CurrentTimingCodeMessageParser);
        }

        public function getParser():CurrentTimingCodeMessageParser
        {
            return (_SafeStr_816 as CurrentTimingCodeMessageParser);
        }


    }
}

