package com.sulake.habbo.communication.messages.incoming.room.engine
{
        public class UserMessageData 
    {

        public static const _SafeStr_1821:String = "M";
        public static const _SafeStr_1822:String = "F";

        private var _roomIndex:int = 0;
        private var _x:Number = 0;
        private var _y:Number = 0;
        private var _z:Number = 0;
        private var _dir:int = 0;
        private var _name:String = "";
        private var _userType:int = 0;
        private var _sex:String = "";
        private var _figure:String = "";
        private var _custom:String = "";
        private var _achievementScore:int;
        private var _webID:int = 0;
        private var _groupID:String = "";
        private var _groupStatus:int = 0;
        private var _groupName:String = "";
        private var _subType:String = "";
        private var _ownerId:int = 0;
        private var _ownerName:String;
        private var _rarityLevel:int;
        private var _hasSaddle:Boolean;
        private var _isRiding:Boolean;
        private var _canBreed:Boolean;
        private var _canHarvest:Boolean;
        private var _canRevive:Boolean;
        private var _hasBreedingPermission:Boolean;
        private var _petLevel:int = 0;
        private var _petPosture:String = "";
        private var _botSkills:Array;
        private var _isModerator:Boolean;
        private var _SafeStr_1818:Boolean = false;

        public function UserMessageData(_arg_1:int)
        {
            _roomIndex = _arg_1;
        }

        public function setReadOnly():void
        {
            _SafeStr_1818 = true;
        }

        public function get roomIndex():int
        {
            return (_roomIndex);
        }

        public function get x():Number
        {
            return (_x);
        }

        public function set x(_arg_1:Number):void
        {
            if (!_SafeStr_1818)
            {
                _x = _arg_1;
            };
        }

        public function get y():Number
        {
            return (_y);
        }

        public function set y(_arg_1:Number):void
        {
            if (!_SafeStr_1818)
            {
                _y = _arg_1;
            };
        }

        public function get z():Number
        {
            return (_z);
        }

        public function set z(_arg_1:Number):void
        {
            if (!_SafeStr_1818)
            {
                _z = _arg_1;
            };
        }

        public function get dir():int
        {
            return (_dir);
        }

        public function set dir(_arg_1:int):void
        {
            if (!_SafeStr_1818)
            {
                _dir = _arg_1;
            };
        }

        public function get name():String
        {
            return (_name);
        }

        public function set name(_arg_1:String):void
        {
            if (!_SafeStr_1818)
            {
                _name = _arg_1;
            };
        }

        public function get userType():int
        {
            return (_userType);
        }

        public function set userType(_arg_1:int):void
        {
            if (!_SafeStr_1818)
            {
                _userType = _arg_1;
            };
        }

        public function get sex():String
        {
            return (_sex);
        }

        public function set sex(_arg_1:String):void
        {
            if (!_SafeStr_1818)
            {
                _sex = _arg_1;
            };
        }

        public function get figure():String
        {
            return (_figure);
        }

        public function set figure(_arg_1:String):void
        {
            if (!_SafeStr_1818)
            {
                _figure = _arg_1;
            };
        }

        public function get custom():String
        {
            return (_custom);
        }

        public function set custom(_arg_1:String):void
        {
            if (!_SafeStr_1818)
            {
                _custom = _arg_1;
            };
        }

        public function get achievementScore():int
        {
            return (_achievementScore);
        }

        public function set achievementScore(_arg_1:int):void
        {
            if (!_SafeStr_1818)
            {
                _achievementScore = _arg_1;
            };
        }

        public function get webID():int
        {
            return (_webID);
        }

        public function set webID(_arg_1:int):void
        {
            if (!_SafeStr_1818)
            {
                _webID = _arg_1;
            };
        }

        public function get groupID():String
        {
            return (_groupID);
        }

        public function set groupID(_arg_1:String):void
        {
            if (!_SafeStr_1818)
            {
                _groupID = _arg_1;
            };
        }

        public function get groupName():String
        {
            return (_groupName);
        }

        public function set groupName(_arg_1:String):void
        {
            if (!_SafeStr_1818)
            {
                _groupName = _arg_1;
            };
        }

        public function get groupStatus():int
        {
            return (_groupStatus);
        }

        public function set groupStatus(_arg_1:int):void
        {
            if (!_SafeStr_1818)
            {
                _groupStatus = _arg_1;
            };
        }

        public function get subType():String
        {
            return (_subType);
        }

        public function set subType(_arg_1:String):void
        {
            if (!_SafeStr_1818)
            {
                _subType = _arg_1;
            };
        }

        public function get ownerId():int
        {
            return (_ownerId);
        }

        public function set ownerId(_arg_1:int):void
        {
            if (!_SafeStr_1818)
            {
                _ownerId = _arg_1;
            };
        }

        public function get ownerName():String
        {
            return (_ownerName);
        }

        public function set ownerName(_arg_1:String):void
        {
            if (!_SafeStr_1818)
            {
                _ownerName = _arg_1;
            };
        }

        public function get rarityLevel():int
        {
            return (_rarityLevel);
        }

        public function set rarityLevel(_arg_1:int):void
        {
            if (!_SafeStr_1818)
            {
                _rarityLevel = _arg_1;
            };
        }

        public function get hasSaddle():Boolean
        {
            return (_hasSaddle);
        }

        public function set hasSaddle(_arg_1:Boolean):void
        {
            if (!_SafeStr_1818)
            {
                _hasSaddle = _arg_1;
            };
        }

        public function get isRiding():Boolean
        {
            return (_isRiding);
        }

        public function set isRiding(_arg_1:Boolean):void
        {
            if (!_SafeStr_1818)
            {
                _isRiding = _arg_1;
            };
        }

        public function get canBreed():Boolean
        {
            return (_canBreed);
        }

        public function set canBreed(_arg_1:Boolean):void
        {
            if (!_SafeStr_1818)
            {
                _canBreed = _arg_1;
            };
        }

        public function get canHarvest():Boolean
        {
            return (_canHarvest);
        }

        public function set canHarvest(_arg_1:Boolean):void
        {
            if (!_SafeStr_1818)
            {
                _canHarvest = _arg_1;
            };
        }

        public function get canRevive():Boolean
        {
            return (_canRevive);
        }

        public function set canRevive(_arg_1:Boolean):void
        {
            if (!_SafeStr_1818)
            {
                _canRevive = _arg_1;
            };
        }

        public function get hasBreedingPermission():Boolean
        {
            return (_hasBreedingPermission);
        }

        public function set hasBreedingPermission(_arg_1:Boolean):void
        {
            if (!_SafeStr_1818)
            {
                _hasBreedingPermission = _arg_1;
            };
        }

        public function get petLevel():int
        {
            return (_petLevel);
        }

        public function set petLevel(_arg_1:int):void
        {
            if (!_SafeStr_1818)
            {
                _petLevel = _arg_1;
            };
        }

        public function get petPosture():String
        {
            return (_petPosture);
        }

        public function set petPosture(_arg_1:String):void
        {
            if (!_SafeStr_1818)
            {
                _petPosture = _arg_1;
            };
        }

        public function get botSkills():Array
        {
            return (_botSkills);
        }

        public function set botSkills(_arg_1:Array):void
        {
            _botSkills = _arg_1;
        }

        public function get isModerator():Boolean
        {
            return (_isModerator);
        }

        public function set isModerator(_arg_1:Boolean):void
        {
            if (!_SafeStr_1818)
            {
                _isModerator = _arg_1;
            };
        }


    }
}

