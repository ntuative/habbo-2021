package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.UserChangeMessageParser;

        public class UserChangeMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function UserChangeMessageEvent(_arg_1:Function)
        {
            super(_arg_1, UserChangeMessageParser);
        }

        public function get id():int
        {
            return ((_SafeStr_816 as UserChangeMessageParser).id);
        }

        public function get figure():String
        {
            return ((_SafeStr_816 as UserChangeMessageParser).figure);
        }

        public function get sex():String
        {
            return ((_SafeStr_816 as UserChangeMessageParser).sex);
        }

        public function get customInfo():String
        {
            return ((_SafeStr_816 as UserChangeMessageParser).customInfo);
        }

        public function get achievementScore():int
        {
            return ((_SafeStr_816 as UserChangeMessageParser).achievementScore);
        }


    }
}

