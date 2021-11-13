package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectMessageData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class ObjectAddMessageParser implements IMessageParser 
    {

        private var _SafeStr_690:ObjectMessageData;


        public function flush():Boolean
        {
            _SafeStr_690 = null;
            return (true);
        }

        public function get data():ObjectMessageData
        {
            var _local_1:ObjectMessageData = _SafeStr_690;
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
            _SafeStr_690 = _SafeStr_75.parseObjectData(_arg_1);
            _SafeStr_690.ownerName = _arg_1.readString();
            return (true);
        }


    }
}

