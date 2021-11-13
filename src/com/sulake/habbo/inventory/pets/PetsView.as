package com.sulake.habbo.inventory.pets
{
    import com.sulake.habbo.inventory.IInventoryView;
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemGridWindow;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.communication.messages.parser.inventory.pets.PetData;
    import com.sulake.habbo.communication.messages.parser.inventory.pets.PetFigureData;
    import flash.display.BitmapData;
    import com.sulake.habbo.avatar.pets.PetCustomPart;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.habbo.room._SafeStr_147;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.geom.Point;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components._SafeStr_101;

    public class PetsView implements IInventoryView, IGetImageListener 
    {

        private static const UNSEEN_SYMBOL_MARGIN:int = 4;

        private const STATE_NULL:int = 0;
        private const STATE_INITIALIZING:int = 1;
        private const STATE_EMPTY:int = 2;
        private const STATE_CONTENT:int = 3;

        private var _windowManager:IHabboWindowManager;
        private var _SafeStr_1354:IAssetLibrary;
        private var _SafeStr_570:IWindowContainer;
        private var _SafeStr_1275:PetsModel;
        private var _disposed:Boolean = false;
        private var _SafeStr_1654:IItemGridWindow;
        private var _roomEngine:IRoomEngine;
        private var _gridItems:Map;
        private var _SafeStr_1563:PetsGridItem;
        private var _SafeStr_2727:int = 0;
        private var _SafeStr_2728:int;
        private var _SafeStr_573:Boolean = false;

        public function PetsView(_arg_1:PetsModel, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary, _arg_4:IRoomEngine)
        {
            _SafeStr_1275 = _arg_1;
            _SafeStr_1354 = _arg_3;
            _windowManager = _arg_2;
            _roomEngine = _arg_4;
            _gridItems = new Map();
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
            if (!_disposed)
            {
                _windowManager = null;
                _SafeStr_1275 = null;
                _SafeStr_570 = null;
                _disposed = true;
            };
        }

        public function update():void
        {
            if (!_SafeStr_573)
            {
                return;
            };
            updateGrid();
            updatePreview(_SafeStr_1563);
            updateContainerVisibility();
        }

        public function removePet(_arg_1:int):void
        {
            if (!_SafeStr_573)
            {
                return;
            };
            var _local_2:PetsGridItem = (_gridItems.remove(_arg_1) as PetsGridItem);
            if (_local_2 == null)
            {
                return;
            };
            _SafeStr_1654.removeGridItem(_local_2.window);
            if (_SafeStr_1563 == _local_2)
            {
                _SafeStr_1563 = null;
                selectFirst();
            };
        }

        public function addPet(_arg_1:PetData):void
        {
            if (!_SafeStr_573)
            {
                return;
            };
            if (_arg_1 == null)
            {
                return;
            };
            if (_gridItems.getValue(_arg_1.id) != null)
            {
                return;
            };
            var _local_2:PetsGridItem = new PetsGridItem(this, _arg_1, _windowManager, _SafeStr_1354, _SafeStr_1275.isUnseen(_arg_1.id));
            if (_local_2 != null)
            {
                _SafeStr_1654.addGridItem(_local_2.window);
                _gridItems.add(_arg_1.id, _local_2);
                if (_SafeStr_1563 == null)
                {
                    selectFirst();
                };
            };
        }

        public function placePetToRoom(_arg_1:int, _arg_2:Boolean=false):void
        {
            _SafeStr_1275.placePetToRoom(_arg_1, _arg_2);
        }

        public function getWindowContainer():IWindowContainer
        {
            if (!_SafeStr_573)
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
            return (_SafeStr_570);
        }

        public function setSelectedGridItem(_arg_1:PetsGridItem):void
        {
            if (!_SafeStr_573)
            {
                return;
            };
            if (_SafeStr_1563 != null)
            {
                _SafeStr_1563.setSelected(false);
            };
            _SafeStr_1563 = _arg_1;
            if (_SafeStr_1563 != null)
            {
                _SafeStr_1563.setSelected(true);
            };
            updatePreview(_arg_1);
        }

        public function updateState():void
        {
            var _local_2:int;
            if (!_SafeStr_573)
            {
                return;
            };
            var _local_1:Map = _SafeStr_1275.pets;
            if (!_SafeStr_1275.isListInitialized())
            {
                _local_2 = 1;
            }
            else
            {
                if (((!(_local_1)) || (_local_1.length == 0)))
                {
                    _local_2 = 2;
                }
                else
                {
                    _local_2 = 3;
                };
            };
            if (_SafeStr_2727 == _local_2)
            {
                return;
            };
            _SafeStr_2727 = _local_2;
            updateContainerVisibility();
            if (_SafeStr_2727 == 3)
            {
                updateGrid();
                updatePreview();
            };
        }

        public function getPetImage(_arg_1:PetData, _arg_2:int, _arg_3:Boolean, _arg_4:PetsGridItem=null, _arg_5:int=64, _arg_6:String=null):BitmapData
        {
            var _local_9:int;
            var _local_10:PetFigureData = _arg_1.figureData;
            var _local_7:BitmapData;
            var _local_8:uint = parseInt(_local_10.color, 16);
            var _local_11:uint;
            var _local_13:Array = [];
            _local_9 = 0;
            while (_local_9 < (_local_10.customPartCount * 3))
            {
                _local_13.push(new PetCustomPart(_local_10.customParts[_local_9], _local_10.customParts[(_local_9 + 1)], _local_10.customParts[(_local_9 + 2)]));
                _local_9 = (_local_9 + 3);
            };
            var _local_12:_SafeStr_147 = _roomEngine.getPetImage(_local_10.typeId, _local_10.paletteId, _local_8, new Vector3d((_arg_2 * 45)), _arg_5, this, _arg_3, _local_11, _local_13, _arg_6);
            if (_local_12 != null)
            {
                _local_7 = _local_12.data;
                if (_arg_4 != null)
                {
                    _arg_4.imageDownloadId = _local_12.id;
                }
                else
                {
                    if (_arg_3)
                    {
                        _SafeStr_2728 = _local_12.id;
                    };
                };
            };
            if (_local_7 == null)
            {
                _local_7 = new BitmapData(30, 30, false, 4289374890);
            };
            return (_local_7);
        }

        public function imageReady(_arg_1:int, _arg_2:BitmapData):void
        {
            if (_arg_1 == _SafeStr_2728)
            {
                updatePreview(_SafeStr_1563);
                return;
            };
            for each (var _local_3:PetsGridItem in _gridItems)
            {
                if (_local_3.imageDownloadId == _arg_1)
                {
                    _local_3.setPetImage(_arg_2);
                    return;
                };
            };
        }

        public function imageFailed(_arg_1:int):void
        {
        }

        private function selectFirst():void
        {
            if (((_gridItems == null) || (_gridItems.length == 0)))
            {
                updatePreview();
                return;
            };
            setSelectedGridItem(_gridItems.getWithIndex(0));
        }

        public function selectById(_arg_1:int):void
        {
            setSelectedGridItem(_gridItems.getValue(_arg_1));
        }

        private function updateGrid():void
        {
            var _local_4:int;
            var _local_3:PetsGridItem;
            if (_SafeStr_570 == null)
            {
                return;
            };
            var _local_1:Array = _gridItems.getKeys();
            var _local_2:Array = ((_SafeStr_1275.pets) ? _SafeStr_1275.pets.getKeys() : []);
            _SafeStr_1654.lock();
            for each (_local_4 in _local_1)
            {
                if (_local_2.indexOf(_local_4) == -1)
                {
                    removePet(_local_4);
                };
            };
            for each (_local_4 in _local_2)
            {
                if (_local_1.indexOf(_local_4) == -1)
                {
                    addPet(_SafeStr_1275.pets.getValue(_local_4));
                };
                _local_3 = _gridItems.getValue(_local_4);
                _local_3.setUnseen(_SafeStr_1275.isUnseen(_local_4));
            };
            _SafeStr_1654.unlock();
        }

        private function startPlacingHandler(_arg_1:WindowMouseEvent):void
        {
            if (_SafeStr_1563 == null)
            {
                return;
            };
            var _local_2:PetData = _SafeStr_1563.pet;
            if (_local_2 == null)
            {
                return;
            };
            placePetToRoom(_local_2.id);
        }

        private function updateContainerVisibility():void
        {
            if (_SafeStr_1275.controller.currentCategoryId != "pets")
            {
                return;
            };
            var _local_1:IWindowContainer = _SafeStr_1275.controller.view.loadingContainer;
            var _local_3:IWindowContainer = _SafeStr_1275.controller.view.emptyContainer;
            var _local_4:IWindow = _SafeStr_570.findChildByName("grid");
            var _local_2:IWindow = _SafeStr_570.findChildByName("preview_container");
            switch (_SafeStr_2727)
            {
                case 1:
                    if (_local_1)
                    {
                        _local_1.visible = true;
                    };
                    if (_local_3)
                    {
                        _local_3.visible = false;
                    };
                    _local_4.visible = false;
                    _local_2.visible = false;
                    return;
                case 2:
                    if (_local_1)
                    {
                        _local_1.visible = false;
                    };
                    if (_local_3)
                    {
                        _local_3.visible = true;
                    };
                    _local_4.visible = false;
                    _local_2.visible = false;
                    return;
                case 3:
                    if (_local_1)
                    {
                        _local_1.visible = false;
                    };
                    if (_local_3)
                    {
                        _local_3.visible = false;
                    };
                    _local_4.visible = true;
                    _local_2.visible = true;
                default:
            };
        }

        private function updatePreview(_arg_1:PetsGridItem=null):void
        {
            var _local_15:BitmapData;
            var _local_8:String;
            var _local_7:String;
            var _local_11:Boolean;
            var _local_16:PetData;
            var _local_3:BitmapData;
            if (_SafeStr_570 == null)
            {
                return;
            };
            var _local_5:int = 64;
            var _local_17:int = 4;
            var _local_14:Boolean = true;
            var _local_4:String;
            _SafeStr_2728 = -1;
            if (((_arg_1 == null) || (_arg_1.pet == null)))
            {
                _local_15 = new BitmapData(1, 1);
                _local_8 = "";
                _local_7 = "";
                _local_11 = false;
            }
            else
            {
                _local_16 = _arg_1.pet;
                _local_8 = _local_16.name;
                if (_local_16.typeId == 16)
                {
                    _local_17 = 2;
                    _local_14 = true;
                    if (_local_16.level >= 7)
                    {
                        _local_4 = "std";
                    }
                    else
                    {
                        _local_4 = ("grw" + _local_16.level);
                    };
                };
                _local_15 = getPetImage(_local_16, _local_17, _local_14, null, _local_5, _local_4);
                _local_11 = true;
            };
            var _local_10:IBitmapWrapperWindow = (_SafeStr_570.findChildByName("preview_image") as IBitmapWrapperWindow);
            if (_local_10 != null)
            {
                _local_3 = new BitmapData(_local_10.width, _local_10.height);
                _local_3.fillRect(_local_3.rect, 0);
                _local_3.copyPixels(_local_15, _local_15.rect, new Point(((_local_3.width / 2) - (_local_15.width / 2)), ((_local_3.height / 2) - (_local_15.height / 2))));
                _local_10.bitmap = _local_3;
            };
            _local_15.dispose();
            var _local_6:ITextWindow = (_SafeStr_570.findChildByName("preview_text") as ITextWindow);
            if (_local_6 != null)
            {
                _local_6.caption = _local_8;
            };
            _local_6 = (_SafeStr_570.findChildByName("preview_description") as ITextWindow);
            if (_local_6 != null)
            {
                _local_6.caption = _local_7;
            };
            var _local_12:Boolean;
            var _local_13:Boolean;
            if (_SafeStr_1275.roomSession != null)
            {
                _local_12 = _SafeStr_1275.roomSession.arePetsAllowed;
                _local_13 = _SafeStr_1275.roomSession.isRoomOwner;
            };
            var _local_2:String = "";
            if (!_local_13)
            {
                if (_local_12)
                {
                    _local_2 = "${inventory.pets.allowed}";
                }
                else
                {
                    _local_2 = "${inventory.pets.forbidden}";
                };
            };
            _local_6 = (_SafeStr_570.findChildByName("preview_info") as ITextWindow);
            if (_local_6 != null)
            {
                _local_6.caption = _local_2;
            };
            var _local_9:_SafeStr_101 = (_SafeStr_570.findChildByName("place_button") as _SafeStr_101);
            if (_local_9 != null)
            {
                if (((_local_11) && ((_local_13) || (_local_12))))
                {
                    _local_9.enable();
                }
                else
                {
                    _local_9.disable();
                };
            };
        }

        private function init():void
        {
            var _local_1:_SafeStr_101;
            _SafeStr_570 = _SafeStr_1275.controller.view.getView("pets");
            _SafeStr_570.visible = false;
            _SafeStr_1654 = (_SafeStr_570.findChildByName("grid") as IItemGridWindow);
            _local_1 = (_SafeStr_570.findChildByName("place_button") as _SafeStr_101);
            if (_local_1 != null)
            {
                _local_1.addEventListener("WME_CLICK", startPlacingHandler);
            };
            var _local_2:IBitmapWrapperWindow = (_SafeStr_570.findChildByName("preview_image") as IBitmapWrapperWindow);
            if (_local_2 != null)
            {
                _local_2.addEventListener("WME_DOWN", startPlacingHandler);
            };
            updatePreview();
            updateState();
            _SafeStr_573 = true;
        }


    }
}

