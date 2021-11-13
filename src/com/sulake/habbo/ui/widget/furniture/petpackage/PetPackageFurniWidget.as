package com.sulake.habbo.ui.widget.furniture.petpackage
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import com.sulake.core.window.components.IFrameWindow;
    import flash.display.BitmapData;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetPetPackageUpdateEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.XmlAsset;
    import flash.geom.Point;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetOpenPetPackageMessage;
    import com.sulake.core.window.components.ITextFieldWindow;

    public class PetPackageFurniWidget extends RoomWidgetBase
    {

        private static const GNOME_SPECIES_TYPE_ID:int = 26;

        private var _window:IFrameWindow;
        private var _SafeStr_4120:int = -1;
        private var _SafeStr_1922:int = -1;
        private var _SafeStr_4121:BitmapData;
        private var _SafeStr_4122:Boolean = false;

        public function PetPackageFurniWidget(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary, _arg_4:IHabboLocalizationManager)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
        }

        override public function dispose():void
        {
            hideInterface();
            super.dispose();
        }

        override public function registerUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            _arg_1.addEventListener("RWOPPUE_OPEN_PET_PACKAGE_REQUESTED", onObjectUpdate);
            _arg_1.addEventListener("RWOPPUE_OPEN_PET_PACKAGE_RESULT", onObjectUpdate);
            _arg_1.addEventListener("RWOPPUE_OPEN_PET_PACKAGE_UPDATE_PET_IMAGE", onObjectUpdate);
            super.registerUpdateEvents(_arg_1);
        }

        override public function unregisterUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            _arg_1.removeEventListener("RWOPPUE_OPEN_PET_PACKAGE_REQUESTED", onObjectUpdate);
            _arg_1.removeEventListener("RWOPPUE_OPEN_PET_PACKAGE_RESULT", onObjectUpdate);
            _arg_1.removeEventListener("RWOPPUE_OPEN_PET_PACKAGE_UPDATE_PET_IMAGE", onObjectUpdate);
            super.unregisterUpdateEvents(_arg_1);
        }

        private function onObjectUpdate(_arg_1:RoomWidgetPetPackageUpdateEvent):void
        {
            var event:RoomWidgetPetPackageUpdateEvent = _arg_1;
            switch (event.type)
            {
                case "RWOPPUE_OPEN_PET_PACKAGE_REQUESTED":
                    hideInterface();
                    _SafeStr_1922 = event.objectId;
                    _SafeStr_4121 = event.image;
                    _SafeStr_4120 = event.typeId;
                    showInterface();
                    showPetImage();
                    return;
                case "RWOPPUE_OPEN_PET_PACKAGE_RESULT":
                    if (!_SafeStr_4122)
                    {
                        return;
                    };
                    _SafeStr_4122 = false;
                    var nameValidationStatus:int = event.nameValidationStatus;
                    var nameValidationInfo:String = event.nameValidationInfo;
                    switch (nameValidationStatus)
                    {
                        case 0:
                            hideInterface();
                            return;
                        case 1:
                            var error:String = "long";
                            break;
                        case 2:
                            error = "short";
                            break;
                        case 3:
                            error = "chars";
                            break;
                        default:
                            error = "bobba";
                    };
                    var resultMessage:String = constructErrorMessage(error, nameValidationInfo);
                    windowManager.alert("${widgets.petpackage.alert.petname.title}", resultMessage, 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
                    {
                        _arg_1.dispose();
                    });
                    return;
                case "RWOPPUE_OPEN_PET_PACKAGE_UPDATE_PET_IMAGE":
                    if (event.objectId != _SafeStr_1922)
                    {
                        return;
                    };
                    _SafeStr_4121 = event.image;
                    showPetImage();
                    return;
            };
        }

        private function constructErrorMessage(_arg_1:String, _arg_2:String):String
        {
            var _local_3:String = ("catalog.alert.petname." + _arg_1);
            var _local_5:String = (_local_3 + ".additionalInfo");
            localizations.registerParameter(_local_5, "additional_info", _arg_2);
            var _local_6:String = localizations.getLocalization(_local_3);
            var _local_4:String = localizations.getLocalization(_local_5);
            if (((((!(_arg_2 == null)) && (_arg_2.length > 0)) && (!(_local_4 == null))) && (_local_4.length > 0)))
            {
                _local_6 = _local_4;
            };
            return (_local_6);
        }

        private function hideInterface():void
        {
            if (_window != null)
            {
                _window.dispose();
                _window = null;
            };
            _SafeStr_1922 = -1;
            _SafeStr_4122 = false;
            _SafeStr_4121 = null;
        }

        private function showInterface():void
        {
            var _local_2:IWindow;
            if (_SafeStr_1922 < 0)
            {
                return;
            };
            var _local_3:IAsset = ((_SafeStr_4121 != null) ? assets.getAssetByName("petpackage") : assets.getAssetByName("petpackage_new"));
            var _local_1:XmlAsset = XmlAsset(_local_3);
            if (_local_1 == null)
            {
                return;
            };
            if (_window != null)
            {
                _window.dispose();
                _window = null;
            };
            _window = (windowManager.buildFromXML(XML(_local_1.content)) as IFrameWindow);
            _window.center();
            var _local_4:IWindow = _window.header.findChildByTag("close");
            if (_local_4)
            {
                _local_4.addEventListener("WME_CLICK", onWindowClose);
            };
            _local_2 = _window.findChildByName("pick_name");
            if (_local_2 != null)
            {
                _local_2.addEventListener("WME_CLICK", onMouseEvent);
            };
            _local_2 = _window.findChildByName("cancel");
            if (_local_2 != null)
            {
                _local_2.addEventListener("WME_CLICK", onMouseEvent);
            };
            _window.addEventListener("WME_CLICK", onMouseEvent);
            showPetImage();
        }

        private function showPetImage():void
        {
            var _local_2:Point;
            if (((_SafeStr_4121 == null) || (_window == null)))
            {
                return;
            };
            var _local_1:IBitmapWrapperWindow = (_window.findChildByName("pet_image") as IBitmapWrapperWindow);
            if (_local_1 != null)
            {
                _local_1.bitmap = new BitmapData(_local_1.width, _local_1.height, true, 0);
                _local_2 = new Point(((_local_1.width - _SafeStr_4121.width) / 2), ((_local_1.height - _SafeStr_4121.height) / 2));
                _local_1.bitmap.copyPixels(_SafeStr_4121, _SafeStr_4121.rect, _local_2);
            };
        }

        private function onWindowClose(_arg_1:WindowEvent):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            hideInterface();
        }

        private function onMouseEvent(_arg_1:WindowMouseEvent):void
        {
            var _local_2:IWindow = (_arg_1.target as IWindow);
            var _local_3:String = _local_2.name;
            switch (_local_3)
            {
                case "pick_name":
                    sendOpenPetPackage();
                    return;
                case "cancel":
                    hideInterface();
                    return;
            };
        }

        private function sendOpenPetPackage():void
        {
            if (((_SafeStr_4122) || (_SafeStr_1922 == -1)))
            {
                return;
            };
            var name:String = getName();
            if (((name == null) || (name.length < 1)))
            {
                windowManager.alert("${widgets.petpackage.alert.petname.title}", "${catalog.alert.petname.short}", 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
                {
                    _arg_1.dispose();
                });
                return;
            };
            if (messageListener != null)
            {
                _SafeStr_4122 = true;
                var message:RoomWidgetOpenPetPackageMessage = new RoomWidgetOpenPetPackageMessage("RWOPPM_OPEN_PET_PACKAGE", _SafeStr_1922, name);
                messageListener.processWidgetMessage(message);
            };
        }

        private function getName():String
        {
            var _local_1:ITextFieldWindow;
            if (_window)
            {
                _local_1 = (_window.findChildByName("input") as ITextFieldWindow);
                if (_local_1)
                {
                    return (_local_1.text);
                };
            };
            return (null);
        }


    }
}