package com.sulake.habbo.communication.messages.parser.navigator
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.navigator.FlatCategory;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class UserFlatCatsMessageParser implements IMessageParser 
    {

        private var _nodes:Array;


        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_2:int;
            _nodes = [];
            var _local_3:int = _arg_1.readInteger();
            _local_2 = 0;
            while (_local_2 < _local_3)
            {
                _nodes.push(new FlatCategory(_arg_1));
                _local_2++;
            };
            return (true);
        }

        public function flush():Boolean
        {
            _nodes = null;
            return (true);
        }

        public function get nodes():Array
        {
            return (_nodes);
        }


    }
}