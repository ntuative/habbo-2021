package com.sulake.habbo.communication.messages.incoming.quest
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.quest.CommunityGoalEarnedPrizesMessageParser;

        public class CommunityGoalEarnedPrizesMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function CommunityGoalEarnedPrizesMessageEvent(_arg_1:Function)
        {
            super(_arg_1, CommunityGoalEarnedPrizesMessageParser);
        }

        public function getParser():CommunityGoalEarnedPrizesMessageParser
        {
            return (this._SafeStr_816 as CommunityGoalEarnedPrizesMessageParser);
        }


    }
}

