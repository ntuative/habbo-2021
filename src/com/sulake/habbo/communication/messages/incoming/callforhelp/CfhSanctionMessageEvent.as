package com.sulake.habbo.communication.messages.incoming.callforhelp
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.callforhelp.CfhSanctionMessageParser;

        public class CfhSanctionMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function CfhSanctionMessageEvent(_arg_1:Function)
        {
            super(_arg_1, CfhSanctionMessageParser);
        }

        public function getParser():CfhSanctionMessageParser
        {
            return (_SafeStr_816 as CfhSanctionMessageParser);
        }


    }
}

