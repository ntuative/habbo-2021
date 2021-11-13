package com.sulake.habbo.communication.messages.parser.mysterybox
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class MysteryBoxKeysMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function MysteryBoxKeysMessageEvent(_arg_1:Function)
        {
            super(_arg_1, MysteryBoxKeysMessageParser);
        }

        public function getParser():MysteryBoxKeysMessageParser
        {
            return (_SafeStr_816 as MysteryBoxKeysMessageParser);
        }


    }
}

