package com.sulake.habbo.communication.messages.parser.mysterybox
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class ShowMysteryBoxWaitMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function ShowMysteryBoxWaitMessageEvent(_arg_1:Function)
        {
            super(_arg_1, _SafeStr_63);
        }

        public function getParser():_SafeStr_63
        {
            return (_SafeStr_816 as _SafeStr_63);
        }


    }
}

