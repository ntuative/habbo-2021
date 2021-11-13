package com.sulake.habbo.communication.messages.parser.poll
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.utils.Map;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class QuestionAnsweredParser implements IMessageParser 
    {

        private var _userId:int;
        private var _value:String;
        private var _answerCounts:Map;


        public function get userId():int
        {
            return (_userId);
        }

        public function get value():String
        {
            return (_value);
        }

        public function get answerCounts():Map
        {
            return (_answerCounts);
        }

        public function flush():Boolean
        {
            _userId = -1;
            _value = "";
            _answerCounts = null;
            return (false);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_3:int;
            var _local_4:String;
            var _local_2:int;
            _userId = _arg_1.readInteger();
            _value = _arg_1.readString();
            _answerCounts = new Map();
            var _local_5:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_5)
            {
                _local_4 = _arg_1.readString();
                _local_2 = _arg_1.readInteger();
                _answerCounts.add(_local_4, _local_2);
                _local_3++;
            };
            return (true);
        }


    }
}