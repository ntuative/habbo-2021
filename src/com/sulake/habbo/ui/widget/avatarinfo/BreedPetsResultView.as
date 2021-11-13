package com.sulake.habbo.ui.widget.avatarinfo
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.utils.Map;
    import flash.display.BitmapData;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.habbo.room._SafeStr_147;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.assets.IAsset;
    import flash.geom.Point;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.inventory.items.IFurnitureItem;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.habbo.inventory.IHabboInventory;

    public class BreedPetsResultView implements IDisposable, IGetImageListener 
    {

        private static const ELEM_LIST:String = "element_list";
        private static const PREVIEW_LIST:String = "preview_list";
        private static const PREVIEW_BUTTONLIST:String = "preview_buttonlist";
        private static const ELEM_SEED1_ITEMLIST:String = "seed1_itemlist";
        private static const ELEM_SEED2_ITEMLIST:String = "seed2_itemlist";
        private static const ELEM_SEED1_BUTTONLIST:String = "seed1_buttonlist";
        private static const ELEM_SEED2_BUTTONLIST:String = "seed2_buttonlist";
        private static const _SafeStr_3921:String = "header_button_close";
        private static const _SafeStr_3113:String = "close_button";
        private static const _SafeStr_3118:String = "save_button";
        private static const ELEM_PLACE_BUTTON1:String = "place_button1";
        private static const ELEM_PLACE_BUTTON2:String = "place_button2";
        private static const ELEM_PICK_BUTTON1:String = "pick_button1";
        private static const ELEM_PICK_BUTTON2:String = "pick_button2";
        private static const ELEM_PREVIEW_IMAGE:String = "preview_image";
        private static const ELEM_PREVIEW_IMAGE2:String = "preview_image2";
        private static const _SafeStr_3922:String = "preview_image_region";
        private static const ELEM_PREVIEW_IMAGE_REGION2:String = "preview_image_region2";
        private static const ELEM_BUTTON_LIST:String = "button_list";
        private static const _SafeStr_3917:String = "description";
        private static const _SafeStr_3923:String = "description_sorry";
        private static const ELEM_INFO:String = "info";
        private static const _SafeStr_3924:String = "info_sorry";
        private static const ELEM_INFO_MUTATE1:String = "info_mutate1";
        private static const ELEM_INFO_MUTATE2:String = "info_mutate2";
        private static const _SafeStr_3119:String = "ok_button";

        private var _window:IFrameWindow;
        private var _disposed:Boolean = false;
        private var _SafeStr_1324:AvatarInfoWidget;
        private var _windowManager:IHabboWindowManager;
        private var _assets:IAssetLibrary;
        private var _SafeStr_3919:Map;
        private var _SafeStr_3925:BreedPetsResultData;
        private var _resultData2:BreedPetsResultData;
        private var _SafeStr_3926:Boolean;

        public function BreedPetsResultView(_arg_1:AvatarInfoWidget)
        {
            _SafeStr_1324 = _arg_1;
            _windowManager = _arg_1.windowManager;
            _assets = _SafeStr_1324.assets;
            _SafeStr_3919 = new Map();
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function dispose():void
        {
            if (disposed)
            {
                return;
            };
            _disposed = true;
            if (_window)
            {
                _window.dispose();
                _window = null;
            };
            if (_SafeStr_3919 != null)
            {
                _SafeStr_3919.dispose();
            };
            _SafeStr_3919 = null;
        }

        public function open(_arg_1:BreedPetsResultData, _arg_2:BreedPetsResultData):void
        {
            _SafeStr_3925 = _arg_1;
            _resultData2 = _arg_2;
            setWindowContent();
            show();
        }

        private function resolvePreviewImage(_arg_1:int, _arg_2:String):BitmapData
        {
            var _local_5:BitmapData;
            var _local_4:int;
            var _local_3:_SafeStr_147 = _SafeStr_1324.handler.container.roomEngine.getFurnitureImage(_arg_1, new Vector3d(90, 0, 0), 64, this, 0, null, -1, -1, null);
            if (_local_3 != null)
            {
                _local_4 = _local_3.id;
                if (_local_4 > 0)
                {
                    _SafeStr_3919.add(_local_4, _arg_2);
                };
                _local_5 = _local_3.data;
            };
            return (_local_5);
        }

        public function imageReady(_arg_1:int, _arg_2:BitmapData):void
        {
            if (disposed)
            {
                return;
            };
            var _local_3:String = _SafeStr_3919.getValue(_arg_1);
            if (_local_3 != null)
            {
                updatePreviewImage(_arg_2, _local_3);
            };
        }

        public function imageFailed(_arg_1:int):void
        {
        }

        private function setWindowContent():void
        {
            var _local_3:String;
            var _local_1:IFurnitureData = _SafeStr_1324.handler.container.sessionDataManager.getFloorItemData(_SafeStr_3925.classId);
            var _local_4:IFurnitureData = _SafeStr_1324.handler.container.sessionDataManager.getFloorItemData(_resultData2.classId);
            _SafeStr_1324.localizations.registerParameter("breedpetsresult.widget.seed1.name", "name", ((_local_1 != null) ? _local_1.localizedName : ""));
            _SafeStr_1324.localizations.registerParameter("breedpetsresult.widget.seed2.name", "name", ((_local_4 != null) ? _local_4.localizedName : ""));
            _SafeStr_1324.localizations.registerParameter("breedpetsresult.widget.seed1.description", "name", _SafeStr_3925.userName);
            _SafeStr_1324.localizations.registerParameter("breedpetsresult.widget.seed2.description", "name", _resultData2.userName);
            _SafeStr_1324.localizations.registerParameter("breedpetsresult.widget.seed1.raritylevel", "level", _SafeStr_3925.rarityLevel.toString());
            _SafeStr_1324.localizations.registerParameter("breedpetsresult.widget.seed2.raritylevel", "level", _resultData2.rarityLevel.toString());
            var _local_7:int = _SafeStr_1324.handler.container.sessionDataManager.userId;
            var _local_5:Boolean = (_SafeStr_3925.userId == _local_7);
            var _local_6:Boolean = (_resultData2.userId == _local_7);
            var _local_2:Boolean = ((_local_5) || (_local_6));
            if (!_local_2)
            {
                _local_3 = "";
                if (((!(_SafeStr_3925.userName == null)) && (!(_SafeStr_3925.userName == ""))))
                {
                    _local_3 = _SafeStr_3925.userName;
                }
                else
                {
                    if (((!(_resultData2.userName == null)) && (!(_resultData2.userName == ""))))
                    {
                        _local_3 = _resultData2.userName;
                    };
                };
                _SafeStr_1324.localization.registerParameter("breedpetsresult.widget.text.sorry", "name", _local_3);
            };
            if (!_window)
            {
                _window = (_windowManager.buildFromXML((_assets.getAssetByName("breed_pets_result_xml").content as XML)) as IFrameWindow);
                addClickListener("header_button_close");
            };
            _window.center();
            _window.visible = true;
            enableElement("seed1_buttonlist", false);
            enableElement("seed2_buttonlist", false);
            enableElement("place_button1", false);
            enableElement("pick_button1", false);
            enableElement("place_button2", false);
            enableElement("pick_button2", false);
            enableElement("close_button", false);
            if (_local_5)
            {
                enableElement("place_button1", true);
                enableElement("seed1_buttonlist", true);
            };
            if (_local_6)
            {
                enableElement("place_button2", true);
                enableElement("seed2_buttonlist", true);
            };
            if (_local_2)
            {
                enableElement("preview_buttonlist", true);
            };
            enableElement("seed2_itemlist", true);
            if (_resultData2.stuffId == -1)
            {
                enableElement("seed2_itemlist", false);
            };
            enableElement("description", true);
            enableElement("info", true);
            enableElement("description_sorry", false);
            enableElement("info", false);
            enableElement("button_list", false);
            enableElement("close_button", false);
            if (!_local_2)
            {
                enableElement("preview_buttonlist", false);
                enableElement("description", false);
                enableElement("info", false);
                enableElement("save_button", false);
                enableElement("place_button1", false);
                enableElement("pick_button1", false);
                enableElement("place_button2", false);
                enableElement("pick_button2", false);
                enableElement("button_list", true);
                enableElement("description_sorry", true);
                enableElement("info_sorry", true);
                enableElement("close_button", true);
            };
            enableElement("info_mutate1", false);
            enableElement("info_mutate2", false);
            if (_SafeStr_3925.hasMutation)
            {
                enableElement("info_mutate1", true);
            };
            if (_resultData2.hasMutation)
            {
                enableElement("info_mutate2", true);
            };
            addClickListener("save_button");
            addClickListener("header_button_close");
            addClickListener("close_button");
            addClickListener("place_button1");
            addClickListener("place_button2");
            addClickListener("pick_button1");
            addClickListener("pick_button2");
            addClickListener("preview_image_region");
            addClickListener("preview_image_region2");
            var _local_8:BitmapData = resolvePreviewImage(_local_1.id, "preview_image");
            updatePreviewImage(((_local_8 != null) ? _local_8 : new BitmapData(10, 10)), "preview_image");
            _local_8 = resolvePreviewImage(_local_1.id, "preview_image2");
            updatePreviewImage(((_local_8 != null) ? _local_8 : new BitmapData(10, 10)), "preview_image2");
            arrangeListItems();
            _window.invalidate();
        }

        private function enableElement(_arg_1:String, _arg_2:Boolean):void
        {
            var _local_3:IWindow = _window.findChildByName(_arg_1);
            if (_local_3 != null)
            {
                _local_3.visible = _arg_2;
            };
        }

        private function arrangeListItems():void
        {
            arrangeListItem("seed1_itemlist");
            arrangeListItem("seed2_itemlist");
            arrangeListItem("seed1_buttonlist");
            arrangeListItem("seed2_buttonlist");
            arrangeListItem("preview_buttonlist");
            arrangeListItem("button_list");
            arrangeListItem("preview_list");
            arrangeListItem("element_list");
            _window.resizeToFitContent();
        }

        private function arrangeListItem(_arg_1:String):void
        {
            var _local_2:IItemListWindow = (_window.findChildByName(_arg_1) as IItemListWindow);
            if (_local_2 != null)
            {
                _local_2.arrangeListItems();
            };
        }

        private function updatePreviewImage(_arg_1:BitmapData, _arg_2:String):void
        {
            var _local_5:BitmapData;
            if (((!(_window)) || (!(_arg_1))))
            {
                return;
            };
            var _local_6:IBitmapWrapperWindow = (_window.findChildByName(_arg_2) as IBitmapWrapperWindow);
            _local_6.bitmap = new BitmapData(_local_6.width, _local_6.height);
            var _local_3:IAsset = (_assets.getAssetByName("breed_pets_preview_bg_png") as IAsset);
            if (_local_3)
            {
                _local_5 = (_local_3.content as BitmapData);
                _local_6.bitmap.copyPixels(_local_5, _local_5.rect, new Point(0, 0));
            };
            var _local_4:Point = new Point(((_local_6.width - _arg_1.width) / 2), ((_local_6.height - _arg_1.height) / 2));
            _local_6.bitmap.copyPixels(_arg_1, _arg_1.rect, _local_4, null, null, true);
        }

        public function close():void
        {
            if (_SafeStr_1324)
            {
                _SafeStr_1324.removeBreedPetsResultView(this);
            };
        }

        public function show():void
        {
            _SafeStr_3926 = false;
            if (_window)
            {
                _window.visible = true;
            };
        }

        private function hide():void
        {
            if (_window)
            {
                _window.visible = false;
            };
        }

        private function addClickListener(_arg_1:String):void
        {
            var _local_2:IWindow = _window.findChildByName(_arg_1);
            if (_local_2 != null)
            {
                _local_2.addEventListener("WME_CLICK", onMouseClick);
            };
        }

        private function onMouseClick(_arg_1:WindowMouseEvent):void
        {
            switch (_arg_1.target.name)
            {
                case "header_button_close":
                case "close_button":
                    close();
                    return;
                case "place_button1":
                    _SafeStr_3926 = placeItemToRoom(_SafeStr_3925.stuffId);
                    if (_SafeStr_3926)
                    {
                        close();
                    };
                    return;
                case "place_button2":
                    _SafeStr_3926 = placeItemToRoom(_resultData2.stuffId);
                    if (_SafeStr_3926)
                    {
                        close();
                    };
                    return;
                case "pick_button1":
                    pickItemFromRoom(_SafeStr_3925.stuffId);
                    return;
                case "pick_button2":
                    pickItemFromRoom(_resultData2.stuffId);
                    return;
                case "preview_image_region":
                    selectItemFromInventoryOrRoom(_SafeStr_3925.stuffId);
                    return;
                case "preview_image_region2":
                    selectItemFromInventoryOrRoom(_resultData2.stuffId);
                    return;
                case "ok_button":
                    hide();
                    return;
                case "save_button":
                    hide();
                    return;
                default:
                    return;
            };
        }

        private function selectItemFromInventoryOrRoom(_arg_1:int):Boolean
        {
            var _local_4:int;
            var _local_5:int;
            var _local_2:IFurnitureItem = findInventoryFloorItemById(_arg_1);
            if (_local_2 != null)
            {
                _SafeStr_1324.handler.container.inventory.toggleInventoryPage("furni");
                return (true);
            };
            var _local_3:IRoomObject = findRoomObject(_arg_1);
            if (_local_3 != null)
            {
                _local_4 = _SafeStr_1324.handler.container.roomSession.roomId;
                _local_5 = 10;
                _SafeStr_1324.handler.container.roomEngine.selectRoomObject(_local_4, _local_3.getId(), _local_5);
                return (true);
            };
            return (false);
        }

        private function pickItemFromRoom(_arg_1:int):Boolean
        {
            var _local_2:IRoomObject = findRoomObject(_arg_1);
            if (_local_2 != null)
            {
                _SafeStr_1324.handler.container.roomEngine.modifyRoomObject(_local_2.getId(), 10, "OBJECT_PICKUP");
                return (true);
            };
            return (false);
        }

        private function placeItemToRoom(_arg_1:int):Boolean
        {
            var _local_2:IFurnitureItem = findInventoryFloorItemById(_arg_1);
            return (requestSelectedFurniPlacement(_local_2));
        }

        private function findRoomObject(_arg_1:int):IRoomObject
        {
            var _local_3:int = _SafeStr_1324.handler.container.roomSession.roomId;
            var _local_4:int = 10;
            return (_SafeStr_1324.handler.container.roomEngine.getRoomObject(_local_3, _arg_1, _local_4));
        }

        private function findInventoryFloorItemById(_arg_1:int):IFurnitureItem
        {
            if (_SafeStr_1324 == null)
            {
                return (null);
            };
            var _local_3:IHabboInventory = _SafeStr_1324.handler.container.inventory;
            if (_local_3 == null)
            {
                return (null);
            };
            return (_local_3.getFloorItemById(-(_arg_1)));
        }

        private function requestSelectedFurniPlacement(_arg_1:IFurnitureItem):Boolean
        {
            if (((_arg_1 == null) || (_SafeStr_1324 == null)))
            {
                return (false);
            };
            var _local_3:IHabboInventory = _SafeStr_1324.handler.container.inventory;
            if (_local_3 == null)
            {
                return (false);
            };
            var _local_2:Boolean;
            if ((((_arg_1.category == 3) || (_arg_1.category == 2)) || (_arg_1.category == 4)))
            {
                _local_2 = false;
            }
            else
            {
                _local_2 = _local_3.requestSelectedFurniToMover(_arg_1);
            };
            return (_local_2);
        }

        public function roomObjectRemoved(_arg_1:int):void
        {
            if (((_SafeStr_3925 == null) || (_resultData2 == null)))
            {
                return;
            };
            if (((_SafeStr_3925.stuffId == _arg_1) || (_resultData2.stuffId == _arg_1)))
            {
                updatePlacingButtons();
                show();
            };
        }

        public function roomObjectAdded(_arg_1:int):void
        {
            if (((_SafeStr_3925 == null) || (_resultData2 == null)))
            {
                return;
            };
            if (((_SafeStr_3925.stuffId == _arg_1) || (_resultData2.stuffId == _arg_1)))
            {
                updatePlacingButtons();
                show();
            };
        }

        public function updatePlacingButtons():void
        {
            updateButtons(_SafeStr_3925, "place_button1", "pick_button1");
            updateButtons(_resultData2, "place_button2", "pick_button2");
            arrangeListItems();
        }

        private function updateButtons(_arg_1:BreedPetsResultData, _arg_2:String, _arg_3:String):void
        {
            var _local_5:IFurnitureItem;
            if (((_window == null) || (_arg_1 == null)))
            {
                return;
            };
            var _local_10:int = _SafeStr_1324.handler.container.sessionDataManager.userId;
            var _local_4:Boolean = (_arg_1.userId == _local_10);
            var _local_9:Boolean;
            var _local_8:Boolean;
            var _local_7:IRoomObject = findRoomObject(_arg_1.stuffId);
            if (_local_7 != null)
            {
                _local_8 = true;
            };
            if (!_local_8)
            {
                _local_5 = findInventoryFloorItemById(_arg_1.stuffId);
                if (_local_5 != null)
                {
                    _local_9 = true;
                };
            };
            var _local_6:IWindow = _window.findChildByName(_arg_2);
            var _local_11:IWindow = _window.findChildByName(_arg_3);
            if (_local_6 != null)
            {
                _local_6.visible = false;
                if (_local_4)
                {
                    if (_local_9)
                    {
                        _local_6.visible = true;
                    };
                    if (((!(_local_9)) && (!(_local_8))))
                    {
                        _local_6.visible = true;
                    };
                };
            };
            if (_local_11 != null)
            {
                _local_11.visible = false;
                if (_local_4)
                {
                    if (_local_8)
                    {
                        _local_11.visible = true;
                    };
                };
            };
        }


    }
}

