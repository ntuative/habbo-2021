package com.sulake.habbo.navigator.view
{
    import com.sulake.habbo.navigator.HabboNewNavigator;
    import com.sulake.core.window.components.ITabButtonWindow;
    import com.sulake.core.window.components.ITabContextWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class TopViewSelector 
    {

        private var _navigator:HabboNewNavigator;
        private var _SafeStr_1565:ITabButtonWindow;
        private var _tabContext:ITabContextWindow;

        public function TopViewSelector(_arg_1:HabboNewNavigator)
        {
            _navigator = _arg_1;
        }

        public function set template(_arg_1:ITabButtonWindow):void
        {
            _SafeStr_1565 = _arg_1;
        }

        public function set tabContext(_arg_1:ITabContextWindow):void
        {
            _tabContext = _arg_1;
        }

        public function refresh():void
        {
            var _local_1:int;
            var _local_3:String;
            var _local_2:ITabButtonWindow;
            clearTabs();
            _local_1 = 0;
            while (_local_1 < _navigator.contextContainer.getTopLevelSearches().length)
            {
                _local_3 = _navigator.contextContainer.getTopLevelSearches()[_local_1];
                _local_2 = ITabButtonWindow(_SafeStr_1565.clone());
                _local_2.caption = (("${navigator.toplevelview." + _local_3) + "}");
                _local_2.id = _local_1;
                _local_2.procedure = topViewSelectorButtonProcedure;
                _tabContext.addTabItem(_local_2);
                _local_1++;
            };
        }

        public function selectTabByIndex(_arg_1:int):void
        {
            _tabContext.selector.setSelected(_tabContext.getTabItemAt(_arg_1));
        }

        private function clearTabs():void
        {
            var _local_1:int;
            _local_1 = 0;
            while (_local_1 < _tabContext.numTabItems)
            {
                _tabContext.removeTabItem(_tabContext.getTabItemAt(0));
                _local_1++;
            };
        }

        private function topViewSelectorButtonProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                if (_navigator.contextContainer.getTopLevelSearches().length > _arg_2.id)
                {
                    _navigator.performSearch(_navigator.contextContainer.getTopLevelSearches()[_arg_2.id], "", _navigator.view.currentFilterText());
                };
            };
        }


    }
}

