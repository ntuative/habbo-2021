package com.sulake.habbo.communication.messages.parser.help
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class ChatReviewSessionVotingStatusMessageParser implements IMessageParser 
    {

        public static const _SafeStr_2031:int = 0;
        public static const _SafeStr_2032:int = 1;
        public static const _SafeStr_2033:int = 2;
        public static const _SafeStr_2034:int = 3;
        public static const _SafeStr_2035:int = 4;
        public static const _SafeStr_2036:int = 5;

        private var _status:Array;


        public function flush():Boolean
        {
            _status = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_3:int;
            _status = [];
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _status.push(_arg_1.readInteger());
                _local_3++;
            };
            return (true);
        }

        public function get status():Array
        {
            return (_status);
        }


    }
}

