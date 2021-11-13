package com.sulake.habbo.navigator.mainview.tabpagedecorators
{
    import com.sulake.habbo.navigator.HabboNavigator;
    import com.sulake.core.window.components.IDropMenuWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.communication.messages.incoming.navigator.FlatCategory;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.events.*;

    public class RoomsTabPageDecorator implements ITabPageDecorator 
    {

        private var _navigator:HabboNavigator;
        private var _SafeStr_2719:IDropMenuWindow;
        private var _SafeStr_2911:Boolean = false;

        public function RoomsTabPageDecorator(_arg_1:HabboNavigator)
        {
            _navigator = _arg_1;
        }

        public function refreshCustomContent(_arg_1:IWindowContainer):void
        {
            var _local_2:String = "rooms_header";
            var _local_3:IWindowContainer = (_arg_1.getChildByName(_local_2) as IWindowContainer);
            if (((_SafeStr_2719 == null) || (_SafeStr_2719.disposed)))
            {
                _SafeStr_2719 = IDropMenuWindow(_local_3.findChildByName("roomCtgFilter"));
                prepareRoomCategories();
                _SafeStr_2719.addEventListener("WE_SELECTED", onFilterSelected);
            };
            _local_3.visible = true;
        }

        public function prepareRoomCategories():void
        {
            if (((_SafeStr_2719 == null) || (_SafeStr_2719.disposed)))
            {
                return;
            };
            var _local_1:Array = [_navigator.getText("navigator.navisel.popularrooms"), _navigator.getText("navigator.navisel.highestscore")];
            _SafeStr_2911 = _navigator.context.configuration.getBoolean("navigator.2014.personalized.navigator");
            if (_SafeStr_2911)
            {
                _local_1.push(_navigator.getText("navigator.navisel.recommendedrooms"));
            };
            for each (var _local_2:FlatCategory in _navigator.data.visibleCategories)
            {
                _local_1.push(_local_2.nodeName);
            };
            _SafeStr_2719.populate(_local_1);
            _SafeStr_2719.selection = defaultSelection;
        }

        private function get defaultSelection():int
        {
            return ((_SafeStr_2911) ? 2 : 0);
        }

        public function tabSelected():void
        {
            if (((!(_SafeStr_2719 == null)) && (!(_SafeStr_2719.disposed))))
            {
                _SafeStr_2719.removeEventListener("WE_SELECTED", onFilterSelected);
                _SafeStr_2719.selection = defaultSelection;
                _SafeStr_2719.addEventListener("WE_SELECTED", onFilterSelected);
            };
        }

        public function refreshFooter(_arg_1:IWindowContainer):void
        {
            _navigator.officialRoomEntryManager.refreshAdFooter(_arg_1);
        }

        public function navigatorOpenedWhileInTab():void
        {
            startSearch();
        }

        private function onFilterSelected(_arg_1:WindowEvent):void
        {
            startSearch();
        }

        private function startSearch():void
        {
            var _local_3:int;
            var _local_4:FlatCategory;
            var _local_1:int;
            var _local_2:int = (((_SafeStr_2719) && (!(_SafeStr_2719.disposed))) ? _SafeStr_2719.selection : defaultSelection);
            Logger.log(("Room filter changed: " + _local_2));
            if (_local_2 == 0)
            {
                _navigator.mainViewCtrl.startSearch(2, 1);
            }
            else
            {
                if (_local_2 == 1)
                {
                    _navigator.mainViewCtrl.startSearch(2, 2);
                }
                else
                {
                    if (((_local_2 == 2) && (_SafeStr_2911)))
                    {
                        _navigator.mainViewCtrl.startSearch(2, 22);
                    }
                    else
                    {
                        _local_3 = 2;
                        if (_SafeStr_2911)
                        {
                            _local_3++;
                        };
                        _local_4 = _navigator.data.visibleCategories[(_local_2 - _local_3)];
                        if (_local_4 == null)
                        {
                            Logger.log(((("No fc found: " + _local_2) + ", ") + _navigator.data.visibleCategories.length));
                            return;
                        };
                        _local_1 = _local_4.nodeId;
                        Logger.log(("Searching with catId: " + _local_1));
                        _navigator.mainViewCtrl.startSearch(2, 1, ("" + _local_1));
                    };
                };
            };
            if (((_SafeStr_2719) && (!(_SafeStr_2719.disposed))))
            {
                _navigator.trackNavigationDataPoint(_SafeStr_2719.enumerateSelection()[_SafeStr_2719.selection], "category.view");
            };
        }

        public function get filterCategory():String
        {
            return (((_SafeStr_2719) && (!(_SafeStr_2719.disposed))) ? _SafeStr_2719.enumerateSelection()[_SafeStr_2719.selection] : null);
        }

        public function setSubSelection(_arg_1:int):void
        {
        }

        public function processSearchParam(_arg_1:String):String
        {
            return (_arg_1);
        }


    }
}

