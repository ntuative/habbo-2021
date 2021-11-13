package com.sulake.habbo.inventory.furni
{
    import com.sulake.habbo.inventory.IInventoryModel;
    import com.sulake.habbo.inventory.HabboInventory;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.inventory.items.GroupItem;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.sound.IHabboSoundManager;
    import flash.utils.Timer;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import flash.utils.Dictionary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.inventory.items.FurnitureItem;
    import com.sulake.habbo.inventory.marketplace.MarketplaceModel;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.habbo.communication.messages.incoming.inventory.furni.FurniData;
    import com.sulake.habbo.inventory.events.HabboInventoryItemAddedEvent;
    import com.sulake.core.utils.Map;
    import flash.display.BitmapData;
    import com.sulake.habbo.room.IStuffData;
    import com.sulake.habbo.inventory.items.CreditTradingItem;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.communication.messages.outgoing.inventory.furni.RequestFurniInventoryComposer;
    import com.sulake.habbo.communication.messages.outgoing.inventory.furni.RequestFurniInventoryWhenNotInRoomComposer;
    import com.sulake.habbo.inventory.trading.TradingModel;
    import com.sulake.habbo.inventory.IUnseenItemTracker;
    import com.sulake.habbo.inventory.items.IFurnitureItem;
    import com.sulake.habbo.room.object.data.LegacyStuffData;
    import com.sulake.habbo.communication.messages.outgoing.inventory.furni.RequestRoomPropertySet;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.habbo.communication.messages.outgoing.room.session.OpenFlatConnectionMessageComposer;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.habbo.room.events.RoomEngineObjectPlacedEvent;
    import flash.events.Event;
    import flash.events.TimerEvent;

    public class FurniModel implements IInventoryModel
    {

        private static const IMAGE_UPDATE_DELAY_MS:int = 100;

        private var _controller:HabboInventory;
        private var _SafeStr_570:FurniView;
        private var _furniData:Vector.<GroupItem>;
        private var _assets:IAssetLibrary;
        private var _windowManager:IHabboWindowManager;
        private var _roomEngine:IRoomEngine;
        private var _communication:IHabboCommunicationManager;
        private var _soundManager:IHabboSoundManager;
        private var _disposed:Boolean = false;
        private var _SafeStr_2752:int = -1;
        private var _SafeStr_539:Boolean;
        private var _SafeStr_2751:Timer;
        private var _SafeStr_2726:Boolean;
        private var _catalog:IHabboCatalog;
        private var _SafeStr_2753:Dictionary;
        private var _localization:IHabboLocalizationManager;
        private var _SafeStr_2754:Array;
        private var _showingRentedFurni:Boolean;
        private var _categorySelection:Dictionary;
        private var _SafeStr_826:String;
        private var _imageUpdateCumulativeTime:int = 0;
        private var _SafeStr_2755:FurnitureItem = null;
        private var _isInRoom:Boolean = false;

        public function FurniModel(_arg_1:HabboInventory, _arg_2:MarketplaceModel, _arg_3:IHabboWindowManager, _arg_4:IHabboCommunicationManager, _arg_5:IAssetLibrary, _arg_6:IRoomEngine, _arg_7:IHabboCatalog, _arg_8:IHabboSoundManager, _arg_9:IHabboLocalizationManager)
        {
            _controller = _arg_1;
            _communication = _arg_4;
            _windowManager = _arg_3;
            _assets = _arg_5;
            _roomEngine = _arg_6;
            _roomEngine.events.addEventListener("REOE_PLACED", onObjectPlaced);
            _catalog = _arg_7;
            _soundManager = _arg_8;
            _localization = _arg_9;
            _SafeStr_2753 = new Dictionary();
            _SafeStr_2754 = _controller.getProperty("catalog.preview.alignment.bottom").split(",");
            _SafeStr_2751 = new Timer(100);
            _SafeStr_2751.addEventListener("timer", onImageUpdateTimerEvent);
            _categorySelection = new Dictionary();
            _categorySelection["furni"] = null;
            _categorySelection["rentables"] = null;
            clearFurniList();
            _SafeStr_570 = new FurniView(this, _arg_2, _windowManager, _assets, _roomEngine);
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get controller():HabboInventory
        {
            return (_controller);
        }

        public function get localization():IHabboLocalizationManager
        {
            return (_localization);
        }

        public function get isTradingOpen():Boolean
        {
            return (_controller.getSubCategoryViewId() == "trading");
        }

        public function get isPrivateRoom():Boolean
        {
            if (((!(_controller)) || (!(_controller.roomSession))))
            {
                return (false);
            };
            return (_controller.roomSession.isPrivateRoom);
        }

        public function get furniData():Vector.<GroupItem>
        {
            return (_furniData);
        }

        public function get soundManager():IHabboSoundManager
        {
            return (_soundManager);
        }

        public function get showingRentedFurni():Boolean
        {
            return (_showingRentedFurni);
        }

        public function set categorySelection(_arg_1:GroupItem):void
        {
            _categorySelection[_SafeStr_826] = _arg_1;
        }

        public function dispose():void
        {
            if (!_disposed)
            {
                _controller = null;
                if (_furniData != null)
                {
                    _furniData = null;
                };
                if (_SafeStr_570 != null)
                {
                    _SafeStr_570.dispose();
                    _SafeStr_570 = null;
                };
                if (_roomEngine != null)
                {
                    if (_roomEngine.events != null)
                    {
                        _roomEngine.events.removeEventListener("REOE_PLACED", onObjectPlaced);
                    };
                    _roomEngine = null;
                };
                _communication = null;
                _assets = null;
                _windowManager = null;
                _catalog = null;
                _soundManager = null;
                _localization = null;
                if (_SafeStr_2751 != null)
                {
                    _SafeStr_2751.removeEventListener("timerComplete", onImageUpdateTimerEvent);
                    _SafeStr_2751.stop();
                    _SafeStr_2751 = null;
                };
                for each (var _local_1:IWindowContainer in _SafeStr_2753)
                {
                    if (_local_1 != null)
                    {
                        _local_1.dispose();
                    };
                };
                _SafeStr_2753 = null;
                _disposed = true;
            };
        }

        public function createItemWindow(_arg_1:String):IWindowContainer
        {
            var _local_4:IAsset;
            var _local_2:XmlAsset;
            var _local_3:XML;
            if (_SafeStr_2753[_arg_1] == null)
            {
                _local_4 = _assets.getAssetByName(_arg_1);
                _local_2 = XmlAsset(_local_4);
                _local_3 = XML(_local_2.content);
                _SafeStr_2753[_arg_1] = (_windowManager.buildFromXML(_local_3) as IWindowContainer);
            };
            return (_SafeStr_2753[_arg_1].clone());
        }

        public function insertFurniture(_arg_1:Map):void
        {
            var _local_2:FurnitureItem;
            var _local_4:FurniData;
            var _local_7:int;
            var _local_10:int;
            var _local_6:int;
            var _local_13:HabboInventoryItemAddedEvent;
            _controller.setInventoryCategoryInit("furni");
            _controller.setInventoryCategoryInit("rentables");
            var _local_11:Vector.<int> = getAllStripIds();
            var _local_9:Array = _arg_1.getKeys();
            var _local_3:Vector.<int> = new Vector.<int>(0);
            var _local_12:Vector.<int> = new Vector.<int>(0);
            _local_7 = 0;
            while (_local_7 < _local_9.length)
            {
                _local_6 = _local_9[_local_7];
                if (_local_11.indexOf(_local_6) == -1)
                {
                    _local_3.push(_local_6);
                };
                _local_7++;
            };
            for each (_local_10 in _local_11)
            {
                if (_local_9.indexOf(_local_10) == -1)
                {
                    _local_12.push(_local_10);
                };
            };
            var _local_8:Boolean = (_local_11.length == 0);
            for each (_local_10 in _local_12)
            {
                removeFurni(_local_10);
            };
            for each (_local_10 in _local_3)
            {
                _local_4 = FurniData(_arg_1.getValue(_local_10));
                _local_2 = new FurnitureItem(_local_4);
                addOrUpdateItem(_local_2, true);
            };
            if (!_local_8)
            {
                if (_local_3.length > 0)
                {
                    updateItemLocks();
                };
            };
            setListInitialized();
            _SafeStr_570.addItems(_furniData);
            if (_local_8)
            {
                selectFirstItem();
            }
            else
            {
                if (getSelectedItem() == null)
                {
                    selectFirstItem();
                };
            };
            setViewToState();
            initListImages();
            for each (var _local_5:int in _local_9)
            {
                if (_local_3.indexOf(_local_5) > -1)
                {
                    _local_13 = new HabboInventoryItemAddedEvent(_local_4.itemTypeId, _local_4.itemId, _local_4.category);
                    _controller.events.dispatchEvent(_local_13);
                };
            };
        }

        public function isListInited():Boolean
        {
            return (_SafeStr_2726);
        }

        public function setListInitialized():void
        {
            if (!_SafeStr_2726)
            {
                _SafeStr_2726 = true;
                setViewToState();
            };
        }

        public function createGroupItem(_arg_1:int, _arg_2:int, _arg_3:IStuffData, _arg_4:Number=NaN, _arg_5:Boolean=false):GroupItem
        {
            var _local_8:BitmapData;
            var _local_7:IAsset;
            if (_arg_2 == 2)
            {
                _local_7 = _windowManager.assets.getAssetByName("inventory_furni_icon_wallpaper");
                if (_local_7 != null)
                {
                    _local_8 = (_local_7.content as BitmapData).clone();
                };
            }
            else
            {
                if (_arg_2 == 3)
                {
                    _local_7 = _windowManager.assets.getAssetByName("inventory_furni_icon_floor");
                    if (_local_7 != null)
                    {
                        _local_8 = (_local_7.content as BitmapData).clone();
                    };
                }
                else
                {
                    if (_arg_2 == 4)
                    {
                        _local_7 = _windowManager.assets.getAssetByName("inventory_furni_icon_landscape");
                        if (_local_7 != null)
                        {
                            _local_8 = (_local_7.content as BitmapData).clone();
                        };
                    };
                };
            };
            var _local_9:String = "center";
            var _local_6:String = _roomEngine.getFurnitureType(_arg_1);
            if (_SafeStr_2754.indexOf(_local_6) > -1)
            {
                _local_9 = "bottom";
            };
            return (new GroupItem(this, _arg_1, _arg_2, _roomEngine, _arg_3, _arg_4, _local_8, _arg_5, _local_9));
        }

        public function createCreditGroupItem(_arg_1:int):GroupItem
        {
            return (new CreditTradingItem(this, _windowManager.assets, _roomEngine, _arg_1));
        }

        public function requestInitialization():void
        {
            var _local_1:IConnection = _communication.connection;
            if (_local_1 != null)
            {
                if (_isInRoom)
                {
                    _local_1.send(new RequestFurniInventoryComposer());
                }
                else
                {
                    _local_1.send(new RequestFurniInventoryWhenNotInRoomComposer());
                };
            };
        }

        public function categorySwitch(_arg_1:String):void
        {
            if (_controller.isVisible)
            {
                Logger.log(("FurniMode.categorySwitch: " + _arg_1));
                switch (_arg_1)
                {
                    case "furni":
                    case "rentables":
                        _SafeStr_826 = _arg_1;
                        _showingRentedFurni = (_SafeStr_826 == "rentables");
                        _SafeStr_570.resetFilters(_arg_1);
                        updateCategorySelection();
                        updateItemLocks();
                        return;
                };
            };
        }

        public function getWindowContainer():IWindowContainer
        {
            _controller.checkCategoryInitilization("marketplace");
            return (_SafeStr_570.getWindowContainer());
        }

        public function closingInventoryView():void
        {
            if (_SafeStr_570.isVisible)
            {
                resetUnseenItems();
            };
        }

        public function updateItemLocks():void
        {
            var _local_2:GroupItem;
            var _local_3:Array = [];
            var _local_1:TradingModel = _controller.tradingModel;
            if (_local_1 != null)
            {
                _local_3 = _local_3.concat(_local_1.getOwnItemIdsInTrade());
            };
            var _local_4:MarketplaceModel = _controller.marketplaceModel;
            if (((!(_local_4 == null)) && (!(_local_4.getOfferItem() == null))))
            {
                _local_3 = _local_3.concat([_local_4.getOfferItem().ref]);
            };
            if (_local_3.length == 0)
            {
                removeAllLocks();
                return;
            };
            for each (_local_2 in _furniData)
            {
                _local_2.updateLocks(_local_3);
            };
            _SafeStr_570.updateActionView();
        }

        public function addLockTo(_arg_1:int):void
        {
            var _local_2:GroupItem;
            for each (_local_2 in _furniData)
            {
                _local_2.addLockTo(_arg_1);
            };
            _SafeStr_570.updateActionView();
        }

        public function removeLockFrom(_arg_1:int):void
        {
            var _local_2:GroupItem;
            for each (_local_2 in _furniData)
            {
                _local_2.removeLockFrom(_arg_1);
            };
            _SafeStr_570.updateActionView();
        }

        public function clearFurniList():void
        {
            _furniData = new Vector.<GroupItem>(0);
            if (_SafeStr_570 != null)
            {
                _SafeStr_570.clearViews();
            };
        }

        public function removeUnseenFurniCounter(_arg_1:int):Boolean
        {
            var _local_2:Boolean;
            var _local_3:int;
            var _local_6:IUnseenItemTracker = _controller.unseenItemTracker;
            if (_local_6 == null)
            {
                return (false);
            };
            var _local_4:GroupItem = getItemById(_arg_1);
            if (_local_4 == null)
            {
                return (false);
            };
            if (_SafeStr_826 == "rentables")
            {
                _local_3 = 2;
            }
            else
            {
                _local_3 = 1;
            };
            var _local_5:Boolean = _controller.unseenItemTracker.isUnseen(_local_3, _arg_1);
            if (_local_5)
            {
                _local_2 = _local_6.removeUnseen(_local_3, _arg_1);
            };
            if (_local_2)
            {
                _local_6.resetCategoryIfEmpty(_local_3);
            };
            return (_local_2);
        }

        public function getItemWithStripId(_arg_1:int):GroupItem
        {
            var _local_2:IFurnitureItem;
            for each (var _local_3:GroupItem in _furniData)
            {
                _local_2 = _local_3.getItem(_arg_1);
                if (_local_2)
                {
                    return (_local_3);
                };
            };
            return (null);
        }

        public function getGroupItemByItemTypeId(_arg_1:int):GroupItem
        {
            for each (var _local_2:GroupItem in _furniData)
            {
                if (_local_2.type == _arg_1)
                {
                    return (_local_2);
                };
            };
            return (null);
        }

        public function addOrUpdateItem(_arg_1:FurnitureItem, _arg_2:Boolean):void
        {
            var _local_3:GroupItem;
            if (!_arg_1.groupable)
            {
                _local_3 = addOrUpdateNonGroupableItem(_arg_1, _arg_2);
            }
            else
            {
                _local_3 = addOrUpdateGroupableItem(_arg_1, _arg_2);
            };
            if (!_arg_2)
            {
                _local_3.hasUnseenItems = true;
            };
            if (_local_3.isSelected)
            {
                _SafeStr_570.updateActionView();
            };
        }

        public function setViewToState():void
        {
            _SafeStr_570.setViewToState();
        }

        public function removeFurni(_arg_1:int):GroupItem
        {
            var _local_3:GroupItem;
            var _local_4:int;
            var _local_2:IFurnitureItem;
            _local_4 = 0;
            while (_local_4 < _furniData.length)
            {
                _local_3 = (_furniData[_local_4] as GroupItem);
                _local_2 = _local_3.remove(_arg_1);
                if (_local_2)
                {
                    if (_SafeStr_2752 == _local_2.ref)
                    {
                        cancelFurniInMover();
                        if (!requestSelectedFurniPlacement())
                        {
                            _controller.showView();
                        };
                    };
                    if (_local_3.getTotalCount() <= 0)
                    {
                        _furniData.splice(_local_4, 1);
                        if (((_SafeStr_570) && (_SafeStr_570.grid)))
                        {
                            _SafeStr_570.grid.itemWasUpdated(_local_3);
                        };
                        if (_local_3.isSelected)
                        {
                            selectFirstItem();
                        };
                        _local_3.dispose();
                    }
                    else
                    {
                        _SafeStr_570.updateActionView();
                    };
                    _SafeStr_570.setViewToState();
                    return (_local_3);
                };
                _local_4++;
            };
            return (null);
        }

        public function updatePostItCount(_arg_1:int, _arg_2:int):void
        {
            var _local_3:FurnitureItem;
            var _local_5:LegacyStuffData;
            for each (var _local_4:GroupItem in _furniData)
            {
                _local_3 = (_local_4.getItem(_arg_1) as FurnitureItem);
                if (_local_3 != null)
                {
                    _local_5 = (_local_3.stuffData as LegacyStuffData);
                    _local_5.setString(String(_arg_2));
                    _local_3.stuffData = _local_5;
                    _local_4.replaceItem(_arg_1, _local_3);
                };
            };
        }

        public function selectFirstItem():void
        {
            var _local_2:IWindowContainer = _SafeStr_570.getFirstThumb();
            if (_local_2 == null)
            {
                return;
            };
            for each (var _local_1:GroupItem in _furniData)
            {
                if (_local_1.window == _local_2)
                {
                    _local_1.isSelected = true;
                    _local_1.selectedItemIndex = -1;
                    break;
                };
            };
            _SafeStr_570.updateActionView();
        }

        public function displayItemInfo(_arg_1:GroupItem):void
        {
            if (((_SafeStr_570) && (!(_SafeStr_570.disposed))))
            {
                _SafeStr_570.displayItemInfo(_arg_1);
            };
        }

        public function getSelectedItem():GroupItem
        {
            for each (var _local_1:GroupItem in _furniData)
            {
                if (_local_1.isSelected)
                {
                    return (_local_1);
                };
            };
            return (null);
        }

        public function removeSelections():void
        {
            for each (var _local_1:GroupItem in _furniData)
            {
                _local_1.isSelected = false;
            };
        }

        public function canUserOfferToTrade():Boolean
        {
            return (_controller.canUserOfferToTrade());
        }

        public function removeAllLocks():void
        {
            for each (var _local_1:GroupItem in _furniData)
            {
                _local_1.removeAllLocks();
            };
            if (_SafeStr_570 != null)
            {
                _SafeStr_570.updateActionView();
            };
        }

        public function cancelFurniInMover():void
        {
            if (_SafeStr_2752 > -1)
            {
                _roomEngine.cancelRoomObjectInsert();
                _SafeStr_539 = false;
                _SafeStr_2752 = -1;
            };
        }

        public function requestSelectedFurniPlacement(_arg_1:Boolean=false):Boolean
        {
            var _local_2:FurnitureItem;
            var _local_3:GroupItem = getSelectedItem();
            if (_local_3 == null)
            {
                return (false);
            };
            if (_local_3.getUnlockedCount() == 0)
            {
                return (false);
            };
            if (_local_3.selectedItemIndex >= 0)
            {
                _local_2 = _local_3.getAt(_local_3.selectedItemIndex);
                if (!_local_2)
                {
                    _local_2 = _local_3.peek();
                };
            }
            else
            {
                _local_2 = _local_3.peek();
            };
            if (_local_2 == null)
            {
                return (false);
            };
            if (((_local_2.isRented) && (_local_2.flatId > -1)))
            {
                return (false);
            };
            if ((((_local_2.category == 3) || (_local_2.category == 2)) || (_local_2.category == 4)))
            {
                if (_arg_1)
                {
                    return (false);
                };
                _communication.connection.send(new RequestRoomPropertySet(_local_2.id));
            }
            else
            {
                requestSelectedFurniToMover(_local_2);
            };
            _SafeStr_570.updateActionView();
            return (true);
        }

        public function requestSelectedFurniToTrading(_arg_1:int=1, _arg_2:ITextFieldWindow=null):void
        {
            var itemsToTrade:int = _arg_1;
            var offerInTradingCount:ITextFieldWindow = _arg_2;
            var groupItem:GroupItem = getSelectedItem();
            if (groupItem == null)
            {
                return;
            };
            var itemsInTrade:Vector.<IFurnitureItem> = groupItem.getItemsForTrade(itemsToTrade);
            if (itemsInTrade.length == 0)
            {
                return;
            };
            var coreItem:IFurnitureItem;
            var itemIds:Vector.<int> = new Vector.<int>();
            for each (var furnitureItem:IFurnitureItem in itemsInTrade)
            {
                itemIds.push(furnitureItem.id);
                if (coreItem == null)
                {
                    coreItem = furnitureItem;
                };
            };
            if (coreItem == null)
            {
                return;
            };
            var trading:TradingModel = _controller.tradingModel;
            if (trading != null)
            {
                var ownItemCount:int = trading.getOwnItemIdsInTrade().length;
                if ((ownItemCount + itemIds.length) <= 1500)
                {
                    if (offerInTradingCount != null)
                    {
                        offerInTradingCount.caption = String(itemIds.length);
                    };
                    trading.requestAddItemsToTrading(itemIds, coreItem.isWallItem, coreItem.type, coreItem.category, coreItem.groupable, coreItem.stuffData);
                }
                else
                {
                    if (offerInTradingCount != null)
                    {
                        offerInTradingCount.caption = "1";
                    };
                    _windowManager.alert("${trading.items.too_many_items.title}", "${trading.items.too_many_items.desc}", 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
                    {
                        _arg_1.dispose();
                    });
                };
            }
            else
            {
                if (offerInTradingCount != null)
                {
                    offerInTradingCount.caption = "1";
                };
            };
            _SafeStr_570.updateActionView();
        }

        public function gotoRoom():void
        {
            var _local_2:GroupItem = getSelectedItem();
            if (_local_2 == null)
            {
                return;
            };
            var _local_1:FurnitureItem = _local_2.peek();
            if (_local_1 == null)
            {
                return;
            };
            if (_communication == null)
            {
                return;
            };
            var _local_3:IConnection = _communication.connection;
            if (_local_3 == null)
            {
                return;
            };
            _local_3.send(new OpenFlatConnectionMessageComposer(_local_1.flatId));
            _SafeStr_2755 = _local_1;
        }

        public function requestSelectedFurniSelling():void
        {
            var _local_2:GroupItem = getSelectedItem();
            if (_local_2 == null)
            {
                return;
            };
            var _local_1:FurnitureItem = _local_2.getOneForTrade();
            if (_local_1 == null)
            {
                return;
            };
            var _local_3:MarketplaceModel = _controller.marketplaceModel;
            if (_local_3 == null)
            {
                return;
            };
            _local_3.startOfferMaking(_local_1);
        }

        public function requestCurrentActionOnSelection():void
        {
            if (isTradingOpen)
            {
                requestSelectedFurniToTrading();
            }
            else
            {
                requestSelectedFurniPlacement(false);
            };
        }

        public function requestClose():void
        {
            _controller.closeView();
        }

        public function showUseProductSelection():void
        {
            var _local_1:IFurnitureItem;
            var _local_2:GroupItem = getSelectedItem();
            if (((!(_local_2 == null)) && (!(_local_2.peek() == null))))
            {
                _local_1 = _local_2.peek();
                if (_local_1)
                {
                    _roomEngine.showUseProductSelection(_local_1.ref, _local_1.type);
                };
            };
        }

        public function subCategorySwitch(_arg_1:String):void
        {
            switch (_arg_1)
            {
                case "trading":
                    cancelFurniInMover();
                    if (_SafeStr_570 != null)
                    {
                        _SafeStr_570.updateActionView();
                    };
                    return;
                case "empty":
                    removeAllLocks();
                    if (_SafeStr_570 != null)
                    {
                        _SafeStr_570.updateActionView();
                    };
                    return;
            };
        }

        public function updateActionView():void
        {
            _SafeStr_570.updateActionView();
        }

        public function updateView():void
        {
            if (_SafeStr_570 != null)
            {
                _SafeStr_570.updateActionView();
                _SafeStr_570.updateGridFilters();
            };
        }

        public function resetUnseenItems():void
        {
            if (!_SafeStr_570)
            {
                return;
            };
            var _local_2:Boolean;
            if (_SafeStr_826 == "rentables")
            {
                _controller.unseenItemTracker.resetCategory(2);
                _local_2 = true;
            }
            else
            {
                _controller.unseenItemTracker.resetCategory(1);
            };
            for each (var _local_1:GroupItem in _furniData)
            {
                if (((_local_1.hasUnseenItems) && (_local_1.isRented == _local_2)))
                {
                    _local_1.hasUnseenItems = false;
                };
            };
            _controller.updateUnseenItemCounts();
        }

        public function updateUnseenItemsThumbs():void
        {
            var _local_2:Array;
            var _local_3:GroupItem;
            var _local_4:int;
            if (((!(_SafeStr_570)) || (!(_SafeStr_570.grid))))
            {
                return;
            };
            var _local_1:Array = [];
            var _local_5:Array = _controller.unseenItemTracker.getIds(1);
            var _local_6:Array = _controller.unseenItemTracker.getIds(2);
            _local_1 = _local_1.concat(_local_5);
            _local_1 = _local_1.concat(_local_6);
            if (((!(_local_1)) || (_local_1.length == 0)))
            {
                return;
            };
            for each (_local_3 in _furniData)
            {
                _local_2 = _local_3.getFurniIds();
                for each (_local_4 in _local_2)
                {
                    if (_local_1.indexOf(_local_4) != -1)
                    {
                        _local_3.hasUnseenItems = true;
                        moveItemToTop(_local_3);
                        _SafeStr_570.grid.itemWasUpdated(_local_3);
                        break;
                    };
                };
            };
        }

        public function extendRentPeriod():void
        {
            var _local_2:GroupItem = getSelectedItem();
            if (_local_2 == null)
            {
                return;
            };
            var _local_1:FurnitureItem = _local_2.peek();
            if (_local_1 == null)
            {
                return;
            };
            var _local_3:IFurnitureData = _controller.getFurnitureData(_local_1.type, ((_local_1.isWallItem) ? "i" : "s"));
            _catalog.openRentConfirmationWindow(_local_3, false, -1, _local_1.id);
        }

        public function buyRentedItem():void
        {
            var _local_2:GroupItem = getSelectedItem();
            if (_local_2 == null)
            {
                return;
            };
            var _local_1:FurnitureItem = _local_2.peek();
            if (_local_1 == null)
            {
                return;
            };
            var _local_3:IFurnitureData = _controller.getFurnitureData(_local_1.type, ((_local_1.isWallItem) ? "i" : "s"));
            _catalog.openRentConfirmationWindow(_local_3, true, -1, _local_1.id);
        }

        private function addItemToTop(_arg_1:GroupItem):void
        {
            _furniData.unshift(_arg_1);
        }

        private function addItemToBottom(_arg_1:GroupItem):void
        {
            _furniData.push(_arg_1);
        }

        private function removeItem(_arg_1:GroupItem):void
        {
            var _local_2:int = _furniData.indexOf(_arg_1);
            if (_local_2 > -1)
            {
                _furniData.splice(_local_2, 1);
            };
        }

        private function moveItemToTop(_arg_1:GroupItem):void
        {
            removeItem(_arg_1);
            addItemToTop(_arg_1);
        }

        private function getAllStripIds():Vector.<int>
        {
            var _local_4:int;
            var _local_3:int;
            var _local_1:Vector.<int> = new Vector.<int>(0);
            for each (var _local_2:GroupItem in _furniData)
            {
                _local_4 = _local_2.getTotalCount();
                if (_local_2.category == 5)
                {
                    _local_4 = 1;
                };
                _local_3 = 0;
                while (_local_3 < _local_4)
                {
                    _local_1.push(_local_2.getAt(_local_3).id);
                    _local_3++;
                };
            };
            return (_local_1);
        }

        private function initListImages():void
        {
            var _local_1:GroupItem;
            if (!_SafeStr_2751.running)
            {
                _SafeStr_2751.start();
            };
            if (((_SafeStr_570) && (_SafeStr_570.currentPageItems)))
            {
                for each (_local_1 in _SafeStr_570.currentPageItems)
                {
                    if (!_local_1.isImageInited)
                    {
                        _local_1.initImage(false);
                        return;
                    };
                };
            };
        }

        private function getItemById(_arg_1:int):GroupItem
        {
            for each (var _local_2:GroupItem in _furniData)
            {
                if (_local_2.getItem(_arg_1) !== null)
                {
                    return (_local_2);
                };
            };
            return (null);
        }

        private function isUnseen(_arg_1:FurnitureItem):Boolean
        {
            var _local_2:int;
            if (_arg_1.isRented)
            {
                _local_2 = 2;
            }
            else
            {
                _local_2 = 1;
            };
            return (_controller.unseenItemTracker.isUnseen(_local_2, _arg_1.id));
        }

        private function addOrUpdateNonGroupableItem(_arg_1:FurnitureItem, _arg_2:Boolean):GroupItem
        {
            var _local_3:GroupItem;
            var _local_4:Vector.<GroupItem> = new Vector.<GroupItem>(0);
            for each (_local_3 in _furniData)
            {
                if (_local_3.type == _arg_1.type)
                {
                    _local_4.push(_local_3);
                };
            };
            for each (_local_3 in _local_4)
            {
                if (_local_3.getItem(_arg_1.id) != null)
                {
                    return (_local_3);
                };
            };
            var _local_5:Boolean = isUnseen(_arg_1);
            _local_3 = createGroupItem(_arg_1.type, _arg_1.category, _arg_1.stuffData, _arg_1.extra, _arg_2);
            _local_3.push(_arg_1, _local_5);
            if (_local_5)
            {
                _local_3.hasUnseenItems = true;
                addItemToTop(_local_3);
            }
            else
            {
                addItemToBottom(_local_3);
            };
            if (((_SafeStr_570) && (_SafeStr_570.grid)))
            {
                _SafeStr_570.grid.itemWasUpdated(_local_3);
            };
            return (_local_3);
        }

        private function addOrUpdateGroupableItem(_arg_1:FurnitureItem, _arg_2:Boolean):GroupItem
        {
            var _local_4:GroupItem = null;
            var _local_5:Boolean = isUnseen(_arg_1);
            for each (var _local_3:GroupItem in _furniData)
            {
                if ((((_local_3.type == _arg_1.type) && (_local_3.isWallItem == _arg_1.isWallItem)) && (_local_3.isGroupable)))
                {
                    if (_arg_1.category == 6)
                    {
                        if (_local_3.stuffData.getLegacyString() == _arg_1.stuffData.getLegacyString())
                        {
                            _local_4 = _local_3;
                            break;
                        };
                    }
                    else
                    {
                        if (_arg_1.category == 17)
                        {
                            if (_arg_1.stuffData.compare(_local_3.stuffData))
                            {
                                _local_4 = _local_3;
                                break;
                            };
                        }
                        else
                        {
                            _local_4 = _local_3;
                            break;
                        };
                    };
                };
            };
            if (_local_4)
            {
                _local_4.push(_arg_1, _local_5);
                if (_local_5)
                {
                    _local_4.hasUnseenItems = true;
                    moveItemToTop(_local_4);
                };
                if (((_SafeStr_570) && (_SafeStr_570.grid)))
                {
                    _SafeStr_570.grid.itemWasUpdated(_local_4);
                };
                return (_local_4);
            };
            _local_3 = createGroupItem(_arg_1.type, _arg_1.category, _arg_1.stuffData, _arg_1.extra, _arg_2);
            _local_3.push(_arg_1, _local_5);
            if (_local_5)
            {
                _local_3.hasUnseenItems = true;
                addItemToTop(_local_3);
            }
            else
            {
                addItemToBottom(_local_3);
            };
            if (((_SafeStr_570) && (_SafeStr_570.grid)))
            {
                _SafeStr_570.grid.itemWasUpdated(_local_3);
            };
            return (_local_3);
        }

        private function requestSelectedFurniToMover(_arg_1:FurnitureItem):void
        {
            var _local_3:int;
            var _local_2:Boolean;
            if (_arg_1.isWallItem)
            {
                _local_3 = 20;
            }
            else
            {
                _local_3 = 10;
            };
            if (((_arg_1.category == 6) || (isExternalImageItem(_arg_1))))
            {
                _local_2 = _roomEngine.initializeRoomObjectInsert("inventory", _arg_1.id, _local_3, _arg_1.type, _arg_1.stuffData.getLegacyString());
            }
            else
            {
                _local_2 = _roomEngine.initializeRoomObjectInsert("inventory", _arg_1.id, _local_3, _arg_1.type, _arg_1.extra.toString(), _arg_1.stuffData);
            };
            if (_local_2)
            {
                _SafeStr_2752 = _arg_1.ref;
                requestClose();
                _SafeStr_539 = true;
            };
            _SafeStr_570.updateActionView();
        }

        private function isExternalImageItem(_arg_1:FurnitureItem):Boolean
        {
            var _local_2:IFurnitureData = _catalog.getFurnitureData(_arg_1.type, "i");
            return ((_local_2) && (_local_2.isExternalImageType));
        }

        private function updateCategorySelection():void
        {
            var _local_2:int;
            removeSelections();
            var _local_1:GroupItem = _categorySelection[_SafeStr_826];
            if (_local_1 != null)
            {
                _local_2 = _furniData.indexOf(_local_1);
                if (_local_2 > -1)
                {
                    _local_1.isSelected = true;
                    _local_1.selectedItemIndex = -1;
                };
            }
            else
            {
                selectFirstItem();
            };
            _SafeStr_570.updateActionView();
        }

        public function onObjectPlaced(_arg_1:Event):void
        {
            if (((_SafeStr_539) && (_arg_1.type == "REOE_PLACED")))
            {
                _SafeStr_539 = false;
                if (!(_arg_1 as RoomEngineObjectPlacedEvent).placedInRoom)
                {
                    _controller.showView();
                }
                else
                {
                    if (_SafeStr_826 == "rentables")
                    {
                        _controller.showView();
                    };
                };
            };
        }

        private function onImageUpdateTimerEvent(_arg_1:TimerEvent):void
        {
            var _local_5:Vector.<int> = undefined;
            var _local_3:FurnitureItem;
            initListImages();
            _imageUpdateCumulativeTime = (_imageUpdateCumulativeTime + 100);
            if (_imageUpdateCumulativeTime >= 1000)
            {
                _local_5 = new Vector.<int>(0);
                for each (var _local_2:GroupItem in _furniData)
                {
                    _local_3 = _local_2.getAt(0);
                    if (((((_local_3) && (_local_3.isRented)) && (_local_3.hasRentPeriodStarted)) && (_local_3.secondsToExpiration <= 0)))
                    {
                        _local_5.push(_local_3.id);
                    };
                };
                for each (var _local_4:int in _local_5)
                {
                    removeFurni(_local_4);
                };
                if (_local_5.length > 0)
                {
                    _SafeStr_570.updateGridFilters();
                };
                _SafeStr_570.updateRentedItem();
                _imageUpdateCumulativeTime = 0;
            };
        }

        public function roomEntered():void
        {
            var _local_1:int;
            _isInRoom = true;
            if (_SafeStr_2755 == null)
            {
                return;
            };
            if (_roomEngine != null)
            {
                _local_1 = ((_SafeStr_2755.isWallItem) ? 20 : 10);
                _roomEngine.selectRoomObject(_SafeStr_2755.flatId, Math.abs(_SafeStr_2755.id), _local_1);
            };
            _SafeStr_2755 = null;
        }

        public function roomLeft():void
        {
            _isInRoom = false;
        }

        public function selectItemById(_arg_1:String):void
        {
            var _local_2:GroupItem = getItemById(-(int(_arg_1)));
            if (_local_2 != null)
            {
                categorySelection = _local_2;
            };
        }


    }
}