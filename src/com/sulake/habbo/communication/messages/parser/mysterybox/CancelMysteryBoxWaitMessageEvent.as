package com.sulake.habbo.communication.messages.parser.mysterybox
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class CancelMysteryBoxWaitMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function CancelMysteryBoxWaitMessageEvent(_arg_1:Function)
        {
            super(_arg_1, _SafeStr_59);
        }

        public function getParser():_SafeStr_59
        {
            return (_SafeStr_816 as _SafeStr_59);
        }


    }
}

