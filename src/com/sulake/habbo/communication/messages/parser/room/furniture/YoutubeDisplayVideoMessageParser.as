package com.sulake.habbo.communication.messages.parser.room.furniture
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class YoutubeDisplayVideoMessageParser implements IMessageParser 
    {

        private var _furniId:int;
        private var _videoId:String;
        private var _startAtSeconds:int;
        private var _endAtSeconds:int;
        private var _state:int;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _furniId = _arg_1.readInteger();
            _videoId = _arg_1.readString();
            _startAtSeconds = _arg_1.readInteger();
            _endAtSeconds = _arg_1.readInteger();
            _state = _arg_1.readInteger();
            return (true);
        }

        public function get furniId():int
        {
            return (_furniId);
        }

        public function get videoId():String
        {
            return (_videoId);
        }

        public function get startAtSeconds():int
        {
            return (_startAtSeconds);
        }

        public function get endAtSeconds():int
        {
            return (_endAtSeconds);
        }

        public function get state():int
        {
            return (_state);
        }


    }
}