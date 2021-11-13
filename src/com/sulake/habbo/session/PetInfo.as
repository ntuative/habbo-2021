package com.sulake.habbo.session
{
    public class PetInfo implements IPetInfo 
    {

        private var _petId:int;
        private var _level:int;
        private var _levelMax:int;
        private var _experience:int;
        private var _experienceMax:int;
        private var _energy:int;
        private var _energyMax:int;
        private var _nutrition:int;
        private var _nutritionMax:int;
        private var _ownerId:int;
        private var _ownerName:String;
        private var _respect:int;
        private var _age:int;
        private var _breedId:int;
        private var _hasFreeSaddle:Boolean;
        private var _isRiding:Boolean;
        private var _canBreed:Boolean;
        private var _skillTresholds:Array;
        private var _accessRights:int;
        private var _canHarvest:Boolean;
        private var _canRevive:Boolean;
        private var _maxWellBeingSeconds:int;
        private var _remainingWellBeingSeconds:int;
        private var _remainingGrowingSeconds:int;
        private var _rarityLevel:int;
        private var _hasBreedingPermission:Boolean;
        private var _adultLevel:int = 7;


        public function get petId():int
        {
            return (_petId);
        }

        public function get level():int
        {
            return (_level);
        }

        public function get levelMax():int
        {
            return (_levelMax);
        }

        public function get experience():int
        {
            return (_experience);
        }

        public function get experienceMax():int
        {
            return (_experienceMax);
        }

        public function get energy():int
        {
            return (_energy);
        }

        public function get energyMax():int
        {
            return (_energyMax);
        }

        public function get nutrition():int
        {
            return (_nutrition);
        }

        public function get nutritionMax():int
        {
            return (_nutritionMax);
        }

        public function get ownerId():int
        {
            return (_ownerId);
        }

        public function get ownerName():String
        {
            return (_ownerName);
        }

        public function get respect():int
        {
            return (_respect);
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

        public function get skillTresholds():Array
        {
            return (_skillTresholds);
        }

        public function get accessRights():int
        {
            return (_accessRights);
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

        public function get rarityLevel():int
        {
            return (_rarityLevel);
        }

        public function set petId(_arg_1:int):void
        {
            _petId = _arg_1;
        }

        public function set level(_arg_1:int):void
        {
            _level = _arg_1;
        }

        public function set levelMax(_arg_1:int):void
        {
            _levelMax = _arg_1;
        }

        public function set experience(_arg_1:int):void
        {
            _experience = _arg_1;
        }

        public function set experienceMax(_arg_1:int):void
        {
            _experienceMax = _arg_1;
        }

        public function set energy(_arg_1:int):void
        {
            _energy = _arg_1;
        }

        public function set energyMax(_arg_1:int):void
        {
            _energyMax = _arg_1;
        }

        public function set nutrition(_arg_1:int):void
        {
            _nutrition = _arg_1;
        }

        public function set nutritionMax(_arg_1:int):void
        {
            _nutritionMax = _arg_1;
        }

        public function set ownerId(_arg_1:int):void
        {
            _ownerId = _arg_1;
        }

        public function set ownerName(_arg_1:String):void
        {
            _ownerName = _arg_1;
        }

        public function set respect(_arg_1:int):void
        {
            _respect = _arg_1;
        }

        public function set age(_arg_1:int):void
        {
            _age = _arg_1;
        }

        public function set breedId(_arg_1:int):void
        {
            _breedId = _arg_1;
        }

        public function set hasFreeSaddle(_arg_1:Boolean):void
        {
            _hasFreeSaddle = _arg_1;
        }

        public function set isRiding(_arg_1:Boolean):void
        {
            _isRiding = _arg_1;
        }

        public function set skillTresholds(_arg_1:Array):void
        {
            _skillTresholds = _arg_1;
        }

        public function set accessRights(_arg_1:int):void
        {
            _accessRights = _arg_1;
        }

        public function set canBreed(_arg_1:Boolean):void
        {
            _canBreed = _arg_1;
        }

        public function set canHarvest(_arg_1:Boolean):void
        {
            _canHarvest = _arg_1;
        }

        public function set canRevive(_arg_1:Boolean):void
        {
            _canRevive = _arg_1;
        }

        public function get maxWellBeingSeconds():int
        {
            return (_maxWellBeingSeconds);
        }

        public function set maxWellBeingSeconds(_arg_1:int):void
        {
            _maxWellBeingSeconds = _arg_1;
        }

        public function get remainingWellBeingSeconds():int
        {
            return (_remainingWellBeingSeconds);
        }

        public function set remainingWellBeingSeconds(_arg_1:int):void
        {
            _remainingWellBeingSeconds = _arg_1;
        }

        public function get remainingGrowingSeconds():int
        {
            return (_remainingGrowingSeconds);
        }

        public function set remainingGrowingSeconds(_arg_1:int):void
        {
            _remainingGrowingSeconds = _arg_1;
        }

        public function set rarityLevel(_arg_1:int):void
        {
            _rarityLevel = _arg_1;
        }

        public function get hasBreedingPermission():Boolean
        {
            return (_hasBreedingPermission);
        }

        public function set hasBreedingPermission(_arg_1:Boolean):void
        {
            _hasBreedingPermission = _arg_1;
        }

        public function get adultLevel():int
        {
            return (_adultLevel);
        }


    }
}