package com.sulake.habbo.communication.messages.incoming.users
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.users.ScrSendUserInfoMessageParser;

        public class ScrSendUserInfoEvent extends MessageEvent implements IMessageEvent 
    {

        public function ScrSendUserInfoEvent(_arg_1:Function)
        {
            super(_arg_1, ScrSendUserInfoMessageParser);
        }

        public function getParser():ScrSendUserInfoMessageParser
        {
            return (this._SafeStr_816 as ScrSendUserInfoMessageParser);
        }


    }
}

