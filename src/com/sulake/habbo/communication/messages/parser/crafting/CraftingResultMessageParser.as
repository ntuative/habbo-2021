package com.sulake.habbo.communication.messages.parser.crafting
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class CraftingResultMessageParser implements IMessageParser 
    {

        private var _success:Boolean;
        private var _productData:FurnitureProductItem;


        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _success = _arg_1.readBoolean();
            if (_success)
            {
                _productData = new FurnitureProductItem(_arg_1);
            };
            return (true);
        }

        public function flush():Boolean
        {
            _success = false;
            return (true);
        }

        public function get success():Boolean
        {
            return (_success);
        }

        public function get productData():FurnitureProductItem
        {
            return (_productData);
        }


    }
}