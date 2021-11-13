package com.sulake.habbo.communication.messages.parser.notifications
{
    import com.sulake.core.communication.messages.IMessageParser;
    import flash.utils.Dictionary;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class ActivityPointsMessageParser implements IMessageParser 
    {

        private var _points:Dictionary;


        public function flush():Boolean
        {
            _points = new Dictionary();
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_4:int;
            var _local_5:int;
            var _local_2:int;
            var _local_3:int = _arg_1.readInteger();
            _local_4 = 0;
            while (_local_4 < _local_3)
            {
                _local_5 = _arg_1.readInteger();
                _local_2 = _arg_1.readInteger();
                _points[_local_5] = _local_2;
                _local_4++;
            };
            return (true);
        }

        public function get points():Dictionary
        {
            return (_points);
        }


    }
}