package com.sulake.habbo.communication.messages.incoming.quest
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.quest.ConcurrentUsersGoalProgressMessageParser;

        public class ConcurrentUsersGoalProgressMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function ConcurrentUsersGoalProgressMessageEvent(_arg_1:Function)
        {
            super(_arg_1, ConcurrentUsersGoalProgressMessageParser);
        }

        public function getParser():ConcurrentUsersGoalProgressMessageParser
        {
            return (_SafeStr_816 as ConcurrentUsersGoalProgressMessageParser);
        }


    }
}

