package com.sulake.habbo.communication.messages.parser.help
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class CallForHelpPendingCallsMessageParser implements IMessageParser 
    {

        private var _callArray:Array = [];


        public function get callArray():Array
        {
            return (_callArray);
        }

        public function get callCount():int
        {
            return (_callArray.length);
        }

        public function flush():Boolean
        {
            _callArray = [];
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_4:int;
            var _local_2:Object;
            _callArray = [];
            var _local_3:int = _arg_1.readInteger();
            while (_local_4 < _local_3)
            {
                _local_2 = {};
                _local_2.callId = _arg_1.readString();
                _local_2.timeStamp = _arg_1.readString();
                _local_2.message = _arg_1.readString();
                _callArray.push(_local_2);
                _local_4++;
            };
            return (true);
        }


    }
}