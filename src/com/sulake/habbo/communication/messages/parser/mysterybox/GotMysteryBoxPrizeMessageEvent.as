package com.sulake.habbo.communication.messages.parser.mysterybox
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class GotMysteryBoxPrizeMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function GotMysteryBoxPrizeMessageEvent(_arg_1:Function)
        {
            super(_arg_1, GotMysteryBoxPrizeMessageParser);
        }

        public function getParser():GotMysteryBoxPrizeMessageParser
        {
            return (_SafeStr_816 as GotMysteryBoxPrizeMessageParser);
        }


    }
}

