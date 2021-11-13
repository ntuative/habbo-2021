package com.sulake.habbo.communication.messages.parser.inventory.pets
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class NestBreedingSuccessParser implements IMessageParser 
    {

        private var _rarityCategory:int;
        private var _petId:int;


        public function flush():Boolean
        {
            _petId = -1;
            _rarityCategory = -1;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _petId = _arg_1.readInteger();
            _rarityCategory = _arg_1.readInteger();
            return (true);
        }

        public function get rarityCategory():int
        {
            return (_rarityCategory);
        }

        public function get petId():int
        {
            return (_petId);
        }


    }
}