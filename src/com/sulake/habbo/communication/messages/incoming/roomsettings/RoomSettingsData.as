package com.sulake.habbo.communication.messages.incoming.roomsettings
{
    import flash.utils.Dictionary;

        public class RoomSettingsData
    {

        public static const _SafeStr_1809:int = 0;
        public static const _SafeStr_1810:int = 1;
        public static const _SafeStr_1811:int = 2;
        public static const _SafeStr_1812:int = 3;
        public static const _SafeStr_1813:int = 4;
        public static const _SafeStr_1839:int = 0;
        public static const _SafeStr_1840:int = 1;
        public static const _SafeStr_1841:int = 2;

        private var _roomId:int;
        private var _name:String;
        private var _description:String;
        private var _doorMode:int;
        private var _categoryId:int;
        private var _maximumVisitors:int;
        private var _maximumVisitorsLimit:int;
        private var _tags:Array;
        private var _tradeMode:int;
        private var _allowPets:Boolean;
        private var _allowFoodConsume:Boolean;
        private var _allowWalkThrough:Boolean;
        private var _hideWalls:Boolean;
        private var _wallThickness:int;
        private var _floorThickness:int;
        private var _controllersById:Dictionary;
        private var _SafeStr_1842:Array;
        private var _highlightedUserId:int;
        private var _bannedUsersById:Dictionary;
        private var _SafeStr_1843:Array;
        private var _roomModerationSettings:RoomModerationSettings;
        private var _chatSettings:RoomChatSettings;
        private var _allowNavigatorDynamicCats:Boolean;


        public static function getDoorModeLocalizationKey(_arg_1:int):String
        {
            switch (_arg_1)
            {
                case 0:
                    return ("${navigator.door.mode.open}");
                case 1:
                    return ("${navigator.door.mode.closed}");
                case 2:
                    return ("${navigator.door.mode.password}");
                case 3:
                    return ("${navigator.door.mode.invisible}");
                case 4:
                    return ("${navigator.door.mode.noobs_only}");
                default:
                    return ("");
            };
        }


        public function get tradeMode():int
        {
            return (_tradeMode);
        }

        public function set tradeMode(_arg_1:int):void
        {
            _tradeMode = _arg_1;
        }

        public function get allowPets():Boolean
        {
            return (_allowPets);
        }

        public function set allowPets(_arg_1:Boolean):void
        {
            _allowPets = _arg_1;
        }

        public function get allowFoodConsume():Boolean
        {
            return (_allowFoodConsume);
        }

        public function set allowFoodConsume(_arg_1:Boolean):void
        {
            _allowFoodConsume = _arg_1;
        }

        public function get allowWalkThrough():Boolean
        {
            return (_allowWalkThrough);
        }

        public function set allowWalkThrough(_arg_1:Boolean):void
        {
            _allowWalkThrough = _arg_1;
        }

        public function get hideWalls():Boolean
        {
            return (_hideWalls);
        }

        public function set hideWalls(_arg_1:Boolean):void
        {
            _hideWalls = _arg_1;
        }

        public function get wallThickness():int
        {
            return (_wallThickness);
        }

        public function set wallThickness(_arg_1:int):void
        {
            _wallThickness = _arg_1;
        }

        public function get floorThickness():int
        {
            return (_floorThickness);
        }

        public function set floorThickness(_arg_1:int):void
        {
            _floorThickness = _arg_1;
        }

        public function get roomId():int
        {
            return (_roomId);
        }

        public function set roomId(_arg_1:int):void
        {
            _roomId = _arg_1;
        }

        public function get name():String
        {
            return (_name);
        }

        public function set name(_arg_1:String):void
        {
            _name = _arg_1;
        }

        public function get description():String
        {
            return (_description);
        }

        public function set description(_arg_1:String):void
        {
            _description = _arg_1;
        }

        public function get doorMode():int
        {
            return (_doorMode);
        }

        public function set doorMode(_arg_1:int):void
        {
            _doorMode = _arg_1;
        }

        public function get categoryId():int
        {
            return (_categoryId);
        }

        public function set categoryId(_arg_1:int):void
        {
            _categoryId = _arg_1;
        }

        public function get maximumVisitors():int
        {
            return (_maximumVisitors);
        }

        public function set maximumVisitors(_arg_1:int):void
        {
            _maximumVisitors = _arg_1;
        }

        public function get maximumVisitorsLimit():int
        {
            return (_maximumVisitorsLimit);
        }

        public function set maximumVisitorsLimit(_arg_1:int):void
        {
            _maximumVisitorsLimit = _arg_1;
        }

        public function get tags():Array
        {
            return (_tags);
        }

        public function set tags(_arg_1:Array):void
        {
            _tags = _arg_1;
        }

        public function setFlatController(_arg_1:int, _arg_2:FlatControllerData):void
        {
            if (_controllersById != null)
            {
                _controllersById[_arg_1] = _arg_2;
                _SafeStr_1842 = null;
                _highlightedUserId = _arg_1;
            };
        }

        public function get roomModerationSettings():RoomModerationSettings
        {
            return (_roomModerationSettings);
        }

        public function set roomModerationSettings(_arg_1:RoomModerationSettings):void
        {
            _roomModerationSettings = _arg_1;
        }

        public function get controllersById():Dictionary
        {
            return (_controllersById);
        }

        public function set controllersById(_arg_1:Dictionary):void
        {
            _controllersById = _arg_1;
        }

        public function get controllerList():Array
        {
            var _local_3:int;
            var _local_2:FlatControllerData;
            if (_SafeStr_1842 == null)
            {
                _SafeStr_1842 = [];
                for (var _local_1:String in _controllersById)
                {
                    _local_3 = int(_local_1);
                    _local_2 = _controllersById[_local_3];
                    if (_local_2 != null)
                    {
                        _SafeStr_1842.push(_local_2);
                    };
                };
                _SafeStr_1842.sortOn("userName", 1);
            };
            return (_SafeStr_1842);
        }

        public function get highlightedUserId():int
        {
            return (_highlightedUserId);
        }

        public function setBannedUser(_arg_1:int, _arg_2:BannedUserData):void
        {
            if (_bannedUsersById == null)
            {
                _bannedUsersById = new Dictionary();
            }
            else
            {
                _SafeStr_1843 = null;
            };
            _bannedUsersById[_arg_1] = _arg_2;
        }

        public function get bannedUsersById():Dictionary
        {
            return (_bannedUsersById);
        }

        public function get bannedUsersList():Array
        {
            if (_SafeStr_1843 == null)
            {
                _SafeStr_1843 = [];
                for each (var _local_1:BannedUserData in _bannedUsersById)
                {
                    _SafeStr_1843.push(_local_1);
                };
                _SafeStr_1843.sortOn("userName", 1);
            };
            return (_SafeStr_1843);
        }

        public function get chatSettings():RoomChatSettings
        {
            return (_chatSettings);
        }

        public function set chatSettings(_arg_1:RoomChatSettings):void
        {
            _chatSettings = _arg_1;
        }

        public function get allowNavigatorDynamicCats():Boolean
        {
            return (_allowNavigatorDynamicCats);
        }

        public function set allowNavigatorDynamicCats(_arg_1:Boolean):void
        {
            _allowNavigatorDynamicCats = _arg_1;
        }


    }
}