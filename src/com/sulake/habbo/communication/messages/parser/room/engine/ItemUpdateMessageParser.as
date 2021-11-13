package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ItemMessageData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class ItemUpdateMessageParser implements IMessageParser 
    {

        private var _SafeStr_2080:ItemMessageData = null;


        public function flush():Boolean
        {
            _SafeStr_2080 = null;
            return (true);
        }

        public function get data():ItemMessageData
        {
            var _local_1:ItemMessageData = _SafeStr_2080;
            if (_local_1 != null)
            {
                _local_1.setReadOnly();
            };
            return (_local_1);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            if (_arg_1 == null)
            {
                return (false);
            };
            _SafeStr_2080 = _SafeStr_84.parseItemData(_arg_1);
            return (true);
        }


    }
}

