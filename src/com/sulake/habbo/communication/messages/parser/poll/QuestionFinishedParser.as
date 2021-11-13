package com.sulake.habbo.communication.messages.parser.poll
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.utils.Map;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class QuestionFinishedParser implements IMessageParser 
    {

        private var _questionId:int;
        private var _answerCounts:Map;


        public function get questionId():int
        {
            return (_questionId);
        }

        public function get answerCounts():Map
        {
            return (_answerCounts);
        }

        public function flush():Boolean
        {
            _questionId = -1;
            _answerCounts = null;
            return (false);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_3:int;
            var _local_4:String;
            var _local_2:int;
            _questionId = _arg_1.readInteger();
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