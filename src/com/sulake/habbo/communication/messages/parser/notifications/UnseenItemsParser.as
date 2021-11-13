package com.sulake.habbo.communication.messages.parser.notifications
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.utils.Map;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class UnseenItemsParser implements IMessageParser 
    {

        private var _items:Map;


        public function flush():Boolean
        {
            if (_items)
            {
                _items.dispose();
                _items = null;
            };
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_5:int;
            var _local_6:Array;
            var _local_3:int;
            var _local_7:int;
            var _local_4:int;
            _items = new Map();
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _local_5 = _arg_1.readInteger();
                _local_6 = [];
                _local_7 = _arg_1.readInteger();
                _local_4 = 0;
                while (_local_4 < _local_7)
                {
                    _local_6.push(_arg_1.readInteger());
                    _local_4++;
                };
                _items.add(_local_5, _local_6);
                _local_3++;
            };
            return (true);
        }

        public function getCategories():Array
        {
            return (_items.getKeys());
        }

        public function getItemsByCategory(_arg_1:int):Array
        {
            return (_items.getValue(_arg_1));
        }


    }
}