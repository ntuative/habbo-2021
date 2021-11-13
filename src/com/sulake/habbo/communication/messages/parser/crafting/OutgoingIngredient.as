package com.sulake.habbo.communication.messages.parser.crafting
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class OutgoingIngredient 
    {

        private var _count:int;
        private var _furnitureClassName:String;

        public function OutgoingIngredient(_arg_1:IMessageDataWrapper)
        {
            _count = _arg_1.readInteger();
            _furnitureClassName = _arg_1.readString();
        }

        public function get count():int
        {
            return (_count);
        }

        public function get furnitureClassName():String
        {
            return (_furnitureClassName);
        }


    }
}