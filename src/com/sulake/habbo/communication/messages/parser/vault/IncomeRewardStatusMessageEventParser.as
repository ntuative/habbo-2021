package com.sulake.habbo.communication.messages.parser.vault
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class IncomeRewardStatusMessageEventParser implements IMessageParser 
    {

        private var _data:Array = [];


        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_3:int;
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _data.push(new IncomeReward(_arg_1.readByte(), _arg_1.readByte(), _arg_1.readInteger(), _arg_1.readString()));
                _local_3++;
            };
            return (true);
        }

        public function flush():Boolean
        {
            _data = [];
            return (true);
        }

        public function get data():Array
        {
            return (_data);
        }

        public function set data(_arg_1:Array):void
        {
            _data = _arg_1;
        }


    }
}