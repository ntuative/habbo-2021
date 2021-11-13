package com.sulake.habbo.communication.messages.incoming.moderation
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.moderation.ModerationCautionParser;

        public class ModeratorCautionEvent extends MessageEvent implements IMessageEvent 
    {

        public function ModeratorCautionEvent(_arg_1:Function)
        {
            super(_arg_1, ModerationCautionParser);
        }

        public function getParser():ModerationCautionParser
        {
            return (_SafeStr_816 as ModerationCautionParser);
        }


    }
}

