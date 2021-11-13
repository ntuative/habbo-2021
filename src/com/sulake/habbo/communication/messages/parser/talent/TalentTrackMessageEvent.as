package com.sulake.habbo.communication.messages.parser.talent
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class TalentTrackMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function TalentTrackMessageEvent(_arg_1:Function)
        {
            super(_arg_1, TalentTrackMessageParser);
        }

        public function getParser():TalentTrackMessageParser
        {
            return (_SafeStr_816 as TalentTrackMessageParser);
        }


    }
}

