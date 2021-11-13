package com.sulake.habbo.communication.messages.parser.room.session
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class CloseConnectionMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function CloseConnectionMessageEvent(_arg_1:Function)
        {
            super(_arg_1, _SafeStr_57);
        }

        public function getParser():_SafeStr_57
        {
            return (_SafeStr_816 as _SafeStr_57);
        }


    }
}

