package com.sulake.habbo.communication.messages.incoming.notifications
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.notifications._SafeStr_62;

        public class RestoreClientMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function RestoreClientMessageEvent(_arg_1:Function)
        {
            super(_arg_1, _SafeStr_62);
        }

        public function getParser():_SafeStr_62
        {
            return (_SafeStr_816 as _SafeStr_62);
        }


    }
}

