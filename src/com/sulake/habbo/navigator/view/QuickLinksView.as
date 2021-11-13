package com.sulake.habbo.navigator.view
{
    import com.sulake.habbo.navigator.HabboNewNavigator;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.habbo.navigator.context.SearchContext;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.communication.messages.incoming.newnavigator.SavedSearch;
    import com.sulake.core.window.components._SafeStr_143;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class QuickLinksView 
    {

        private var _navigator:HabboNewNavigator;
        private var _SafeStr_1565:IRegionWindow;
        private var _itemList:IItemListWindow;
        private var _SafeStr_2985:Array = [];
        private var _SafeStr_2986:Array = [];

        public function QuickLinksView(_arg_1:HabboNewNavigator)
        {
            _navigator = _arg_1;
        }

        public function set itemList(_arg_1:IItemListWindow):void
        {
            _itemList = _arg_1;
        }

        public function set template(_arg_1:IRegionWindow):void
        {
            _SafeStr_1565 = _arg_1;
        }

        public function setQuickLinks(_arg_1:Vector.<SavedSearch>):void
        {
            var _local_2:int;
            var _local_4:IRegionWindow;
            var _local_3:ITextWindow;
            _itemList.removeListItems();
            _SafeStr_2985 = [];
            _SafeStr_2986 = [];
            _local_2 = 0;
            while (_local_2 < _arg_1.length)
            {
                _local_4 = IRegionWindow(_SafeStr_1565.clone());
                _local_4.id = _local_2;
                _local_3 = ITextWindow(_local_4.findChildByName("quick_link_text"));
                _local_3.caption = (_navigator.localization.getLocalization(("navigator.searchcode.title." + _arg_1[_local_2].searchCode), _arg_1[_local_2].searchCode) + ((_arg_1[_local_2].filter != "") ? (" - " + _arg_1[_local_2].filter) : ""));
                if (_arg_1[_local_2].searchCode.indexOf("category__") == 0)
                {
                    _local_3.caption = (_arg_1[_local_2].searchCode.substr("category__".length) + ((_arg_1[_local_2].filter != "") ? (" - " + _arg_1[_local_2].filter) : ""));
                };
                _local_4.procedure = listItemProcedure;
                _SafeStr_2985.push(new SearchContext(_arg_1[_local_2].searchCode, _arg_1[_local_2].filter));
                _SafeStr_2986.push(_arg_1[_local_2].id);
                _itemList.addListItem(_local_4);
                _local_2++;
            };
        }

        private function listItemProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                if ((_arg_2 is IRegionWindow))
                {
                    if (_SafeStr_2985.length > _arg_2.id)
                    {
                        _navigator.performSearchByContext(_SafeStr_2985[_arg_2.id]);
                        _navigator.trackEventLog("savedsearch.execute", "SavedSearch", HabboNewNavigator.getEventLogExtraStringFromSearch(_SafeStr_2985[_arg_2.id].searchCode, _SafeStr_2985[_arg_2.id].filtering));
                    };
                }
                else
                {
                    if ((_arg_2 is _SafeStr_143))
                    {
                        _navigator.deleteSavedSearch(_SafeStr_2986[_arg_2.parent.id]);
                    };
                };
            }
            else
            {
                if (_arg_1.type == "WME_OVER")
                {
                    if ((_arg_2 is IRegionWindow))
                    {
                        _SafeStr_143(IRegionWindow(_arg_2).getChildAt(1)).visible = true;
                    }
                    else
                    {
                        if ((_arg_2 is _SafeStr_143))
                        {
                            _arg_2.visible = true;
                        };
                    };
                }
                else
                {
                    if (((_arg_1.type == "WME_OUT") && (_arg_2 is IRegionWindow)))
                    {
                        _SafeStr_143(IRegionWindow(_arg_2).getChildAt(1)).visible = false;
                    };
                };
            };
        }


    }
}

