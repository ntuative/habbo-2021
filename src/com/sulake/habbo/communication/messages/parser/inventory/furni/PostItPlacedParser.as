package com.sulake.habbo.communication.messages.parser.inventory.furni
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class PostItPlacedParser implements IMessageParser 
    {

        private var _id:int;
        private var _itemsLeft:int;


        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _id = _arg_1.readInteger();
            _itemsLeft = _arg_1.readInteger();
            return (true);
        }

        public function flush():Boolean
        {
            return (true);
        }

        public function get id():int
        {
            return (_id);
        }

        public function get itemsLeft():int
        {
            return (_itemsLeft);
        }


    }
}