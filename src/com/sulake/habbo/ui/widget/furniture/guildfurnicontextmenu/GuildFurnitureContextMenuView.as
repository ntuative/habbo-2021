package com.sulake.habbo.ui.widget.furniture.guildfurnicontextmenu
{
    import com.sulake.habbo.ui.widget.furniture.contextmenu.FurnitureContextInfoView;
    import com.sulake.habbo.groups.IHabboGroupsManager;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.ui.widget.contextmenu.IContextMenuParentWidget;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.runtime.Component;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.ui.widget.furniture.contextmenu.FurnitureContextMenuWidget;

    public class GuildFurnitureContextMenuView extends FurnitureContextInfoView 
    {

        protected var _SafeStr_4104:IHabboGroupsManager;
        protected var _windowManager:IHabboWindowManager;
        public var _SafeStr_618:int = -1;
        public var _SafeStr_619:int = -1;
        public var _SafeStr_620:Boolean = false;
        public var _SafeStr_621:Boolean = false;

        public function GuildFurnitureContextMenuView(_arg_1:IContextMenuParentWidget, _arg_2:IHabboGroupsManager, _arg_3:IHabboWindowManager)
        {
            super(_arg_1);
            _SafeStr_3885 = false;
            _SafeStr_4104 = _arg_2;
            _windowManager = _arg_3;
        }

        override public function dispose():void
        {
            _SafeStr_4104 = null;
            _windowManager = null;
            super.dispose();
        }

        override protected function updateWindow():void
        {
            var _local_1:XML;
            var _local_2:IRegionWindow;
            if ((((!(_SafeStr_1324)) || (!(_SafeStr_1324.assets))) || (!(_SafeStr_1324.windowManager))))
            {
                return;
            };
            if (_SafeStr_2776)
            {
                activeView = getMinimizedView();
            }
            else
            {
                if (!_window)
                {
                    _local_1 = (XmlAsset(_SafeStr_1324.assets.getAssetByName("guild_furni_menu")).content as XML);
                    _window = (_SafeStr_1324.windowManager.buildFromXML(_local_1, 0) as IWindowContainer);
                    if (!_window)
                    {
                        return;
                    };
                    _window.addEventListener("WME_OVER", onMouseHoverEvent);
                    _window.addEventListener("WME_OUT", onMouseHoverEvent);
                    _window.findChildByName("minimize").addEventListener("WME_CLICK", onMinimize);
                    _window.findChildByName("minimize").addEventListener("WME_OVER", onMinimizeHover);
                    _window.findChildByName("minimize").addEventListener("WME_OUT", onMinimizeHover);
                };
                _buttons = (_window.findChildByName("buttons") as IItemListWindow);
                _buttons.procedure = buttonEventProc;
                _local_2 = (_window.findChildByName("profile_link") as IRegionWindow);
                if (_local_2)
                {
                    _local_2.procedure = buttonEventProc;
                    _local_2.toolTipCaption = widget.localizations.getLocalization("infostand.profile.link.tooltip", "Click to view profile");
                    _local_2.toolTipDelay = 100;
                };
                _window.findChildByName("name").caption = _SafeStr_906;
                _window.visible = false;
                activeView = _window;
                updateButtons();
                _lockPosition = false;
            };
        }

        protected function updateButtons():void
        {
            if (((!(_window)) || (!(_buttons))))
            {
                return;
            };
            _buttons.autoArrangeItems = false;
            showButton("join", (!(_SafeStr_620)), true);
            showButton("open_forum", _SafeStr_621, true);
            _buttons.autoArrangeItems = true;
            _buttons.visible = true;
        }

        override protected function buttonEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_4:Component;
            if (disposed)
            {
                return;
            };
            if (((!(_window)) || (_window.disposed)))
            {
                return;
            };
            var _local_3:Boolean;
            if (_arg_1.type == "WME_CLICK")
            {
                if (_arg_2.name == "button")
                {
                    switch (_arg_2.parent.name)
                    {
                        case "join":
                            widget.handler.sendJoinToGroupMessage(_SafeStr_618);
                            showButton("join", (!(_SafeStr_620)), false);
                            break;
                        case "home_room":
                            widget.handler.sendGoToHomeRoomMessage(_SafeStr_619);
                            break;
                        case "open_forum":
                            if (((!(widget == null)) && (!(widget.roomEngine == null))))
                            {
                                _local_4 = (widget.roomEngine as Component);
                                if (_local_4.context != null)
                                {
                                    _local_4.context.createLinkEvent(("groupforum/" + _SafeStr_618));
                                    break;
                                };
                            };
                    };
                };
                if (_arg_2.name == "profile_link")
                {
                    _SafeStr_4104.openGroupInfo(_SafeStr_618);
                };
                _local_3 = true;
            }
            else
            {
                super.buttonEventProc(_arg_1, _arg_2);
            };
            if (_local_3)
            {
                _SafeStr_1324.removeView(this, false);
            };
        }

        private function get widget():FurnitureContextMenuWidget
        {
            return (_SafeStr_1324 as FurnitureContextMenuWidget);
        }


    }
}

