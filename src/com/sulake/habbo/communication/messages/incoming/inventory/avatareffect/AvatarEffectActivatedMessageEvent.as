package com.sulake.habbo.communication.messages.incoming.inventory.avatareffect
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.avatareffect.AvatarEffectActivatedMessageParser;

        public class AvatarEffectActivatedMessageEvent extends MessageEvent 
    {

        public function AvatarEffectActivatedMessageEvent(_arg_1:Function)
        {
            super(_arg_1, AvatarEffectActivatedMessageParser);
        }

        public function getParser():AvatarEffectActivatedMessageParser
        {
            return (_SafeStr_816 as AvatarEffectActivatedMessageParser);
        }


    }
}

