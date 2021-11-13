package com.sulake.habbo.inventory.furni
{
    import com.sulake.habbo.inventory.IInventoryView;
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.inventory.marketplace.MarketplaceModel;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.window.widgets.ILimitedItemPreviewOverlayWidget;
    import com.sulake.habbo.window.widgets.IRarityItemPreviewOverlayWidget;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.components._SafeStr_101;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.habbo.room.preview.RoomPreviewer;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.inventory.items.GroupItem;
    import com.sulake.habbo.inventory.items.FurnitureItem;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.room.utils.Vector3d;
    import flash.filters.GlowFilter;
    import com.sulake.habbo.room.object.data.MapStuffData;
    import com.sulake.core.window.components.IDropMenuWindow;
    import com.sulake.core.window.components.IItemGridWindow;
    import com.sulake.habbo.window.widgets.IRoomPreviewerWidget;
    import com.sulake.core.window.components.IInteractiveWindow;
    import com.sulake.habbo.inventory.items.IFurnitureItem;
    import com.sulake.core.window.events.WindowKeyboardEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.utils.FriendlyTime;

    public class FurniView implements IInventoryView, IUpdateReceiver
    {

        private static const STATE_NULL:int = 0;
        private static const STATE_INITIALIZING:int = 1;
        private static const STATE_EMPTY:int = 2;
        private static const STATE_CONTENT:int = 3;
        private static const UNSEEN_SYMBOL_MARGIN:int = 4;

        private var _SafeStr_2756:String = "";
        private var _windowManager:IHabboWindowManager;
        private var _SafeStr_1354:IAssetLibrary;
        private var _SafeStr_570:IWindowContainer;
        private var _grid:FurniGridView;
        private var _SafeStr_1275:FurniModel;
        private var _marketplace:MarketplaceModel;
        private var _roomEngine:IRoomEngine;
        private var _disposed:Boolean = false;
        private var _SafeStr_2727:int = 0;
        private var _SafeStr_2757:ILimitedItemPreviewOverlayWidget;
        private var _SafeStr_2758:IRarityItemPreviewOverlayWidget;
        private var _SafeStr_2759:IItemListWindow;
        private var _placeInRoomButton:_SafeStr_101;
        private var _gotoRoomButton:_SafeStr_101;
        private var _sellInMarketplaceButton:_SafeStr_101;
        private var _offerInTradingButton:_SafeStr_101;
        private var _offerInTradingCountButton:ITextFieldWindow;
        private var _useFurnitureButton:_SafeStr_101;
        private var _extendRentPeriodButton:_SafeStr_101;
        private var _buyRentedItemButton:_SafeStr_101;
        private var _isInitialized:Boolean = false;
        private var _SafeStr_515:RoomPreviewer;
        private var _rentablesPlacementSelection:int = 0;

        public function FurniView(_arg_1:FurniModel, _arg_2:MarketplaceModel, _arg_3:IHabboWindowManager, _arg_4:IAssetLibrary, _arg_5:IRoomEngine)
        {
            _SafeStr_1275 = _arg_1;
            _marketplace = _arg_2;
            _SafeStr_1354 = _arg_4;
            _windowManager = _arg_3;
            _roomEngine = _arg_5;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get isVisible():Boolean
        {
            return (((_SafeStr_570) && (!(_SafeStr_570.parent == null))) && (_SafeStr_570.visible));
        }

        public function get isInitialized():Boolean
        {
            return (_isInitialized);
        }

        public function get currentPageItems():Vector.<GroupItem>
        {
            return ((_grid) ? _grid.currentPageItems : null);
        }

        public function get grid():FurniGridView
        {
            return (_grid);
        }

        public function dispose():void
        {
            if (!_disposed)
            {
                if (((_SafeStr_1275) && (_SafeStr_1275.controller)))
                {
                    _SafeStr_1275.controller.removeUpdateReceiver(this);
                };
                _SafeStr_1275 = null;
                _marketplace = null;
                _SafeStr_1354 = null;
                _windowManager = null;
                _roomEngine = null;
                if (_SafeStr_2757)
                {
                    _SafeStr_2757.dispose();
                    _SafeStr_2757 = null;
                };
                if (_SafeStr_2758)
                {
                    _SafeStr_2758.dispose();
                    _SafeStr_2758 = null;
                };
                if (_SafeStr_570)
                {
                    _SafeStr_570.dispose();
                    _SafeStr_570 = null;
                };
                _disposed = true;
            };
        }

        public function getWindowContainer():IWindowContainer
        {
            if (!_isInitialized)
            {
                init();
            };
            if (_SafeStr_570 == null)
            {
                return (null);
            };
            if (_SafeStr_570.disposed)
            {
                return (null);
            };
            updateActionButtons(false);
            return (_SafeStr_570);
        }

        public function setViewToState():void
        {
            var _local_1:int;
            if (!_SafeStr_1275.isListInited())
            {
                _local_1 = 1;
            }
            else
            {
                if (((!(_SafeStr_1275.furniData)) || (_SafeStr_1275.furniData.length == 0)))
                {
                    _local_1 = 2;
                }
                else
                {
                    _local_1 = 3;
                };
            };
            if (_SafeStr_2727 == _local_1)
            {
                return;
            };
            _SafeStr_2727 = _local_1;
            updateContainerVisibility();
        }

        public function clearViews():void
        {
            updateActionView();
        }

        public function getFirstThumb():IWindowContainer
        {
            return ((_grid != null) ? _grid.getFirstThumb() : null);
        }

        public function updateActionView():void
        {
            var _local_4:FurnitureItem;
            var _local_14:IStaticBitmapWrapperWindow;
            var _local_18:ITextWindow;
            var _local_16:IRegionWindow;
            var _local_5:String;
            var _local_10:String;
            var _local_19:String;
            var _local_8:String;
            var _local_17:String;
            var _local_3:String;
            var _local_20:String;
            var _local_12:IFurnitureData;
            var _local_9:int;
            var _local_1:IWidgetWindow;
            var _local_11:IWidgetWindow;
            var _local_13:String;
            if (_SafeStr_570 == null)
            {
                return;
            };
            if (_SafeStr_570.disposed)
            {
                return;
            };
            updateContainerVisibility();
            var _local_6:Boolean;
            var _local_7:GroupItem = _SafeStr_1275.getSelectedItem();
            if (((!(_local_7 == null)) && (!(_local_7.peek() == null))))
            {
                if (_local_7.selectedItemIndex >= 0)
                {
                    _local_4 = _local_7.getAt(_local_7.selectedItemIndex);
                    if (!_local_4)
                    {
                        _local_4 = _local_7.peek();
                    };
                }
                else
                {
                    _local_4 = _local_7.peek();
                };
                _local_6 = true;
                _local_5 = _roomEngine.getWallItemType(_local_4.type);
                var _local_21:Boolean = ((_local_5) && (!(_local_5.indexOf("external_image_wallitem") == -1)));
                _SafeStr_570.findChildByName("viewItemButton").visible = _local_21;
                _SafeStr_570.findChildByName("nextItemButton").visible = _local_21;
                _SafeStr_570.findChildByName("furni_preview_widget").visible = true;
                _local_10 = _roomEngine.getRoomStringValue(_roomEngine.activeRoomId, "room_wall_type");
                _local_19 = _roomEngine.getRoomStringValue(_roomEngine.activeRoomId, "room_floor_type");
                _local_8 = _roomEngine.getRoomStringValue(_roomEngine.activeRoomId, "room_landscape_type");
                _local_10 = (((_local_10) && (_local_10.length > 0)) ? _local_10 : "101");
                _local_19 = (((_local_19) && (_local_19.length > 0)) ? _local_19 : "101");
                _local_8 = (((_local_8) && (_local_8.length > 0)) ? _local_8 : "1.1");
                _SafeStr_515.reset(false);
                _SafeStr_515.updateObjectRoom(_local_19, _local_10, _local_8);
                if ((((_local_4.category == 2) || (_local_4.category == 3)) || (_local_4.category == 4)))
                {
                    _SafeStr_515.updateRoomWallsAndFloorVisibility(true, true);
                    _local_17 = ((_local_4.category == 3) ? _local_7.stuffData.getLegacyString() : _local_19);
                    _local_3 = ((_local_4.category == 2) ? _local_7.stuffData.getLegacyString() : _local_10);
                    _local_20 = ((_local_4.category == 4) ? _local_7.stuffData.getLegacyString() : _local_8);
                    _SafeStr_515.updateObjectRoom(_local_17, _local_3, _local_20);
                    if (_local_4.category == 4)
                    {
                        _local_12 = _SafeStr_1275.controller.getFurnitureDataByName("ads_twi_windw", "i");
                        _SafeStr_515.addWallItemIntoRoom(_local_12.id, new Vector3d(90, 0, 0), _local_12.customParams);
                    };
                }
                else
                {
                    if (_local_7.isWallItem)
                    {
                        _SafeStr_515.updateRoomWallsAndFloorVisibility(true, true);
                        _SafeStr_515.addWallItemIntoRoom(_local_7.type, new Vector3d(90, 0, 0), _local_4.stuffData.getLegacyString());
                    }
                    else
                    {
                        _SafeStr_515.updateRoomWallsAndFloorVisibility(false, true);
                        _SafeStr_515.addFurnitureIntoRoom(_local_7.type, new Vector3d(90, 0, 0), _local_7.stuffData, _local_7.extra.toString());
                    };
                };
                _local_14 = (_SafeStr_570.findChildByName("tradeable_icon") as IStaticBitmapWrapperWindow);
                _local_18 = (_SafeStr_570.findChildByName("tradeable_number") as ITextWindow);
                _local_16 = (_SafeStr_570.findChildByName("tradeable_info_region") as IRegionWindow);
                if ((((!(_local_14 == null)) && (!(_local_18 == null))) && (!(_local_16 == null))))
                {
                    _local_9 = _local_7.getTradeableCount();
                    if (_local_9 == 0)
                    {
                        _local_14.assetUri = "inventory_furni_no_trade_icon";
                        _local_18.visible = false;
                        _local_16.toolTipCaption = "${inventory.furni.preview.not_tradeable}";
                        _local_18.filters = [];
                    }
                    else
                    {
                        _local_14.assetUri = "inventory_furni_trade_icon";
                        _local_18.visible = true;
                        _local_18.text = String(_local_9);
                        _local_16.toolTipCaption = "${inventory.furni.preview.tradeable_amount}";
                        _local_18.filters = [new GlowFilter(0xFFFFFF, 1, 3, 3, 300)];
                    };
                };
                _local_1 = IWidgetWindow(_SafeStr_570.findChildByName("unique_limited_item_overlay_widget"));
                if (((_local_4.stuffData) && (_local_4.stuffData.uniqueSerialNumber > 0)))
                {
                    if (_SafeStr_2757 == null)
                    {
                        _SafeStr_2757 = ILimitedItemPreviewOverlayWidget(_local_1.widget);
                    };
                    _SafeStr_2757.serialNumber = _local_4.stuffData.uniqueSerialNumber;
                    _SafeStr_2757.seriesSize = _local_4.stuffData.uniqueSeriesSize;
                    _local_1.visible = true;
                }
                else
                {
                    _local_1.visible = false;
                };
                _local_11 = IWidgetWindow(_SafeStr_570.findChildByName("rarity_item_overlay_widget"));
                if (((_local_4.stuffData) && (_local_4.stuffData.rarityLevel >= 0)))
                {
                    if (_SafeStr_2758 == null)
                    {
                        _SafeStr_2758 = IRarityItemPreviewOverlayWidget(_local_11.widget);
                    };
                    _SafeStr_2758.rarityLevel = _local_4.stuffData.rarityLevel;
                    _local_11.visible = true;
                }
                else
                {
                    _local_11.visible = false;
                };
            }
            else
            {
                _local_21 = false;
                _SafeStr_570.findChildByName("viewItemButton").visible = _local_21;
                _SafeStr_570.findChildByName("nextItemButton").visible = _local_21;
                _SafeStr_570.findChildByName("furni_preview_widget").visible = _local_21;
                _local_14 = (_SafeStr_570.findChildByName("tradeable_icon") as IStaticBitmapWrapperWindow);
                _local_18 = (_SafeStr_570.findChildByName("tradeable_number") as ITextWindow);
                _local_16 = (_SafeStr_570.findChildByName("tradeable_info_region") as IRegionWindow);
                if ((((_local_14) && (_local_18)) && (_local_16)))
                {
                    _local_14.assetUri = "";
                    _local_18.visible = false;
                };
            };
            var _local_2:Boolean = _SafeStr_1275.isTradingOpen;
            updateActionButtons(_local_6);
            if (((_local_7) && (_local_4)))
            {
                _SafeStr_570.findChildByName("furni_name").caption = _local_7.name;
                if (((_local_4) && (_roomEngine.getWallItemType(_local_4.type) == "external_image_wallitem")))
                {
                    _SafeStr_570.findChildByName("furni_description").caption = _local_4.stuffData.getJSONValue("m");
                }
                else
                {
                    _SafeStr_570.findChildByName("furni_description").caption = _local_7.description;
                };
            }
            else
            {
                _SafeStr_570.findChildByName("furni_name").caption = "";
                _SafeStr_570.findChildByName("furni_description").caption = "";
            };
            var _local_15:ITextWindow = (_SafeStr_570.findChildByName("furni_extra") as ITextWindow);
            if (_local_15 != null)
            {
                if ((((!(_local_4 == null)) && (!(_local_4.stuffData == null))) && (_local_4.stuffData.rarityLevel >= 0)))
                {
                    _local_13 = (_local_4.stuffData as MapStuffData).getValue("rarity");
                    if (_local_13 != null)
                    {
                        _windowManager.registerLocalizationParameter("inventory.rarity", "rarity", String(_local_4.stuffData.rarityLevel));
                        _local_15.text = _SafeStr_1275.localization.getLocalization("inventory.rarity");
                        _local_15.visible = true;
                    };
                }
                else
                {
                    _local_15.text = "";
                };
            };
            updateRentedItem();
        }

        public function displayItemInfo(_arg_1:GroupItem):void
        {
            if (_SafeStr_570 == null)
            {
                return;
            };
            if (_SafeStr_570.disposed)
            {
                return;
            };
            var _local_2:FurnitureItem = _arg_1.peek();
            if (_local_2.isWallItem)
            {
                _SafeStr_515.addWallItemIntoRoom(_local_2.type, new Vector3d(90, 0, 0), _local_2.stuffData.getLegacyString());
            }
            else
            {
                _SafeStr_515.addFurnitureIntoRoom(_local_2.type, new Vector3d(90, 0, 0), _local_2.stuffData);
            };
            _placeInRoomButton.disable();
            _offerInTradingButton.disable();
            _offerInTradingCountButton.disable();
        }

        public function addItems(_arg_1:Vector.<GroupItem>):void
        {
            if (_grid)
            {
                _grid.setItems(_arg_1);
            };
        }

        public function updateGridFilters():void
        {
            if (((_SafeStr_570 == null) || (_SafeStr_570.disposed)))
            {
                return;
            };
            var _local_4:IDropMenuWindow = (_SafeStr_570.findChildByName("filter.options") as IDropMenuWindow);
            var _local_2:IDropMenuWindow = (_SafeStr_570.findChildByName("placement.options") as IDropMenuWindow);
            var _local_3:String = _SafeStr_570.findChildByName("filter").caption;
            var _local_1:String = _local_4.enumerateSelection()[_local_4.selection];
            _grid.setFilter(_local_4.selection, _local_1, _SafeStr_1275.showingRentedFurni, _local_3, _local_2.selection);
        }

        public function resetFilters(_arg_1:String):void
        {
            var _local_3:IDropMenuWindow = (_SafeStr_570.findChildByName("filter.options") as IDropMenuWindow);
            var _local_2:IDropMenuWindow = (_SafeStr_570.findChildByName("placement.options") as IDropMenuWindow);
            _local_3.selection = 0;
            switch (_arg_1)
            {
                case "furni":
                    _local_2.selection = ((_local_2.numMenuItems > 2) ? 2 : 0);
                    _local_2.disable();
                    break;
                case "rentables":
                    _local_2.selection = _rentablesPlacementSelection;
                    _local_2.enable();
            };
            if (_SafeStr_2756 != _arg_1)
            {
                _SafeStr_570.findChildByName("filter").caption = "";
                _SafeStr_570.findChildByName("clear_filter_button").visible = false;
            };
            _SafeStr_2756 = _arg_1;
            updateGridFilters();
        }

        private function init():void
        {
            _SafeStr_570 = _SafeStr_1275.controller.view.getView("furni");
            _SafeStr_570.visible = false;
            _SafeStr_570.procedure = windowEventProc;
            var _local_1:IItemGridWindow = (_SafeStr_570.findChildByName("item_grid") as IItemGridWindow);
            var _local_3:IItemListWindow = (_SafeStr_570.findChildByName("item_grid_pages") as IItemListWindow);
            _grid = new FurniGridView(_local_1, _local_3);
            populateFilterOptions();
            _SafeStr_2759 = (_SafeStr_570.findChildByName("preview_element_list") as IItemListWindow);
            _placeInRoomButton = (_SafeStr_2759.removeListItem(_SafeStr_2759.getListItemByName("placeinroom_btn")) as _SafeStr_101);
            _extendRentPeriodButton = (_SafeStr_2759.removeListItem(_SafeStr_2759.getListItemByName("extendrent_btn")) as _SafeStr_101);
            _buyRentedItemButton = (_SafeStr_2759.removeListItem(_SafeStr_2759.getListItemByName("buyrenteditem_btn")) as _SafeStr_101);
            _gotoRoomButton = (_SafeStr_2759.removeListItem(_SafeStr_2759.getListItemByName("goto_room_btn")) as _SafeStr_101);
            _useFurnitureButton = (_SafeStr_2759.removeListItem(_SafeStr_2759.getListItemByName("use_btn")) as _SafeStr_101);
            _offerInTradingCountButton = (_SafeStr_2759.removeListItem(_SafeStr_2759.getListItemByName("offertotrade_cnt")) as ITextFieldWindow);
            _offerInTradingButton = (_SafeStr_2759.removeListItem(_SafeStr_2759.getListItemByName("offertotrade_btn")) as _SafeStr_101);
            _sellInMarketplaceButton = (_SafeStr_2759.removeListItem(_SafeStr_2759.getListItemByName("sell_btn")) as _SafeStr_101);
            var _local_2:IRoomPreviewerWidget = ((_SafeStr_570.findChildByName("furni_preview_widget") as IWidgetWindow).widget as IRoomPreviewerWidget);
            _SafeStr_515 = _local_2.roomPreviewer;
            _SafeStr_1275.controller.registerUpdateReceiver(this, 1);
            setViewToState();
            _isInitialized = true;
        }

        private function fixPreviewHeightInTrading():void
        {
            var _local_1:IWidgetWindow = (_SafeStr_570.findChildByName("furni_preview_widget") as IWidgetWindow);
            var _local_2:IRoomPreviewerWidget = ((_SafeStr_570.findChildByName("furni_preview_widget") as IWidgetWindow).widget as IRoomPreviewerWidget);
            _local_2.roomPreviewer.modifyRoomCanvas(_local_1.width, _local_1.height);
        }

        private function updateActionButtons(_arg_1:Boolean):void
        {
            if (_SafeStr_1275.isTradingOpen)
            {
                fixPreviewHeightInTrading();
            };
            removeButtons();
            var _local_2:Boolean = _SafeStr_1275.isTradingOpen;
            var _local_6:GroupItem = _SafeStr_1275.getSelectedItem();
            var _local_3:FurnitureItem;
            if (_local_6)
            {
                _local_3 = _local_6.peek();
            };
            if (_local_3 == null)
            {
                return;
            };
            var _local_10:IFurnitureData = _SafeStr_1275.controller.getFurnitureData(_local_3.type, ((_local_3.isWallItem) ? "i" : "s"));
            var _local_9:Boolean = ((((((_arg_1) && (_marketplace)) && (_marketplace.isEnabled)) && (_local_3.sellable)) && (!(_SafeStr_1275.controller.sessionData.isAccountSafetyLocked()))) && (!(_local_2)));
            var _local_5:Boolean = (((_SafeStr_1275.isPrivateRoom) && (_arg_1)) && (((((_local_3.category == 16) || (_local_3.category == 14)) || (_local_3.category == 15)) || (_local_3.category == 13)) || (_local_3.category == 20)));
            var _local_4:Boolean = true;
            if (_local_3.isRented)
            {
                if (_local_3.flatId > -1)
                {
                    _local_4 = false;
                };
            };
            var _local_11:Boolean = (_local_3.flatId > -1);
            var _local_7:Boolean = ((((_local_3.isRented) && (_local_4)) && (_local_10)) && (_local_10.rentCouldBeUsedForBuyout));
            var _local_8:Boolean = ((((_local_3.isRented) && (_local_4)) && (_local_10)) && (_local_10.purchaseCouldBeUsedForBuyout));
            if (((_local_10) && (_local_10.isExternalImageType)))
            {
                _local_9 = false;
            };
            updateButtonAvailability(_placeInRoomButton, ((!(_local_2)) && (_local_4)));
            updateButtonAvailability(_extendRentPeriodButton, ((!(_local_2)) && (_local_7)));
            updateButtonAvailability(_buyRentedItemButton, ((!(_local_2)) && (_local_8)));
            updateButtonAvailability(_gotoRoomButton, ((!(_local_2)) && (_local_11)));
            updateButtonAvailability(_offerInTradingCountButton, ((_local_2) && (_SafeStr_1275.controller.getBoolean("multi.item.trading.enabled"))));
            updateButtonAvailability(_offerInTradingButton, _local_2);
            updateButtonAvailability(_sellInMarketplaceButton, _local_9);
            updateButtonAvailability(_useFurnitureButton, _local_5);
            if (((_arg_1) && (_SafeStr_1275.isPrivateRoom)))
            {
                _placeInRoomButton.enable();
            }
            else
            {
                _placeInRoomButton.disable();
            };
            if (((((_arg_1) && (!(_local_6 == null))) && (!(_local_3 == null))) && (_SafeStr_1275.canUserOfferToTrade())))
            {
                if (((_local_6.getUnlockedCount()) && (_local_3.tradeable)))
                {
                    _offerInTradingButton.enable();
                    _offerInTradingCountButton.enable();
                }
                else
                {
                    _offerInTradingButton.disable();
                    _offerInTradingCountButton.disable();
                };
            }
            else
            {
                _offerInTradingButton.disable();
                _offerInTradingCountButton.disable();
            };
        }

        private function updateButtonAvailability(_arg_1:IInteractiveWindow, _arg_2:Boolean):void
        {
            if (_SafeStr_2759.getListItemByName(_arg_1.name) == null)
            {
                if (_arg_2)
                {
                    _SafeStr_2759.addListItem(_arg_1);
                };
            }
            else
            {
                if (!_arg_2)
                {
                    _SafeStr_2759.removeListItem(_arg_1);
                };
            };
        }

        private function removeButtons():void
        {
            _SafeStr_2759.removeListItem(_placeInRoomButton);
            _SafeStr_2759.removeListItem(_extendRentPeriodButton);
            _SafeStr_2759.removeListItem(_buyRentedItemButton);
            _SafeStr_2759.removeListItem(_gotoRoomButton);
            _SafeStr_2759.removeListItem(_useFurnitureButton);
            _SafeStr_2759.removeListItem(_offerInTradingCountButton);
            _SafeStr_2759.removeListItem(_offerInTradingButton);
            _SafeStr_2759.removeListItem(_sellInMarketplaceButton);
        }

        private function updateContainerVisibility():void
        {
            if (!_isInitialized)
            {
                return;
            };
            if (((!(_SafeStr_1275.controller.currentCategoryId == "furni")) && (!(_SafeStr_1275.controller.currentCategoryId == "rentables"))))
            {
                return;
            };
            var _local_1:IWindowContainer = _SafeStr_1275.controller.view.loadingContainer;
            var _local_4:IWindowContainer = _SafeStr_1275.controller.view.emptyContainer;
            var _local_5:IWindowContainer = (_SafeStr_570.findChildByName("grid_container") as IWindowContainer);
            var _local_2:IWindowContainer = (_SafeStr_570.findChildByName("preview_container") as IWindowContainer);
            var _local_3:IWindowContainer = (_SafeStr_570.findChildByName("options_container") as IWindowContainer);
            switch (_SafeStr_2727)
            {
                case 1:
                    if (_local_1)
                    {
                        _local_1.visible = true;
                    };
                    if (_local_4)
                    {
                        _local_4.visible = false;
                    };
                    _local_5.visible = false;
                    _local_2.visible = false;
                    _local_3.visible = false;
                    return;
                case 2:
                    if (_local_1)
                    {
                        _local_1.visible = false;
                    };
                    if (_local_4)
                    {
                        _local_4.visible = true;
                    };
                    _local_5.visible = false;
                    _local_2.visible = false;
                    _local_3.visible = false;
                    return;
                case 3:
                    if (_local_1)
                    {
                        _local_1.visible = false;
                    };
                    if (_local_4)
                    {
                        _local_4.visible = false;
                    };
                    _local_5.visible = true;
                    _local_2.visible = true;
                    _local_3.visible = true;
                default:
            };
        }

        private function showNextPreviewItem():void
        {
            _SafeStr_1275.getSelectedItem().selectedItemIndex++;
            updateActionView();
        }

        private function windowEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_4:GroupItem = null;
            var _local_5:FurnitureItem;
            var _local_8:int;
            var _local_9:GroupItem;
            var _local_3:IFurnitureItem;
            var _local_6:WindowKeyboardEvent;
            var _local_7:IDropMenuWindow;
            if (_arg_1.type == "WME_CLICK")
            {
                switch (_arg_2.name)
                {
                    case "placeinroom_btn":
                    case "furni_preview_region":
                        if (!_SafeStr_1275.isTradingOpen)
                        {
                            _SafeStr_1275.requestSelectedFurniPlacement(false);
                        };
                        break;
                    case "nextItemButton":
                        showNextPreviewItem();
                        break;
                    case "viewItemButton":
                        _local_4 = _SafeStr_1275.getSelectedItem();
                        _local_5 = _local_4.getAt(_local_4.selectedItemIndex);
                        if (!_local_5)
                        {
                            _local_5 = _local_4.peek();
                        };
                        _roomEngine.showUseProductSelection(_local_5.ref, _local_5.type, _local_5.id);
                        break;
                    case "goto_room_btn":
                        _SafeStr_1275.gotoRoom();
                        break;
                    case "offertotrade_btn":
                        _local_8 = Math.max(1, Number(_offerInTradingCountButton.caption));
                        if (_local_8 != Number(_offerInTradingCountButton.caption))
                        {
                            _offerInTradingCountButton.caption = String(_local_8);
                        };
                        _SafeStr_1275.requestSelectedFurniToTrading(_local_8, _offerInTradingCountButton);
                        break;
                    case "sell_btn":
                        _SafeStr_1275.requestSelectedFurniSelling();
                        break;
                    case "use_btn":
                        _SafeStr_1275.showUseProductSelection();
                        break;
                    case "extendrent_btn":
                        _SafeStr_1275.extendRentPeriod();
                        break;
                    case "buyrenteditem_btn":
                        _SafeStr_1275.buyRentedItem();
                        break;
                    case "clear_filter_button":
                        _SafeStr_570.findChildByName("filter").caption = "";
                        _arg_2.visible = false;
                        updateGridFilters();
                        break;
                    default:
                        _SafeStr_1275.cancelFurniInMover();
                };
            }
            else
            {
                if (_arg_1.type == "WME_DOWN")
                {
                    switch (_arg_2.name)
                    {
                        case "furni_preview_region":
                            _local_9 = _SafeStr_1275.getSelectedItem();
                            if (_local_9 == null)
                            {
                                return;
                            };
                            _local_3 = _local_9.peek();
                            if ((((_local_3.category == 2) || (_local_3.category == 3)) || (_local_3.category == 4)))
                            {
                                return;
                            };
                            if (!_SafeStr_1275.isTradingOpen)
                            {
                                _SafeStr_1275.requestSelectedFurniPlacement(false);
                            };
                    };
                }
                else
                {
                    if (_arg_1.type == "WKE_KEY_UP")
                    {
                        _local_6 = (_arg_1 as WindowKeyboardEvent);
                        switch (_arg_2.name)
                        {
                            case "filter":
                                _SafeStr_570.findChildByName("clear_filter_button").visible = (_arg_2.caption.length > 0);
                                if (_local_6.keyCode == 13)
                                {
                                    updateGridFilters();
                                };
                        };
                    };
                };
            };
            if (_arg_1.type == "WE_SELECTED")
            {
                switch (_arg_2.name)
                {
                    case "filter.options":
                        updateGridFilters();
                        return;
                    case "placement.options":
                        _local_7 = (_SafeStr_570.findChildByName("placement.options") as IDropMenuWindow);
                        if (_SafeStr_1275.controller.currentCategoryId == "rentables")
                        {
                            _rentablesPlacementSelection = _local_7.selection;
                        };
                        updateGridFilters();
                        return;
                };
            };
        }

        private function populateFilterOptions():void
        {
            var _local_3:IDropMenuWindow = (_SafeStr_570.findChildByName("filter.options") as IDropMenuWindow);
            var _local_1:Array = [];
            _local_1.push(_SafeStr_1275.controller.localization.getLocalization("inventory.filter.option.everything", "Everything"));
            _local_1.push(_SafeStr_1275.controller.localization.getLocalization("inventory.furni.tab.floor", "Floor"));
            _local_1.push(_SafeStr_1275.controller.localization.getLocalization("inventory.furni.tab.wall", "Wall"));
            _local_3.populate(_local_1);
            _local_3.selection = 0;
            var _local_2:IDropMenuWindow = (_SafeStr_570.findChildByName("placement.options") as IDropMenuWindow);
            _local_1 = [];
            _local_1.push(_SafeStr_1275.controller.localization.getLocalization("inventory.placement.option.anywhere", "Anywhere"));
            _local_1.push(_SafeStr_1275.controller.localization.getLocalization("inventory.placement.option.inroom", "In room"));
            _local_1.push(_SafeStr_1275.controller.localization.getLocalization("inventory.placement.option.notinroom", "Not in room"));
            _local_2.populate(_local_1);
            _local_2.selection = 2;
            _rentablesPlacementSelection = 2;
            _SafeStr_570.findChildByName("filter").caption = "";
            _SafeStr_570.findChildByName("items.shown").visible = false;
            _SafeStr_570.invalidate();
        }

        public function updateRentedItem():void
        {
            var _local_2:GroupItem = _SafeStr_1275.getSelectedItem();
            var _local_1:FurnitureItem;
            if (_local_2)
            {
                _local_1 = _local_2.peek();
            };
            if (_local_1 == null)
            {
                return;
            };
            if (!_local_1.isRented)
            {
                return;
            };
            var _local_3:IWindow = (_SafeStr_570.findChildByName("furni_extra") as ITextWindow);
            _local_3.visible = true;
            if (_local_1.hasRentPeriodStarted)
            {
                _SafeStr_1275.controller.localization.registerParameter("inventory.rent.expiration", "time", FriendlyTime.getFriendlyTime(_SafeStr_1275.controller.localization, _local_1.secondsToExpiration));
                _local_3.caption = _SafeStr_1275.controller.localization.getLocalization("inventory.rent.expiration");
            }
            else
            {
                _SafeStr_1275.controller.localization.registerParameter("inventory.rent.inactive", "time", FriendlyTime.getFriendlyTime(_SafeStr_1275.controller.localization, _local_1.secondsToExpiration));
                _local_3.caption = _SafeStr_1275.controller.localization.getLocalization("inventory.rent.inactive");
            };
        }

        public function update(_arg_1:uint):void
        {
            if (_SafeStr_515 != null)
            {
                _SafeStr_515.updatePreviewRoomView();
            };
        }


    }
}