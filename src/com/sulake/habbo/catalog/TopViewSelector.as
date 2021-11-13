package com.sulake.habbo.catalog
{
    import com.sulake.habbo.catalog.navigation.CatalogNavigator;
    import com.sulake.core.window.components.ITabButtonWindow;
    import com.sulake.core.window.components.ITabContextWindow;
    import com.sulake.habbo.catalog.navigation.ICatalogNode;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class TopViewSelector 
    {

        private var _catalog:CatalogNavigator;
        private var _SafeStr_1565:ITabButtonWindow;
        private var _tabContext:ITabContextWindow;

        public function TopViewSelector(_arg_1:CatalogNavigator, _arg_2:ITabContextWindow)
        {
            _catalog = _arg_1;
            _tabContext = _arg_2;
            var _local_3:ITabButtonWindow = ITabButtonWindow(_arg_2.getTabItemAt(0).clone());
            _SafeStr_1565 = _local_3;
            _tabContext.removeTabItem(_local_3);
        }

        public function addTabItem(_arg_1:ICatalogNode):void
        {
            var _local_2:ITabButtonWindow = ITabButtonWindow(_SafeStr_1565.clone());
            _local_2.caption = _arg_1.localization;
            _local_2.name = _arg_1.pageName;
            _local_2.procedure = topViewSelectorButtonProcedure;
            _tabContext.addTabItem(_local_2);
            alignTabs();
        }

        private function alignTabs():void
        {
            var _local_1:int;
            _local_1 = 0;
            while (_local_1 < _tabContext.numTabItems)
            {
                _tabContext.getTabItemAt(_local_1).width = (_tabContext.getTabItemAt(_local_1).parent.width / _tabContext.numTabItems);
                _local_1++;
            };
        }

        public function clearTabs():void
        {
            while (_tabContext.numTabItems > 0)
            {
                _tabContext.removeTabItem(_tabContext.getTabItemAt(0));
            };
        }

        public function selectTabByIndex(_arg_1:int):void
        {
            _tabContext.selector.setSelected(_tabContext.getTabItemAt(_arg_1));
            selectTabButton(_tabContext.getTabItemAt(_arg_1));
        }

        private function topViewSelectorButtonProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:ITabButtonWindow;
            if (_arg_1.type == "WME_CLICK")
            {
                _local_3 = (_arg_2 as ITabButtonWindow);
                if (_local_3)
                {
                    selectTabButton(_local_3);
                };
            };
        }

        private function selectTabButton(_arg_1:ITabButtonWindow):void
        {
            if (!_arg_1)
            {
                return;
            };
            var _local_2:ICatalogNode = _catalog.getNodeByName(_arg_1.name);
            if (_local_2 != null)
            {
                _catalog.showNodeContent(_local_2);
            };
        }


    }
}

