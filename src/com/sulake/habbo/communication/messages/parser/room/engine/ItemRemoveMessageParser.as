package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class ItemRemoveMessageParser implements IMessageParser
    {

        private var _itemId:int = 0;
        private var _pickerId:int = -1;


        public function get itemId():int
        {
            return (_itemId);
        }

        public function get pickerId():int
        {
            return (_pickerId);
        }

        public function flush():Boolean
        {
            _itemId = 0;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            if (_arg_1 == null)
            {
                return (false);
            };
            _itemId = int(_arg_1.readString());
            _pickerId = _arg_1.readInteger();
            return (true);
        }


    }
}
