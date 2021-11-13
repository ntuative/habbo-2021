package com.sulake.habbo.communication.messages.parser.room.action
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class UseObjectMessageParser implements IMessageParser 
    {

        private var _userId:int = 0;
        private var _itemType:int;


        public function get userId():int
        {
            return (_userId);
        }

        public function get itemType():int
        {
            return (_itemType);
        }

        public function flush():Boolean
        {
            _userId = 0;
            _itemType = 0;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            if (_arg_1 == null)
            {
                return (false);
            };
            _userId = _arg_1.readInteger();
            _itemType = _arg_1.readInteger();
            return (true);
        }


    }
}