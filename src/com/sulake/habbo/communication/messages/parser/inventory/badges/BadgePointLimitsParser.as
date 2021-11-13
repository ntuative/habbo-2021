package com.sulake.habbo.communication.messages.parser.inventory.badges
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class BadgePointLimitsParser implements IMessageParser 
    {

        private var _data:Array;


        public function flush():Boolean
        {
            _data = [];
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_5:int;
            var _local_6:String;
            var _local_2:int;
            var _local_3:int;
            var _local_4:int = _arg_1.readInteger();
            _local_5 = 0;
            while (_local_5 < _local_4)
            {
                _local_6 = _arg_1.readString();
                _local_2 = _arg_1.readInteger();
                _local_3 = 0;
                while (_local_3 < _local_2)
                {
                    _data.push(new BadgeAndPointLimit(_local_6, _arg_1));
                    _local_3++;
                };
                _local_5++;
            };
            return (true);
        }

        public function get data():Array
        {
            return (_data);
        }


    }
}