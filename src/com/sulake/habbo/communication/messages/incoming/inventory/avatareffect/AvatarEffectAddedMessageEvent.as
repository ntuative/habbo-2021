package com.sulake.habbo.communication.messages.incoming.inventory.avatareffect
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.avatareffect.AvatarEffectAddedMessageParser;

        public class AvatarEffectAddedMessageEvent extends MessageEvent 
    {

        public function AvatarEffectAddedMessageEvent(_arg_1:Function)
        {
            super(_arg_1, AvatarEffectAddedMessageParser);
        }

        public function getParser():AvatarEffectAddedMessageParser
        {
            return (_SafeStr_816 as AvatarEffectAddedMessageParser);
        }


    }
}

