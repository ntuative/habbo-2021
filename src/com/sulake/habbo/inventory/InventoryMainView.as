package com.sulake.habbo.inventory
{
    import flash.geom.Point;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.toolbar.IHabboToolbar;
    import flash.utils.Dictionary;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.components.ITabContextWindow;
    import com.sulake.core.window.components.ITabButtonWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.utils.WindowToggle;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.components.ILabelWindow;
    import com.sulake.habbo.toolbar.events.HabboToolbarEvent;

    public class InventoryMainView 
    {

        private static const COUNTER_MARGIN:int = 3;

        private const DEFAULT_VIEW_LOCATION:Point = new Point(120, 150);

        private var _windowManager:IHabboWindowManager;
        private var _SafeStr_1354:IAssetLibrary;
        private var _SafeStr_2554:IFrameWindow;
        private var _SafeStr_2781:String;
        private var _SafeStr_2782:IWindowContainer;
        private var _SafeStr_2783:String;
        private var _SafeStr_2784:IWindowContainer;
        private var _SafeStr_1284:HabboInventory;
        private var _toolbar:IHabboToolbar;
        private var _SafeStr_2785:IWindowContainer;
        private var _SafeStr_2786:IWindowContainer;
        private var _SafeStr_2787:IWindowContainer;
        private var _SafeStr_2788:IWindowContainer;
        private var _SafeStr_2789:IWindowContainer;
        private var _SafeStr_2790:Dictionary;

        public function InventoryMainView(_arg_1:HabboInventory, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary)
        {
            _SafeStr_1284 = _arg_1;
            _SafeStr_1354 = _arg_3;
            _windowManager = _arg_2;
        }

        public function get isVisible():Boolean
        {
            return ((_SafeStr_2554) ? _SafeStr_2554.visible : false);
        }

        public function get isActive():Boolean
        {
            return ((_SafeStr_2554) ? _SafeStr_2554.getStateFlag(1) : false);
        }

        public function get emptyContainer():IWindowContainer
        {
            if (!_SafeStr_2554)
            {
                return (null);
            };
            return (_SafeStr_2554.findChildByName("empty_container") as IWindowContainer);
        }

        public function get loadingContainer():IWindowContainer
        {
            if (!_SafeStr_2554)
            {
                return (null);
            };
            return (_SafeStr_2554.findChildByName("loading_container") as IWindowContainer);
        }

        public function get mainContainer():IWindowContainer
        {
            if (!_SafeStr_2554)
            {
                return (null);
            };
            return (_SafeStr_2554.findChildByName("contentArea") as IWindowContainer);
        }

        public function dispose():void
        {
            _SafeStr_2785 = null;
            _SafeStr_2786 = null;
            _SafeStr_2789 = null;
            _SafeStr_2788 = null;
            _SafeStr_2787 = null;
            _SafeStr_1284 = null;
            _SafeStr_2782 = null;
            _SafeStr_2784 = null;
            if (_SafeStr_2554)
            {
                _SafeStr_2554.dispose();
                _SafeStr_2554 = null;
            };
            if (_toolbar)
            {
                if (_toolbar.events)
                {
                    _toolbar.events.removeEventListener("HTE_TOOLBAR_CLICK", onHabboToolbarEvent);
                };
                _toolbar = null;
            };
            _windowManager = null;
            _SafeStr_1354 = null;
        }

        private function getWindow():IFrameWindow
        {
            var _local_4:IAsset;
            var _local_1:XmlAsset;
            var _local_2:ITabContextWindow;
            var _local_3:Array;
            var _local_5:ITabButtonWindow;
            if (!_SafeStr_2554)
            {
                _local_4 = _SafeStr_1354.getAssetByName("inventory_xml");
                _local_1 = XmlAsset(_local_4);
                _SafeStr_2790 = new Dictionary();
                _SafeStr_2554 = (_windowManager.buildFromXML(XML(_local_1.content)) as IFrameWindow);
                if (_SafeStr_2554 != null)
                {
                    _SafeStr_2554.position = DEFAULT_VIEW_LOCATION;
                    _SafeStr_2554.visible = false;
                    _SafeStr_2554.procedure = windowEventProc;
                    _SafeStr_2554.setParamFlag(0x10000, _SafeStr_1284.getBoolean("inventory.allow.scaling"));
                    extractWindow("furni");
                    extractWindow("pets");
                    extractWindow("bots");
                    extractWindow("badges");
                    _local_2 = (_SafeStr_2554.findChildByName("tabs") as ITabContextWindow);
                    _local_3 = [];
                    while (_local_2.numTabItems > 0)
                    {
                        _local_5 = _local_2.getTabItemAt(0);
                        _local_3.push(_local_5);
                        _local_2.removeTabItem(_local_5);
                    };
                    for each (_local_5 in _local_3)
                    {
                        switch (_local_5.name)
                        {
                            case "bots":
                                if (_SafeStr_1284.getBoolean("inventory.bots.enabled"))
                                {
                                    _local_2.addTabItem(_local_5);
                                };
                                break;
                            case "rentables":
                                if (_SafeStr_1284.getBoolean("duckets.enabled"))
                                {
                                    _local_2.addTabItem(_local_5);
                                };
                                break;
                            default:
                                _local_2.addTabItem(_local_5);
                        };
                    };
                    _SafeStr_1284.preparingInventoryView();
                };
                _SafeStr_1284.updateUnseenItemCounts();
            };
            if (_SafeStr_2554.y < 0)
            {
                _SafeStr_2554.y = 0;
            };
            if (_SafeStr_2554.x < 0)
            {
                _SafeStr_2554.x = 0;
            };
            return (_SafeStr_2554);
        }

        public function getCategoryViewId():String
        {
            return (_SafeStr_2781);
        }

        public function getSubCategoryViewId():String
        {
            return (_SafeStr_2783);
        }

        public function hideInventory():void
        {
            _SafeStr_1284.closingInventoryView();
            var _local_1:IWindow = getWindow();
            if (_local_1 == null)
            {
                return;
            };
            _local_1.visible = false;
        }

        public function showInventory():void
        {
            var _local_1:IWindow = getWindow();
            if (_local_1 == null)
            {
                return;
            };
            _local_1.visible = true;
            _SafeStr_1284.inventoryViewOpened((((_SafeStr_2783) && (_SafeStr_2783.length > 0)) ? _SafeStr_2783 : _SafeStr_2781));
        }

        public function toggleCategoryView(_arg_1:String, _arg_2:Boolean=true, _arg_3:Boolean=false):Boolean
        {
            var _local_4:IWindow = getWindow();
            if (_local_4 == null)
            {
                return (false);
            };
            if (_local_4.visible)
            {
                if (_SafeStr_2781 == _arg_1)
                {
                    if (_arg_2)
                    {
                        if (WindowToggle.isHiddenByOtherWindows(_local_4))
                        {
                            _local_4.activate();
                        }
                        else
                        {
                            hideInventory();
                            return (false);
                        };
                    };
                }
                else
                {
                    setViewToCategory(_arg_1);
                };
            }
            else
            {
                if ((((_arg_3) && (!(_SafeStr_2781 == null))) && (!(_SafeStr_2781 == _arg_1))))
                {
                    setViewToCategory(_arg_1);
                };
                _local_4.visible = true;
                _local_4.activate();
                if (((!(_arg_1 == _SafeStr_2781)) || (!(_SafeStr_1284.isInventoryCategoryInit(_arg_1)))))
                {
                    setViewToCategory(_arg_1);
                };
                _SafeStr_1284.inventoryViewOpened(_arg_1);
            };
            return (true);
        }

        public function toggleSubCategoryView(_arg_1:String, _arg_2:Boolean=true):void
        {
            var _local_3:IWindow = getWindow();
            if (_local_3 == null)
            {
                return;
            };
            if (_local_3.visible)
            {
                if (_SafeStr_2783 == _arg_1)
                {
                    if (_arg_2)
                    {
                        _local_3.visible = false;
                    };
                }
                else
                {
                    setSubViewToCategory(_arg_1);
                };
            }
            else
            {
                _local_3.visible = true;
                if (_arg_1 != _SafeStr_2783)
                {
                    setSubViewToCategory(_arg_1);
                };
            };
        }

        public function updateSubCategoryView():void
        {
            if (_SafeStr_2783 == null)
            {
                return;
            };
            setSubViewToCategory(_SafeStr_2783);
        }

        public function setToolbar(_arg_1:IHabboToolbar):void
        {
            _toolbar = _arg_1;
            _toolbar.events.addEventListener("HTE_TOOLBAR_CLICK", onHabboToolbarEvent);
        }

        public function windowEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:String;
            if (_arg_1.type == "WE_SELECTED")
            {
                _local_3 = ITabContextWindow(_arg_2).selector.getSelected().name;
                if (_local_3 != _SafeStr_2781)
                {
                    resetUnseenCounters(_SafeStr_2781);
                    _SafeStr_1284.toggleInventoryPage(_local_3);
                };
            }
            else
            {
                if (_arg_1.type == "WME_CLICK")
                {
                    if (_arg_2.name == "header_button_close")
                    {
                        hideInventory();
                    };
                    if (_arg_2.name == "open_catalog_btn")
                    {
                        _SafeStr_1284.catalog.openCatalog();
                    };
                }
                else
                {
                    if (_arg_1.type == "WME_DOUBLE_CLICK")
                    {
                        if (_arg_2.name == "titlebar")
                        {
                            _SafeStr_2554.height = _SafeStr_2554.limits.minHeight;
                        };
                    };
                };
            };
        }

        public function updateUnseenFurniCount(_arg_1:int):void
        {
            if (!_SafeStr_2554)
            {
                return;
            };
            if (!_SafeStr_2785)
            {
                _SafeStr_2785 = createCounter("furni");
            };
            updateCounter(_SafeStr_2785, _arg_1);
            _SafeStr_1284.furniModel.updateView();
        }

        public function updateUnseenRentedFurniCount(_arg_1:int):void
        {
            if (!_SafeStr_2554)
            {
                return;
            };
            if (!_SafeStr_2786)
            {
                _SafeStr_2786 = createCounter("rentables");
            };
            updateCounter(_SafeStr_2786, _arg_1);
            _SafeStr_1284.furniModel.updateView();
        }

        public function updateUnseenPetsCount(_arg_1:int):void
        {
            if (!_SafeStr_2554)
            {
                return;
            };
            if (!_SafeStr_2788)
            {
                _SafeStr_2788 = createCounter("pets");
            };
            updateCounter(_SafeStr_2788, _arg_1);
            _SafeStr_1284.petsModel.updateView();
        }

        public function updateUnseenBadgeCount(_arg_1:int):void
        {
            if (!_SafeStr_2554)
            {
                return;
            };
            if (!_SafeStr_2787)
            {
                _SafeStr_2787 = createCounter("badges");
            };
            updateCounter(_SafeStr_2787, _arg_1);
            _SafeStr_1284.badgesModel.updateView();
        }

        public function updateUnseenBotCount(_arg_1:int):void
        {
            if (!_SafeStr_2554)
            {
                return;
            };
            if (!_SafeStr_2789)
            {
                _SafeStr_2789 = createCounter("bots");
            };
            updateCounter(_SafeStr_2789, _arg_1);
            _SafeStr_1284.botsModel.updateView();
        }

        public function getView(_arg_1:String):IWindowContainer
        {
            return (_SafeStr_2790[_arg_1] as IWindowContainer);
        }

        private function extractWindow(_arg_1:String):void
        {
            var _local_2:IWindow = mainContainer.getChildByName(_arg_1);
            if (_local_2)
            {
                _SafeStr_2790[_arg_1] = mainContainer.removeChild(_local_2);
            };
        }

        private function resetUnseenCounters(_arg_1:String):void
        {
            switch (_arg_1)
            {
                case "furni":
                    _SafeStr_1284.furniModel.resetUnseenItems();
                    return;
                case "rentables":
                    _SafeStr_1284.furniModel.resetUnseenItems();
                    return;
                case "pets":
                    _SafeStr_1284.petsModel.resetUnseenItems();
                    return;
                case "badges":
                    _SafeStr_1284.badgesModel.resetUnseenItems();
                    return;
                case "bots":
                    _SafeStr_1284.botsModel.resetUnseenItems();
                    return;
            };
        }

        private function setViewToCategory(_arg_1:String):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            if (_arg_1 == "")
            {
                return;
            };
            if (emptyContainer)
            {
                emptyContainer.visible = false;
            };
            if (loadingContainer)
            {
                loadingContainer.visible = false;
            };
            _SafeStr_1284.checkCategoryInitilization(_arg_1);
            if (mainContainer == null)
            {
                return;
            };
            mainContainer.removeChild(_SafeStr_2782);
            mainContainer.invalidate();
            var _local_2:IWindowContainer = _SafeStr_1284.getCategoryWindowContainer(_arg_1);
            if (_local_2 == null)
            {
                return;
            };
            _local_2.visible = true;
            mainContainer.addChild(_local_2);
            _local_2.height = mainContainer.height;
            _SafeStr_1284.updateView(_arg_1);
            _SafeStr_2782 = _local_2;
            _SafeStr_2781 = _arg_1;
            var _local_3:ITabContextWindow = (_SafeStr_2554.findChildByName("tabs") as ITabContextWindow);
            if (_local_3 == null)
            {
                return;
            };
            _local_3.selector.setSelected(_local_3.selector.getSelectableByName(_arg_1));
        }

        private function enableScaling():void
        {
            _SafeStr_2554.height = _SafeStr_2554.limits.minHeight;
            _SafeStr_2554.setParamFlag(0x10000, true);
            _SafeStr_2554.findChildByName("top_content").setParamFlag(0x0800, true);
        }

        private function disableScaling():void
        {
            _SafeStr_2554.height = _SafeStr_2554.limits.minHeight;
            _SafeStr_2554.setParamFlag(0x10000, false);
            _SafeStr_2554.findChildByName("top_content").setParamFlag(0x0800, false);
        }

        private function setSubViewToCategory(_arg_1:String):void
        {
            if (((_arg_1 == null) || (_arg_1 == "")))
            {
                return;
            };
            _SafeStr_1284.checkCategoryInitilization(_arg_1);
            var _local_2:IWindowContainer = (_SafeStr_2554.findChildByName("subContentArea") as IWindowContainer);
            while (_local_2.numChildren > 0)
            {
                _local_2.removeChildAt(0);
            };
            var _local_3:IWindowContainer = _SafeStr_1284.getCategorySubWindowContainer(_arg_1);
            if (_local_3 != null)
            {
                disableScaling();
                _local_2.visible = true;
                _local_3.visible = true;
                _local_2.height = _local_3.height;
                _local_2.addChild(_local_3);
            }
            else
            {
                enableScaling();
                _local_2.visible = false;
                _local_2.height = 0;
            };
            _local_2.y = (_SafeStr_2554.findChildByName("top_content").rectangle.bottom + 5);
            _SafeStr_2554.resizeToFitContent();
            if (_SafeStr_2554.parent != null)
            {
                if ((_SafeStr_2554.x + _SafeStr_2554.width) > _SafeStr_2554.parent.width)
                {
                    _SafeStr_2554.x = (_SafeStr_2554.parent.width - _SafeStr_2554.width);
                };
                if ((_SafeStr_2554.y + _SafeStr_2554.height) > _SafeStr_2554.parent.height)
                {
                    _SafeStr_2554.y = ((_SafeStr_2554.parent.height - _SafeStr_2554.height) * 0.5);
                };
                if (_SafeStr_2554.y < 0)
                {
                    _SafeStr_2554.y = 0;
                };
            };
            _SafeStr_2784 = _local_3;
            _SafeStr_2783 = _arg_1;
        }

        private function createCounter(_arg_1:String):IWindowContainer
        {
            var _local_3:IWindowContainer = _windowManager.createUnseenItemCounter();
            var _local_2:IWindowContainer = (_SafeStr_2554.findChildByName(_arg_1) as IWindowContainer);
            if (_local_2)
            {
                _local_2.addChild(_local_3);
                _local_3.x = ((_local_2.width - _local_3.width) - 3);
                _local_3.y = 3;
            };
            return (_local_3);
        }

        private function updateCounter(_arg_1:IWindowContainer, _arg_2:int):void
        {
            var _local_5:ILabelWindow;
            _arg_1.findChildByName("count").caption = _arg_2.toString();
            _arg_1.visible = (_arg_2 > 0);
            var _local_3:String = "";
            switch (_arg_1)
            {
                case _SafeStr_2789:
                    _local_3 = "bots";
                    break;
                case _SafeStr_2788:
                    _local_3 = "pets";
                    break;
                case _SafeStr_2787:
                    _local_3 = "badges";
                    break;
                case _SafeStr_2785:
                    _local_3 = "furni";
                    break;
                case _SafeStr_2786:
                    _local_3 = "rentables";
            };
            var _local_4:IWindowContainer = (_SafeStr_2554.findChildByName(_local_3) as IWindowContainer);
            if (_local_4)
            {
                _local_5 = (_local_4.getChildByTag("TITLE") as ILabelWindow);
                if (_local_5)
                {
                    if (_arg_1.visible)
                    {
                        _local_5.margins.right = (_arg_1.width + (2 * 3));
                    }
                    else
                    {
                        _local_5.margins.right = _local_5.margins.left;
                    };
                    _local_4.width = _local_5.width;
                    _arg_1.x = ((_local_4.width - _arg_1.width) - 3);
                };
            };
        }

        public function onHabboToolbarEvent(_arg_1:HabboToolbarEvent):void
        {
            if (_arg_1.iconId != "HTIE_ICON_INVENTORY")
            {
                return;
            };
            if (_arg_1.type == "HTE_TOOLBAR_CLICK")
            {
                if (_SafeStr_2781 == "pets")
                {
                    toggleCategoryView("pets");
                }
                else
                {
                    if (_SafeStr_2781 == "furni")
                    {
                        toggleCategoryView("furni");
                    }
                    else
                    {
                        if (_SafeStr_2781 == "rentables")
                        {
                            toggleCategoryView("rentables");
                        }
                        else
                        {
                            if (_SafeStr_2781 == "badges")
                            {
                                toggleCategoryView("badges");
                            }
                            else
                            {
                                if (_SafeStr_2781 == "bots")
                                {
                                    toggleCategoryView("bots");
                                }
                                else
                                {
                                    if (_SafeStr_1284 != null)
                                    {
                                        _SafeStr_1284.toggleInventoryPage("furni");
                                    };
                                };
                            };
                        };
                    };
                };
            };
        }


    }
}

