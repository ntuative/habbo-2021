package com.sulake.habbo.communication.messages.incoming.help
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.help.GuideSessionDetachedMessageParser;

        public class GuideSessionDetachedMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function GuideSessionDetachedMessageEvent(_arg_1:Function)
        {
            super(_arg_1, GuideSessionDetachedMessageParser);
        }

        public function getParser():GuideSessionDetachedMessageParser
        {
            return (_SafeStr_816 as GuideSessionDetachedMessageParser);
        }


    }
}

