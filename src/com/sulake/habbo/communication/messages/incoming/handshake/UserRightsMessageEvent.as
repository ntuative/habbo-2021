package com.sulake.habbo.communication.messages.incoming.handshake
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.handshake.UserRightsMessageParser;

        public class UserRightsMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function UserRightsMessageEvent(_arg_1:Function)
        {
            super(_arg_1, UserRightsMessageParser);
        }

        public function get clubLevel():int
        {
            return ((this._SafeStr_816 as UserRightsMessageParser).clubLevel);
        }

        public function get securityLevel():int
        {
            return ((this._SafeStr_816 as UserRightsMessageParser).securityLevel);
        }

        public function get isAmbassador():Boolean
        {
            return ((this._SafeStr_816 as UserRightsMessageParser).isAmbassador);
        }


    }
}

