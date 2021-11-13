package com.sulake.habbo.communication.messages.parser.room.action
{
    import com.sulake.core.communication.messages.MessageEvent;

        public class ExpressionMessageEvent extends MessageEvent 
    {

        public function ExpressionMessageEvent(_arg_1:Function)
        {
            super(_arg_1, ExpressionMessageParser);
        }

        public function getParser():ExpressionMessageParser
        {
            return (_SafeStr_816 as ExpressionMessageParser);
        }


    }
}

