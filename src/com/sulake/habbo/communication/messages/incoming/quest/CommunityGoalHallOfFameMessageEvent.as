package com.sulake.habbo.communication.messages.incoming.quest
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.quest.CommunityGoalHallOfFameMessageParser;

        public class CommunityGoalHallOfFameMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function CommunityGoalHallOfFameMessageEvent(_arg_1:Function)
        {
            super(_arg_1, CommunityGoalHallOfFameMessageParser);
        }

        public function getParser():CommunityGoalHallOfFameMessageParser
        {
            return (_SafeStr_816 as CommunityGoalHallOfFameMessageParser);
        }


    }
}

