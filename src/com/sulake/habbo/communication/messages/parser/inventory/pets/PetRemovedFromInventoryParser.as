package com.sulake.habbo.communication.messages.parser.inventory.pets
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class PetRemovedFromInventoryParser implements IMessageParser 
    {

        private var _petId:int;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _petId = _arg_1.readInteger();
            return (true);
        }

        public function get petId():int
        {
            return (_petId);
        }


    }
}