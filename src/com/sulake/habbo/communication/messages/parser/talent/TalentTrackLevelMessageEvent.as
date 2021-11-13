package com.sulake.habbo.communication.messages.parser.talent
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class TalentTrackLevelMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function TalentTrackLevelMessageEvent(_arg_1:Function)
        {
            super(_arg_1, TalentTrackLevelMessageParser);
        }

        public function getParser():TalentTrackLevelMessageParser
        {
            return (_SafeStr_816 as TalentTrackLevelMessageParser);
        }


    }
}

