package com.sulake.habbo.communication.messages.parser.room.action
{
    import com.sulake.core.communication.messages.MessageEvent;

        public class AvatarEffectMessageEvent extends MessageEvent 
    {

        public function AvatarEffectMessageEvent(_arg_1:Function)
        {
            super(_arg_1, AvatarEffectMessageParser);
        }

        public function getParser():AvatarEffectMessageParser
        {
            return (_SafeStr_816 as AvatarEffectMessageParser);
        }


    }
}

