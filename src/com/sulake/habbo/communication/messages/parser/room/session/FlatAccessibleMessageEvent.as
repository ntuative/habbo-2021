package com.sulake.habbo.communication.messages.parser.room.session
{
    import com.sulake.core.communication.messages.MessageEvent;

        public class FlatAccessibleMessageEvent extends MessageEvent 
    {

        public function FlatAccessibleMessageEvent(_arg_1:Function)
        {
            super(_arg_1, FlatAccessibleMessageParser);
        }

        public function getParser():FlatAccessibleMessageParser
        {
            return (_SafeStr_816 as FlatAccessibleMessageParser);
        }


    }
}

