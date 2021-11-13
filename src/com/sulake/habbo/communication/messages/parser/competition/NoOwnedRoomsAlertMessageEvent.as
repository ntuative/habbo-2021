package com.sulake.habbo.communication.messages.parser.competition
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class NoOwnedRoomsAlertMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function NoOwnedRoomsAlertMessageEvent(_arg_1:Function)
        {
            super(_arg_1, _SafeStr_56);
        }

        public function getParser():_SafeStr_56
        {
            return (_SafeStr_816 as _SafeStr_56);
        }


    }
}

