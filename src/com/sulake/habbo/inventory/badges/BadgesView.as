package com.sulake.habbo.inventory.badges
{
    import com.sulake.habbo.inventory.IInventoryView;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemGridWindow;
    import com.sulake.core.assets.IAssetLibrary;
    import __AS3__.vec.Vector;
    import com.sulake.core.window.components._SafeStr_101;
    import com.sulake.habbo.window.widgets.IBadgeImageWidget;
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.events.WindowKeyboardEvent;
    import com.sulake.core.window.events.WindowEvent;

    public class BadgesView implements IInventoryView 
    {

        private static const GRID_UPDATE_DELAY_MS:int = 100;
        private static const GRID_ITEMS_PER_UPDATE:int = 25;

        private var _windowManager:IHabboWindowManager;
        private var _SafeStr_570:IWindowContainer;
        private var _SafeStr_1275:BadgesModel;
        private var _SafeStr_2722:IItemGridWindow;
        private var _disposed:Boolean = false;
        private var _SafeStr_573:Boolean = false;
        private var _SafeStr_1654:BadgeGridView;

        public function BadgesView(_arg_1:BadgesModel, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary)
        {
            _SafeStr_1275 = _arg_1;
            _windowManager = _arg_2;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get isVisible():Boolean
        {
            return (((_SafeStr_570) && (!(_SafeStr_570.parent == null))) && (_SafeStr_570.visible));
        }

        public function dispose():void
        {
            if (_disposed)
            {
                return;
            };
            _disposed = true;
            _windowManager = null;
            _SafeStr_1275 = null;
            if (_SafeStr_1654 != null)
            {
                _SafeStr_1654.dispose();
                _SafeStr_1654 = null;
            };
            _SafeStr_2722 = null;
            if (_SafeStr_570)
            {
                _SafeStr_570.dispose();
                _SafeStr_570 = null;
            };
        }

        public function getWindowContainer():IWindowContainer
        {
            if (!_SafeStr_573)
            {
                init();
            };
            if (((_SafeStr_570 == null) || (_SafeStr_570.disposed)))
            {
                return (null);
            };
            return (_SafeStr_570);
        }

        public function updateAll(_arg_1:String):void
        {
            updateListViews(_arg_1);
            updateActionView();
        }

        public function updateActionView():void
        {
            var _local_2:Vector.<Badge> = undefined;
            if (!_SafeStr_573)
            {
                return;
            };
            if (((_SafeStr_570 == null) || (_SafeStr_570.disposed)))
            {
                return;
            };
            var _local_3:_SafeStr_101 = (_SafeStr_570.findChildByName("wearBadge_button") as _SafeStr_101);
            if (_local_3 == null)
            {
                return;
            };
            var _local_1:Badge = _SafeStr_1275.getSelectedBadge();
            if (_local_1 == null)
            {
                _local_3.disable();
                setBadgeName(null);
                _SafeStr_570.findChildByName("badge_image").visible = false;
            }
            else
            {
                if (_local_1.isInUse)
                {
                    _local_3.caption = "${inventory.badges.clearbadge}";
                }
                else
                {
                    _local_3.caption = "${inventory.badges.wearbadge}";
                };
                setBadgeName(_local_1.badgeName);
                IBadgeImageWidget(IWidgetWindow(_SafeStr_570.findChildByName("badge_image")).widget).badgeId = _local_1.badgeId;
                _SafeStr_570.findChildByName("badge_image").visible = true;
                _local_2 = _SafeStr_1275.getBadges(1);
                if ((((!(_local_2 == null)) && (_local_2.length >= _SafeStr_1275.getMaxActiveCount())) && (!(_local_1.isInUse))))
                {
                    _local_3.disable();
                }
                else
                {
                    _local_3.enable();
                };
            };
        }

        private function init():void
        {
            _SafeStr_570 = _SafeStr_1275.controller.view.getView("badges");
            _SafeStr_570.procedure = windowEventProc;
            _SafeStr_570.visible = false;
            var _local_3:IWindow = _SafeStr_570.findChildByName("wearBadge_button");
            if (_local_3 != null)
            {
                _local_3.addEventListener("WME_CLICK", onWearBadgeClick);
            };
            var _local_1:IItemGridWindow = (_SafeStr_570.findChildByName("inactive_items") as IItemGridWindow);
            var _local_2:IItemListWindow = (_SafeStr_570.findChildByName("item_grid_pages") as IItemListWindow);
            _SafeStr_1654 = new BadgeGridView(this, _local_1, _local_2);
            _SafeStr_2722 = (_SafeStr_570.findChildByName("active_items") as IItemGridWindow);
            _SafeStr_570.findChildByName("filter").caption = "";
            _SafeStr_570.findChildByName("clear_filter_button").visible = false;
            _SafeStr_573 = true;
        }

        private function updateListViews(_arg_1:String):void
        {
            var _local_2:Badge;
            var _local_3:int;
            if (!_SafeStr_573)
            {
                return;
            };
            if (((_SafeStr_570 == null) || (_SafeStr_570.disposed)))
            {
                return;
            };
            _SafeStr_2722.removeGridItems();
            _SafeStr_1654.setFilter(0, _arg_1, _arg_1);
            _SafeStr_1654.setItems(_SafeStr_1275.getBadges(0));
            var _local_4:Vector.<Badge> = _SafeStr_1275.getBadges(1);
            _local_3 = 0;
            while (_local_3 < _local_4.length)
            {
                _local_2 = (_local_4[_local_3] as Badge);
                _SafeStr_2722.addGridItem(_local_2.window);
                _local_3++;
            };
        }

        private function setBadgeName(_arg_1:String):void
        {
            if (((_SafeStr_570 == null) || (_SafeStr_570.disposed)))
            {
                return;
            };
            var _local_2:ITextWindow = (_SafeStr_570.findChildByName("badgeName") as ITextWindow);
            if (_local_2 == null)
            {
                return;
            };
            if (_arg_1 == null)
            {
                _local_2.text = "";
            }
            else
            {
                _local_2.text = "";
                _local_2.text = _arg_1;
            };
        }

        private function windowEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:WindowKeyboardEvent;
            if (_arg_1.type == "WME_CLICK")
            {
                switch (_arg_2.name)
                {
                    case "clear_filter_button":
                        _SafeStr_570.findChildByName("filter").caption = "";
                        _arg_2.visible = false;
                        updateAll(null);
                };
            }
            else
            {
                if (_arg_1.type == "WKE_KEY_UP")
                {
                    _local_3 = (_arg_1 as WindowKeyboardEvent);
                    switch (_arg_2.name)
                    {
                        case "filter":
                            _SafeStr_570.findChildByName("clear_filter_button").visible = (_arg_2.caption.length > 0);
                            if (_local_3.keyCode == 13)
                            {
                                updateAll(_arg_2.caption);
                            };
                            return;
                    };
                };
            };
        }

        private function onWearBadgeClick(_arg_1:WindowEvent):void
        {
            var _local_2:Badge = _SafeStr_1275.getSelectedBadge();
            if (_local_2 != null)
            {
                _SafeStr_1275.toggleBadgeWearing(_local_2.badgeId);
            };
        }


    }
}

