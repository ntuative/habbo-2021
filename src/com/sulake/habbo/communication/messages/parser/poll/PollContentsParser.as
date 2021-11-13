package com.sulake.habbo.communication.messages.parser.poll
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class PollContentsParser implements IMessageParser 
    {

        private var _id:int = -1;
        private var _startMessage:String = "";
        private var _endMessage:String = "";
        private var _numQuestions:int = 0;
        private var _questionArray:Array = null;
        private var _npsPoll:Boolean = false;


        public function get id():int
        {
            return (_id);
        }

        public function get startMessage():String
        {
            return (_startMessage);
        }

        public function get endMessage():String
        {
            return (_endMessage);
        }

        public function get numQuestions():int
        {
            return (_numQuestions);
        }

        public function get questionArray():Array
        {
            return (_questionArray);
        }

        public function get npsPoll():Boolean
        {
            return (_npsPoll);
        }

        public function flush():Boolean
        {
            _id = -1;
            _startMessage = "";
            _endMessage = "";
            _numQuestions = 0;
            _questionArray = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_2:int;
            var _local_4:PollQuestion;
            var _local_5:int;
            var _local_3:int;
            _id = _arg_1.readInteger();
            _startMessage = _arg_1.readString();
            _endMessage = _arg_1.readString();
            _numQuestions = _arg_1.readInteger();
            _questionArray = [];
            _local_2 = 0;
            while (_local_2 < _numQuestions)
            {
                _local_4 = parseQuestion(_arg_1);
                _local_5 = _arg_1.readInteger();
                _local_3 = 0;
                while (_local_3 < _local_5)
                {
                    _local_4.children.push(parseQuestion(_arg_1));
                    _local_3++;
                };
                _questionArray.push(_local_4);
                _local_2++;
            };
            _npsPoll = _arg_1.readBoolean();
            return (true);
        }

        private function parseQuestion(_arg_1:IMessageDataWrapper):PollQuestion
        {
            var _local_2:int;
            var _local_3:PollQuestion = new PollQuestion();
            _local_3.questionId = _arg_1.readInteger();
            _local_3.sortOrder = _arg_1.readInteger();
            _local_3.questionType = _arg_1.readInteger();
            _local_3.questionText = _arg_1.readString();
            _local_3.questionCategory = _arg_1.readInteger();
            _local_3.questionAnswerType = _arg_1.readInteger();
            _local_3.questionAnswerCount = _arg_1.readInteger();
            if (((_local_3.questionType == 1) || (_local_3.questionType == 2)))
            {
                _local_2 = 0;
                while (_local_2 < _local_3.questionAnswerCount)
                {
                    _local_3.questionChoices.push(new PollChoice(_arg_1.readString(), _arg_1.readString(), _arg_1.readInteger()));
                    _local_2++;
                };
            };
            return (_local_3);
        }


    }
}