package com.sulake.habbo.communication.messages.parser.room.furniture
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class YoutubeControlVideoMessageParser implements IMessageParser 
    {

        private var _furniId:int;
        private var _commandId:int;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _furniId = _arg_1.readInteger();
            _commandId = _arg_1.readInteger();
            return (true);
        }

        public function get furniId():int
        {
            return (_furniId);
        }

        public function get commandId():int
        {
            return (_commandId);
        }


    }
}