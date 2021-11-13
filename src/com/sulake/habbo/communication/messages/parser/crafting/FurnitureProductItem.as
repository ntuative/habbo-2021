package com.sulake.habbo.communication.messages.parser.crafting
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class FurnitureProductItem 
    {

        private var _productCode:String;
        private var _furnitureClassName:String;

        public function FurnitureProductItem(_arg_1:IMessageDataWrapper)
        {
            _productCode = _arg_1.readString();
            _furnitureClassName = _arg_1.readString();
        }

        public function get productCode():String
        {
            return (_productCode);
        }

        public function get furnitureClassName():String
        {
            return (_furnitureClassName);
        }


    }
}