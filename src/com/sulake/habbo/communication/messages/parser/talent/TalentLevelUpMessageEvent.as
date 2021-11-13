package com.sulake.habbo.communication.messages.parser.talent
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class TalentLevelUpMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function TalentLevelUpMessageEvent(_arg_1:Function)
        {
            super(_arg_1, TalentLevelUpMessageParser);
        }

        public function getParser():TalentLevelUpMessageParser
        {
            return (_SafeStr_816 as TalentLevelUpMessageParser);
        }


    }
}

