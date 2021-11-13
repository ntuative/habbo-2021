package com.sulake.habbo.ui.widget.avatarinfo
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.session.IUserData;
    import com.sulake.core.utils.Map;
    import flash.display.BitmapData;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.avatar.pets.PetFigureData;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.habbo.room._SafeStr_147;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.geom.Point;

    public class NestBreedingSuccessView implements IDisposable, IGetImageListener 
    {

        private static const _SafeStr_3113:String = "header_button_close";
        private static const _SafeStr_3114:String = "cancel_button";
        private static const _SafeStr_3119:String = "button.ok";

        private var _window:IFrameWindow;
        private var _disposed:Boolean = false;
        private var _SafeStr_1324:AvatarInfoWidget;
        private var _windowManager:IHabboWindowManager;
        private var _assets:IAssetLibrary;
        private var _SafeStr_3920:IUserData;
        private var _SafeStr_1915:int;
        private var _SafeStr_3919:Map;
        private var _SafeStr_3932:int;

        public function NestBreedingSuccessView(_arg_1:AvatarInfoWidget)
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
        }

        public function open(_arg_1:int, _arg_2:int):void
        {
            _SafeStr_1915 = _arg_1;
            _SafeStr_3920 = _SafeStr_1324.handler.roomSession.userDataManager.getUserDataByIndex(_arg_1);
            if (_SafeStr_3920 == null)
            {
                Logger.log("Couldn't find the correct pet.");
                return;
            };
            _SafeStr_3932 = _arg_2;
            setWindowContent();
            _window.visible = true;
        }

        private function setWindowContent():void
        {
            if (!_window)
            {
                _window = (_windowManager.buildFromXML((_assets.getAssetByName("nestBreedingSuccess_xml").content as XML)) as IFrameWindow);
                addClickListener("header_button_close");
            };
            _window.center();
            _window.visible = true;
            addClickListener("button.ok");
            _window.findChildByName("pet.name").caption = _SafeStr_3920.name;
            _window.findChildByName("pet.raritycategory").caption = (("${breedpets.nestbreeding.success.raritycategory." + _SafeStr_3932) + "}");
            var _local_1:BitmapData = resolvePreviewImage(_SafeStr_3920.figure, "pet_image");
            updatePreviewImage(((_local_1 != null) ? _local_1 : new BitmapData(10, 10)), "pet_image");
            _window.invalidate();
        }

        public function close():void
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
                case "cancel_button":
                    close();
                    return;
                case "button.ok":
                    close();
                    return;
            };
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


    }
}

