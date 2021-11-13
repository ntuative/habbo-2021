package com.sulake.habbo.communication.messages.parser.room.pets
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class PetInfoMessageParser implements IMessageParser 
    {

        private var _petId:int;
        private var _name:String;
        private var _level:int;
        private var _maxLevel:int;
        private var _experience:int;
        private var _energy:int;
        private var _nutrition:int;
        private var _experienceRequiredToLevel:int;
        private var _maxEnergy:int;
        private var _maxNutrition:int;
        private var _respect:int;
        private var _ownerId:int;
        private var _ownerName:String;
        private var _age:int;
        private var _breedId:int;
        private var _hasFreeSaddle:Boolean;
        private var _isRiding:Boolean;
        private var _canBreed:Boolean;
        private var _canHarvest:Boolean;
        private var _canRevive:Boolean;
        private var _maxWellBeingSeconds:int;
        private var _remainingWellBeingSeconds:int;
        private var _remainingGrowingSeconds:int;
        private var _skillTresholds:Array;
        private var _accessRights:int;
        private var _rarityLevel:int;
        private var _hasBreedingPermission:Boolean;


        public function get petId():int
        {
            return (_petId);
        }

        public function get name():String
        {
            return (_name);
        }

        public function get level():int
        {
            return (_level);
        }

        public function get maxLevel():int
        {
            return (_maxLevel);
        }

        public function get experience():int
        {
            return (_experience);
        }

        public function get energy():int
        {
            return (_energy);
        }

        public function get nutrition():int
        {
            return (_nutrition);
        }

        public function get experienceRequiredToLevel():int
        {
            return (_experienceRequiredToLevel);
        }

        public function get maxEnergy():int
        {
            return (_maxEnergy);
        }

        public function get maxNutrition():int
        {
            return (_maxNutrition);
        }

        public function get respect():int
        {
            return (_respect);
        }

        public function get ownerId():int
        {
            return (_ownerId);
        }

        public function get ownerName():String
        {
            return (_ownerName);
        }

        public function get age():int
        {
            return (_age);
        }

        public function get breedId():int
        {
            return (_breedId);
        }

        public function get hasFreeSaddle():Boolean
        {
            return (_hasFreeSaddle);
        }

        public function get isRiding():Boolean
        {
            return (_isRiding);
        }

        public function get canBreed():Boolean
        {
            return (_canBreed);
        }

        public function get canHarvest():Boolean
        {
            return (_canHarvest);
        }

        public function get canRevive():Boolean
        {
            return (_canRevive);
        }

        public function get maxWellBeingSeconds():int
        {
            return (_maxWellBeingSeconds);
        }

        public function get remainingWellBeingSeconds():int
        {
            return (_remainingWellBeingSeconds);
        }

        public function get remainingGrowingSeconds():int
        {
            return (_remainingGrowingSeconds);
        }

        public function get skillTresholds():Array
        {
            return (_skillTresholds);
        }

        public function get accessRights():int
        {
            return (_accessRights);
        }

        public function get rarityLevel():int
        {
            return (_rarityLevel);
        }

        public function get hasBreedingPermission():Boolean
        {
            return (_hasBreedingPermission);
        }

        public function flush():Boolean
        {
            _petId = -1;
            _skillTresholds = [];
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_2:int;
            if (_arg_1 == null)
            {
                return (false);
            };
            _petId = _arg_1.readInteger();
            _name = _arg_1.readString();
            _level = _arg_1.readInteger();
            _maxLevel = _arg_1.readInteger();
            _experience = _arg_1.readInteger();
            _experienceRequiredToLevel = _arg_1.readInteger();
            _energy = _arg_1.readInteger();
            _maxEnergy = _arg_1.readInteger();
            _nutrition = _arg_1.readInteger();
            _maxNutrition = _arg_1.readInteger();
            _respect = _arg_1.readInteger();
            _ownerId = _arg_1.readInteger();
            _age = _arg_1.readInteger();
            _ownerName = _arg_1.readString();
            _breedId = _arg_1.readInteger();
            _hasFreeSaddle = _arg_1.readBoolean();
            _isRiding = _arg_1.readBoolean();
            var _local_3:int = _arg_1.readInteger();
            _local_2 = 0;
            while (_local_2 < _local_3)
            {
                _skillTresholds.push(_arg_1.readInteger());
                _local_2++;
            };
            _skillTresholds.sort(16);
            _accessRights = _arg_1.readInteger();
            _canBreed = _arg_1.readBoolean();
            _canHarvest = _arg_1.readBoolean();
            _canRevive = _arg_1.readBoolean();
            _rarityLevel = _arg_1.readInteger();
            _maxWellBeingSeconds = _arg_1.readInteger();
            _remainingWellBeingSeconds = _arg_1.readInteger();
            _remainingGrowingSeconds = _arg_1.readInteger();
            _hasBreedingPermission = _arg_1.readBoolean();
            return (true);
        }


    }
}