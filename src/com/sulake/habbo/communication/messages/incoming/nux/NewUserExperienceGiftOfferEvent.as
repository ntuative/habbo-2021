package com.sulake.habbo.communication.messages.incoming.nux
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.nux.NewUserExperienceGiftOfferParser;

        public class NewUserExperienceGiftOfferEvent extends MessageEvent implements IMessageEvent 
    {

        public function NewUserExperienceGiftOfferEvent(_arg_1:Function)
        {
            super(_arg_1, NewUserExperienceGiftOfferParser);
        }

        public function getParser():NewUserExperienceGiftOfferParser
        {
            return (_SafeStr_816 as NewUserExperienceGiftOfferParser);
        }


    }
}

