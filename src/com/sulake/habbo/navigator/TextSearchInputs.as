package com.sulake.habbo.navigator
{
    import com.sulake.core.window.components.IDropMenuWindow;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class TextSearchInputs 
    {

        private var _navigator:HabboNavigator;
        private var _searchStr:TextFieldManager;
        private var _SafeStr_3005:IDropMenuWindow;

        public function TextSearchInputs(_arg_1:HabboNavigator, _arg_2:IWindowContainer)
        {
            super();
            var _local_4:Array = null;
            _navigator = _arg_1;
            var _local_3:ITextFieldWindow = ITextFieldWindow(_arg_2.findChildByName("search_str"));
            _searchStr = new TextFieldManager(_navigator, _local_3, 35, searchRooms, _navigator.getText("navigator.search.info"));
            Util.setProc(_arg_2, "search_but", onSearchButtonClick);
            var _local_5:Boolean = true;
            if (_local_5)
            {
                _SafeStr_3005 = (_arg_2.findChildByName("search_type") as IDropMenuWindow);
                _local_4 = [];
                _local_4.push(_navigator.getText("${navigator.navisel.bydefault}"));
                _local_4.push(_navigator.getText("${navigator.navisel.byowner}"));
                _local_4.push(_navigator.getText("${navigator.navisel.byroomname}"));
                _local_4.push(_navigator.getText("${navigator.navisel.bytag}"));
                _local_4.push(_navigator.getText("${navigator.navisel.bygroupname}"));
                _SafeStr_3005.populate(_local_4);
                _SafeStr_3005.selection = 0;
            };
        }

        public function dispose():void
        {
            if (_searchStr)
            {
                _searchStr.dispose();
                _searchStr = null;
            };
            _navigator = null;
        }

        public function setText(_arg_1:String, _arg_2:int):void
        {
            _searchStr.setText(_arg_1);
            if (_SafeStr_3005 != null)
            {
                switch (_arg_2)
                {
                    case 8:
                        _SafeStr_3005.selection = 0;
                        return;
                    case 20:
                        _SafeStr_3005.selection = 1;
                        return;
                    case 10:
                        _SafeStr_3005.selection = 2;
                        return;
                    case 9:
                        _SafeStr_3005.selection = 3;
                        return;
                    case 13:
                        _SafeStr_3005.selection = 4;
                    default:
                };
            };
        }

        private function onSearchButtonClick(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            searchRooms();
        }

        private function searchRooms():void
        {
            var _local_1:String = _searchStr.getText();
            if (_local_1 == "")
            {
                return;
            };
            if (_SafeStr_3005 != null)
            {
                switch (_SafeStr_3005.selection)
                {
                    case 0:
                        _navigator.mainViewCtrl.startSearch(5, 8, _local_1);
                        break;
                    case 1:
                        _navigator.mainViewCtrl.startSearch(5, 20, _local_1);
                        break;
                    case 2:
                        _navigator.mainViewCtrl.startSearch(5, 10, _local_1);
                        break;
                    case 3:
                        _navigator.mainViewCtrl.startSearch(5, 9, _local_1);
                        break;
                    case 4:
                        _navigator.mainViewCtrl.startSearch(5, 13, _local_1);
                    default:
                };
            }
            else
            {
                _navigator.mainViewCtrl.startSearch(5, 8, _local_1);
            };
            _navigator.trackNavigationDataPoint("Search", "search", _local_1);
        }

        public function get searchStr():TextFieldManager
        {
            return (_searchStr);
        }


    }
}

