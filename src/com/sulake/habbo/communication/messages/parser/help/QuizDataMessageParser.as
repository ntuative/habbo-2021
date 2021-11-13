package com.sulake.habbo.communication.messages.parser.help
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class QuizDataMessageParser implements IMessageParser 
    {

        private var _quizCode:String;
        private var _questionIds:Array;


        public function flush():Boolean
        {
            _quizCode = null;
            _questionIds = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_3:int;
            _quizCode = _arg_1.readString();
            _questionIds = [];
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _questionIds.push(_arg_1.readInteger());
                _local_3++;
            };
            return (true);
        }

        public function get quizCode():String
        {
            return (_quizCode);
        }

        public function get questionIds():Array
        {
            return (_questionIds);
        }


    }
}