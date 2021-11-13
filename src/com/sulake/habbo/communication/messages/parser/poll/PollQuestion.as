package com.sulake.habbo.communication.messages.parser.poll
{
    import __AS3__.vec.Vector;

        public class PollQuestion 
    {

        public static const _SafeStr_2072:int = 0;
        public static const _SafeStr_2073:int = 1;
        public static const _SafeStr_2074:int = 2;
        public static const _SafeStr_2075:int = 3;

        private var _questionId:int;
        private var _questionType:int;
        private var _sortOrder:int;
        private var _questionCategory:int;
        private var _questionText:String;
        private var _questionAnswerType:int;
        private var _questionAnswerCount:int;
        private var _children:Vector.<PollQuestion>;
        private var _questionChoices:Vector.<PollChoice>;

        public function PollQuestion()
        {
            _children = new Vector.<PollQuestion>();
            _questionChoices = new Vector.<PollChoice>();
        }

        public function get questionId():int
        {
            return (_questionId);
        }

        public function set questionId(_arg_1:int):void
        {
            _questionId = _arg_1;
        }

        public function get questionType():int
        {
            return (_questionType);
        }

        public function set questionType(_arg_1:int):void
        {
            _questionType = _arg_1;
        }

        public function get sortOrder():int
        {
            return (_sortOrder);
        }

        public function set sortOrder(_arg_1:int):void
        {
            _sortOrder = _arg_1;
        }

        public function get questionText():String
        {
            return (_questionText);
        }

        public function set questionText(_arg_1:String):void
        {
            _questionText = _arg_1;
        }

        public function get questionCategory():int
        {
            return (_questionCategory);
        }

        public function set questionCategory(_arg_1:int):void
        {
            _questionCategory = _arg_1;
        }

        public function get questionAnswerType():int
        {
            return (_questionAnswerType);
        }

        public function set questionAnswerType(_arg_1:int):void
        {
            _questionAnswerType = _arg_1;
        }

        public function get questionAnswerCount():int
        {
            return (_questionAnswerCount);
        }

        public function set questionAnswerCount(_arg_1:int):void
        {
            _questionAnswerCount = _arg_1;
        }

        public function get children():Vector.<PollQuestion>
        {
            return (_children);
        }

        public function set children(_arg_1:Vector.<PollQuestion>):void
        {
            _children = _arg_1;
        }

        public function get questionChoices():Vector.<PollChoice>
        {
            return (_questionChoices);
        }

        public function set questionChoices(_arg_1:Vector.<PollChoice>):void
        {
            _questionChoices = _arg_1;
        }


    }
}

