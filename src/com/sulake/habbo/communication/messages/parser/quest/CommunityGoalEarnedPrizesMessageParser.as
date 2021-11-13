package com.sulake.habbo.communication.messages.parser.quest
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.quest.PrizeData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class CommunityGoalEarnedPrizesMessageParser implements IMessageParser 
    {

        private var _prizes:Array;


        public function flush():Boolean
        {
            _prizes = [];
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_3:int;
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _prizes.push(new PrizeData(_arg_1));
                _local_3++;
            };
            return (true);
        }

        public function get prizes():Array
        {
            return (_prizes);
        }


    }
}