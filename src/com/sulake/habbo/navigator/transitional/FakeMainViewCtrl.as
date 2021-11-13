package com.sulake.habbo.navigator.transitional
{
    import com.sulake.habbo.navigator.mainview.ITransitionalMainViewCtrl;
    import com.sulake.habbo.navigator.HabboNewNavigator;
    import com.sulake.habbo.navigator.HabboNavigator;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.habbo.navigator.TextSearchInputs;
    import flash.geom.Point;

    public class FakeMainViewCtrl implements ITransitionalMainViewCtrl 
    {

        private var _newNavigator:HabboNewNavigator;
        private var _SafeStr_606:HabboNavigator;

        public function FakeMainViewCtrl(_arg_1:HabboNewNavigator, _arg_2:HabboNavigator)
        {
            _newNavigator = _arg_1;
            _SafeStr_606 = _arg_2;
        }

        public function get disposed():Boolean
        {
            return ((_newNavigator == null) && (_SafeStr_606 == null));
        }

        public function onNavigatorToolBarIconClick():void
        {
            _newNavigator.toggle();
        }

        public function dispose():void
        {
            _newNavigator = null;
            _SafeStr_606 = null;
        }

        public function open():void
        {
            _newNavigator.open();
        }

        public function isOpen():Boolean
        {
            return (false);
        }

        public function close():void
        {
            _newNavigator.close();
        }

        public function get mainWindow():IFrameWindow
        {
            return (_newNavigator.mainWindow);
        }

        public function refresh():void
        {
            _newNavigator.refresh();
        }

        public function reloadRoomList(_arg_1:int):Boolean
        {
            _newNavigator.refresh();
            return (true);
        }

        private function getSearchCodeByLegacySearchType(_arg_1:int):String
        {
            switch (_arg_1)
            {
                case 1:
                    return ("popular");
                case 2:
                    return ("highest_score");
                case 3:
                    return ("friends_rooms");
                case 4:
                    return ("with_friends");
                case 5:
                    return ("my");
                case 6:
                    return ("favorites");
                case 7:
                    return ("history");
                case 8:
                    return ("query");
                case 9:
                    return ("query");
                case 10:
                    return ("query");
                case 11:
                    return ("official");
                case 12:
                    return ("new_ads");
                case 13:
                    return ("groups");
                case 14:
                    return ("groups");
                case 15:
                    return ("competition");
                case 16:
                    return ("top_promotions");
                case 17:
                    return ("new_ads");
                case 18:
                    return ("with_rights");
                case 19:
                    return ("my_groups");
                case 20:
                    return ("query");
                case 21:
                    return ("all_categories");
                case 22:
                    return ("recommended");
                case 23:
                    return ("history_freq");
                default:
                    return ("query");
            };
        }

        public function startSearch(_arg_1:int, _arg_2:int, _arg_3:String="-1", _arg_4:int=1):void
        {
            _newNavigator.performSearch(getSearchCodeByLegacySearchType(_arg_2), _arg_3);
        }

        public function update(_arg_1:uint):void
        {
        }

        public function get searchInput():TextSearchInputs
        {
            return (_SafeStr_606.mainViewCtrl.searchInput);
        }

        public function openAtPosition(_arg_1:Point):void
        {
            return (_newNavigator.open());
        }

        public function get isPhaseOneNavigator():Boolean
        {
            return (_SafeStr_606.mainViewCtrl.isPhaseOneNavigator);
        }


    }
}

