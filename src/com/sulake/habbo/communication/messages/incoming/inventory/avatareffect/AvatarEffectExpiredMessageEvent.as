package com.sulake.habbo.communication.messages.incoming.inventory.avatareffect
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.avatareffect.AvatarEffectExpiredMessageParser;

        public class AvatarEffectExpiredMessageEvent extends MessageEvent 
    {

        public function AvatarEffectExpiredMessageEvent(_arg_1:Function)
        {
            super(_arg_1, AvatarEffectExpiredMessageParser);
        }

        public function getParser():AvatarEffectExpiredMessageParser
        {
            return (_SafeStr_816 as AvatarEffectExpiredMessageParser);
        }


    }
}

