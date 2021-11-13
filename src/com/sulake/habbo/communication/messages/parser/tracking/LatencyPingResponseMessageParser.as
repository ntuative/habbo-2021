package com.sulake.habbo.communication.messages.parser.tracking
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class LatencyPingResponseMessageParser implements IMessageParser 
    {

        private var _requestId:int;


        public function get requestId():int
        {
            return (_requestId);
        }

        public function flush():Boolean
        {
            _requestId = -1;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _requestId = _arg_1.readInteger();
            return (true);
        }


    }
}