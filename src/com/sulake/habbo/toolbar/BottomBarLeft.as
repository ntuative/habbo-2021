package com.sulake.habbo.toolbar
{
    import com.sulake.core.runtime.events.ILinkEventTracker;
    import flash.geom.Point;
    import com.sulake.core.window.IWindowContainer;
    import flash.events.IEventDispatcher;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.utils.Map;
    import flash.display.BitmapData;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.core.window.components.IBoxSizerWindow;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
    import com.sulake.habbo.toolbar.memenu.MeMenuNewController;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.localization.ILocalization;
    import com.sulake.core.runtime.Component;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.catalog.event.CatalogEvent;
    import flash.geom.Rectangle;
    import com.sulake.core.window.components._SafeStr_124;
    import com.sulake.core.window.utils.IBitmapDataContainer;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.filters.GlowFilter;
    import com.sulake.core.window.motion.Motions;
    import com.sulake.core.window.motion.Queue;
    import com.sulake.core.window.motion.Wait;
    import com.sulake.core.window.motion.DropBounce;
    import com.sulake.core.window.motion.EaseOut;
    import com.sulake.core.window.motion.JumpBy;
    import com.sulake.core.window.motion.Dispose;
    import com.sulake.core.window.motion.Motion;

    public class BottomBarLeft implements ILinkEventTracker 
    {

        private static const DEFAULT_LOCATION:Point = new Point(0, 500);
        private static const LANDING_VIEW_LOCATION:Point = new Point(0, 500);
        private static const ICON_BG_COLOR_OVER:uint = 7433577;
        private static const ICON_BG_COLOR_OUT:uint = 5723213;
        private static const ICON_MOUSE_OVER:String = "_hover";
        private static const ICON_MOUSE_OUT:String = "_normal";
        private static const COUNTER_MARGIN:int = 0;
        private static const ME_MENU_ICON_NAME:String = "icon_me_menu";
        private static const ICON_REGION_WIDTH:int = 45;
        private static const ICON_LABEL_HEIGHT:int = 20;
        private static const WINDOW_RIGHT_PADDING:int = 10;
        private static const COLLAPSED_MARGIN:int = 185;

        private var _window:IWindowContainer;
        private var _SafeStr_913:IEventDispatcher;
        private var _disposed:Boolean;
        private var _toolbar:HabboToolbar;
        private var _assets:IAssetLibrary;
        private var _windowManager:IHabboWindowManager;
        private var _unseenItemCounters:Map;
        private var _newItemsNotification:IWindowContainer;
        private var _SafeStr_3806:Boolean;
        private var _SafeStr_3807:BitmapData;
        private var _left_arrow:IRegionWindow;
        private var _right_arrow:IRegionWindow;
        private var _buttonContainer:IBoxSizerWindow;
        private var _SafeStr_2458:IStaticBitmapWrapperWindow;
        private var _SafeStr_3808:String;
        private var _SafeStr_3809:int;
        private var _SafeStr_3810:int;
        private var _SafeStr_3811:int;
        private var _SafeStr_2445:Boolean = false;
        private var _memenu:MeMenuNewController;

        public function BottomBarLeft(_arg_1:HabboToolbar, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary, _arg_4:IEventDispatcher)
        {
            super();
            var _local_5:IWindowContainer = null;
            _toolbar = _arg_1;
            _windowManager = _arg_2;
            _assets = _arg_3;
            _SafeStr_913 = _arg_4;
            _memenu = new MeMenuNewController(_toolbar, this);
            _unseenItemCounters = new Map();
            var _local_13:XmlAsset = (_arg_3.getAssetByName("bottom_bar_left_xml") as XmlAsset);
            _window = (_arg_2.buildFromXML((_local_13.content as XML)) as IWindowContainer);
            if (_window == null)
            {
                throw (new Error("Failed to construct window from XML!"));
            };
            _window.addEventListener("WE_PARENT_RESIZED", onParentResized);
            _buttonContainer = (_window.getChildByName("toolbar_items") as IBoxSizerWindow);
            var _local_14:IWindowContainer = (_window.getChildByName("arrow_container_left") as IWindowContainer);
            var _local_10:IWindowContainer = (_window.getChildByName("arrow_container_right") as IWindowContainer);
            _left_arrow = (_local_14.getChildByName("collapse_left") as IRegionWindow);
            _right_arrow = (_local_10.getChildByName("collapse_right") as IRegionWindow);
            if (_left_arrow)
            {
                _left_arrow.addEventListener("WME_CLICK", onCollapseToolsBar);
            };
            if (_right_arrow)
            {
                _right_arrow.addEventListener("WME_CLICK", onCollapseToolsBar);
            };
            _SafeStr_2458 = (_buttonContainer.getChildByName("line") as IStaticBitmapWrapperWindow);
            var _local_9:Array = [];
            _window.groupChildrenWithTag("TOGGLE", _local_9, -1);
            for each (var _local_7:IWindow in _local_9)
            {
                if (((_local_7) && (_local_7 is IRegionWindow)))
                {
                    _local_7.addEventListener("WME_CLICK", onIconClick);
                };
            };
            iconVisibility(HabboToolbarIconEnum.getIconName("HTIE_ICON_MEMENU"), false);
            iconVisibility(HabboToolbarIconEnum.getIconName("HTIE_ICON_INVENTORY"), false);
            var _local_12:Boolean = _arg_1.getBoolean("games_icon_enabled");
            if (_local_12)
            {
                iconVisibility(HabboToolbarIconEnum.getIconName("HTIE_ICON_GAMES"), true);
            }
            else
            {
                iconVisibility(HabboToolbarIconEnum.getIconName("HTIE_ICON_GAMES"), false);
            };
            var _local_11:XmlAsset = (_arg_3.getAssetByName("new_items_label_xml") as XmlAsset);
            _newItemsNotification = (_arg_2.buildFromXML((_local_11.content as XML), 2) as IWindowContainer);
            if (_newItemsNotification == null)
            {
                throw (new Error("Failed to construct toolbar label from XML!"));
            };
            _local_5 = (_window.findChildByName(HabboToolbarIconEnum.getIconName("HTIE_ICON_NAVIGATOR")) as IWindowContainer);
            if (_local_5)
            {
                _windowManager.registerHintWindow(HabboToolbarIconEnum.getIconName("HTIE_ICON_NAVIGATOR"), _local_5);
            };
            _local_5 = (_window.findChildByName(HabboToolbarIconEnum.getIconName("HTIE_ICON_MEMENU")) as IWindowContainer);
            if (_local_5)
            {
                _windowManager.registerHintWindow(HabboToolbarIconEnum.getIconName("HTIE_ICON_MEMENU"), _local_5);
            };
            _local_5 = (_window.findChildByName(HabboToolbarIconEnum.getIconName("HTIE_ICON_INVENTORY")) as IWindowContainer);
            if (_local_5)
            {
                _windowManager.registerHintWindow(HabboToolbarIconEnum.getIconName("HTIE_ICON_INVENTORY"), _local_5);
            };
            var _local_8:IWindowContainer = (_window.findChildByName(HabboToolbarIconEnum.getIconName("HTIE_ICON_CATALOGUE")) as IWindowContainer);
            _local_8.addChild(_newItemsNotification);
            _windowManager.registerHintWindow(HabboToolbarIconEnum.getIconName("HTIE_ICON_CATALOGUE"), _local_8);
            var _local_15:ITextWindow = (_newItemsNotification.findChildByName("new_textfield") as ITextWindow);
            var _local_6:ILocalization = _arg_1.localization.getLocalizationRaw("toolbar.new_additions.notification");
            if (_local_6 != null)
            {
                _local_15.text = _local_6.value;
            };
            _newItemsNotification.visible = false;
            _newItemsNotification.x = ((_local_8.width - _newItemsNotification.width) - 0);
            _newItemsNotification.y = 0;
            _SafeStr_3806 = isNewItemsNotificationEnabled();
            checkSize();
            (_arg_1 as Component).context.addLinkEventTracker(this);
        }

        private function onPanicButton(_arg_1:WindowMouseEvent, _arg_2:*):void
        {
            _toolbar.toggleWindowVisibility("PANIC");
        }

        private function onParentResized(_arg_1:WindowEvent):void
        {
            checkSize();
        }

        private function checkSize():void
        {
            if (((!(_window)) || (!(_windowManager))))
            {
                return;
            };
            _left_arrow.visible = (!(_SafeStr_2445));
            _right_arrow.visible = _SafeStr_2445;
            _window.y = (_window.desktop.height - _window.height);
            _window.width = (((45 * calculateNewWidth()) + 10) + 150);
            if (!_SafeStr_2445)
            {
                if (_memenu != null)
                {
                    _memenu.reposition();
                };
            };
            _window.invalidate();
        }

        public function dispose():void
        {
            if (_memenu != null)
            {
                _memenu.dispose();
                _memenu = null;
            };
            if (_SafeStr_3807 != null)
            {
                _SafeStr_3807.dispose();
                _SafeStr_3807 = null;
            };
            if (_unseenItemCounters != null)
            {
                _unseenItemCounters.dispose();
                _unseenItemCounters = null;
            };
            if (_window != null)
            {
                _window.dispose();
                _window = null;
            };
            if (_newItemsNotification != null)
            {
                _newItemsNotification.dispose();
                _newItemsNotification = null;
            };
            if (_windowManager)
            {
                _windowManager.unregisterHintWindow(HabboToolbarIconEnum.getIconName("HTIE_ICON_NAVIGATOR"));
                _windowManager.unregisterHintWindow(HabboToolbarIconEnum.getIconName("HTIE_ICON_MEMENU"));
                _windowManager.unregisterHintWindow(HabboToolbarIconEnum.getIconName("HTIE_ICON_INVENTORY"));
                _windowManager.unregisterHintWindow(HabboToolbarIconEnum.getIconName("HTIE_ICON_CATALOGUE"));
            };
            if (_toolbar)
            {
                (_toolbar as Component).context.removeLinkEventTracker(this);
                _toolbar = null;
            };
            _windowManager = null;
            _assets = null;
            _disposed = true;
            if (_SafeStr_913)
            {
                _SafeStr_913 = null;
            };
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get window():IWindow
        {
            return (_window);
        }

        private function disableCatalogIcon():void
        {
            var _local_1:IWindowContainer = (_window.findChildByName(HabboToolbarIconEnum.getIconName("HTIE_ICON_CATALOGUE")) as IWindowContainer);
            _local_1.blend = 0.5;
            _local_1.disable();
        }

        public function onCatalogEvent(_arg_1:CatalogEvent):void
        {
            var _local_2:IWindowContainer;
            var _local_3:String;
            switch (_arg_1.type)
            {
                case "CATALOG_INITIALIZED":
                    _local_2 = (_window.findChildByName(HabboToolbarIconEnum.getIconName("HTIE_ICON_CATALOGUE")) as IWindowContainer);
                    _local_2.blend = 1;
                    _local_2.enable();
                    _local_3 = _toolbar.getProperty("open.catalog.page");
                    if (((_local_3.length > 0) && (_toolbar.catalog)))
                    {
                        _toolbar.catalog.openCatalogPage("hc_membership");
                        _toolbar.setProperty("open.catalog.page", "");
                    };
                    return;
                case "CATALOG_NOT_READY":
                    disableCatalogIcon();
                    return;
                case "CATALOG_NEW_ITEMS_SHOW":
                    if (((!(_newItemsNotification == null)) && (_SafeStr_3806)))
                    {
                        _newItemsNotification.visible = true;
                    };
                    return;
                case "CATALOG_NEW_ITEMS_HIDE":
                    if (_newItemsNotification != null)
                    {
                        _newItemsNotification.visible = false;
                    };
                    return;
            };
        }

        public function setToolbarState(_arg_1:String):void
        {
            var _local_3:String;
            var _local_4:Boolean;
            var _local_5:String;
            var _local_6:Boolean;
            if (_arg_1 == "HTE_STATE_HIDDEN")
            {
                _window.visible = false;
                return;
            };
            _window.visible = true;
            if (_arg_1 != "HTE_STATE_COLLAPSED")
            {
                _SafeStr_3808 = _arg_1;
            };
            var _local_7:Array = [];
            _window.groupChildrenWithTag("TOGGLE", _local_7, -1);
            switch (_arg_1)
            {
                case "HTE_STATE_GAME_CENTER_VIEW":
                    _local_3 = "VISIBLE_GAME_CENTER";
                    _window.position = DEFAULT_LOCATION;
                    break;
                case "HTE_STATE_HOTEL_VIEW":
                    _local_3 = "VISIBLE_HOTEL";
                    _window.position = LANDING_VIEW_LOCATION;
                    break;
                case "HTE_STATE_NOOB_NOT_HOME":
                    _local_3 = "VISIBLE_NOOB";
                    _window.position = DEFAULT_LOCATION;
                    break;
                case "HETE_STATE_NOOB_HOME":
                    _local_3 = "VISIBLE_ROOM";
                    _window.position = DEFAULT_LOCATION;
                    break;
                case "HTE_STATE_ROOM_VIEW":
                    _local_3 = "VISIBLE_ROOM";
                    _window.position = DEFAULT_LOCATION;
                    break;
                case "HTE_STATE_COLLAPSED":
                    _local_3 = "VISIBLE_COLLAPSED";
                    _window.position = DEFAULT_LOCATION;
            };
            for each (var _local_2:IWindow in _local_7)
            {
                if (_local_2)
                {
                    _local_2.visible = (_local_2.tags.indexOf(_local_3) >= 0);
                    if (((_local_2.name == "QUESTS") && (!(_SafeStr_2445))))
                    {
                        _local_2.visible = ((_local_2.visible) && ((!(_toolbar.isNewIdentity())) || (!(_toolbar.getBoolean("new.identity.hide.quests")))));
                        _local_2.visible = ((_local_2.visible) && (!(_toolbar.getBoolean("toolbar.hide.quests"))));
                    }
                    else
                    {
                        if (((_local_2.name == "STORIES") && (!(_SafeStr_2445))))
                        {
                            _local_2.visible = ((_local_2.visible) && (_toolbar.getBoolean("toolbar.stories.enabled")));
                        }
                        else
                        {
                            if (((_local_2.name == "BUILDER") && (!(_SafeStr_2445))))
                            {
                                _local_2.visible = ((_local_2.visible) && (_toolbar.getBoolean("builders.club.enabled")));
                            }
                            else
                            {
                                if (_local_2.name == "GAMES")
                                {
                                    _local_2.visible = ((_local_2.visible) && (_toolbar.getBoolean("games_icon_enabled")));
                                }
                                else
                                {
                                    if (_local_2.name == "CAMERA")
                                    {
                                        _local_4 = ((((_arg_1 == "HTE_STATE_ROOM_VIEW") || (_arg_1 == "HETE_STATE_NOOB_HOME")) || (_arg_1 == "HTE_STATE_NOOB_NOT_HOME")) || ((_SafeStr_2445) && (((_SafeStr_3808 == "HTE_STATE_ROOM_VIEW") || (_SafeStr_3808 == "HETE_STATE_NOOB_HOME")) || (_SafeStr_3808 == "HTE_STATE_NOOB_NOT_HOME"))));
                                        _local_5 = _toolbar.getProperty("camera.launch.ui.position");
                                        _local_6 = _toolbar.sessionDataManager.isPerkAllowed("CAMERA");
                                        _local_2.visible = (((_local_4) && (_local_5 == "bottom-icons")) && (_local_6));
                                    };
                                };
                            };
                        };
                    };
                };
            };
            checkSize();
        }

        public function iconVisibility(_arg_1:String, _arg_2:Boolean):void
        {
            var _local_3:IWindowContainer = (_window.findChildByName(_arg_1) as IWindowContainer);
            if (_local_3)
            {
                _local_3.visible = _arg_2;
            };
            checkSize();
        }

        public function calculateNewWidth():int
        {
            var _local_3:Array = [];
            var _local_2:int = 1;
            _window.groupChildrenWithTag("TOGGLE", _local_3, -1);
            for each (var _local_1:IWindow in _local_3)
            {
                if (((_local_1) && (_local_1.visible)))
                {
                    _local_2++;
                };
            };
            return (_local_2);
        }

        private function onNaviHover(_arg_1:WindowMouseEvent):void
        {
            var _local_2:Rectangle;
            if (_toolbar.navigator == null)
            {
                return;
            };
            switch (_arg_1.type)
            {
                case "WME_OVER":
                    _local_2 = getIconLocation("HTIE_ICON_NAVIGATOR");
                    _toolbar.navigator.showToolbarHover(new Point((_local_2.right + 15), _local_2.y));
                    return;
                case "WME_OUT":
                    _toolbar.navigator.hideToolbarHover(true);
                    return;
            };
        }

        private function onIconHoverMouseEvent(_arg_1:WindowMouseEvent):void
        {
            var _local_2:IWindowContainer = (_arg_1.target as IWindowContainer);
            if (!_local_2)
            {
                return;
            };
            var _local_3:_SafeStr_124 = (_local_2.findChildByTag("ICON_BORDER") as _SafeStr_124);
            var _local_4:IBitmapDataContainer = (_local_2.findChildByTag("ICON_BMP") as IBitmapDataContainer);
            Logger.log(_arg_1);
            switch (_arg_1.type)
            {
                case "WME_OVER":
                    setIconHoverState(_local_4, "_hover");
                    setIconBgHoverState(_local_3, "_hover");
                    if (_arg_1.target.name == "NAVIGATOR")
                    {
                        onNaviHover(_arg_1);
                    };
                    return;
                case "WME_OUT":
                    setIconHoverState(_local_4, "_normal");
                    setIconBgHoverState(_local_3, "_normal");
                    if (_arg_1.target.name == "NAVIGATOR")
                    {
                        onNaviHover(_arg_1);
                    };
                    return;
            };
        }

        private function setIconHoverState(_arg_1:IBitmapDataContainer, _arg_2:String):void
        {
            var _local_3:IStaticBitmapWrapperWindow;
            var _local_4:IBitmapWrapperWindow;
            if ((_arg_1 is IStaticBitmapWrapperWindow))
            {
                _local_3 = (_arg_1 as IStaticBitmapWrapperWindow);
                _local_3.assetUri = (_local_3.name + _arg_2);
            }
            else
            {
                if ((_arg_1 is IBitmapWrapperWindow))
                {
                    _local_4 = (_arg_1 as IBitmapWrapperWindow);
                    if (_local_4.name == "icon_me_menu")
                    {
                        _local_4.bitmap = _SafeStr_3807;
                    };
                };
            };
        }

        private function setIconBgHoverState(_arg_1:IWindowContainer, _arg_2:String):void
        {
            if (!_arg_1)
            {
                return;
            };
            if (_arg_2 == "_hover")
            {
                _arg_1.color = 7433577;
            }
            else
            {
                _arg_1.color = 5723213;
            };
        }

        private function onIconClick(_arg_1:WindowMouseEvent):void
        {
            var _local_2:String = IWindow(_arg_1.target).name;
            _toolbar.toggleWindowVisibility(_local_2);
            _windowManager.hideMatchingHint(_local_2);
        }

        public function setIconBitmap(_arg_1:String, _arg_2:BitmapData):void
        {
            var _local_3:String;
            if (!_arg_2)
            {
                return;
            };
            switch (_arg_1)
            {
                case "HTIE_ICON_MEMENU":
                    _local_3 = "icon_me_menu";
                    setMeMenuIconBitmaps(_arg_2);
            };
            var _local_4:IBitmapDataContainer = (_window.findChildByName(_local_3) as IBitmapDataContainer);
            if (_local_4 != null)
            {
                setIconHoverState(_local_4, "_normal");
            };
        }

        private function getIconName(_arg_1:String):String
        {
            var _local_2:String;
            switch (_arg_1)
            {
                case "HTIE_ICON_CATALOGUE":
                    _local_2 = "icons_toolbar_catalogue";
                    break;
                case "HTIE_ICON_INVENTORY":
                    _local_2 = "icons_toolbar_inventory";
                    break;
                case "HTIE_ICON_MEMENU":
                    _local_2 = "MEMENU";
                    break;
                case "HTIE_ICON_NAVIGATOR":
                    _local_2 = "icons_toolbar_navigator";
                    break;
                case "HTIE_ICON_QUESTS":
                    _local_2 = "icons_toolbar_quests";
                    break;
                case "HTIE_ICON_GAMES":
                    _local_2 = "icons_toolbar_games";
                    break;
                case "HTIE_ICON_STORIES":
                    _local_2 = "icons_toolbar_stories";
                    break;
                case "HTIE_ICON_RECEPTION":
                    _local_2 = "icons_toolbar_reception";
                    break;
                case "HTIE_ICON_BUILDER":
                    _local_2 = "icons_toolbar_builder";
                    break;
                case "HTIE_ICON_CAMERA":
                    _local_2 = "icons_toolbar_camera";
            };
            return (_local_2);
        }

        public function getIconLocation(_arg_1:String):Rectangle
        {
            var _local_4:IWindow;
            var _local_2:Rectangle = new Rectangle();
            var _local_5:String;
            _local_5 = getIconName(_arg_1);
            if (_local_5 != null)
            {
                _local_4 = _window.findChildByName(_local_5);
            };
            if (((!(_local_4 == null)) && (_local_4.visible)))
            {
                _local_4.getGlobalRectangle(_local_2);
                return (_local_2);
            };
            var _local_3:Rectangle = _memenu.getIconPosition(_arg_1);
            if (_local_3 != null)
            {
                return (_local_3);
            };
            return (null);
        }

        public function geIcon(_arg_1:String):IWindow
        {
            var _local_3:IWindow;
            var _local_2:String = getIconName(_arg_1);
            _local_3 = _window.findChildByName(_local_2);
            if (!_local_3)
            {
                _local_3 = _memenu.getIcon(_arg_1);
            };
            return (_local_3);
        }

        private function setMeMenuIconBitmaps(_arg_1:BitmapData):void
        {
            if (_SafeStr_3807 != null)
            {
                _SafeStr_3807.dispose();
            };
            if (_arg_1 != null)
            {
                _SafeStr_3807 = _arg_1.clone();
            };
            _arg_1.dispose();
        }

        public function setUnseenItemCount(_arg_1:String, _arg_2:int):void
        {
            var _local_3:IWindowContainer = getUnseenItemCounter(_arg_1);
            if (!_local_3)
            {
                return;
            };
            if (_arg_2 < 0)
            {
                _local_3.visible = true;
                _local_3.findChildByName("count").caption = " ";
            }
            else
            {
                if (_arg_2 > 0)
                {
                    _local_3.visible = true;
                    _local_3.findChildByName("count").caption = _arg_2.toString();
                }
                else
                {
                    _local_3.visible = false;
                };
            };
        }

        public function getUnseenItemCounter(_arg_1:String):IWindowContainer
        {
            var _local_2:IWindowContainer;
            var _local_4:String = HabboToolbarIconEnum.getIconName(_arg_1);
            if (!_local_4)
            {
                Logger.log(("[Toolbar] Unknown icon type for unseen item counter for iconId: " + _arg_1));
            };
            var _local_3:IWindowContainer = (_unseenItemCounters.getValue(_arg_1) as IWindowContainer);
            if (!_local_3)
            {
                _local_3 = _windowManager.createUnseenItemCounter();
                _local_2 = (_window.findChildByName(_local_4) as IWindowContainer);
                if (_local_2)
                {
                    _local_2.addChild(_local_3);
                    _local_3.x = ((_local_2.width - _local_3.width) - 0);
                    _local_3.y = 0;
                    _unseenItemCounters.add(_arg_1, _local_3);
                };
            };
            return (_local_3);
        }

        public function isNewItemsNotificationEnabled():Boolean
        {
            return (_toolbar.getBoolean("toolbar.new_additions.notification.enabled"));
        }

        public function animateToIcon(_arg_1:String, _arg_2:BitmapData, _arg_3:int, _arg_4:int):Motion
        {
            var _local_14:IWindow;
            var _local_11:int = 20;
            var _local_16:int = ((_arg_2) ? _arg_2.width : _local_11);
            var _local_19:int = ((_arg_2) ? _arg_2.height : _local_11);
            var _local_18:IBitmapWrapperWindow = (_windowManager.create("ToolBarTransition", 21, 0, 0, new Rectangle(_arg_3, _arg_4, _local_16, _local_19)) as IBitmapWrapperWindow);
            if (_arg_2)
            {
                _local_18.bitmap = _arg_2;
                _local_18.disposesBitmap = true;
                _local_18.filters = [new GlowFilter(0xFFFFFF, 1, 2, 2, 0xFF, 1, false, false)];
            };
            _windowManager.getDesktop(2).addChild(_local_18);
            var _local_7:String;
            _local_7 = getIconName(_arg_1);
            if (_local_7 != null)
            {
                _local_14 = _window.findChildByName(_local_7);
            };
            if (!_local_14)
            {
                _local_18.dispose();
                return (null);
            };
            var _local_12:Rectangle = new Rectangle();
            _local_18.getGlobalRectangle(_local_12);
            var _local_10:Rectangle = new Rectangle();
            _local_14.getGlobalRectangle(_local_10);
            var _local_13:int = (_local_12.x - _local_10.x);
            var _local_15:int = (_local_12.y - _local_10.y);
            var _local_5:Number = Math.sqrt(((_local_13 * _local_13) + (_local_15 * _local_15)));
            var _local_8:int = (500 - Math.abs(((((1 / _local_5) * 100) * 500) * 0.5)));
            var _local_9:int = 20;
            var _local_17:String = (("ToolBarBouncing[ " + _local_7) + " ]");
            if (!Motions.getMotionByTag(_local_17))
            {
                Motions.runMotion(new Queue(new Wait((_local_8 + 8)), new DropBounce(_local_14, 400, 12))).tag = _local_17;
            };
            var _local_6:Motion = new Queue(new EaseOut(new JumpBy(_local_18, _local_8, ((_local_10.x - _local_12.x) + _local_9), (_local_10.y - _local_12.y), 100, 1), 1), new Dispose(_local_18));
            return (Motions.runMotion(_local_6));
        }

        public function set onDuty(_arg_1:Boolean):void
        {
            var _local_2:IWindow = _window.findChildByName("guide_icon");
            if (_local_2 != null)
            {
                _local_2.visible = _arg_1;
            };
        }

        public function set unseenAchievementCount(_arg_1:int):void
        {
            _SafeStr_3810 = _arg_1;
        }

        public function set unseenMiniMailMessageCount(_arg_1:int):void
        {
            _SafeStr_3809 = _arg_1;
        }

        public function set unseenForumsCount(_arg_1:int):void
        {
            _SafeStr_3811 = _arg_1;
        }

        public function get unseenMeMenuCount():int
        {
            return ((_SafeStr_3809 + _SafeStr_3810) + _SafeStr_3811);
        }

        public function get memenu():MeMenuNewController
        {
            return (_memenu);
        }

        public function get linkPattern():String
        {
            return ("toolbar/");
        }

        private function onCollapseToolsBar(_arg_1:WindowMouseEvent):void
        {
            _SafeStr_2445 = (!(_SafeStr_2445));
            if (_SafeStr_2445)
            {
                setToolbarState("HTE_STATE_COLLAPSED");
            }
            else
            {
                setToolbarState(_SafeStr_3808);
            };
            checkSize();
            _toolbar.roomUI.triggerbottomBarResize();
        }

        public function linkReceived(_arg_1:String):void
        {
            var _local_2:Array = _arg_1.split("/");
            if (_local_2.length < 2)
            {
                return;
            };
            switch (_local_2[1])
            {
                case "memenu":
                    memenu.toggleVisibility();
                    return;
                case "highlight":
                    if (_local_2.length <= 2)
                    {
                        return;
                    };
                    switch (_local_2[2])
                    {
                        case "catalog":
                            _windowManager.showHint(HabboToolbarIconEnum.getIconName("HTIE_ICON_CATALOGUE"));
                            break;
                        case "navigator":
                            _windowManager.showHint(HabboToolbarIconEnum.getIconName("HTIE_ICON_NAVIGATOR"));
                            break;
                        case "memenu":
                            _windowManager.showHint(HabboToolbarIconEnum.getIconName("HTIE_ICON_MEMENU"));
                    };
                    return;
                default:
                    Logger.log(("Toolbar unknown link-type received: " + _local_2[1]));
                    return;
            };
        }

        public function getToolbarAreaWidth():int
        {
            if (((!(_SafeStr_2458)) || (!(_SafeStr_2458.parent))))
            {
                return (0);
            };
            return ((_SafeStr_2445) ? 185 : (_SafeStr_2458.x + _SafeStr_2458.parent.x));
        }


    }
}

