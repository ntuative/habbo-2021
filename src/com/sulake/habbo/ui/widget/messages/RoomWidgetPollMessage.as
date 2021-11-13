package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetPollMessage extends RoomWidgetMessage 
    {

        public static const START:String = "RWPM_START";
        public static const REJECT:String = "RWPM_REJECT";
        public static const ANSWER:String = "RWPM_ANSWER";

        private var _id:int = -1;
        private var _questionId:int = 0;
        private var _answers:Array = null;

        public function RoomWidgetPollMessage(_arg_1:String, _arg_2:int)
        {
            _id = _arg_2;
            super(_arg_1);
        }

        public function get id():int
        {
            return (_id);
        }

        public function get questionId():int
        {
            return (_questionId);
        }

        public function set questionId(_arg_1:int):void
        {
            _questionId = _arg_1;
        }

        public function get answers():Array
        {
            return (_answers);
        }

        public function set answers(_arg_1:Array):void
        {
            _answers = _arg_1;
        }


    }
}