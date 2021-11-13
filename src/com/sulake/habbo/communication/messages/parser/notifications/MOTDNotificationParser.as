package com.sulake.habbo.communication.messages.parser.notifications
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class MOTDNotificationParser implements IMessageParser 
    {

        private var _messages:Array;


        public function flush():Boolean
        {
            _messages = [];
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_3:int;
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _messages.push(_arg_1.readString());
                _local_3++;
            };
            return (true);
        }

        public function get messages():Array
        {
            return (_messages);
        }


    }
}