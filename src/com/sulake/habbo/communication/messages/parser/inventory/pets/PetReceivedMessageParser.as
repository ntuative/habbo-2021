package com.sulake.habbo.communication.messages.parser.inventory.pets
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class PetReceivedMessageParser implements IMessageParser 
    {

        private var _boughtAsGift:Boolean;
        private var _pet:PetData;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _boughtAsGift = _arg_1.readBoolean();
            _pet = new PetData(_arg_1);
            return (true);
        }

        public function get boughtAsGift():Boolean
        {
            return (_boughtAsGift);
        }

        public function get pet():PetData
        {
            return (_pet);
        }


    }
}