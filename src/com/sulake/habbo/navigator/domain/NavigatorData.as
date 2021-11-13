package com.sulake.habbo.navigator.domain
{
    import com.sulake.habbo.navigator.HabboNavigator;
    import com.sulake.habbo.communication.messages.incoming.navigator._SafeStr_78;
    import com.sulake.habbo.communication.messages.incoming.navigator.RoomEventData;
    import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
    import flash.utils.Dictionary;
    import com.sulake.habbo.communication.messages.incoming.navigator.OfficialRoomEntryData;
    import com.sulake.habbo.communication.messages.incoming.navigator.PromotedRoomsData;
    import com.sulake.habbo.navigator.roomsettings.FriendList;
    import com.sulake.habbo.communication.messages.incoming.navigator.CompetitionRoomsData;
    import com.sulake.habbo.communication.messages.parser.room.engine.RoomEntryInfoMessageParser;
    import com.sulake.habbo.communication.messages.incoming.navigator.PopularRoomTagsData;
    import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomSearchResultData;
    import com.sulake.habbo.communication.messages.incoming.navigator.OfficialRoomsData;
    import com.sulake.habbo.communication.messages.incoming.navigator.CategoriesWithVisitorCountData;
    import com.sulake.habbo.communication.messages.incoming.navigator.FlatCategory;
    import com.sulake.habbo.communication.messages.incoming.navigator.EventCategory;
    import com.sulake.habbo.communication.messages.parser.navigator.FavouritesMessageParser;
    import com.sulake.habbo.communication.messages.incoming.navigator.*;
    import com.sulake.habbo.navigator.*;
    import com.sulake.habbo.communication.messages.parser.navigator.*;

    public class NavigatorData 
    {

        private static const MAX_HISTORY_LENGTH:int = 10;

        private var _navigator:HabboNavigator;
        private var _lastMsg:_SafeStr_78;
        private var _roomEventData:RoomEventData;
        private var _eventMod:Boolean;
        private var _roomPicker:Boolean;
        private var _currentRoomOwner:Boolean;
        private var _currentRoomId:int;
        private var _avatarId:int;
        private var _enteredGuestRoom:GuestRoomData;
        private var _hcMember:Boolean;
        private var _createdFlatId:int;
        private var _hotRoomPopupOpen:Boolean;
        private var _homeRoomId:int;
        private var _settingsReceived:Boolean;
        private var _allCategories:Array = [];
        private var _visibleCategories:Array = [];
        private var _allEventCategories:Array = [];
        private var _visibleEventCategories:Array = [];
        private var _SafeStr_2896:int;
        private var _SafeStr_2897:int;
        private var _SafeStr_2898:Dictionary = new Dictionary();
        private var _SafeStr_2899:Boolean;
        private var _currentRoomRating:int;
        private var _canRate:Boolean;
        private var _currentRoomIsStaffPick:Boolean;
        private var _adIndex:int = 0;
        private var _adRoom:OfficialRoomEntryData;
        private var _promotedRooms:PromotedRoomsData;
        private var _friendList:FriendList = new FriendList();
        private var _SafeStr_2900:RoomSessionTags;
        private var _competitionRoomsData:CompetitionRoomsData;

        public function NavigatorData(_arg_1:HabboNavigator)
        {
            _navigator = _arg_1;
        }

        public function get canAddFavourite():Boolean
        {
            return ((!(_enteredGuestRoom == null)) && (!(_currentRoomOwner)));
        }

        public function get canEditRoomSettings():Boolean
        {
            return ((!(_enteredGuestRoom == null)) && ((_currentRoomOwner) || (_navigator.sessionData.hasSecurity(5))));
        }

        public function onRoomEnter(_arg_1:RoomEntryInfoMessageParser):void
        {
            _enteredGuestRoom = null;
            _currentRoomOwner = false;
            _currentRoomOwner = _arg_1.owner;
            _currentRoomId = _arg_1.guestRoomId;
        }

        public function onRoomExit():void
        {
            if (_roomEventData != null)
            {
                _roomEventData.dispose();
                _roomEventData = null;
            };
            if (_enteredGuestRoom != null)
            {
                _enteredGuestRoom.dispose();
                _enteredGuestRoom = null;
            };
            _currentRoomOwner = false;
        }

        public function set enteredRoom(_arg_1:GuestRoomData):void
        {
            if (_enteredGuestRoom != null)
            {
                _enteredGuestRoom.dispose();
            };
            _enteredGuestRoom = _arg_1;
        }

        public function set roomEventData(_arg_1:RoomEventData):void
        {
            if (_roomEventData != null)
            {
                _roomEventData.dispose();
            };
            _roomEventData = _arg_1;
        }

        public function get popularTagsArrived():Boolean
        {
            return ((!(_lastMsg == null)) && (!((_lastMsg as PopularRoomTagsData) == null)));
        }

        public function get guestRoomSearchArrived():Boolean
        {
            return ((!(_lastMsg == null)) && (!((_lastMsg as GuestRoomSearchResultData) == null)));
        }

        public function get officialRoomsArrived():Boolean
        {
            return ((!(_lastMsg == null)) && (!((_lastMsg as OfficialRoomsData) == null)));
        }

        public function get categoriesWithUserCountArrived():Boolean
        {
            return ((!(_lastMsg == null)) && (!((_lastMsg as CategoriesWithVisitorCountData) == null)));
        }

        public function set guestRoomSearchResults(_arg_1:GuestRoomSearchResultData):void
        {
            disposeCurrentMsg();
            _lastMsg = _arg_1;
            _adRoom = _arg_1.ad;
            _SafeStr_2899 = false;
        }

        public function set popularTags(_arg_1:PopularRoomTagsData):void
        {
            disposeCurrentMsg();
            _lastMsg = _arg_1;
            _SafeStr_2899 = false;
        }

        public function set officialRooms(_arg_1:OfficialRoomsData):void
        {
            disposeCurrentMsg();
            _lastMsg = _arg_1;
            _SafeStr_2899 = false;
        }

        public function set categoriesWithVisitorData(_arg_1:CategoriesWithVisitorCountData):void
        {
            disposeCurrentMsg();
            _lastMsg = _arg_1;
            _SafeStr_2899 = false;
        }

        private function disposeCurrentMsg():void
        {
            if (_lastMsg == null)
            {
                return;
            };
            _lastMsg.dispose();
            _lastMsg = null;
        }

        public function set adRoom(_arg_1:OfficialRoomEntryData):void
        {
            _adRoom = _arg_1;
        }

        public function set promotedRooms(_arg_1:PromotedRoomsData):void
        {
            _promotedRooms = _arg_1;
        }

        public function get adRoom():OfficialRoomEntryData
        {
            return (_adRoom);
        }

        public function get guestRoomSearchResults():GuestRoomSearchResultData
        {
            return (_lastMsg as GuestRoomSearchResultData);
        }

        public function get popularTags():PopularRoomTagsData
        {
            return (_lastMsg as PopularRoomTagsData);
        }

        public function get officialRooms():OfficialRoomsData
        {
            return (_lastMsg as OfficialRoomsData);
        }

        public function get categoriesWithVisitorData():CategoriesWithVisitorCountData
        {
            return (_lastMsg as CategoriesWithVisitorCountData);
        }

        public function get promotedRooms():PromotedRoomsData
        {
            return (_promotedRooms);
        }

        public function get roomEventData():RoomEventData
        {
            return (_roomEventData);
        }

        public function get avatarId():int
        {
            return (_avatarId);
        }

        public function get eventMod():Boolean
        {
            return (_eventMod);
        }

        public function get roomPicker():Boolean
        {
            return (_roomPicker);
        }

        public function get currentRoomOwner():Boolean
        {
            return (_currentRoomOwner);
        }

        public function get enteredGuestRoom():GuestRoomData
        {
            return (_enteredGuestRoom);
        }

        public function get hcMember():Boolean
        {
            return (_hcMember);
        }

        public function get createdFlatId():int
        {
            return (_createdFlatId);
        }

        public function get homeRoomId():int
        {
            return (_homeRoomId);
        }

        public function get hotRoomPopupOpen():Boolean
        {
            return (_hotRoomPopupOpen);
        }

        public function get currentRoomRating():int
        {
            return (_currentRoomRating);
        }

        public function get canRate():Boolean
        {
            return (_canRate);
        }

        public function get settingsReceived():Boolean
        {
            return (_settingsReceived);
        }

        public function get adIndex():int
        {
            return (_adIndex);
        }

        public function get currentRoomIsStaffPick():Boolean
        {
            return (_currentRoomIsStaffPick);
        }

        public function get currentRoomId():int
        {
            return (_currentRoomId);
        }

        public function set avatarId(_arg_1:int):void
        {
            _avatarId = _arg_1;
        }

        public function set createdFlatId(_arg_1:int):void
        {
            _createdFlatId = _arg_1;
        }

        public function set hcMember(_arg_1:Boolean):void
        {
            _hcMember = _arg_1;
        }

        public function set eventMod(_arg_1:Boolean):void
        {
            _eventMod = _arg_1;
        }

        public function set roomPicker(_arg_1:Boolean):void
        {
            _roomPicker = _arg_1;
        }

        public function set hotRoomPopupOpen(_arg_1:Boolean):void
        {
            _hotRoomPopupOpen = _arg_1;
        }

        public function set homeRoomId(_arg_1:int):void
        {
            _homeRoomId = _arg_1;
        }

        public function set currentRoomRating(_arg_1:int):void
        {
            _currentRoomRating = _arg_1;
        }

        public function set canRate(_arg_1:Boolean):void
        {
            _canRate = _arg_1;
        }

        public function set settingsReceived(_arg_1:Boolean):void
        {
            _settingsReceived = _arg_1;
        }

        public function set adIndex(_arg_1:int):void
        {
            _adIndex = _arg_1;
        }

        public function set currentRoomIsStaffPick(_arg_1:Boolean):void
        {
            _currentRoomIsStaffPick = _arg_1;
        }

        public function set categories(_arg_1:Array):void
        {
            _allCategories = _arg_1;
            _visibleCategories = [];
            for each (var _local_2:FlatCategory in _allCategories)
            {
                if (_local_2.visible)
                {
                    _visibleCategories.push(_local_2);
                };
            };
        }

        public function get allCategories():Array
        {
            return (_allCategories);
        }

        public function get visibleCategories():Array
        {
            return (_visibleCategories);
        }

        public function getCategoryById(_arg_1:int):FlatCategory
        {
            for each (var _local_2:FlatCategory in _allCategories)
            {
                if (_local_2.nodeId == _arg_1)
                {
                    return (_local_2);
                };
            };
            return (null);
        }

        public function set eventCategories(_arg_1:Array):void
        {
            _allEventCategories = _arg_1;
            _visibleEventCategories = [];
            for each (var _local_2:EventCategory in _allEventCategories)
            {
                if (_local_2.visible)
                {
                    _visibleEventCategories.push(_local_2);
                };
            };
        }

        public function get allEventCategories():Array
        {
            return (_allEventCategories);
        }

        public function get visibleEventCategories():Array
        {
            return (_visibleEventCategories);
        }

        public function getEventCategoryById(_arg_1:int):EventCategory
        {
            for each (var _local_2:EventCategory in _allCategories)
            {
                if (_local_2.categoryId == _arg_1)
                {
                    return (_local_2);
                };
            };
            return (null);
        }

        public function onFavourites(_arg_1:FavouritesMessageParser):void
        {
            this._SafeStr_2896 = _arg_1.limit;
            this._SafeStr_2897 = _arg_1.favouriteRoomIds.length;
            this._SafeStr_2898 = new Dictionary();
            for each (var _local_2:int in _arg_1.favouriteRoomIds)
            {
                this._SafeStr_2898[_local_2] = "yes";
            };
        }

        public function favouriteChanged(_arg_1:int, _arg_2:Boolean):void
        {
            _SafeStr_2898[_arg_1] = ((_arg_2) ? "yes" : null);
            _SafeStr_2897 = (_SafeStr_2897 + ((_arg_2) ? 1 : -1));
        }

        public function isCurrentRoomFavourite():Boolean
        {
            var _local_1:int = _enteredGuestRoom.flatId;
            return (!(_SafeStr_2898[_local_1] == null));
        }

        public function isCurrentRoomHome():Boolean
        {
            if (_enteredGuestRoom == null)
            {
                return (false);
            };
            var _local_1:int = _enteredGuestRoom.flatId;
            return (this._homeRoomId == _local_1);
        }

        public function isRoomFavourite(_arg_1:int):Boolean
        {
            return (!(_SafeStr_2898[_arg_1] == null));
        }

        public function isFavouritesFull():Boolean
        {
            return (_SafeStr_2897 >= _SafeStr_2896);
        }

        public function isRoomHome(_arg_1:int):Boolean
        {
            return (_arg_1 == _homeRoomId);
        }

        public function startLoading():void
        {
            this._SafeStr_2899 = true;
        }

        public function isLoading():Boolean
        {
            return (this._SafeStr_2899);
        }

        public function get friendList():FriendList
        {
            return (_friendList);
        }

        public function getAndResetSessionTags():RoomSessionTags
        {
            var _local_1:RoomSessionTags = _SafeStr_2900;
            _SafeStr_2900 = null;
            return (_local_1);
        }

        public function set roomSessionTags(_arg_1:RoomSessionTags):void
        {
            _SafeStr_2900 = _arg_1;
        }

        public function get competitionRoomsData():CompetitionRoomsData
        {
            return (_competitionRoomsData);
        }

        public function set competitionRoomsData(_arg_1:CompetitionRoomsData):void
        {
            _competitionRoomsData = _arg_1;
        }


    }
}

