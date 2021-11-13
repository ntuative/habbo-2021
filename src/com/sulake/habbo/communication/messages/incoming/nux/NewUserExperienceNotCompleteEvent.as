package com.sulake.habbo.communication.messages.incoming.nux
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.nux._SafeStr_67;

        public class NewUserExperienceNotCompleteEvent extends MessageEvent implements IMessageEvent 
    {

        public function NewUserExperienceNotCompleteEvent(_arg_1:Function)
        {
            super(_arg_1, _SafeStr_67);
        }

        public function getParser():_SafeStr_67
        {
            return (_SafeStr_816 as _SafeStr_67);
        }


    }
}

