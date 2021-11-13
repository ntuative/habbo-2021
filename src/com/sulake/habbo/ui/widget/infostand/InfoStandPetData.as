package com.sulake.habbo.ui.widget.infostand
{
    import flash.display.BitmapData;
    import com.sulake.habbo.ui.widget.events.RoomWidgetPetInfoUpdateEvent;

    public class InfoStandPetData 
    {

        private var _level:int;
        private var _levelMax:int;
        private var _experience:int;
        private var _experienceMax:int;
        private var _energy:int;
        private var _energyMax:int;
        private var _nutrition:int;
        private var _nutritionMax:int;
        private var _petRespect:int;
        private var _name:String = "";
        private var _id:int = -1;
        private var _type:int;
        private var _race:int;
        private var _image:BitmapData;
        private var _isOwnPet:Boolean;
        private var _ownerId:int;
        private var _ownerName:String;
        private var _canRemovePet:Boolean;
        private var _roomIndex:int;
        private var _age:int;
        private var _breedId:int;
        private var _skillTresholds:Array;
        private var _accessRights:int;
        private var _rarityLevel:int;
        private var _hasBreedingPermission:Boolean;
        private var _maxWellBeingSeconds:int;
        private var _remainingWellBeingSeconds:int;
        private var _remainingGrowingSeconds:int;


        public function get name():String
        {
            return (_name);
        }

        public function get id():int
        {
            return (_id);
        }

        public function get type():int
        {
            return (_type);
        }

        public function get race():int
        {
            return (_race);
        }

        public function get image():BitmapData
        {
            return (_image);
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

        public function get age():int
        {
            return (_age);
        }

        public function get breedId():int
        {
            return (_breedId);
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

        public function get petRespect():int
        {
            return (_petRespect);
        }

        public function get roomIndex():int
        {
            return (_roomIndex);
        }

        public function get rarityLevel():int
        {
            return (_rarityLevel);
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

        public function get hasBreedingPermission():Boolean
        {
            return (_hasBreedingPermission);
        }

        public function setData(_arg_1:RoomWidgetPetInfoUpdateEvent):void
        {
            _name = _arg_1.name;
            _id = _arg_1.id;
            _type = _arg_1.petType;
            _race = _arg_1.petRace;
            _image = _arg_1.image;
            _isOwnPet = _arg_1.isOwnPet;
            _ownerId = _arg_1.ownerId;
            _ownerName = _arg_1.ownerName;
            _canRemovePet = _arg_1.canRemovePet;
            _level = _arg_1.level;
            _levelMax = _arg_1.levelMax;
            _experience = _arg_1.experience;
            _experienceMax = _arg_1.experienceMax;
            _energy = _arg_1.energy;
            _energyMax = _arg_1.energyMax;
            _nutrition = _arg_1.nutrition;
            _nutritionMax = _arg_1.nutritionMax;
            _petRespect = _arg_1.petRespect;
            _roomIndex = _arg_1.roomIndex;
            _age = _arg_1.age;
            _breedId = _arg_1.breedId;
            _skillTresholds = _arg_1.skillTresholds;
            _accessRights = _arg_1.accessRights;
            _maxWellBeingSeconds = _arg_1.maxWellBeingSeconds;
            _remainingWellBeingSeconds = _arg_1.remainingWellBeingSeconds;
            _remainingGrowingSeconds = _arg_1.remainingGrowingSeconds;
            _rarityLevel = _arg_1.rarityLevel;
            _hasBreedingPermission = _arg_1.hasBreedingPermission;
        }


    }
}