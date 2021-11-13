package com.sulake.habbo.ui.widget.events
{
    import flash.display.BitmapData;

    public class RoomWidgetPetInfoUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const PET_INFO:String = "RWPIUE_PET_INFO";

        private var _level:int;
        private var _levelMax:int;
        private var _experience:int;
        private var _experienceMax:int;
        private var _energy:int;
        private var _energyMax:int;
        private var _nutrition:int;
        private var _nutritionMax:int;
        private var _petRespectLeft:int;
        private var _petRespect:int;
        private var _age:int;
        private var _name:String;
        private var _id:int;
        private var _image:BitmapData;
        private var _petType:int;
        private var _petRace:int;
        private var _isOwnPet:Boolean;
        private var _ownerId:int;
        private var _ownerName:String;
        private var _canRemovePet:Boolean;
        private var _roomIndex:int;
        private var _breedId:int;
        private var _hasFreeSaddle:Boolean;
        private var _isRiding:Boolean;
        private var _canBreed:Boolean;
        private var _skillTresholds:Array;
        private var _accessRights:int;
        private var _canHarvest:Boolean;
        private var _canRevive:Boolean;
        private var _rarityLevel:int;
        private var _maxWellBeingSeconds:int;
        private var _remainingWellBeingSeconds:int;
        private var _remainingGrowingSeconds:int;
        private var _hasBreedingPermission:Boolean;

        public function RoomWidgetPetInfoUpdateEvent(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:int, _arg_5:BitmapData, _arg_6:Boolean, _arg_7:int, _arg_8:String, _arg_9:int, _arg_10:int, _arg_11:Boolean=false, _arg_12:Boolean=false)
        {
            super("RWPIUE_PET_INFO", _arg_11, _arg_12);
            _petType = _arg_1;
            _petRace = _arg_2;
            _name = _arg_3;
            _id = _arg_4;
            _image = _arg_5;
            _isOwnPet = _arg_6;
            _ownerId = _arg_7;
            _ownerName = _arg_8;
            _roomIndex = _arg_9;
            _breedId = _arg_10;
        }

        public function get name():String
        {
            return (_name);
        }

        public function get image():BitmapData
        {
            return (_image);
        }

        public function get id():int
        {
            return (_id);
        }

        public function get petType():int
        {
            return (_petType);
        }

        public function get petRace():int
        {
            return (_petRace);
        }

        public function get isOwnPet():Boolean
        {
            return (_isOwnPet);
        }

        public function get ownerId():int
        {
            return (_ownerId);
        }

        public function get ownerName():String
        {
            return (_ownerName);
        }

        public function get canRemovePet():Boolean
        {
            return (_canRemovePet);
        }

        public function get roomIndex():int
        {
            return (_roomIndex);
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

        public function get rarityLevel():int
        {
            return (_rarityLevel);
        }

        public function get skillTresholds():Array
        {
            return (_skillTresholds);
        }

        public function get accessRights():int
        {
            return (_accessRights);
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

        public function get petRespectLeft():int
        {
            return (_petRespectLeft);
        }

        public function get petRespect():int
        {
            return (_petRespect);
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

        public function set petRespectLeft(_arg_1:int):void
        {
            _petRespectLeft = _arg_1;
        }

        public function set canRemovePet(_arg_1:Boolean):void
        {
            _canRemovePet = _arg_1;
        }

        public function set petRespect(_arg_1:int):void
        {
            _petRespect = _arg_1;
        }

        public function set age(_arg_1:int):void
        {
            _age = _arg_1;
        }

        public function set hasFreeSaddle(_arg_1:Boolean):void
        {
            _hasFreeSaddle = _arg_1;
        }

        public function set isRiding(_arg_1:Boolean):void
        {
            _isRiding = _arg_1;
        }

        public function set canBreed(_arg_1:Boolean):void
        {
            _canBreed = _arg_1;
        }

        public function set skillTresholds(_arg_1:Array):void
        {
            _skillTresholds = _arg_1;
        }

        public function set accessRights(_arg_1:int):void
        {
            _accessRights = _arg_1;
        }

        public function set canHarvest(_arg_1:Boolean):void
        {
            _canHarvest = _arg_1;
        }

        public function set canRevive(_arg_1:Boolean):void
        {
            _canRevive = _arg_1;
        }

        public function set rarityLevel(_arg_1:int):void
        {
            _rarityLevel = _arg_1;
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

        public function get hasBreedingPermission():Boolean
        {
            return (_hasBreedingPermission);
        }

        public function set hasBreedingPermission(_arg_1:Boolean):void
        {
            _hasBreedingPermission = _arg_1;
        }


    }
}