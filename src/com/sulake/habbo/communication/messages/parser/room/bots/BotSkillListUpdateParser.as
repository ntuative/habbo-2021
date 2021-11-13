package com.sulake.habbo.communication.messages.parser.room.bots
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class BotSkillListUpdateParser implements IMessageParser 
    {

        private var _botId:int;
        private var _skillList:Array;


        public function get skillList():Array
        {
            return (_skillList);
        }

        public function get botId():int
        {
            return (_botId);
        }

        public function flush():Boolean
        {
            _botId = -1;
            _skillList = new Array(0);
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_3:int;
            _botId = _arg_1.readInteger();
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _skillList.push(new BotSkillData(_arg_1));
                _local_3++;
            };
            return (true);
        }


    }
}