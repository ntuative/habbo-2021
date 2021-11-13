package com.sulake.habbo.communication.messages.incoming.quest
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.quest.CommunityGoalProgressMessageParser;

        public class CommunityGoalProgressMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function CommunityGoalProgressMessageEvent(_arg_1:Function)
        {
            super(_arg_1, CommunityGoalProgressMessageParser);
        }

        public function getParser():CommunityGoalProgressMessageParser
        {
            return (_SafeStr_816 as CommunityGoalProgressMessageParser);
        }


    }
}

