package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ItemMessageData;
    import com.sulake.core.utils.Map;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class ItemsMessageParser implements IMessageParser 
    {

        private var _items:Array = [];


        public function flush():Boolean
        {
            _items = [];
            return (true);
        }

        public function getItemCount():int
        {
            return (_items.length);
        }

        public function getItem(_arg_1:int):ItemMessageData
        {
            if (((_arg_1 < 0) || (_arg_1 >= getItemCount())))
            {
                return (null);
            };
            var _local_2:ItemMessageData = (_items[_arg_1] as ItemMessageData);
            if (_local_2 != null)
            {
                _local_2.setReadOnly();
            };
            return (_local_2);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_5:int;
            var _local_7:int;
            var _local_3:String;
            var _local_2:ItemMessageData;
            if (_arg_1 == null)
            {
                return (false);
            };
            _items = [];
            var _local_6:Map = new Map();
            var _local_4:int = _arg_1.readInteger();
            _local_5 = 0;
            while (_local_5 < _local_4)
            {
                _local_7 = _arg_1.readInteger();
                _local_3 = _arg_1.readString();
                _local_6.add(_local_7, _local_3);
                _local_5++;
            };
            var _local_8:int = _arg_1.readInteger();
            Logger.log((("We have: " + _local_8) + " items"));
            _local_5 = 0;
            while (_local_5 < _local_8)
            {
                _local_2 = _SafeStr_84.parseItemData(_arg_1);
                _local_2.ownerName = _local_6.getValue(_local_2.ownerId);
                _items.push(_local_2);
                _local_5++;
            };
            return (true);
        }


    }
}

