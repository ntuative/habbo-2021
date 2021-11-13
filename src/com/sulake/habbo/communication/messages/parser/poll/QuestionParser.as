package com.sulake.habbo.communication.messages.parser.poll
{
    import com.sulake.core.communication.messages.IMessageParser;
    import flash.utils.Dictionary;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class QuestionParser implements IMessageParser 
    {

        private var _pollType:String = null;
        private var _pollId:int = -1;
        private var _questionId:int = -1;
        private var _duration:int = -1;
        private var _question:Dictionary = null;


        public function get pollType():String
        {
            return (_pollType);
        }

        public function get pollId():int
        {
            return (_pollId);
        }

        public function get questionId():int
        {
            return (_questionId);
        }

        public function get duration():int
        {
            return (_duration);
        }

        public function get question():Dictionary
        {
            return (_question);
        }

        public function flush():Boolean
        {
            _pollType = null;
            _pollId = -1;
            _questionId = -1;
            _duration = -1;
            _question = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_2:int;
            var _local_3:int;
            _pollType = _arg_1.readString();
            _pollId = _arg_1.readInteger();
            _questionId = _arg_1.readInteger();
            _duration = _arg_1.readInteger();
            _question = new Dictionary();
            _question["id"] = _arg_1.readInteger();
            _question["number"] = _arg_1.readInteger();
            _question["type"] = _arg_1.readInteger();
            _question["content"] = _arg_1.readString();
            if (((_question["type"] == 1) || (_question["type"] == 2)))
            {
                _question["selection_min"] = _arg_1.readInteger();
                _local_2 = _arg_1.readInteger();
                var _local_4:Array = [];
                var _local_5:Array = [];
                _question["selections"] = _local_4;
                _question["selection_values"] = _local_5;
                _question["selection_count"] = _local_2;
                _question["selection_max"] = _local_2;
                _local_3 = 0;
                while (_local_3 < _local_2)
                {
                    _local_5.push(_arg_1.readString());
                    _local_4.push(_arg_1.readString());
                    _local_3++;
                };
            };
            return (true);
        }


    }
}