package com.sulake.habbo.inventory.items
{
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.core.utils.Map;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.inventory.furni.FurniModel;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.room.IStuffData;
    import flash.display.BitmapData;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.room._SafeStr_147;
    import __AS3__.vec.Vector;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.habbo.window.widgets.ILimitedItemGridOverlayWidget;
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.habbo.window.widgets.IRarityItemGridOverlayWidget;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.sound.ISongInfo;
    import com.sulake.habbo.sound.events.SongInfoReceivedEvent;

    public class GroupItem implements IGetImageListener
    {

        private static const THUMB_WINDOW_LAYOUT:String = "inventory_thumb_xml";
        private static const THUMB_COLOR_NORMAL:int = 0xCCCCCC;
        private static const THUMB_COLOR_UNSEEN:int = 10275685;

        private const THUMB_BLEND_ITEMS_AVAILABLE:Number = 1;
        private const THUMB_BLEND_ITEMS_NOT_AVAILABLE:Number = 0.2;

        protected var _items:Map;
        protected var _window:IWindowContainer;
        protected var _SafeStr_1275:FurniModel;
        private var _type:int;
        private var _roomEngine:IRoomEngine;
        private var _isLocked:Boolean;
        private var _isSelected:Boolean;
        private var _category:int;
        private var _stuffData:IStuffData;
        private var _extra:Number;
        private var _iconCallbackId:int = 0;
        private var _iconImage:BitmapData;
        private var _previewCallbackId:int;
        private var _SafeStr_2761:Boolean;
        private var _SafeStr_2762:Boolean;
        private var _icon:BitmapData;
        private var _SafeStr_1277:IWindow;
        private var _hasUnseenItems:Boolean;
        private var _SafeStr_2763:Boolean;
        private var _alignment:String = "center";
        private var _SafeStr_573:Boolean = false;
        private var _name:String = "";
        private var _description:String = "";
        private var _SafeStr_2764:int = -1;
        private var _selectedItemIndex:int = -1;

        public function GroupItem(_arg_1:FurniModel, _arg_2:int, _arg_3:int, _arg_4:IRoomEngine, _arg_5:IStuffData, _arg_6:Number, _arg_7:BitmapData, _arg_8:Boolean, _arg_9:String)
        {
            _SafeStr_1275 = _arg_1;
            _type = _arg_2;
            _roomEngine = _arg_4;
            _items = new Map();
            _category = _arg_3;
            _stuffData = _arg_5;
            _extra = _arg_6;
            _alignment = _arg_9;
            _icon = _arg_7;
            _SafeStr_2762 = _arg_8;
            switch (_category)
            {
                case 2:
                    _name = _SafeStr_1275.controller.localization.getLocalization("inventory.furni.item.wallpaper.name");
                    _description = _SafeStr_1275.controller.localization.getLocalization("inventory.furni.item.wallpaper.desc");
                    break;
                case 3:
                    _name = _SafeStr_1275.controller.localization.getLocalization("inventory.furni.item.floor.name");
                    _description = _SafeStr_1275.controller.localization.getLocalization("inventory.furni.item.floor.desc");
                    break;
                case 4:
                    _name = _SafeStr_1275.controller.localization.getLocalization("inventory.furni.item.landscape.name");
                    _description = _SafeStr_1275.controller.localization.getLocalization("inventory.furni.item.landscape.desc");
                default:
            };
            _SafeStr_1275.soundManager.events.addEventListener("SIR_TRAX_SONG_INFO_RECEIVED", onSongInfoReceivedEvent);
        }

        public function get isImageInited():Boolean
        {
            return ((_SafeStr_573) && (_SafeStr_2761));
        }

        public function get isImageFinished():Boolean
        {
            return (_iconCallbackId == -1);
        }

        public function get window():IWindowContainer
        {
            if (!_SafeStr_573)
            {
                initWindow();
            };
            if (_window == null)
            {
                return (null);
            };
            if (_window.disposed)
            {
                return (null);
            };
            return (_window);
        }

        public function get isLocked():Boolean
        {
            return (_isLocked);
        }

        public function set isLocked(_arg_1:Boolean):void
        {
            _isLocked = _arg_1;
        }

        public function get isSelected():Boolean
        {
            return (_isSelected);
        }

        public function set isSelected(_arg_1:Boolean):void
        {
            if (_isSelected != _arg_1)
            {
                _isSelected = _arg_1;
                updateSelectionVisual();
            };
        }

        public function get type():int
        {
            return (_type);
        }

        public function get iconImage():BitmapData
        {
            return (_iconImage);
        }

        public function set iconImage(_arg_1:BitmapData):void
        {
            _iconImage = _arg_1;
        }

        public function get iconCallbackId():int
        {
            return (_iconCallbackId);
        }

        public function set iconCallbackId(_arg_1:int):void
        {
            _iconCallbackId = _arg_1;
        }

        public function get previewCallbackId():int
        {
            return (_previewCallbackId);
        }

        public function set previewCallbackId(_arg_1:int):void
        {
            _previewCallbackId = _arg_1;
        }

        public function get category():int
        {
            return (_category);
        }

        public function get stuffData():IStuffData
        {
            return (_stuffData);
        }

        public function get extra():Number
        {
            return (_extra);
        }

        public function get hasUnseenItems():Boolean
        {
            return (_hasUnseenItems);
        }

        public function set hasUnseenItems(_arg_1:Boolean):void
        {
            if (_hasUnseenItems != _arg_1)
            {
                _hasUnseenItems = _arg_1;
                updateBackgroundVisual();
            };
        }

        public function get alignment():String
        {
            return (_alignment);
        }

        public function get isWallItem():Boolean
        {
            var _local_1:FurnitureItem = getAt(0);
            return ((_local_1) ? _local_1.isWallItem : false);
        }

        public function get flatId():int
        {
            var _local_1:FurnitureItem = getAt(0);
            return ((_local_1) ? _local_1.flatId : -1);
        }

        public function get isGroupable():Boolean
        {
            var _local_1:FurnitureItem = getAt(0);
            return ((_local_1) ? _local_1.groupable : true);
        }

        public function get isRented():Boolean
        {
            var _local_1:FurnitureItem = getAt(0);
            return ((_local_1) ? _local_1.isRented : false);
        }

        public function get name():String
        {
            return (_name);
        }

        public function get description():String
        {
            return (_description);
        }

        public function dispose():void
        {
            if (_SafeStr_1275.soundManager)
            {
                if (_SafeStr_1275.soundManager.events != null)
                {
                    _SafeStr_1275.soundManager.events.removeEventListener("SIR_TRAX_SONG_INFO_RECEIVED", onSongInfoReceivedEvent);
                };
            };
            _SafeStr_1275 = null;
            _SafeStr_1277 = null;
            _roomEngine = null;
            if (_items)
            {
                _items.dispose();
                _items = null;
            };
            _stuffData = null;
            if (_window)
            {
                _window.dispose();
            };
        }

        public function removeIntervalProcedure():void
        {
            if (_window)
            {
                _window.procedure = null;
            };
        }

        public function initImage(_arg_1:Boolean=true):void
        {
            var _local_2:_SafeStr_147;
            if (_iconImage != null)
            {
                return;
            };
            if (_SafeStr_2761)
            {
                return;
            };
            if (isWallItem)
            {
                _local_2 = _roomEngine.getWallItemIcon(_type, this, _stuffData.getLegacyString());
            }
            else
            {
                _local_2 = _roomEngine.getFurnitureIcon(_type, this, String(_extra), _stuffData);
            };
            if (_local_2.id > 0)
            {
                if (_arg_1)
                {
                    setLoadingImage(_local_2.data);
                };
                _iconCallbackId = _local_2.id;
            }
            else
            {
                setFinalImage(_local_2.data);
                _iconCallbackId = -1;
            };
            _SafeStr_2761 = true;
        }

        public function push(_arg_1:FurnitureItem, _arg_2:Boolean=false):void
        {
            var _local_3:FurnitureItem = _items.getValue(_arg_1.id);
            if (_local_3 == null)
            {
                _items.add(_arg_1.id, _arg_1);
            }
            else
            {
                _local_3.locked = false;
            };
            updateItemCountVisual();
            updateSelectionVisual();
            if (((_name == null) || (_name.length == 0)))
            {
                _name = getFurniItemName();
            };
            if (((_description == null) || (_description.length == 0)))
            {
                _description = getFurniItemDesc();
            };
            if (_arg_2 != _hasUnseenItems)
            {
                _hasUnseenItems = _arg_2;
                updateBackgroundVisual();
            };
        }

        public function unshift(_arg_1:FurnitureItem):void
        {
            var _local_2:FurnitureItem = _items.getValue(_arg_1.id);
            if (_local_2 == null)
            {
                _items.unshift(_arg_1.id, _arg_1);
            }
            else
            {
                _local_2.locked = false;
            };
            updateAllThumbDataVisuals();
        }

        public function pop():FurnitureItem
        {
            var _local_1:FurnitureItem;
            if (_items.length > 0)
            {
                _local_1 = (_items.getWithIndex((_items.length - 1)) as FurnitureItem);
                _items.remove(_local_1.id);
            };
            updateAllThumbDataVisuals();
            return (_local_1);
        }

        public function peek():FurnitureItem
        {
            var _local_1:FurnitureItem;
            if (_items.length > 0)
            {
                _local_1 = (_items.getWithIndex((_items.length - 1)) as FurnitureItem);
                updateAllThumbDataVisuals();
            };
            return (_local_1);
        }

        public function getAt(_arg_1:int):FurnitureItem
        {
            return (_items.getWithIndex(_arg_1));
        }

        public function getItemsForTrade(_arg_1:int):Vector.<IFurnitureItem>
        {
            var _local_5:int;
            var _local_2:FurnitureItem;
            var _local_3:Vector.<IFurnitureItem> = new Vector.<IFurnitureItem>();
            var _local_6:IFurnitureItem = getOneForTrade();
            if (_local_6 == null)
            {
                return (_local_3);
            };
            var _local_4:int;
            _local_5 = 0;
            while (_local_5 < _items.length)
            {
                if (_local_4 >= _arg_1) break;
                _local_2 = _items.getWithIndex(_local_5);
                if ((((!(_local_2.locked)) && (_local_2.tradeable)) && (_local_2.type == _local_6.type)))
                {
                    _local_4++;
                    _local_3.push(_local_2);
                };
                _local_5++;
            };
            return (_local_3);
        }

        public function getOneForTrade():FurnitureItem
        {
            var _local_2:FurnitureItem;
            var _local_3:int;
            var _local_1:FurnitureItem;
            if (((_selectedItemIndex >= 0) && (_selectedItemIndex < _items.length)))
            {
                _local_2 = _items.getWithIndex(_selectedItemIndex);
                if (((!(_local_2.locked)) && (_local_2.tradeable)))
                {
                    return (_local_2);
                };
            };
            _local_3 = 0;
            while (_local_3 < _items.length)
            {
                _local_1 = _items.getWithIndex(_local_3);
                if (((!(_local_1.locked)) && (_local_1.tradeable)))
                {
                    return (_local_1);
                };
                _local_3++;
            };
            return (null);
        }

        public function getOneForRecycle():FurnitureItem
        {
            var _local_2:int;
            var _local_1:FurnitureItem;
            _local_2 = 0;
            while (_local_2 < _items.length)
            {
                _local_1 = _items.getWithIndex(_local_2);
                if (((!(_local_1.locked)) && (_local_1.recyclable)))
                {
                    addLockTo(_local_1.id);
                    return (_local_1);
                };
                _local_2++;
            };
            return (null);
        }

        public function getOneForSelling():FurnitureItem
        {
            var _local_2:int;
            var _local_1:FurnitureItem;
            _local_2 = 0;
            while (_local_2 < _items.length)
            {
                _local_1 = _items.getWithIndex(_local_2);
                if (((!(_local_1.locked)) && (_local_1.sellable)))
                {
                    return (_local_1);
                };
                _local_2++;
            };
            return (null);
        }

        public function getFurniIds():Array
        {
            var _local_2:Array = [];
            for each (var _local_1:FurnitureItem in _items)
            {
                _local_2.push(_local_1.id);
            };
            return (_local_2);
        }

        public function getNonRentedFurnitureIds():Array
        {
            var _local_2:Array = [];
            for each (var _local_1:FurnitureItem in _items)
            {
                if (!_local_1.isRented)
                {
                    _local_2.push(_local_1.id);
                };
            };
            return (_local_2);
        }

        public function addLockTo(_arg_1:int):Boolean
        {
            var _local_3:int;
            var _local_2:FurnitureItem;
            _local_3 = 0;
            while (_local_3 < _items.length)
            {
                _local_2 = _items.getWithIndex(_local_3);
                if (_local_2.id == _arg_1)
                {
                    _local_2.locked = true;
                    updateItemCountVisual();
                    return (true);
                };
                _local_3++;
            };
            return (false);
        }

        public function updateLocks(_arg_1:Array):void
        {
            var _local_5:Boolean;
            var _local_2:FurnitureItem;
            var _local_4:Boolean;
            var _local_3:int = (_items.length - 1);
            while (_local_3 >= 0)
            {
                _local_2 = _items.getWithIndex(_local_3);
                _local_4 = (_arg_1.indexOf(_local_2.ref) >= 0);
                if (_local_2.locked != _local_4)
                {
                    _local_2.locked = _local_4;
                    _local_5 = true;
                };
                _local_3--;
            };
            if (_local_5)
            {
                updateItemCountVisual();
            };
        }

        public function removeLockFrom(_arg_1:int):Boolean
        {
            var _local_3:int;
            var _local_2:FurnitureItem;
            _local_3 = 0;
            while (_local_3 < _items.length)
            {
                _local_2 = _items.getWithIndex(_local_3);
                if (_local_2.id == _arg_1)
                {
                    _local_2.locked = false;
                    updateItemCountVisual();
                    return (true);
                };
                _local_3++;
            };
            return (false);
        }

        public function removeAllLocks():void
        {
            var _local_3:Boolean;
            var _local_2:int;
            var _local_1:FurnitureItem;
            _local_2 = (_items.length - 1);
            while (_local_2 >= 0)
            {
                _local_1 = _items.getWithIndex(_local_2);
                if (_local_1.locked)
                {
                    _local_1.locked = false;
                    _local_3 = true;
                };
                _local_2--;
            };
            if (_local_3)
            {
                updateItemCountVisual();
            };
        }

        public function getTotalCount():int
        {
            var _local_2:int;
            var _local_3:int;
            var _local_1:FurnitureItem;
            if (category == 5)
            {
                _local_2 = 0;
                _local_3 = 0;
                while (_local_3 < _items.length)
                {
                    _local_1 = (_items.getWithIndex(_local_3) as FurnitureItem);
                    _local_2 = int((_local_2 + _local_1.stuffData.getLegacyString()));
                    _local_3++;
                };
                return (_local_2);
            };
            return (_items.length);
        }

        public function getRecyclableCount():int
        {
            var _local_3:int;
            var _local_1:FurnitureItem;
            var _local_2:int;
            _local_3 = 0;
            while (_local_3 < _items.length)
            {
                _local_1 = (_items.getWithIndex(_local_3) as FurnitureItem);
                if (((_local_1.recyclable) && (!(_local_1.locked))))
                {
                    _local_2++;
                };
                _local_3++;
            };
            return (_local_2);
        }

        public function getTradeableCount():int
        {
            var _local_3:int;
            var _local_1:FurnitureItem;
            var _local_2:int;
            _local_3 = 0;
            while (_local_3 < _items.length)
            {
                _local_1 = (_items.getWithIndex(_local_3) as FurnitureItem);
                if (((_local_1.tradeable) && (!(_local_1.locked))))
                {
                    _local_2++;
                };
                _local_3++;
            };
            return (_local_2);
        }

        public function remove(_arg_1:int):FurnitureItem
        {
            var _local_2:FurnitureItem = _items.getValue(_arg_1);
            if (_local_2)
            {
                _items.remove(_arg_1);
                updateAllThumbDataVisuals();
                return (_local_2);
            };
            return (null);
        }

        public function getItem(_arg_1:int):FurnitureItem
        {
            return (_items.getValue(_arg_1));
        }

        public function replaceItem(_arg_1:int, _arg_2:FurnitureItem):void
        {
            _items.add(_arg_1, _arg_2);
            updateAllThumbDataVisuals();
        }

        public function getMinimumItemsToShowCounter():int
        {
            return (2);
        }

        public function getUnlockedCount():int
        {
            var _local_1:FurnitureItem;
            var _local_3:int;
            if (category == 5)
            {
                return (getTotalCount());
            };
            var _local_2:int;
            _local_3 = 0;
            while (_local_3 < _items.length)
            {
                _local_1 = _items.getWithIndex(_local_3);
                if (!_local_1.locked)
                {
                    _local_2++;
                };
                _local_3++;
            };
            return (_local_2);
        }

        public function updateAllThumbDataVisuals():void
        {
            if (_window == null)
            {
                return;
            };
            if (_window.disposed)
            {
                return;
            };
            updateItemImageVisual();
            updateBackgroundVisual();
            updateItemCountVisual();
            updateSelectionVisual();
            updateRentStateVisual();
        }

        public function imageReady(_arg_1:int, _arg_2:BitmapData):void
        {
            if (_window == null)
            {
                return;
            };
            if (_window.disposed)
            {
                return;
            };
            if (_iconCallbackId != _arg_1)
            {
                return;
            };
            _iconImage = _arg_2;
            updateItemImageVisual();
        }

        public function imageFailed(_arg_1:int):void
        {
        }

        private function setFinalImage(_arg_1:BitmapData):void
        {
            _iconImage = _arg_1;
            _SafeStr_2761 = true;
            _iconCallbackId = -1;
            updateItemImageVisual();
        }

        private function setLoadingImage(_arg_1:BitmapData):void
        {
            _iconImage = _arg_1;
            _SafeStr_2761 = true;
            updateItemImageVisual();
        }

        private function updateRentStateVisual():void
        {
            if (((_window == null) || (_window.disposed)))
            {
                return;
            };
            var _local_2:FurnitureItem = getAt(0);
            var _local_1:IStaticBitmapWrapperWindow = (_window.findChildByName("rent_state") as IStaticBitmapWrapperWindow);
            if (((!(_local_2)) || (!(isRented))))
            {
                _local_1.visible = false;
                return;
            };
            _local_1.visible = ((_local_2.secondsToExpiration >= 0) && (_local_2.hasRentPeriodStarted));
            var _local_3:int = _SafeStr_1275.controller.getInteger("purchase.rent.warning_duration_seconds", 172800);
            _local_1.assetUri = ((_local_2.secondsToExpiration < _local_3) ? "inventory_thumb_rent_ending" : "inventory_thumb_rent_started");
        }

        private function updateItemCountVisual():void
        {
            var _local_4:ITextWindow;
            if (!_window)
            {
                return;
            };
            var _local_5:int = getUnlockedCount();
            var _local_1:Boolean = (_local_5 >= getMinimumItemsToShowCounter());
            var _local_3:IWindow = _window.findChildByName("number_container");
            _local_3.visible = _local_1;
            if (_local_1)
            {
                _local_4 = (_window.findChildByName("number") as ITextWindow);
                _local_4.text = String(_local_5);
            };
            var _local_2:IBitmapWrapperWindow = (_window.findChildByName("bitmap") as IBitmapWrapperWindow);
            if (_local_5 <= 0)
            {
                _local_2.blend = 0.2;
            }
            else
            {
                _local_2.blend = 1;
            };
        }

        private function updateBackgroundVisual():void
        {
            if (!_window)
            {
                return;
            };
            if (!_SafeStr_1277)
            {
                _SafeStr_1277 = _window.findChildByTag("BG_COLOR");
            };
            _SafeStr_1277.color = ((_hasUnseenItems) ? 10275685 : 0xCCCCCC);
        }

        private function updateSelectionVisual():void
        {
            if (!_window)
            {
                return;
            };
            _window.findChildByName("outline").visible = isSelected;
        }

        private function updateItemImageVisual():void
        {
            var _local_2:ILimitedItemGridOverlayWidget;
            var _local_4:IWidgetWindow;
            var _local_5:IWidgetWindow;
            var _local_1:IRarityItemGridOverlayWidget;
            if (!_window)
            {
                return;
            };
            if (stuffData.uniqueSerialNumber > 0)
            {
                _local_4 = IWidgetWindow(_window.findChildByName("unique_item_overlay_container"));
                _local_2 = ILimitedItemGridOverlayWidget(_local_4.widget);
                _local_4.visible = true;
                _local_2.serialNumber = stuffData.uniqueSerialNumber;
                _local_2.animated = true;
                _window.findChildByName("unique_item_background_bitmap").visible = true;
            }
            else
            {
                if (stuffData.rarityLevel >= 0)
                {
                    _local_5 = IWidgetWindow(_window.findChildByName("rarity_item_overlay_container"));
                    _local_1 = IRarityItemGridOverlayWidget(_local_5.widget);
                    _local_1.rarityLevel = stuffData.rarityLevel;
                    _local_5.visible = true;
                };
            };
            var _local_3:IBitmapWrapperWindow = (_window.findChildByName("bitmap") as IBitmapWrapperWindow);
            if (_local_3)
            {
                _local_3.bitmap = _iconImage;
            };
        }

        private function itemEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:Boolean;
            switch (_arg_1.type)
            {
                case "WME_UP":
                    _SafeStr_2763 = false;
                    _SafeStr_1275.cancelFurniInMover();
                    return;
                case "WME_DOWN":
                    _SafeStr_1275.removeSelections();
                    isSelected = true;
                    _SafeStr_2763 = true;
                    _SafeStr_1275.updateActionView();
                    _SafeStr_1275.categorySelection = this;
                    return;
                case "WME_OUT":
                    if (((!(_SafeStr_2763)) || (_SafeStr_1275.isTradingOpen)))
                    {
                        return;
                    };
                    _local_3 = _SafeStr_1275.requestSelectedFurniPlacement(true);
                    if (_local_3)
                    {
                        _SafeStr_2763 = false;
                    };
                    return;
                case "WME_CLICK":
                    _SafeStr_2763 = false;
                    return;
                case "WME_DOUBLE_CLICK":
                    _SafeStr_1275.requestCurrentActionOnSelection();
                    _SafeStr_2763 = false;
                    return;
            };
        }

        private function initWindow():void
        {
            createWindow();
            if (_icon != null)
            {
                setFinalImage(_icon);
            }
            else
            {
                if (!_SafeStr_2762)
                {
                    initImage();
                };
            };
            _window.procedure = itemEventProc;
            _window.name = ((_roomEngine.getFurnitureType(type) + ".") + category);
            if (((stuffData) && (!(stuffData.getLegacyString() == ""))))
            {
                _window.name = (_window.name + (".s" + stuffData));
            };
            if (!isNaN(extra))
            {
                _window.name = (_window.name + (".e" + extra));
            };
            updateBackgroundVisual();
            updateItemCountVisual();
            updateItemImageVisual();
            updateSelectionVisual();
            _SafeStr_573 = true;
        }

        protected function createWindow():void
        {
            _window = _SafeStr_1275.createItemWindow("inventory_thumb_xml");
        }

        private function getFurniItemName():String
        {
            var _local_2:String;
            var _local_3:ISongInfo;
            var _local_1:FurnitureItem = peek();
            if (_local_1 == null)
            {
                return ("");
            };
            switch (_category)
            {
                case 6:
                    _local_2 = (("poster_" + _local_1.stuffData.getLegacyString()) + "_name");
                    break;
                case 8:
                    _local_3 = _SafeStr_1275.soundManager.musicController.getSongInfo(_local_1.extra);
                    if (_local_3 != null)
                    {
                        return (_local_3.name);
                    };
                    getSongInfo(_local_1);
                    return ("");
                default:
                    if (isWallItem)
                    {
                        _local_2 = ("wallItem.name." + _local_1.type);
                    }
                    else
                    {
                        _local_2 = ("roomItem.name." + _local_1.type);
                    };
            };
            return (_SafeStr_1275.controller.localization.getLocalization(_local_2));
        }

        private function getFurniItemDesc():String
        {
            var _local_2:String;
            var _local_3:ISongInfo;
            var _local_1:FurnitureItem = peek();
            if (_local_1 == null)
            {
                return ("");
            };
            switch (_category)
            {
                case 6:
                    _local_2 = (("poster_" + _local_1.stuffData.getLegacyString()) + "_desc");
                    break;
                case 8:
                    _local_3 = _SafeStr_1275.soundManager.musicController.getSongInfo(_local_1.extra);
                    if (_local_3 != null)
                    {
                        return (_local_3.creator);
                    };
                    getSongInfo(_local_1);
                    return ("");
                default:
                    if (isWallItem)
                    {
                        _local_2 = ("wallItem.desc." + _local_1.type);
                    }
                    else
                    {
                        _local_2 = ("roomItem.desc." + _local_1.type);
                    };
            };
            return (_SafeStr_1275.controller.localization.getLocalization(_local_2));
        }

        private function getSongInfo(_arg_1:FurnitureItem):void
        {
            var _local_2:int;
            var _local_3:ISongInfo;
            if (_arg_1 == null)
            {
                return;
            };
            _SafeStr_2764 = -1;
            if (_arg_1 != null)
            {
                if (_arg_1.category == 8)
                {
                    _local_2 = _arg_1.extra;
                    _local_3 = _SafeStr_1275.soundManager.musicController.getSongInfo(_local_2);
                    if (_local_3 == null)
                    {
                        _SafeStr_1275.soundManager.musicController.requestSongInfoWithoutSamples(_local_2);
                        _SafeStr_2764 = _local_2;
                    };
                };
            };
        }

        private function onSongInfoReceivedEvent(_arg_1:SongInfoReceivedEvent):void
        {
            if (_arg_1.id == _SafeStr_2764)
            {
                _SafeStr_2764 = -1;
                _name = getFurniItemName();
                _description = getFurniItemDesc();
                if (_SafeStr_1275.getSelectedItem() == this)
                {
                    _SafeStr_1275.updateActionView();
                };
            };
        }

        public function get selectedItemIndex():int
        {
            return (_selectedItemIndex);
        }

        public function set selectedItemIndex(_arg_1:int):void
        {
            if (_arg_1 >= _items.length)
            {
                _arg_1 = 0;
            };
            _selectedItemIndex = _arg_1;
        }


    }
}