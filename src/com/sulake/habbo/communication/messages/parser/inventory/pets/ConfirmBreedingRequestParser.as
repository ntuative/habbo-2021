package com.sulake.habbo.communication.messages.parser.inventory.pets
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.room.pets.BreedingPetInfo;
    import com.sulake.habbo.communication.messages.incoming.room.pets.RarityCategoryData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class ConfirmBreedingRequestParser implements IMessageParser 
    {

        private var _nestId:int;
        private var _pet1:BreedingPetInfo;
        private var _pet2:BreedingPetInfo;
        private var _rarityCategories:Array;
        private var _resultPetType:int;


        public function flush():Boolean
        {
            _nestId = 0;
            if (_pet1)
            {
                _pet1.dispose();
                _pet1 = null;
            };
            if (_pet2)
            {
                _pet2.dispose();
                _pet2 = null;
            };
            for each (var _local_1:RarityCategoryData in _rarityCategories)
            {
                _local_1.dispose();
            };
            _rarityCategories = [];
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_2:int;
            _nestId = _arg_1.readInteger();
            _pet1 = new BreedingPetInfo(_arg_1);
            _pet2 = new BreedingPetInfo(_arg_1);
            var _local_3:int = _arg_1.readInteger();
            _local_2 = 0;
            while (_local_2 < _local_3)
            {
                _rarityCategories.push(new RarityCategoryData(_arg_1));
                _local_2++;
            };
            _resultPetType = _arg_1.readInteger();
            return (true);
        }

        public function get nestId():int
        {
            return (_nestId);
        }

        public function get pet1():BreedingPetInfo
        {
            return (_pet1);
        }

        public function get pet2():BreedingPetInfo
        {
            return (_pet2);
        }

        public function get rarityCategories():Array
        {
            return (_rarityCategories);
        }

        public function get resultPetType():int
        {
            return (_resultPetType);
        }


    }
}