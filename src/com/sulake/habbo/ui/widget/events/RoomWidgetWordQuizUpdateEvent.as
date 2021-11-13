package com.sulake.habbo.ui.widget.events
{
    import flash.utils.Dictionary;
    import com.sulake.core.utils.Map;

    public class RoomWidgetWordQuizUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const _SafeStr_3691:String = "RWPUW_NEW_QUESTION";
        public static const FINISHED:String = "RWPUW_QUESION_FINSIHED";
        public static const _SafeStr_3692:String = "RWPUW_QUESTION_ANSWERED";

        private var _id:int = -1;
        private var _pollType:String = null;
        private var _pollId:int = -1;
        private var _questionId:int = -1;
        private var _duration:int = -1;
        private var _question:Dictionary = null;
        private var _userId:int = -1;
        private var _value:String;
        private var _answerCounts:Map;

        public function RoomWidgetWordQuizUpdateEvent(_arg_1:int, _arg_2:String, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            _id = _arg_1;
            super(_arg_2, _arg_3, _arg_4);
        }

        public function get id():int
        {
            return (_id);
        }

        public function get pollType():String
        {
            return (_pollType);
        }

        public function set pollType(_arg_1:String):void
        {
            _pollType = _arg_1;
        }

        public function get pollId():int
        {
            return (_pollId);
        }

        public function set pollId(_arg_1:int):void
        {
            _pollId = _arg_1;
        }

        public function get questionId():int
        {
            return (_questionId);
        }

        public function set questionId(_arg_1:int):void
        {
            _questionId = _arg_1;
        }

        public function get duration():int
        {
            return (_duration);
        }

        public function set duration(_arg_1:int):void
        {
            _duration = _arg_1;
        }

        public function get question():Dictionary
        {
            return (_question);
        }

        public function set question(_arg_1:Dictionary):void
        {
            _question = _arg_1;
        }

        public function get userId():int
        {
            return (_userId);
        }

        public function set userId(_arg_1:int):void
        {
            _userId = _arg_1;
        }

        public function get value():String
        {
            return (_value);
        }

        public function set value(_arg_1:String):void
        {
            _value = _arg_1;
        }

        public function get answerCounts():Map
        {
            return (_answerCounts);
        }

        public function set answerCounts(_arg_1:Map):void
        {
            _answerCounts = _arg_1;
        }


    }
}

