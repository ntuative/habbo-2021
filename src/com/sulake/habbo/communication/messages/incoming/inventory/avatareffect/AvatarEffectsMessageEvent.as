package com.sulake.habbo.communication.messages.incoming.inventory.avatareffect
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.avatareffect.AvatarEffectsMessageParser;

        public class AvatarEffectsMessageEvent extends MessageEvent 
    {

        public function AvatarEffectsMessageEvent(_arg_1:Function)
        {
            super(_arg_1, AvatarEffectsMessageParser);
        }

        public function getParser():AvatarEffectsMessageParser
        {
            return (_SafeStr_816 as AvatarEffectsMessageParser);
        }


    }
}

