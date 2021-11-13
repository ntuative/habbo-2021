package com.sulake.habbo.communication.messages.incoming.callforhelp
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.callforhelp.CfhTopicsInitMessageParser;

        public class CfhTopicsInitMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function CfhTopicsInitMessageEvent(_arg_1:Function)
        {
            super(_arg_1, CfhTopicsInitMessageParser);
        }

        public function getParser():CfhTopicsInitMessageParser
        {
            return (_SafeStr_816 as CfhTopicsInitMessageParser);
        }


    }
}

