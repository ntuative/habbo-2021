package com.sulake.habbo.session
{
    import com.sulake.core.utils.Map;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.communication.messages.outgoing.users.GetSelectedBadgesMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.pets.GetPetInfoMessageComposer;

    public class UserDataManager implements IUserDataManager 
    {

        private static const TYPE_USER:int = 1;
        private static const TYPE_PET:int = 2;
        private static const _SafeStr_3714:int = 3;
        private static const _SafeStr_3715:int = 4;

        private var _SafeStr_3716:Map;
        private var _SafeStr_3717:Map;
        private var _SafeStr_3718:Map;
        private var _connection:IConnection;

        public function UserDataManager()
        {
            _SafeStr_3716 = new Map();
            _SafeStr_3717 = new Map();
            _SafeStr_3718 = new Map();
        }

        public function dispose():void
        {
            _connection = null;
            _SafeStr_3716.dispose();
            _SafeStr_3716 = null;
            _SafeStr_3717.dispose();
            _SafeStr_3717 = null;
            _SafeStr_3718.dispose();
            _SafeStr_3718 = null;
        }

        public function set connection(_arg_1:IConnection):void
        {
            _connection = _arg_1;
        }

        public function getUserData(_arg_1:int):IUserData
        {
            return (getUserDataByType(_arg_1, 1));
        }

        public function getUserDataByType(_arg_1:int, _arg_2:int):IUserData
        {
            var _local_3:IUserData;
            var _local_4:Map = _SafeStr_3716.getValue(_arg_2);
            if (_local_4 != null)
            {
                _local_3 = _local_4.getValue(_arg_1);
            };
            return (_local_3);
        }

        public function getUserDataByIndex(_arg_1:int):IUserData
        {
            return (_SafeStr_3717.getValue(_arg_1));
        }

        public function getUserDataByName(_arg_1:String):IUserData
        {
            for each (var _local_2:IUserData in _SafeStr_3717)
            {
                if (_local_2.name == _arg_1)
                {
                    return (_local_2);
                };
            };
            return (null);
        }

        public function getUserBadges(_arg_1:int):Array
        {
            if (_connection != null)
            {
                _connection.send(new GetSelectedBadgesMessageComposer(_arg_1));
            };
            var _local_2:Array = (_SafeStr_3718.getValue(_arg_1) as Array);
            if (_local_2 == null)
            {
                _local_2 = [];
            };
            return (_local_2);
        }

        public function setUserData(_arg_1:IUserData):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            removeUserDataByRoomIndex(_arg_1.roomObjectId);
            var _local_2:Map = _SafeStr_3716.getValue(_arg_1.type);
            if (_local_2 == null)
            {
                _local_2 = new Map();
                _SafeStr_3716.add(_arg_1.type, _local_2);
            };
            _local_2.add(_arg_1.webID, _arg_1);
            _SafeStr_3717.add(_arg_1.roomObjectId, _arg_1);
        }

        public function removeUserDataByRoomIndex(_arg_1:int):void
        {
            var _local_4:Map;
            var _local_3:IUserData;
            var _local_2:IUserData = _SafeStr_3717.remove(_arg_1);
            if (_local_2 != null)
            {
                _local_4 = _SafeStr_3716.getValue(_local_2.type);
                if (_local_4 != null)
                {
                    _local_3 = _local_4.remove(_local_2.webID);
                    if (_local_3 != null)
                    {
                    };
                };
            };
        }

        public function setUserBadges(_arg_1:int, _arg_2:Array):void
        {
            _SafeStr_3718.remove(_arg_1);
            _SafeStr_3718.add(_arg_1, _arg_2);
        }

        public function updateFigure(_arg_1:int, _arg_2:String, _arg_3:String, _arg_4:Boolean, _arg_5:Boolean):void
        {
            var _local_6:IUserData = getUserDataByIndex(_arg_1);
            if (_local_6 != null)
            {
                _local_6.figure = _arg_2;
                _local_6.sex = _arg_3;
                _local_6.hasSaddle = _arg_4;
                _local_6.isRiding = _arg_5;
            };
        }

        public function updatePetLevel(_arg_1:int, _arg_2:int):void
        {
            var _local_3:IUserData = getUserDataByIndex(_arg_1);
            if (_local_3 != null)
            {
                _local_3.petLevel = _arg_2;
            };
        }

        public function updatePetBreedingStatus(_arg_1:int, _arg_2:Boolean, _arg_3:Boolean, _arg_4:Boolean, _arg_5:Boolean):void
        {
            var _local_6:IUserData = getUserDataByIndex(_arg_1);
            if (_local_6 != null)
            {
                _local_6.canBreed = _arg_2;
                _local_6.canHarvest = _arg_3;
                _local_6.canRevive = _arg_4;
                _local_6.hasBreedingPermission = _arg_5;
            };
        }

        public function updateCustom(_arg_1:int, _arg_2:String):void
        {
            var _local_3:IUserData = getUserDataByIndex(_arg_1);
            if (_local_3 != null)
            {
                _local_3.custom = _arg_2;
            };
        }

        public function updateAchievementScore(_arg_1:int, _arg_2:int):void
        {
            var _local_3:IUserData = getUserDataByIndex(_arg_1);
            if (_local_3 != null)
            {
                _local_3.achievementScore = _arg_2;
            };
        }

        public function updateNameByIndex(_arg_1:int, _arg_2:String):void
        {
            var _local_3:IUserData = getUserDataByIndex(_arg_1);
            if (_local_3 != null)
            {
                _local_3.name = _arg_2;
            };
        }

        public function getPetUserData(_arg_1:int):IUserData
        {
            return (getUserDataByType(_arg_1, 2));
        }

        public function getRentableBotUserData(_arg_1:int):IUserData
        {
            return (getUserDataByType(_arg_1, 4));
        }

        public function requestPetInfo(_arg_1:int):void
        {
            var _local_2:IUserData = getPetUserData(_arg_1);
            if (((!(_local_2 == null)) && (!(_connection == null))))
            {
                _connection.send(new GetPetInfoMessageComposer(_local_2.webID));
            };
        }

        public function getAllUserIds():Array
        {
            var _local_2:Array = [];
            for each (var _local_1:IUserData in _SafeStr_3717)
            {
                _local_2.push(_local_1.webID);
            };
            return (_local_2);
        }


    }
}

