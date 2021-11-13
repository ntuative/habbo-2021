package com.sulake.habbo.communication.messages.incoming.help
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.help.GuideOnDutyStatusMessageParser;

        public class GuideOnDutyStatusMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function GuideOnDutyStatusMessageEvent(_arg_1:Function)
        {
            super(_arg_1, GuideOnDutyStatusMessageParser);
        }

        public function getParser():GuideOnDutyStatusMessageParser
        {
            return (_SafeStr_816 as GuideOnDutyStatusMessageParser);
        }


    }
}

