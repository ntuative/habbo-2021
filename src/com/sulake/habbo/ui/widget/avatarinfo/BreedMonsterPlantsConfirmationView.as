package com.sulake.habbo.ui.widget.avatarinfo
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.session.IUserData;
    import flash.display.BitmapData;
    import com.sulake.habbo.avatar.pets.PetFigureData;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.habbo.room._SafeStr_147;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.assets.IAsset;
    import flash.geom.Point;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class BreedMonsterPlantsConfirmationView implements IDisposable, IGetImageListener 
    {

        private static const STATE_NORMAL:int = 0;
        private static const STATE_REQUESTED:int = 1;
        private static const ELEM_LIST:String = "element_list";
        private static const PREVIEW_LIST:String = "preview_list";
        private static const ELEM_PLANT1_ITEMLIST:String = "plant1_itemlist";
        private static const ELEM_PLANT2_ITEMLIST:String = "plant2_itemlist";
        private static const _SafeStr_3917:String = "description";
        private static const ELEM_REQUEST:String = "request";
        private static const _SafeStr_3113:String = "header_button_close";
        private static const _SafeStr_3118:String = "save_button";
        private static const _SafeStr_3918:String = "accept_button";
        private static const _SafeStr_3114:String = "cancel_button";
        private static const _SafeStr_3119:String = "ok_button";
        private static const BUTTON_LIST:String = "button_list";

        private var _window:IFrameWindow;
        private var _disposed:Boolean = false;
        private var _SafeStr_1324:AvatarInfoWidget;
        private var _windowManager:IHabboWindowManager;
        private var _assets:IAssetLibrary;
        private var _SafeStr_3919:Map;
        private var _requestRoomObjectId:int;
        private var _targetRoomObjectId:int;
        private var _SafeStr_3920:IUserData;
        private var _petData2:IUserData;
        private var _SafeStr_448:int = 0;

        public function BreedMonsterPlantsConfirmationView(_arg_1:AvatarInfoWidget)
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

        public function get requestRoomObjectId():int
        {
            return (_requestRoomObjectId);
        }

        public function get targetRoomObjectId():int
        {
            return (_targetRoomObjectId);
        }

        public function open(_arg_1:int, _arg_2:int, _arg_3:Boolean):void
        {
            _requestRoomObjectId = _arg_1;
            _targetRoomObjectId = _arg_2;
            _SafeStr_3920 = _SafeStr_1324.handler.roomSession.userDataManager.getUserDataByIndex(_arg_1);
            _petData2 = _SafeStr_1324.handler.roomSession.userDataManager.getUserDataByIndex(_arg_2);
            _SafeStr_448 = ((_arg_3) ? 1 : 0);
            setWindowContent();
            _window.visible = true;
        }

        private function resolvePreviewImage(_arg_1:String, _arg_2:String):BitmapData
        {
            var _local_7:BitmapData;
            var _local_6:int;
            var _local_3:PetFigureData = new PetFigureData(_arg_1);
            var _local_4:String = "std";
            var _local_5:_SafeStr_147 = _SafeStr_1324.handler.roomEngine.getPetImage(_local_3.typeId, _local_3.paletteId, _local_3.color, new Vector3d(90), 64, this, true, 0, _local_3.customParts, _local_4);
            if (_local_5 != null)
            {
                _local_6 = _local_5.id;
                if (_local_6 > 0)
                {
                    _SafeStr_3919.add(_local_6, _arg_2);
                };
                _local_7 = _local_5.data;
            };
            return (_local_7);
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
            _SafeStr_1324.localizations.registerParameter("breedpets.widget.title", "name", _SafeStr_3920.name);
            _SafeStr_1324.localizations.registerParameter("breedpets.widget.plant1.name", "name", _SafeStr_3920.name);
            _SafeStr_1324.localizations.registerParameter("breedpets.widget.plant2.name", "name", _petData2.name);
            _SafeStr_1324.localizations.registerParameter("breedpets.widget.plant1.description", "name", _SafeStr_3920.ownerName);
            _SafeStr_1324.localizations.registerParameter("breedpets.widget.plant2.description", "name", _petData2.ownerName);
            _SafeStr_1324.localizations.registerParameter("breedpets.widget.plant1.raritylevel", "level", _SafeStr_3920.rarityLevel.toString());
            _SafeStr_1324.localizations.registerParameter("breedpets.widget.plant2.raritylevel", "level", _petData2.rarityLevel.toString());
            _SafeStr_1324.localizations.registerParameter("breedpets.widget.request", "name", _petData2.ownerName);
            if (!_window)
            {
                _window = (_windowManager.buildFromXML((_assets.getAssetByName("breed_pets_confirmation_xml").content as XML)) as IFrameWindow);
                addClickListener("header_button_close");
            };
            _window.center();
            _window.visible = true;
            addClickListener("save_button");
            addClickListener("accept_button");
            addClickListener("cancel_button");
            enableElement("description", false);
            enableElement("request", false);
            enableElement("save_button", false);
            enableElement("save_button", false);
            enableElement("accept_button", false);
            enableElement("cancel_button", true);
            enableElement("cancel_button", true);
            switch (_SafeStr_448)
            {
                case 0:
                    enableElement("description", true);
                    enableElement("save_button", true);
                    break;
                case 1:
                    enableElement("request", true);
                    enableElement("accept_button", true);
                default:
            };
            var _local_1:BitmapData = resolvePreviewImage(_SafeStr_3920.figure, "preview_image");
            updatePreviewImage(((_local_1 != null) ? _local_1 : new BitmapData(10, 10)), "preview_image");
            _local_1 = resolvePreviewImage(_petData2.figure, "preview_image2");
            updatePreviewImage(((_local_1 != null) ? _local_1 : new BitmapData(10, 10)), "preview_image2");
            arrangeListItems();
            _window.invalidate();
        }

        private function arrangeListItems():void
        {
            arrangeListItem("button_list");
            arrangeListItem("plant1_itemlist");
            arrangeListItem("plant2_itemlist");
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

        private function close():void
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

        private function enableElement(_arg_1:String, _arg_2:Boolean):void
        {
            var _local_3:IWindow = _window.findChildByName(_arg_1);
            if (_local_3 != null)
            {
                _local_3.visible = _arg_2;
            };
        }

        private function onMouseClick(_arg_1:WindowMouseEvent):void
        {
            switch (_arg_1.target.name)
            {
                case "header_button_close":
                case "cancel_button":
                    _SafeStr_1324.cancelBreedPets(_requestRoomObjectId, _targetRoomObjectId);
                    close();
                    return;
                case "ok_button":
                    close();
                    return;
                case "accept_button":
                    close();
                    _SafeStr_1324.acceptBreedPets(_requestRoomObjectId, _targetRoomObjectId);
                    return;
                case "save_button":
                    _SafeStr_1324.breedPets(_requestRoomObjectId, _targetRoomObjectId);
                    if (_SafeStr_3920.ownerId != _petData2.ownerId)
                    {
                        _SafeStr_1324.showBreedingPetsWaitingConfirmationAlert(requestRoomObjectId, _targetRoomObjectId);
                    };
                    close();
                    return;
            };
        }


    }
}

