package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class ItemDataUpdateMessageParser implements IMessageParser
    {

        private var _id:int = 0;
        private var _itemData:String;


        public function get id():int
        {
            return (_id);
        }

        public function get itemData():String
        {
            return (_itemData);
        }

        public function flush():Boolean
        {
            _id = 0;
            _itemData = "";
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            if (_arg_1 == null)
            {
                return (false);
            };
            var _local_2:String = _arg_1.readString();
            _id = int(_local_2);
            _itemData = _arg_1.readString();
            return (true);
        }


    }
}
