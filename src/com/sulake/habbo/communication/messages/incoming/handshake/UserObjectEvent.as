package com.sulake.habbo.communication.messages.incoming.handshake
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.handshake.UserObjectMessageParser;

        public class UserObjectEvent extends MessageEvent implements IMessageEvent 
    {

        public function UserObjectEvent(_arg_1:Function)
        {
            super(_arg_1, UserObjectMessageParser);
        }

        public function getParser():UserObjectMessageParser
        {
            return (this._SafeStr_816 as UserObjectMessageParser);
        }


    }
}

