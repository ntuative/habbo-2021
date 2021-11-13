package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetPollUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const OFFER:String = "RWPUW_OFFER";
        public static const ERROR:String = "RWPUW_ERROR";
        public static const CONTENT:String = "RWPUW_CONTENT";

        private var _id:int = -1;
        private var _summary:String;
        private var _headline:String;
        private var _numQuestions:int = 0;
        private var _startMessage:String = "";
        private var _endMessage:String = "";
        private var _questionArray:Array = null;
        private var _pollType:String = "";
        private var _npsPoll:Boolean = false;

        public function RoomWidgetPollUpdateEvent(_arg_1:int, _arg_2:String, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            _id = _arg_1;
            super(_arg_2, _arg_3, _arg_4);
        }

        public function get id():int
        {
            return (_id);
        }

        public function get summary():String
        {
            return (_summary);
        }

        public function set summary(_arg_1:String):void
        {
            _summary = _arg_1;
        }

        public function get headline():String
        {
            return (_headline);
        }

        public function set headline(_arg_1:String):void
        {
            _headline = _arg_1;
        }

        public function get numQuestions():int
        {
            return (_numQuestions);
        }

        public function set numQuestions(_arg_1:int):void
        {
            _numQuestions = _arg_1;
        }

        public function get startMessage():String
        {
            return (_startMessage);
        }

        public function set startMessage(_arg_1:String):void
        {
            _startMessage = _arg_1;
        }

        public function get endMessage():String
        {
            return (_endMessage);
        }

        public function set endMessage(_arg_1:String):void
        {
            _endMessage = _arg_1;
        }

        public function get questionArray():Array
        {
            return (_questionArray);
        }

        public function set questionArray(_arg_1:Array):void
        {
            _questionArray = _arg_1;
        }

        public function get pollType():String
        {
            return (_pollType);
        }

        public function set pollType(_arg_1:String):void
        {
            _pollType = _arg_1;
        }

        public function get npsPoll():Boolean
        {
            return (_npsPoll);
        }

        public function set npsPoll(_arg_1:Boolean):void
        {
            _npsPoll = _arg_1;
        }


    }
}