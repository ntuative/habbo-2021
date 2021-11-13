package com.sulake.habbo.communication.messages.parser.help
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class QuizResultsMessageParser implements IMessageParser 
    {

        private var _quizCode:String;
        private var _questionIdsForWrongAnswers:Array;


        public function flush():Boolean
        {
            _quizCode = null;
            _questionIdsForWrongAnswers = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_2:int;
            _quizCode = _arg_1.readString();
            _questionIdsForWrongAnswers = [];
            var _local_3:int = _arg_1.readInteger();
            _local_2 = 0;
            while (_local_2 < _local_3)
            {
                _questionIdsForWrongAnswers.push(_arg_1.readInteger());
                _local_2++;
            };
            return (true);
        }

        public function get quizCode():String
        {
            return (_quizCode);
        }

        public function get questionIdsForWrongAnswers():Array
        {
            return (_questionIdsForWrongAnswers);
        }


    }
}