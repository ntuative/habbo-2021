package com.sulake.habbo.ui.widget.avatarinfo
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.habbo.session.IUserData;
    import com.sulake.room.object.IRoomObject;
    import flash.display.BitmapData;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.IAsset;
    import com.sulake.habbo.room._SafeStr_147;
    import com.sulake.habbo.avatar.pets.PetCustomPart;
    import com.sulake.habbo.room.PetColorResult;
    import com.sulake.habbo.avatar.pets.PetFigureData;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.geom.Point;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetUseProductMessage;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class UseProductConfirmationView implements IDisposable, IGetImageListener
    {

        private static const PRODUCT_PAGE_UKNOWN:int = -1;
        private static const PRODUCT_PAGE_SHAMPOO:int = 0;
        private static const PRODUCT_PAGE_CUSTOM_PART:int = 1;
        private static const PRODUCT_PAGE_CUSTOM_PART_SHAMPOO:int = 2;
        private static const PRODUCT_PAGE_SADDLE:int = 3;
        private static const PRODUCT_PAGE_REVIVE:int = 4;
        private static const PRODUCT_PAGE_REBREED:int = 5;
        private static const PRODUCT_PAGE_FERTILIZE:int = 6;
        private static const _SafeStr_3113:String = "header_button_close";
        private static const _SafeStr_3118:String = "save_button";
        private static const _SafeStr_3937:String = "cancel_text";
        private static const _SafeStr_3119:String = "ok_button";
        private static const _SafeStr_3922:String = "preview_image_region";

        private var _window:IWindowContainer;
        private var _disposed:Boolean = false;
        private var _SafeStr_1324:AvatarInfoWidget;
        private var _windowManager:IHabboWindowManager;
        private var _assets:IAssetLibrary;
        private var _requestObjectId:int = -1;
        private var _targetRoomObjectId:int = -1;
        private var _SafeStr_1593:int;
        private var _SafeStr_537:IFurnitureData;
        private var _SafeStr_3920:IUserData;

        public function UseProductConfirmationView(_arg_1:AvatarInfoWidget)
        {
            _SafeStr_1324 = _arg_1;
            _windowManager = _arg_1.windowManager;
            _assets = _SafeStr_1324.assets;
        }

        public function get requestObjectId():int
        {
            return (_requestObjectId);
        }

        public function get targetRoomObjectId():int
        {
            return (_targetRoomObjectId);
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
            if (_window)
            {
                _window.dispose();
                _window = null;
            };
            _disposed = true;
            _SafeStr_537 = null;
            _SafeStr_3920 = null;
        }

        public function open(_arg_1:int, _arg_2:int, _arg_3:int):void
        {
            var _local_5:int = _SafeStr_1324.handler.roomSession.roomId;
            var _local_6:IRoomObject = _SafeStr_1324.handler.roomEngine.getRoomObject(_local_5, _arg_1, 10);
            if (_local_6 != null)
            {
                _SafeStr_537 = _SafeStr_1324.handler.getFurniData(_local_6);
                _requestObjectId = _local_6.getId();
            }
            else
            {
                _SafeStr_537 = _SafeStr_1324.handler.container.sessionDataManager.getFloorItemData(_arg_1);
                _requestObjectId = _arg_3;
            };
            _targetRoomObjectId = _arg_2;
            _SafeStr_3920 = _SafeStr_1324.handler.roomSession.userDataManager.getUserDataByIndex(_arg_2);
            var _local_4:int = -1;
            switch (_SafeStr_537.category)
            {
                case 13:
                    _local_4 = 0;
                    break;
                case 14:
                    _local_4 = 1;
                    break;
                case 15:
                    _local_4 = 2;
                    break;
                case 16:
                    _local_4 = 3;
                    break;
                case 20:
                    _local_4 = 4;
                    break;
                case 21:
                    _local_4 = 5;
                    break;
                case 22:
                    _local_4 = 6;
                    break;
                default:
                    Logger.log(("[UseProductConfirmationView.open()] Unsupported furniture category: " + _SafeStr_537.category));
            };
            setWindowContent(_local_4);
            _window.center();
            _window.visible = true;
        }

        private function setWindowContent(_arg_1:int):void
        {
            var _local_3:String;
            var _local_2:BitmapData = new BitmapData(10, 10);
            _SafeStr_1324.localizations.registerParameter("useproduct.widget.title", "name", _SafeStr_3920.name);
            _SafeStr_1324.localizations.registerParameter("useproduct.widget.title.monsterplant", "name", _SafeStr_3920.name);
            _SafeStr_1324.localizations.registerParameter("useproduct.widget.title.monsterplant_rebreed", "name", _SafeStr_3920.name);
            _SafeStr_1324.localizations.registerParameter("useproduct.widget.title.monsterplant_fertilize", "name", _SafeStr_3920.name);
            _SafeStr_1324.localizations.registerParameter("useproduct.widget.title.monsterplant_rebreed", "name", _SafeStr_3920.name);
            _SafeStr_1324.localizations.registerParameter("useproduct.widget.monsterplant.plant.name", "name", _SafeStr_3920.name);
            _SafeStr_1324.localizations.registerParameter("useproduct.widget.monsterplant.plant.raritylevel", "level", _SafeStr_3920.rarityLevel.toString());
            _SafeStr_1324.localizations.registerParameter("useproduct.widget.monsterplant.plant.description", "name", _SafeStr_3920.ownerName);
            if (!_window)
            {
                _local_3 = "use_product_widget_frame_xml";
                switch (_arg_1)
                {
                    case 4:
                        _local_3 = "use_product_widget_frame_monsterplant_xml";
                        break;
                    case 5:
                        _local_3 = "use_product_widget_frame_monsterplant_rebreed_xml";
                        break;
                    case 6:
                        _local_3 = "use_product_widget_frame_monsterplant_fertilize_xml";
                        break;
                    default:
                        _local_3 = "use_product_widget_frame_xml";
                };
                _window = (_windowManager.buildFromXML((_assets.getAssetByName(_local_3).content as XML)) as IWindowContainer);
                addClickListener("header_button_close");
            };
            _SafeStr_1324.localizations.registerParameter("useproduct.widget.text.saddle", "productName", _SafeStr_537.localizedName);
            _SafeStr_1324.localizations.registerParameter("useproduct.widget.text.custompart", "productName", _SafeStr_537.localizedName);
            _SafeStr_1324.localizations.registerParameter("useproduct.widget.text.custompartshampoo", "productName", _SafeStr_537.localizedName);
            _SafeStr_1324.localizations.registerParameter("useproduct.widget.text.shampoo", "productName", _SafeStr_537.localizedName);
            _SafeStr_1324.localizations.registerParameter("useproduct.widget.text.revive_monsterplant", "productName", _SafeStr_537.localizedName);
            (_window as IFrameWindow).content.removeChildAt(0);
            var _local_4:IWindow = createWindow(_arg_1);
            (_window as IFrameWindow).content.addChild(_local_4);
            (_window as IFrameWindow).resizeToFitContent();
            switch (_arg_1)
            {
                case 0:
                case 1:
                case 2:
                case 3:
                case 4:
                case 5:
                case 6:
                    addClickListener("preview_image_region");
                    addClickListener("save_button");
                    addClickListener("cancel_text");
                    _local_2 = resolvePreviewImage(_SafeStr_537);
                    break;
                default:
                    throw (new Error(("Invalid type for use product confirmation content apply: " + _arg_1)));
            };
            updatePreviewImage(_local_2);
            _window.invalidate();
        }

        private function createWindow(_arg_1:int):IWindow
        {
            var _local_2:IAsset;
            var _local_3:IWindow;
            switch (_arg_1)
            {
                case 0:
                    _local_2 = _assets.getAssetByName("use_product_controller_shampoo_xml");
                    break;
                case 1:
                    _local_2 = _assets.getAssetByName("use_product_controller_custom_part_xml");
                    break;
                case 2:
                    _local_2 = _assets.getAssetByName("use_product_controller_custom_part_shampoo_xml");
                    break;
                case 3:
                    _local_2 = _assets.getAssetByName("use_product_controller_saddle_xml");
                    break;
                case 4:
                    _local_2 = _assets.getAssetByName("use_product_controller_revive_monsterplant_xml");
                    break;
                case 5:
                    _local_2 = _assets.getAssetByName("use_product_controller_rebreed_monsterplant_xml");
                    break;
                case 6:
                    _local_2 = _assets.getAssetByName("use_product_controller_fertilize_monsterplant_xml");
                    break;
                default:
                    throw (new Error(("Invalid type for Use Product View content creation: " + _arg_1)));
            };
            return (_windowManager.buildFromXML((_local_2.content as XML)) as IWindow);
        }

        private function resolvePreviewImage(_arg_1:IFurnitureData):BitmapData
        {
            var _local_7:_SafeStr_147;
            var _local_21:Array;
            var _local_16:Array;
            var _local_18:Array;
            var _local_9:int;
            var _local_23:BitmapData;
            var _local_2:int;
            var _local_14:int;
            var _local_5:int;
            var _local_20:PetCustomPart;
            var _local_19:String;
            var _local_11:Array;
            var _local_10:PetColorResult;
            var _local_8:String;
            var _local_15:IRoomObject;
            var _local_6:int;
            if (!_arg_1)
            {
                return (null);
            };
            var _local_12:PetFigureData = new PetFigureData(_SafeStr_3920.figure);
            var _local_3:Array = _arg_1.customParams.split(" ");
            var _local_17:int = _local_3[0];
            var _local_22:Array = [];
            switch (_arg_1.category)
            {
                case 13:
                    if (_local_3.length < 2)
                    {
                        Logger.log(("[UseProductConfirmationView] Invalid custom params: " + _local_3));
                        break;
                    };
                    _local_19 = _local_3[1];
                    _local_11 = _SafeStr_1324.handler.roomEngine.getPetColorsByTag(_local_17, _local_19);
                    _local_10 = _SafeStr_1324.handler.roomEngine.getPetColor(_local_17, _local_12.paletteId);
                    for each (var _local_4:PetColorResult in _local_11)
                    {
                        if (_local_4.breed == _local_10.breed)
                        {
                            _local_2 = int(_local_4.id);
                            break;
                        };
                    };
                    _local_7 = _SafeStr_1324.handler.roomEngine.getPetImage(_local_12.typeId, _local_2, _local_12.color, new Vector3d(90), 64, this, true, 0, _local_12.customParts);
                    break;
                case 14:
                    if (_local_3.length < 4)
                    {
                        Logger.log(("[UseProductConfirmationView] Invalid custom params: " + _local_3));
                        break;
                    };
                    _local_21 = (_local_3[1] as String).split(",");
                    _local_16 = (_local_3[2] as String).split(",");
                    _local_18 = (_local_3[3] as String).split(",");
                    _local_9 = 0;
                    while (_local_9 < _local_21.length)
                    {
                        _local_14 = _local_21[_local_9];
                        _local_20 = _local_12.getCustomPart(_local_14);
                        _local_2 = _local_18[_local_9];
                        if (_local_20 != null)
                        {
                            _local_2 = _local_20.paletteId;
                        };
                        _local_22.push(new PetCustomPart(_local_14, _local_16[_local_9], _local_2));
                        _local_9++;
                    };
                    _local_7 = _SafeStr_1324.handler.roomEngine.getPetImage(_local_12.typeId, _local_12.paletteId, _local_12.color, new Vector3d(90), 64, this, true, 0, _local_22);
                    break;
                case 15:
                    if (_local_3.length < 3)
                    {
                        Logger.log(("[UseProductConfirmationView] Invalid custom params: " + _local_3));
                        break;
                    };
                    _local_21 = (_local_3[1] as String).split(",");
                    _local_18 = (_local_3[2] as String).split(",");
                    _local_9 = 0;
                    while (_local_9 < _local_21.length)
                    {
                        _local_14 = _local_21[_local_9];
                        _local_20 = _local_12.getCustomPart(_local_14);
                        _local_5 = -1;
                        if (_local_20 != null)
                        {
                            _local_5 = _local_20.partId;
                        };
                        _local_22.push(new PetCustomPart(_local_21[_local_9], _local_5, _local_18[_local_9]));
                        _local_9++;
                    };
                    _local_7 = _SafeStr_1324.handler.roomEngine.getPetImage(_local_12.typeId, _local_12.paletteId, _local_12.color, new Vector3d(90), 64, this, true, 0, _local_22);
                    break;
                case 16:
                    if (_local_3.length < 4)
                    {
                        Logger.log(("[UseProductConfirmationView] Invalid custom params: " + _local_3));
                        break;
                    };
                    _local_21 = (_local_3[1] as String).split(",");
                    _local_16 = (_local_3[2] as String).split(",");
                    _local_18 = (_local_3[3] as String).split(",");
                    _local_9 = 0;
                    while (_local_9 < _local_21.length)
                    {
                        _local_22.push(new PetCustomPart(_local_21[_local_9], _local_16[_local_9], _local_18[_local_9]));
                        _local_9++;
                    };
                    for each (var _local_13:PetCustomPart in _local_12.customParts)
                    {
                        if (_local_21.indexOf(_local_13.layerId) == -1)
                        {
                            _local_22.push(_local_13);
                        };
                    };
                    _local_7 = _SafeStr_1324.handler.roomEngine.getPetImage(_local_12.typeId, _local_12.paletteId, _local_12.color, new Vector3d(90), 64, this, true, 0, _local_22);
                    break;
                case 20:
                case 21:
                case 22:
                    _local_8 = null;
                    if (_SafeStr_3920 != null)
                    {
                        _local_8 = "rip";
                        _local_15 = getRoomUserObject(_SafeStr_3920.roomObjectId);
                        if (_local_15 != null)
                        {
                            _local_8 = _local_15.getModel().getString("figure_posture");
                            if (_local_8 == "rip")
                            {
                                _local_6 = _SafeStr_3920.petLevel;
                                if (_local_6 < 7)
                                {
                                    _local_8 = ("grw" + _local_6);
                                }
                                else
                                {
                                    _local_8 = "std";
                                };
                            };
                        };
                    };
                    _local_7 = _SafeStr_1324.handler.roomEngine.getPetImage(_local_12.typeId, _local_12.paletteId, _local_12.color, new Vector3d(90), 64, this, true, 0, _local_12.customParts, _local_8);
                    break;
                default:
                    Logger.log(("[UseProductConfirmationView] Unsupported furniture category: " + _arg_1.category));
            };
            if (_local_7 != null)
            {
                _SafeStr_1593 = _local_7.id;
                _local_23 = _local_7.data;
            };
            return (_local_23);
        }

        private function getRoomUserObject(_arg_1:int):IRoomObject
        {
            return (_SafeStr_1324.handler.roomEngine.getRoomObject(_SafeStr_1324.handler.roomEngine.activeRoomId, _arg_1, 100));
        }

        private function updatePreviewImage(_arg_1:BitmapData):void
        {
            var _local_4:BitmapData;
            if (((!(_window)) || (!(_arg_1))))
            {
                return;
            };
            var _local_5:IBitmapWrapperWindow = (_window.findChildByName("preview_image") as IBitmapWrapperWindow);
            if (_local_5.bitmap == null)
            {
                _local_5.bitmap = new BitmapData(_local_5.width, _local_5.height);
            };
            var _local_2:IAsset = (_assets.getAssetByName("use_product_preview_bg_png") as IAsset);
            if (_local_2)
            {
                _local_4 = (_local_2.content as BitmapData);
                _local_5.bitmap.copyPixels(_local_4, _local_4.rect, new Point(0, 0));
            };
            var _local_3:Point = new Point(((_local_5.width - _arg_1.width) / 2), ((_local_5.height - _arg_1.height) / 2));
            _local_5.bitmap.copyPixels(_arg_1, _arg_1.rect, _local_3, null, null, true);
        }

        private function close():void
        {
            _window.visible = false;
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
            var _local_2:RoomWidgetMessage;
            switch (_arg_1.target.name)
            {
                case "preview_image_region":
                    if (_SafeStr_3920 != null)
                    {
                        selectItemFromRoom(_SafeStr_3920.roomObjectId, 100);
                    };
                    break;
                case "header_button_close":
                case "cancel_text":
                case "ok_button":
                    close();
                    break;
                case "save_button":
                    _local_2 = new RoomWidgetUseProductMessage("RWUPM_PET_PRODUCT", _requestObjectId, _SafeStr_3920.webID);
                    close();
            };
            if (_local_2)
            {
                _SafeStr_1324.messageListener.processWidgetMessage(_local_2);
            };
        }

        public function imageReady(_arg_1:int, _arg_2:BitmapData):void
        {
            if (disposed)
            {
                return;
            };
            if (_SafeStr_1593 == _arg_1)
            {
                updatePreviewImage(_arg_2);
                _SafeStr_1593 = 0;
            };
        }

        public function imageFailed(_arg_1:int):void
        {
        }

        private function selectItemFromRoom(_arg_1:int, _arg_2:int):Boolean
        {
            var _local_4:int;
            var _local_3:IRoomObject = findRoomObject(_arg_1, _arg_2);
            if (_local_3 != null)
            {
                _local_4 = _SafeStr_1324.handler.container.roomSession.roomId;
                _SafeStr_1324.handler.container.roomEngine.selectRoomObject(_local_4, _local_3.getId(), _arg_2);
                return (true);
            };
            return (false);
        }

        private function findRoomObject(_arg_1:int, _arg_2:int):IRoomObject
        {
            var _local_4:int = _SafeStr_1324.handler.container.roomSession.roomId;
            return (_SafeStr_1324.handler.container.roomEngine.getRoomObject(_local_4, _arg_1, _arg_2));
        }


    }
}