package com.sulake.habbo.navigator.domain
{
    import flash.utils.Dictionary;
    import com.sulake.habbo.navigator.HabboNavigator;
    import com.sulake.habbo.navigator.mainview.tabpagedecorators.EventsTabPageDecorator;
    import com.sulake.habbo.navigator.mainview.tabpagedecorators.CategoriesTabPageDecorator;
    import com.sulake.habbo.navigator.mainview.tabpagedecorators.RoomsTabPageDecorator;
    import com.sulake.habbo.navigator.mainview.tabpagedecorators.OfficialTabPageDecorator;
    import com.sulake.habbo.navigator.mainview.tabpagedecorators.MyRoomsTabPageDecorator;
    import com.sulake.habbo.navigator.mainview.tabpagedecorators.SearchTabPageDecorator;
    import com.sulake.habbo.navigator.mainview.*;
    import com.sulake.habbo.navigator.mainview.tabpagedecorators.*;

    public class Tabs 
    {

        public static const TAB_EVENTS:int = 1;
        public static const TAB_ROOMS:int = 2;
        public static const TAB_ME:int = 3;
        public static const TAB_OFFICIAL:int = 4;
        public static const TAB_SEARCH:int = 5;
        public static const TAB_CATEGORIES:int = 6;
        private static const TAB_NAMES:Dictionary = new Dictionary();
        public static const SEARCHTYPE_POPULAR_ROOMS:int = 1;
        public static const SEARCHTYPE_ROOMS_WITH_HIGHEST_SCORE:int = 2;
        public static const SEARCHTYPE_MY_FRIENDS_ROOMS:int = 3;
        public static const SEARCHTYPE_ROOMS_WHERE_MY_FRIENDS_ARE:int = 4;
        public static const SEARCHTYPE_MY_ROOMS:int = 5;
        public static const SEARCHTYPE_MY_FAVOURITES:int = 6;
        public static const _SafeStr_2901:int = 7;
        public static const SEARCHTYPE_TEXT_SEARCH:int = 8;
        public static const SEARCHTYPE_TAG_SEARCH:int = 9;
        public static const SEARCHTYPE_ROOM_NAME_SEARCH:int = 10;
        public static const SEARCHTYPE_OFFICIALROOMS:int = 11;
        public static const _SafeStr_2902:int = 12;
        public static const SEARCHTYPE_GROUP_NAME_SEARCH:int = 13;
        public static const SEARCHTYPE_GUILD_BASES:int = 14;
        public static const SEARCHTYPE_COMPETITION_ROOMS:int = 15;
        public static const _SafeStr_2903:int = 16;
        public static const _SafeStr_2904:int = 17;
        public static const _SafeStr_2905:int = 18;
        public static const SEARCHTYPE_MY_GUILD_BASES:int = 19;
        public static const SEARCHTYPE_BY_OWNER:int = 20;
        public static const SEARCHTYPE_CATEGORIES:int = 21;
        public static const SEARCHTYPE_RECOMMENDED_ROOMS:int = 22;
        public static const _SafeStr_2906:int = 23;

        private var _tabs:Array;
        private var _navigator:HabboNavigator;

        {
            TAB_NAMES["popular"] = 2;
            TAB_NAMES["official"] = 4;
            TAB_NAMES["me"] = 3;
            TAB_NAMES["events"] = 1;
            TAB_NAMES["search"] = 5;
            TAB_NAMES["categories"] = 6;
        }

        public function Tabs(_arg_1:HabboNavigator)
        {
            _navigator = _arg_1;
            _tabs = [];
            _tabs.push(new Tab(_navigator, 1, 16, new EventsTabPageDecorator(_navigator), 1));
            _tabs.push(new Tab(_navigator, 6, 21, new CategoriesTabPageDecorator(_navigator), 5));
            _tabs.push(new Tab(_navigator, 2, 1, new RoomsTabPageDecorator(_navigator), 1));
            _tabs.push(new Tab(_navigator, 4, 11, new OfficialTabPageDecorator(_navigator), 4));
            _tabs.push(new Tab(_navigator, 3, 5, new MyRoomsTabPageDecorator(_navigator), 1));
            _tabs.push(new Tab(_navigator, 5, 8, new SearchTabPageDecorator(_navigator), 2));
            setSelectedTab(1);
        }

        public static function tabIdFromName(_arg_1:String, _arg_2:int):int
        {
            return ((_arg_1 in TAB_NAMES) ? TAB_NAMES[_arg_1] : _arg_2);
        }


        public function onFrontPage():Boolean
        {
            return (this.getSelected().id == 4);
        }

        public function get tabs():Array
        {
            return (_tabs);
        }

        public function setSelectedTab(_arg_1:int):void
        {
            var _local_2:Tab = getTab(_arg_1);
            if (_local_2 != null)
            {
                this.clearSelected();
                _local_2.selected = true;
            };
        }

        public function getSelected():Tab
        {
            for each (var _local_1:Tab in _tabs)
            {
                if (_local_1.selected)
                {
                    return (_local_1);
                };
            };
            return (null);
        }

        private function clearSelected():void
        {
            for each (var _local_1:Tab in _tabs)
            {
                _local_1.selected = false;
            };
        }

        public function getTab(_arg_1:int):Tab
        {
            for each (var _local_2:Tab in _tabs)
            {
                if (_local_2.id == _arg_1)
                {
                    return (_local_2);
                };
            };
            return (null);
        }


    }
}

