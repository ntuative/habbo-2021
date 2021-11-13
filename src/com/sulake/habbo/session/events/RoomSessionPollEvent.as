package com.sulake.habbo.session.events
{
    import com.sulake.habbo.session.IRoomSession;

    public class RoomSessionPollEvent extends RoomSessionEvent 
    {

        public static const OFFER:String = "RSPE_POLL_OFFER";
        public static const ERROR:String = "RSPE_POLL_ERROR";
        public static const CONTENT:String = "RSPE_POLL_CONTENT";

        private var _id:int = -1;
        private var _headline:String;
        private var _summary:String;
        private var _numQuestions:int = 0;
        private var _startMessage:String = "";
        private var _endMessage:String = "";
        private var _questionArray:Array = null;
        private var _npsPoll:Boolean = false;

        public function RoomSessionPollEvent(_arg_1:String, _arg_2:IRoomSession, _arg_3:int)
        {
            _id = _arg_3;
            super(_arg_1, _arg_2);
        }

        public function get id():int
        {
            return (_id);
        }

        public function get headline():String
        {
            return (_headline);
        }

        public function set headline(_arg_1:String):void
        {
            _headline = _arg_1;
        }

        public function get summary():String
        {
            return (_summary);
        }

        public function set summary(_arg_1:String):void
        {
            _summary = _arg_1;
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