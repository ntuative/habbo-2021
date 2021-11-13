package com.sulake.habbo.communication.messages.parser.inventory.bots
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.utils.Map;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class BotInventoryMessageParser implements IMessageParser 
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
            var _local_4:int;
            var _local_2:BotData;
            _items = new Map();
            var _local_3:int = _arg_1.readInteger();
            _local_4 = 0;
            while (_local_4 < _local_3)
            {
                _local_2 = new BotData(_arg_1);
                _items.add(_local_2.id, _local_2);
                _local_4++;
            };
            return (true);
        }

        public function get items():Map
        {
            return (_items);
        }


    }
}