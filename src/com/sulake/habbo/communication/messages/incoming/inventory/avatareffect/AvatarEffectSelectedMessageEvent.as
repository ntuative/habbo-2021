package com.sulake.habbo.communication.messages.incoming.inventory.avatareffect
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.avatareffect.AvatarEffectSelectedMessageParser;

        public class AvatarEffectSelectedMessageEvent extends MessageEvent 
    {

        public function AvatarEffectSelectedMessageEvent(_arg_1:Function)
        {
            super(_arg_1, AvatarEffectSelectedMessageParser);
        }

        public function getParser():AvatarEffectSelectedMessageParser
        {
            return (_SafeStr_816 as AvatarEffectSelectedMessageParser);
        }


    }
}

