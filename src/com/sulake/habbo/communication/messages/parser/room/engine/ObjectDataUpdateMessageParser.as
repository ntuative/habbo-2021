package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.room.IStuffData;
    import com.sulake.habbo.room.object.data.LegacyStuffData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class ObjectDataUpdateMessageParser implements IMessageParser
    {

        private var _id:int = 0;
        private var _state:int = 0;
        private var _data:IStuffData;


        public function get id():int
        {
            return (_id);
        }

        public function get state():int
        {
            return (_state);
        }

        public function get data():IStuffData
        {
            return (_data);
        }

        public function flush():Boolean
        {
            _state = 0;
            _data = (new LegacyStuffData() as IStuffData);
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            if (_arg_1 == null)
            {
                return (false);
            };
            var _local_3:String = _arg_1.readString();
            _id = int(_local_3);
            _data = _SafeStr_75.parseStuffData(_arg_1);
            var _local_2:Number = parseFloat(_data.getLegacyString());
            if (!isNaN(_local_2))
            {
                _state = int(_data.getLegacyString());
            };
            return (true);
        }


    }
}