package com.sulake.habbo.navigator.mainview
{
    import com.sulake.habbo.navigator.IViewCtrl;
    import com.sulake.habbo.navigator.UserCountRenderer;
    import com.sulake.habbo.navigator.HabboNavigator;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.components.IScrollbarWindow;
    import com.sulake.habbo.communication.messages.incoming.navigator.FlatCategory;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.navigator.Util;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class CategoryListCtrl implements IViewCtrl 
    {

        private static const CATEGORY_SPACING:int = 5;

        private var _SafeStr_2912:UserCountRenderer;
        private var _navigator:HabboNavigator;
        private var _content:IWindowContainer;
        private var _SafeStr_853:IItemListWindow;
        private var _SafeStr_951:IScrollbarWindow;

        public function CategoryListCtrl(_arg_1:HabboNavigator)
        {
            _navigator = _arg_1;
            _SafeStr_2912 = new UserCountRenderer(_navigator);
        }

        public function dispose():void
        {
            if (_SafeStr_2912)
            {
                _SafeStr_2912.dispose();
                _SafeStr_2912 = null;
            };
        }

        public function refresh():void
        {
            var _local_4:int;
            var _local_1:FlatCategory;
            var _local_10:IWindowContainer;
            var _local_2:int;
            var _local_5:int;
            var _local_3:int;
            var _local_6:Array = _navigator.data.allCategories;
            var _local_7:Map = _navigator.data.categoriesWithVisitorData.categoryToCurrentUserCountMap;
            var _local_8:Map = _navigator.data.categoriesWithVisitorData.categoryToMaxUserCountMap;
            var _local_9:IWindowContainer = IWindowContainer(_SafeStr_853.getListItemAt(0));
            _local_4 = 0;
            while (_local_4 < _local_6.length)
            {
                _local_1 = _local_6[_local_4];
                if (_local_1.visible)
                {
                    _local_10 = getCategoryContainer(_local_9, _local_4);
                    if (_local_10 == null)
                    {
                        _local_10 = createEntry(_local_4);
                        _local_10.id = _local_4;
                        _local_9.addChild(_local_10);
                    };
                    _local_2 = _local_7.getValue(_local_1.nodeId);
                    _local_5 = _local_8.getValue(_local_1.nodeId);
                    refreshEntry(_local_10, _local_1, _local_2, _local_5);
                    _local_10.y = _local_3;
                    _local_3 = (_local_3 + (_local_10.height + 5));
                    _local_10.visible = true;
                    _local_9.height = ((Util.getLowestPoint(_local_9) > 0) ? (Util.getLowestPoint(_local_9) + 5) : 0);
                };
                _local_4++;
            };
            if (_SafeStr_951 != null)
            {
                _SafeStr_951.scrollV = 0;
                _SafeStr_951.visible = true;
            };
        }

        public function refreshEntry(_arg_1:IWindowContainer, _arg_2:FlatCategory, _arg_3:int, _arg_4:int):void
        {
            _arg_1.findChildByName("category_name_txt").caption = _arg_2.visibleName;
            _arg_1.findChildByName("arrow_right_icon").visible = true;
            _SafeStr_2912.refreshUserCount(_arg_4, IWindowContainer(_arg_1.findChildByName("enter_category_button")), _arg_3, "${navigator.usercounttooltip.users}", 297, 35);
        }

        public function createEntry(_arg_1:int):IWindowContainer
        {
            var _local_2:IWindowContainer = IWindowContainer(_navigator.getXmlWindow("grs_category_selector"));
            setProcedureAndId(_local_2, _arg_1, "enter_category_button", onSelectCategory);
            _navigator.refreshButton(_local_2, "navi_room_icon", true, null, 0);
            return (_local_2);
        }

        private function onSelectCategory(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:FlatCategory;
            if (_arg_1.type == "WME_CLICK")
            {
                _local_3 = _navigator.data.allCategories[_arg_2.id];
                _navigator.mainViewCtrl.startSearch(2, 1, ("" + _local_3.nodeId));
            };
        }

        private function getCategoryContainer(_arg_1:IWindowContainer, _arg_2:int):IWindowContainer
        {
            return (IWindowContainer(_arg_1.getChildByID(_arg_2)));
        }

        private function setProcedureAndId(_arg_1:IWindowContainer, _arg_2:int, _arg_3:String, _arg_4:Function):void
        {
            _arg_1.findChildByName(_arg_3).procedure = _arg_4;
            _arg_1.findChildByName(_arg_3).id = _arg_2;
        }

        public function set content(_arg_1:IWindowContainer):void
        {
            _content = _arg_1;
            _SafeStr_853 = ((_content) ? IItemListWindow(_content.findChildByName("item_list_category")) : null);
            _SafeStr_951 = ((_content) ? IScrollbarWindow(_content.findChildByName("scroller")) : null);
        }

        public function get content():IWindowContainer
        {
            return (_content);
        }


    }
}

