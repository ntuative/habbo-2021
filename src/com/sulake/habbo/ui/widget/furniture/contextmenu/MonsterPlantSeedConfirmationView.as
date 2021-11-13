package com.sulake.habbo.ui.widget.furniture.contextmenu
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.room.object.IRoomObject;
    import flash.display.BitmapData;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.assets.IAsset;
    import com.sulake.habbo.room._SafeStr_147;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetUseProductMessage;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class MonsterPlantSeedConfirmationView implements IDisposable, IGetImageListener 
    {

        private static const PRODUCT_PAGE_UKNOWN:int = -1;
        private static const PRODUCT_PAGE_SEED:int = 0;
        private static const _SafeStr_3113:String = "header_button_close";
        private static const _SafeStr_3118:String = "save_button";
        private static const _SafeStr_3937:String = "cancel_text";
        private static const _SafeStr_3119:String = "ok_button";

        private var _window:IWindowContainer;
        private var _disposed:Boolean = false;
        private var _SafeStr_1324:FurnitureContextMenuWidget;
        private var _windowManager:IHabboWindowManager;
        private var _assets:IAssetLibrary;
        private var _SafeStr_4077:int = -1;
        private var _SafeStr_1593:int;
        private var _SafeStr_537:IFurnitureData;

        public function MonsterPlantSeedConfirmationView(_arg_1:FurnitureContextMenuWidget)
        {
            _SafeStr_1324 = _arg_1;
            _windowManager = _arg_1.windowManager;
            _assets = _SafeStr_1324.assets;
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
            _SafeStr_537 = null;
        }

        public function open(_arg_1:int):void
        {
            var _local_3:int = _SafeStr_1324.handler.roomSession.roomId;
            var _local_4:IRoomObject = _SafeStr_1324.handler.roomEngine.getRoomObject(_local_3, _arg_1, 10);
            if (_local_4 != null)
            {
                _SafeStr_537 = _SafeStr_1324.handler.getFurniData(_local_4);
                _SafeStr_4077 = _local_4.getId();
            };
            var _local_2:int = -1;
            switch (_SafeStr_537.category)
            {
                case 19:
                    _local_2 = 0;
                    break;
                default:
                    Logger.log(("[PlantSeedConfirmationView.open()] Unsupported furniture category: " + _SafeStr_537.category));
            };
            setWindowContent(_local_2);
            _window.visible = true;
        }

        private function setWindowContent(_arg_1:int):void
        {
            var _local_4:String;
            var _local_3:BitmapData = new BitmapData(10, 10);
            _SafeStr_1324.localizations.registerParameter("useproduct.widget.title.plant_seed", "name", _SafeStr_537.localizedName);
            if (!_window)
            {
                _local_4 = "use_product_widget_frame_plant_seed_xml";
                _window = (_windowManager.buildFromXML((_assets.getAssetByName(_local_4).content as XML)) as IWindowContainer);
                addClickListener("header_button_close");
                _window.center();
            };
            _SafeStr_1324.localizations.registerParameter("useproduct.widget.text.plant_seed", "productName", _SafeStr_537.localizedName);
            var _local_2:IFrameWindow = (_window as IFrameWindow);
            _local_2.content.removeChildAt(0);
            var _local_5:IWindowContainer = createWindow(_arg_1);
            _local_2.content.addChild(_local_5);
            switch (_arg_1)
            {
                case 0:
                    addClickListener("save_button");
                    addClickListener("cancel_text");
                    _local_3 = resolvePreviewImage(_SafeStr_537);
                    break;
                default:
                    throw (new Error(("Invalid type for use product confirmation content apply: " + _arg_1)));
            };
            updatePreviewImage(_local_3);
            _window.invalidate();
        }

        private function createWindow(_arg_1:int):IWindowContainer
        {
            var _local_2:IAsset;
            var _local_3:IWindowContainer;
            switch (_arg_1)
            {
                case 0:
                    _local_2 = _assets.getAssetByName("use_product_controller_plant_seed_xml");
                    break;
                default:
                    throw (new Error(("Invalid type for view content creation: " + _arg_1)));
            };
            return (_windowManager.buildFromXML((_local_2.content as XML)) as IWindowContainer);
        }

        private function resolvePreviewImage(_arg_1:IFurnitureData):BitmapData
        {
            var _local_3:_SafeStr_147;
            var _local_4:BitmapData;
            if (!_arg_1)
            {
                return (null);
            };
            var _local_2:Array = _arg_1.customParams.split(" ");
            switch (_arg_1.category)
            {
                case 19:
                    _local_3 = _SafeStr_1324.handler.roomEngine.getFurnitureImage(_SafeStr_537.id, new Vector3d(90, 0, 0), 64, this, 0, "", -1, -1, null);
                    break;
                default:
                    Logger.log(("[PlantSeedConfirmationView] Unsupported furniture category: " + _arg_1.category));
            };
            if (_local_3 != null)
            {
                _SafeStr_1593 = _local_3.id;
                _local_4 = _local_3.data;
            };
            return (_local_4);
        }

        private function updatePreviewImage(_arg_1:BitmapData):void
        {
            if (((!(_window)) || (!(_arg_1))))
            {
                return;
            };
            setPreviewImage("preview_image_bg");
            setPreviewImage("preview_image");
        }

        private function setPreviewImage(_arg_1:String):void
        {
            if (!_window)
            {
                return;
            };
            var _local_2:IBitmapWrapperWindow = (_window.findChildByName(_arg_1) as IBitmapWrapperWindow);
            if (_local_2 == null)
            {
                return;
            };
            var _local_3:BitmapDataAsset = (_assets.getAssetByName(_local_2.bitmapAssetName) as BitmapDataAsset);
            if (_local_3 == null)
            {
                return;
            };
            _local_2.disposesBitmap = false;
            _local_2.bitmap = (_local_3.content as BitmapData);
        }

        public function close():void
        {
            if (_window != null)
            {
                _window.visible = false;
            };
        }

        private function addClickListener(_arg_1:String):void
        {
            _window.findChildByName(_arg_1).addEventListener("WME_CLICK", onMouseClick);
        }

        private function onMouseClick(_arg_1:WindowMouseEvent):void
        {
            var _local_2:RoomWidgetMessage;
            switch (_arg_1.target.name)
            {
                case "header_button_close":
                case "cancel_text":
                case "ok_button":
                    close();
                    break;
                case "save_button":
                    _local_2 = new RoomWidgetUseProductMessage("RWUPM_MONSTERPLANT_SEED", _SafeStr_4077);
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


    }
}

