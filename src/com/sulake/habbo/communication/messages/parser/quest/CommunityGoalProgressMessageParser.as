package com.sulake.habbo.communication.messages.parser.quest
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.quest.CommunityGoalData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class CommunityGoalProgressMessageParser implements IMessageParser 
    {

        private var _data:CommunityGoalData;


        public function flush():Boolean
        {
            _data = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _data = new CommunityGoalData(_arg_1);
            return (true);
        }

        public function get data():CommunityGoalData
        {
            return (_data);
        }


    }
}