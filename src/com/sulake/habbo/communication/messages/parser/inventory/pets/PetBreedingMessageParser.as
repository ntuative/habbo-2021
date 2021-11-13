package com.sulake.habbo.communication.messages.parser.inventory.pets
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class PetBreedingMessageParser implements IMessageParser 
    {

        public static const _SafeStr_1940:int = 1;
        public static const _SafeStr_1941:int = 2;
        public static const _SafeStr_2058:int = 3;

        private var _state:int;
        private var _ownPetId:int;
        private var _otherPetId:int;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _state = _arg_1.readInteger();
            _ownPetId = _arg_1.readInteger();
            _otherPetId = _arg_1.readInteger();
            return (true);
        }

        public function get state():int
        {
            return (_state);
        }

        public function get ownPetId():int
        {
            return (_ownPetId);
        }

        public function get otherPetId():int
        {
            return (_otherPetId);
        }


    }
}

