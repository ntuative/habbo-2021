package com.sulake.habbo.communication.messages.parser.inventory.pets
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class PetAddedToInventoryParser implements IMessageParser 
    {

        private var _pet:PetData;
        private var _SafeStr_2055:Boolean;


        public function flush():Boolean
        {
            _pet = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _pet = new PetData(_arg_1);
            _SafeStr_2055 = _arg_1.readBoolean();
            return (true);
        }

        public function get pet():PetData
        {
            return (_pet);
        }

        public function openInventory():Boolean
        {
            return (_SafeStr_2055);
        }


    }
}

