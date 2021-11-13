package com.sulake.habbo.navigator.domain
{
    import com.sulake.habbo.navigator.HabboNavigator;
    import com.sulake.core.window.components.ITabButtonWindow;
    import com.sulake.habbo.navigator.mainview.tabpagedecorators.ITabPageDecorator;

    public class Tab 
    {

        private var _navigator:HabboNavigator;
        private var _id:int;
        private var _defaultSearchType:int;
        private var _button:ITabButtonWindow;
        private var _tabPageDecorator:ITabPageDecorator;
        private var _selected:Boolean;
        private var _searchMsg:int;

        public function Tab(_arg_1:HabboNavigator, _arg_2:int, _arg_3:int, _arg_4:ITabPageDecorator, _arg_5:int=1)
        {
            _navigator = _arg_1;
            _id = _arg_2;
            _defaultSearchType = _arg_3;
            _tabPageDecorator = _arg_4;
            _searchMsg = _arg_5;
        }

        public function sendSearchRequest():void
        {
            var _local_1:Boolean = _navigator.context.configuration.getBoolean("navigator.2014.personalized.navigator");
            if (((_local_1) && (id == 2)))
            {
                _defaultSearchType = 22;
            };
            _navigator.mainViewCtrl.startSearch(_id, _defaultSearchType, "-1", _searchMsg);
        }

        public function set selected(_arg_1:Boolean):void
        {
            this._selected = _arg_1;
        }

        public function get id():int
        {
            return (_id);
        }

        public function get defaultSearchType():int
        {
            return (_defaultSearchType);
        }

        public function get selected():Boolean
        {
            return (_selected);
        }

        public function get tabPageDecorator():ITabPageDecorator
        {
            return (_tabPageDecorator);
        }

        public function get searchMsg():int
        {
            return (_searchMsg);
        }

        public function get button():ITabButtonWindow
        {
            return (_button);
        }

        public function set button(_arg_1:ITabButtonWindow):void
        {
            _button = _arg_1;
        }


    }
}