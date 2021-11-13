package com.sulake.habbo.communication.messages.parser.quest
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.quest.CommunityGoalHallOfFame;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class CommunityGoalHallOfFameMessageParser implements IMessageParser 
    {

        private var _data:CommunityGoalHallOfFame;


        public function flush():Boolean
        {
            _data = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _data = new CommunityGoalHallOfFame(_arg_1);
            return (true);
        }

        public function get data():CommunityGoalHallOfFame
        {
            return (_data);
        }


    }
}