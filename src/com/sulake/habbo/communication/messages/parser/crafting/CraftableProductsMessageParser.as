package com.sulake.habbo.communication.messages.parser.crafting
{
    import com.sulake.core.communication.messages.IMessageParser;
    import __AS3__.vec.Vector;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class CraftableProductsMessageParser implements IMessageParser 
    {

        private var _recipeProductItems:Vector.<FurnitureProductItem> = new Vector.<FurnitureProductItem>(0);
        private var _usableInventoryFurniClasses:Vector.<String> = new Vector.<String>(0);


        public function flush():Boolean
        {
            _recipeProductItems = new Vector.<FurnitureProductItem>(0);
            _usableInventoryFurniClasses = new Vector.<String>(0);
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_3:int;
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _recipeProductItems.push(new FurnitureProductItem(_arg_1));
                _local_3++;
            };
            _local_2 = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _usableInventoryFurniClasses.push(_arg_1.readString());
                _local_3++;
            };
            return (true);
        }

        public function get recipeProductItems():Vector.<FurnitureProductItem>
        {
            return (_recipeProductItems);
        }

        public function get usableInventoryFurniClasses():Vector.<String>
        {
            return (_usableInventoryFurniClasses);
        }

        public function hasData():Boolean
        {
            return ((_recipeProductItems.length > 0) || (_usableInventoryFurniClasses.length > 0));
        }


    }
}