package com.sulake.habbo.communication.messages.parser.hotlooks
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.hotlooks.HotLookInfo;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class HotLooksMessageParser implements IMessageParser 
    {

        private var _hotLooks:Array;


        public function flush():Boolean
        {
            _hotLooks = [];
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_3:int;
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _hotLooks.push(new HotLookInfo(_arg_1));
                _local_3++;
            };
            return (true);
        }

        public function get hotLooks():Array
        {
            return (_hotLooks);
        }


    }
}