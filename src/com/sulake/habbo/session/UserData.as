package com.sulake.habbo.session
{
    public class UserData implements IUserData 
    {

        private var _roomObjectId:int = -1;
        private var _name:String = "";
        private var _type:int = 0;
        private var _sex:String = "";
        private var _figure:String = "";
        private var _custom:String = "";
        private var _achievementScore:int;
        private var _webID:int = 0;
        private var _groupID:String = "";
        private var _groupStatus:int = 0;
        private var _groupName:String = "";
        private var _ownerId:int = 0;
        private var _ownerName:String = "";
        private var _petLevel:int = 0;
        private var _rarityLevel:int = 0;
        private var _hasSaddle:Boolean;
        private var _isRiding:Boolean;
        private var _canBreed:Boolean;
        private var _canHarvest:Boolean;
        private var _canRevive:Boolean;
        private var _hasBreedingPermission:Boolean;
        private var _botSkills:Array;
        private var _botSkillData:Array;
        private var _isModerator:Boolean;

        public function UserData(_arg_1:int)
        {
            _roomObjectId = _arg_1;
        }

        public function get roomObjectId():int
        {
            return (_roomObjectId);
        }

        public function get achievementScore():int
        {
            return (_achievementScore);
        }

        public function set achievementScore(_arg_1:int):void
        {
            _achievementScore = _arg_1;
        }

        public function get name():String
        {
            return (_name);
        }

        public function set name(_arg_1:String):void
        {
            _name = _arg_1;
        }

        public function get type():int
        {
            return (_type);
        }

        public function set type(_arg_1:int):void
        {
            _type = _arg_1;
        }

        public function get sex():String
        {
            return (_sex);
        }

        public function set sex(_arg_1:String):void
        {
            _sex = _arg_1;
        }

        public function get figure():String
        {
            return (_figure);
        }

        public function set figure(_arg_1:String):void
        {
            _figure = _arg_1;
        }

        public function get custom():String
        {
            return (_custom);
        }

        public function set custom(_arg_1:String):void
        {
            _custom = _arg_1;
        }

        public function get webID():int
        {
            return (_webID);
        }

        public function set webID(_arg_1:int):void
        {
            _webID = _arg_1;
        }

        public function get groupID():String
        {
            return (_groupID);
        }

        public function set groupID(_arg_1:String):void
        {
            _groupID = _arg_1;
        }

        public function get groupName():String
        {
            return (_groupName);
        }

        public function set groupName(_arg_1:String):void
        {
            _groupName = _arg_1;
        }

        public function get groupStatus():int
        {
            return (_groupStatus);
        }

        public function set groupStatus(_arg_1:int):void
        {
            _groupStatus = _arg_1;
        }

        public function get ownerId():int
        {
            return (_ownerId);
        }

        public function set ownerId(_arg_1:int):void
        {
            _ownerId = _arg_1;
        }

        public function get ownerName():String
        {
            return (_ownerName);
        }

        public function set ownerName(_arg_1:String):void
        {
            _ownerName = _arg_1;
        }

        public function get rarityLevel():int
        {
            return (_rarityLevel);
        }

        public function set rarityLevel(_arg_1:int):void
        {
            _rarityLevel = _arg_1;
        }

        public function get hasSaddle():Boolean
        {
            return (_hasSaddle);
        }

        public function set hasSaddle(_arg_1:Boolean):void
        {
            _hasSaddle = _arg_1;
        }

        public function get isRiding():Boolean
        {
            return (_isRiding);
        }

        public function set isRiding(_arg_1:Boolean):void
        {
            _isRiding = _arg_1;
        }

        public function get canBreed():Boolean
        {
            return (_canBreed);
        }

        public function set canBreed(_arg_1:Boolean):void
        {
            _canBreed = _arg_1;
        }

        public function get canHarvest():Boolean
        {
            return (_canHarvest);
        }

        public function set canHarvest(_arg_1:Boolean):void
        {
            _canHarvest = _arg_1;
        }

        public function get canRevive():Boolean
        {
            return (_canRevive);
        }

        public function set canRevive(_arg_1:Boolean):void
        {
            _canRevive = _arg_1;
        }

        public function get hasBreedingPermission():Boolean
        {
            return (_hasBreedingPermission);
        }

        public function set hasBreedingPermission(_arg_1:Boolean):void
        {
            _hasBreedingPermission = _arg_1;
        }

        public function get petLevel():int
        {
            return (_petLevel);
        }

        public function set petLevel(_arg_1:int):void
        {
            _petLevel = _arg_1;
        }

        public function get botSkills():Array
        {
            return (_botSkills);
        }

        public function set botSkills(_arg_1:Array):void
        {
            _botSkills = _arg_1;
        }

        public function get botSkillData():Array
        {
            return (_botSkillData);
        }

        public function set botSkillData(_arg_1:Array):void
        {
            _botSkillData = _arg_1;
        }

        public function get isModerator():Boolean
        {
            return (_isModerator);
        }

        public function set isModerator(_arg_1:Boolean):void
        {
            _isModerator = _arg_1;
        }


    }
}