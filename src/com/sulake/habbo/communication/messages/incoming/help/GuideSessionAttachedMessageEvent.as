package com.sulake.habbo.communication.messages.incoming.help
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.help.GuideSessionAttachedMessageParser;

        public class GuideSessionAttachedMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function GuideSessionAttachedMessageEvent(_arg_1:Function)
        {
            super(_arg_1, GuideSessionAttachedMessageParser);
        }

        public function getParser():GuideSessionAttachedMessageParser
        {
            return (_SafeStr_816 as GuideSessionAttachedMessageParser);
        }


    }
}

