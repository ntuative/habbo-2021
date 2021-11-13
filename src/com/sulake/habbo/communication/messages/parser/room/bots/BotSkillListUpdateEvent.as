package com.sulake.habbo.communication.messages.parser.room.bots
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class BotSkillListUpdateEvent extends MessageEvent implements IMessageEvent 
    {

        public function BotSkillListUpdateEvent(_arg_1:Function)
        {
            super(_arg_1, BotSkillListUpdateParser);
        }

        public function getParser():BotSkillListUpdateParser
        {
            return (_SafeStr_816 as BotSkillListUpdateParser);
        }


    }
}

