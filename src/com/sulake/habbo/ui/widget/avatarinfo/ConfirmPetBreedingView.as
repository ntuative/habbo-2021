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
    import com.sulake.habbo.ui.widget.events.BreedingRarityCategoryData;
    import com.sulake.core.window.components.ITextFieldWindow;
    import flash.geom.Point;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class ConfirmPetBreedingView implements IDisposable, IGetImageListener 
    {

        private static const ELEM_LIST:String = "element_list";
        private static const PREVIEW_LIST:String = "preview_list";
        private static const ELEM_PET1_ITEMLIST:String = "pet1_itemlist";
        private static const ELEM_PET2_ITEMLIST:String = "pet2_itemlist";
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
        private var _SafeStr_3929:Boolean = false;
        private var _stuffId:int;
        private var _SafeStr_3930:Array;
        private var _SafeStr_3931:int;

        public function ConfirmPetBreedingView(_arg_1:AvatarInfoWidget)
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

        public function open(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:Array, _arg_5:int, _arg_6:int, _arg_7:int):void
        {
            _requestRoomObjectId = _arg_1;
            _targetRoomObjectId = _arg_2;
            _SafeStr_3920 = _SafeStr_1324.handler.roomSession.userDataManager.getUserDataByIndex(_arg_1);
            _petData2 = _SafeStr_1324.handler.roomSession.userDataManager.getUserDataByIndex(_arg_2);
            _SafeStr_3920.petLevel = _arg_6;
            _petData2.petLevel = _arg_7;
            _SafeStr_3930 = _arg_4;
            _SafeStr_3931 = _arg_5;
            _stuffId = _arg_3;
            setWindowContent();
            _window.visible = true;
        }

        private function resolvePreviewImage(_arg_1:String, _arg_2:String, _arg_3:int=64):BitmapData
        {
            var _local_8:BitmapData;
            var _local_7:int;
            var _local_4:PetFigureData = new PetFigureData(_arg_1);
            var _local_5:String = "std";
            var _local_6:_SafeStr_147 = _SafeStr_1324.handler.roomEngine.getPetImage(_local_4.typeId, _local_4.paletteId, _local_4.color, new Vector3d(90), _arg_3, this, true, 0, _local_4.customParts, _local_5);
            if (_local_6 != null)
            {
                _local_7 = _local_6.id;
                if (_local_7 > 0)
                {
                    _SafeStr_3919.add(_local_7, _arg_2);
                };
                _local_8 = _local_6.data;
            };
            return (_local_8);
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
            var _local_8:IItemListWindow;
            var _local_1:PetFigureData;
            var _local_5:IBitmapWrapperWindow;
            _SafeStr_1324.localizations.registerParameter("breedpets.widget.title", "name", _SafeStr_3920.name);
            _SafeStr_1324.localizations.registerParameter("breedpets.widget.pet1.name", "name", _SafeStr_3920.name);
            _SafeStr_1324.localizations.registerParameter("breedpets.widget.pet2.name", "name", _petData2.name);
            _SafeStr_1324.localizations.registerParameter("breedpets.widget.pet1.description", "name", _SafeStr_3920.ownerName);
            _SafeStr_1324.localizations.registerParameter("breedpets.widget.pet2.description", "name", _petData2.ownerName);
            _SafeStr_1324.localizations.registerParameter("breedpets.widget.pet1.level", "level", _SafeStr_3920.petLevel.toString());
            _SafeStr_1324.localizations.registerParameter("breedpets.widget.pet2.level", "level", _petData2.petLevel.toString());
            _SafeStr_1324.localizations.registerParameter("breedpets.widget.request", "name", _petData2.ownerName);
            if (!_window)
            {
                _window = (_windowManager.buildFromXML((_assets.getAssetByName("confirm_pet_breeding_xml").content as XML)) as IFrameWindow);
                addClickListener("header_button_close");
            };
            _window.center();
            _window.visible = true;
            addClickListener("save_button");
            addClickListener("cancel_button");
            enable();
            var _local_6:BitmapData = resolvePreviewImage(_SafeStr_3920.figure, "preview_image");
            updatePreviewImage(((_local_6 != null) ? _local_6 : new BitmapData(10, 10)), "preview_image");
            _local_6 = resolvePreviewImage(_petData2.figure, "preview_image2");
            updatePreviewImage(((_local_6 != null) ? _local_6 : new BitmapData(10, 10)), "preview_image2");
            var _local_4:IBitmapWrapperWindow = (_windowManager.buildFromXML((_assets.getAssetByName("pet_breeding_pet_preview_xml").content as XML)) as IBitmapWrapperWindow);
            var _local_2:int = 1;
            for each (var _local_3:BreedingRarityCategoryData in _SafeStr_3930)
            {
                _SafeStr_1324.localizations.registerParameter(("breedpets.confirmation.widget.raritycategory." + _local_2), "percent", _local_3.chance.toString());
                _local_8 = (_window.findChildByName(("breeds" + _local_2)) as IItemListWindow);
                _local_8.removeListItems();
                for each (var _local_7:int in _local_3.breeds)
                {
                    _local_1 = new PetFigureData([_SafeStr_3931, _local_7].join(" "));
                    _local_5 = (_local_4.clone() as IBitmapWrapperWindow);
                    _local_5.name = ("breed." + _local_7);
                    _local_5.bitmap = new BitmapData(_local_5.width, _local_5.height, true, 0xFFFFFF);
                    if (_local_8)
                    {
                        _local_8.addListItem(_local_5);
                    };
                    _local_6 = resolvePreviewImage(_local_1.figureString, _local_5.name, 64);
                    updatePreviewImage(((_local_6 != null) ? _local_6 : new BitmapData(25, 25, true, 0xFFFFFF)), _local_5.name);
                };
                _local_2++;
            };
            arrangeListItems();
            (_window.findChildByName("puppy.name.input") as ITextFieldWindow).setSelection(0, 0);
            _window.invalidate();
        }

        private function arrangeListItems():void
        {
            arrangeListItem("button_list");
            arrangeListItem("pet1_itemlist");
            arrangeListItem("pet2_itemlist");
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
            if (((!(_window)) || (!(_arg_1))))
            {
                return;
            };
            var _local_4:IBitmapWrapperWindow = (_window.findChildByName(_arg_2) as IBitmapWrapperWindow);
            _local_4.bitmap = new BitmapData(_local_4.width, _local_4.height, true, 0xFFFFFF);
            var _local_3:Point = new Point(((_local_4.width - _arg_1.width) / 2), ((_local_4.height - _arg_1.height) / 2));
            _local_4.bitmap.copyPixels(_arg_1, _arg_1.rect, _local_3, null, null, true);
        }

        public function close():void
        {
            if (_window)
            {
                _window.visible = false;
            };
        }

        private function disable():void
        {
            enableElement("description", false, false);
            enableElement("request", false, false);
            enableElement("cancel_button", false, true);
            enableElement("description", false, true);
            enableElement("save_button", false, true);
        }

        public function enable():void
        {
            enableElement("description", false, false);
            enableElement("request", false, false);
            enableElement("cancel_button", true, true);
            enableElement("description", true, true);
            enableElement("save_button", true, true);
        }

        private function addClickListener(_arg_1:String):void
        {
            var _local_2:IWindow = _window.findChildByName(_arg_1);
            if (_local_2 != null)
            {
                _local_2.addEventListener("WME_CLICK", onMouseClick);
            };
        }

        private function enableElement(_arg_1:String, _arg_2:Boolean, _arg_3:Boolean):void
        {
            var _local_4:IWindow = _window.findChildByName(_arg_1);
            if (_local_4 != null)
            {
                _local_4.visible = _arg_3;
                if (_arg_2)
                {
                    _local_4.enable();
                }
                else
                {
                    _local_4.disable();
                };
            };
        }

        private function onMouseClick(_arg_1:WindowMouseEvent):void
        {
            var _local_2:String;
            switch (_arg_1.target.name)
            {
                case "header_button_close":
                case "cancel_button":
                    _SafeStr_1324.cancelPetBreeding(_stuffId);
                    close();
                    return;
                case "ok_button":
                    disable();
                    return;
                case "save_button":
                    _local_2 = _window.findChildByName("puppy.name.input").caption;
                    if (_local_2.length == 0)
                    {
                        _windowManager.simpleAlert("${breedpets.confirmation.alert.title}", "${breedpets.confirmation.alert.name.required.head}", "${breedpets.confirmation.alert.name.required.desc}");
                    }
                    else
                    {
                        _SafeStr_1324.confirmPetBreeding(_stuffId, _local_2, _SafeStr_3920.webID, _petData2.webID);
                        disable();
                    };
                    return;
            };
        }


    }
}

