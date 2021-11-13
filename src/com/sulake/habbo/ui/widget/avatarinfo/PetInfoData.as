package com.sulake.habbo.ui.widget.avatarinfo
{
    import com.sulake.habbo.ui.widget.events.RoomWidgetPetInfoUpdateEvent;

    public class PetInfoData 
    {

        public var age:int = 0;
        public var breedId:int = 0;
        public var canRemovePet:Boolean = false;
        public var energy:int = 0;
        public var energyMax:int = 0;
        public var experience:int = 0;
        public var experienceMax:int = 0;
        public var id:int = 0;
        public var isOwnPet:Boolean = false;
        public var level:int = 0;
        public var levelMax:int = 0;
        public var name:String = "";
        public var nutrition:int = 0;
        public var nutritionMax:int = 0;
        public var ownerId:int = 0;
        public var ownerName:String = "";
        public var petRace:int = 0;
        public var petRespect:int = 0;
        public var petRespectLeft:int = 0;
        public var petType:int = 0;
        public var hasFreeSaddle:Boolean = false;
        public var isRiding:Boolean = false;
        public var canBreed:Boolean = false;
        public var canHarvest:Boolean = false;
        public var canRevive:Boolean = false;
        public var skillTresholds:Array = [];
        public var accessRights:int = 0;
        public var maxWellBeingSeconds:int = 0;
        public var remainingWellBeingSeconds:int = 0;
        public var remainingGrowingSeconds:int = 0;
        public var hasBreedingPermission:Boolean = false;


        public function populate(_arg_1:RoomWidgetPetInfoUpdateEvent):void
        {
            age = _arg_1.age;
            breedId = _arg_1.breedId;
            canRemovePet = _arg_1.canRemovePet;
            energy = _arg_1.energy;
            energyMax = _arg_1.energyMax;
            experience = _arg_1.experience;
            experienceMax = _arg_1.experienceMax;
            id = _arg_1.id;
            isOwnPet = _arg_1.isOwnPet;
            level = _arg_1.level;
            levelMax = _arg_1.levelMax;
            name = _arg_1.name;
            nutrition = _arg_1.nutrition;
            nutritionMax = _arg_1.nutritionMax;
            ownerId = _arg_1.ownerId;
            ownerName = _arg_1.ownerName;
            petRace = _arg_1.petRace;
            petRespect = _arg_1.petRespect;
            petRespectLeft = _arg_1.petRespectLeft;
            petType = _arg_1.petType;
            hasFreeSaddle = _arg_1.hasFreeSaddle;
            isRiding = _arg_1.isRiding;
            canBreed = _arg_1.canBreed;
            canRevive = _arg_1.canRevive;
            canHarvest = _arg_1.canHarvest;
            skillTresholds = _arg_1.skillTresholds;
            accessRights = _arg_1.accessRights;
            maxWellBeingSeconds = _arg_1.maxWellBeingSeconds;
            remainingWellBeingSeconds = _arg_1.remainingWellBeingSeconds;
            remainingGrowingSeconds = _arg_1.remainingGrowingSeconds;
            hasBreedingPermission = _arg_1.hasBreedingPermission;
        }


    }
}