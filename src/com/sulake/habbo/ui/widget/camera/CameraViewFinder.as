package com.sulake.habbo.ui.widget.camera
{
    import com.sulake.core.runtime.IUpdateReceiver;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.communication.messages.outgoing.camera.RenderRoomMessageComposer;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.display.Loader;
    import flash.display.BitmapData;
    import flash.geom.Matrix;
    import flash.geom.Rectangle;
    import flash.utils.getTimer;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.tracking.HabboTracking;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.adobe.serialization.json.JSON;
    import flash.net.URLLoader;
    import flash.events.Event;
    import flash.net.SharedObject;
    import flash.utils.ByteArray;

    public class CameraViewFinder implements IUpdateReceiver
    {

        private static const _SafeStr_3954:Number = 350;
        private static const NUMBER_OF_SLOTS:int = 5;

        private static var _SafeStr_3955:Boolean = false;
        private static var _SafeStr_3956:Vector.<CameraSlotData> = new Vector.<CameraSlotData>(5);
        private static var _SafeStr_3957:Vector.<RenderRoomMessageComposer> = new Vector.<RenderRoomMessageComposer>(5);

        private var _SafeStr_1324:CameraWidget;
        private var _window:IWindowContainer;
        private var _disposed:Boolean = false;
        private var _SafeStr_3943:IBitmapWrapperWindow;
        private var _flash:IBitmapWrapperWindow;
        private var _imageWidth:int;
        private var _SafeStr_3958:int;
        private var _SafeStr_3959:Boolean = false;
        private var _SafeStr_3953:int = 0;
        private var _isLoadingFromCache:Boolean = false;
        private var _imageLoader:Loader;
        private var _flashStartTime:uint = 0;

        public function CameraViewFinder(_arg_1:CameraWidget)
        {
            super();
            var _local_2:IWindow = null;
            _SafeStr_1324 = _arg_1;
            openViewFinder();
            _SafeStr_3953 = 0;
            while (_SafeStr_3953 < 5)
            {
                clearCurrentSlot(true);
                _SafeStr_3953++;
            };
            _SafeStr_3953 = 0;
            var _local_3:Boolean = getFromMemoryCache();
            if (_local_3)
            {
                _local_2 = _window.findChildByName("slot_container");
                _local_2.visible = true;
            };
            setMode(false);
            setActiveSlot(0);
            _flash = (_window.findChildByName("flash") as IBitmapWrapperWindow);
            _flash.bitmap = new BitmapData(_flash.width, _flash.height, false, 0xFFFFFF);
            _flash.visible = false;
        }

        public function dispose():void
        {
            if (_disposed)
            {
                return;
            };
            _flash = null;
            _SafeStr_3943 = null;
            _SafeStr_1324.component.removeUpdateReceiver(this);
            if (_window)
            {
                _window.dispose();
                _window = null;
            };
            _disposed = true;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        private function openViewFinder():void
        {
            if (_window != null)
            {
                return;
            };
            _window = (_SafeStr_1324.getXmlWindow("camera_interface") as IWindowContainer);
            _window.center();
            _window.visible = false;
            _SafeStr_3943 = (_window.findChildByName("image") as IBitmapWrapperWindow);
            _imageWidth = _SafeStr_3943.width;
            _SafeStr_3958 = _SafeStr_3943.height;
            _SafeStr_3943.visible = true;
            _window.procedure = windowProcedure;
        }

        public function update(_arg_1:uint):void
        {
            if (_SafeStr_3959)
            {
                return;
            };
            if (_SafeStr_3943.bitmap == null)
            {
                _SafeStr_3943.bitmap = new BitmapData(_imageWidth, _SafeStr_3958, false, 0);
            };
            _SafeStr_3943.bitmap.fillRect(_SafeStr_3943.bitmap.rect, _SafeStr_1324.handler.roomDesktop.roomBackgroundColor);
            var _local_3:Matrix = new Matrix();
            var _local_2:Rectangle = getViewPort();
            _local_3.translate(-(_local_2.x), -(_local_2.y));
            _SafeStr_1324.snapShotRoomCanvas(_SafeStr_3943.bitmap, _local_3, false);
            _SafeStr_3943.invalidate();
            if (_flashStartTime > 0)
            {
                updateFlash();
            };
        }

        private function updateFlash():void
        {
            _flash.visible = true;
            var _local_2:Number = (getTimer() - _flashStartTime);
            var _local_1:Number = ((350 - _local_2) / 350);
            _flash.blend = _local_1;
            if (_local_2 > 350)
            {
                _flashStartTime = 0;
                _flash.visible = false;
            };
        }

        public function getViewPort():Rectangle
        {
            var _local_1:IWindow = (_window as IWindow);
            return (new Rectangle((_window.x + _SafeStr_3943.x), (_window.y + _SafeStr_3943.y), _SafeStr_3943.width, _SafeStr_3943.height));
        }

        public function toggleVisible(_arg_1:String):void
        {
            if (_window.visible)
            {
                hide();
            }
            else
            {
                HabboTracking.getInstance().trackEventLog("Stories", "camera", "stories.camera.opened", _arg_1);
                show();
                setMode(false);
            };
        }

        public function show():void
        {
            _window.visible = true;
            _window.center();
            _SafeStr_1324.component.registerUpdateReceiver(this, 100);
        }

        public function hide():void
        {
            _window.visible = false;
            _SafeStr_1324.component.removeUpdateReceiver(this);
        }

        private function windowProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_5:IStaticBitmapWrapperWindow;
            var _local_4:RenderRoomMessageComposer;
            var _local_3:IWindow;
            var _local_6:String;
            var _local_7:CameraSlotData;
            var _local_8:int;
            if (_arg_2.name == "button_release")
            {
                _local_5 = IStaticBitmapWrapperWindow(_window.findChildByName("release_bitmap"));
                switch (_arg_1.type)
                {
                    case "WME_DOWN":
                        _local_5.assetUri = "camera_camera_btn_down";
                        break;
                    case "WME_UP":
                        _local_5.assetUri = "camera_cam_btn_hi";
                        break;
                    case "WME_OVER":
                        _local_5.assetUri = "camera_cam_btn_hi";
                        break;
                    case "WME_OUT":
                        _local_5.assetUri = "camera_camera_btn";
                };
            };
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            switch (_arg_1.target.name)
            {
                case "header_button_close":
                    hide();
                    break;
                case "button_editor":
                    hide();
                    _SafeStr_1324.editPhoto(_SafeStr_3943.bitmap.clone());
                    break;
                case "delete_photo_button":
                    clearCurrentSlot();
                    setMode(false);
                    break;
                case "header_button_help":
                    _SafeStr_1324.component.context.createLinkEvent("habbopages/camera");
                    break;
                case "button_release":
                    if (_SafeStr_3959)
                    {
                        setMode(false);
                    }
                    else
                    {
                        _SafeStr_1324.triggetCameraShutterSound();
                        _local_4 = _SafeStr_1324.handler.collectPhotoData();
                        if (((!(_local_4 == null)) && (_local_4.isSendable())))
                        {
                            _SafeStr_3957[_SafeStr_3953] = _local_4;
                            addToCurrentSlot(_SafeStr_3943.bitmap.clone());
                            _flashStartTime = getTimer();
                            HabboTracking.getInstance().trackEventLog("Stories", "camera", "stories.photo.taken");
                            _local_3 = _window.findChildByName("slot_container");
                            _local_3.visible = true;
                        }
                        else
                        {
                            _SafeStr_1324.windowManager.alert("${generic.alert.title}", "${camera.alert.too_much_stuff}", 0, null);
                        };
                    };
            };
            if (_arg_1.target.name.indexOf("cameraButton_") != -1)
            {
                _local_6 = _arg_1.target.name.charAt((_arg_1.target.name.length - 1));
                if (_SafeStr_3956[int(_local_6)].isEmpty)
                {
                    setActiveSlot(int(_local_6));
                    setMode(false);
                    return;
                };
                _local_7 = _SafeStr_3956[int(_local_6)];
                _SafeStr_3943.bitmap = _local_7.image.clone();
                setMode(true);
                setActiveSlot(int(_local_6));
            };
            if (_arg_1.target.name.indexOf("chooseSlotButton_") != -1)
            {
                _local_8 = int(_arg_1.target.name.charAt((_arg_1.target.name.length - 1)));
                if (_SafeStr_3956.length < _local_8)
                {
                    return;
                };
                setActiveSlot(_local_8);
                setMode(false);
            };
        }

        private function setActiveSlot(_arg_1:int):void
        {
            (_window.findChildByName(("slotImage_" + _SafeStr_3953)) as IStaticBitmapWrapperWindow).assetUri = "camera_arrow_gray";
            _SafeStr_3953 = _arg_1;
            (_window.findChildByName(("slotImage_" + _SafeStr_3953)) as IStaticBitmapWrapperWindow).assetUri = "camera_arrow_green";
            var _local_2:IWindow = _window.findChildByName("photo_border");
            var _local_4:IWindow = _window.findChildByName(("cameraButton_" + _SafeStr_3953));
            _local_2.x = ((_local_4.x - 1) + _local_4.parent.x);
            _local_2.y = ((_local_4.y - 3) + _local_4.parent.y);
            _local_2.visible = true;
            var _local_3:IWindow = _window.findChildByName("delete_photo_button");
            _local_3.y = _local_2.y;
            _local_3.x = (_local_2.right - _local_3.width);
        }

        private function setMode(_arg_1:Boolean):void
        {
            _SafeStr_3959 = _arg_1;
            var _local_3:IWindow = _window.findChildByName("button_editor");
            var _local_5:IWindow = _window.findChildByName("camera_crosshair");
            var _local_2:IWindow = _window.findChildByName("photo_date");
            var _local_7:IWindow = _window.findChildByName("photo_roomname");
            var _local_6:IWindow = _window.findChildByName("buyButtonBg");
            var _local_8:Boolean = false;
            _local_7.visible = _local_8;
            _local_2.visible = _local_8;
            var _local_4:IWindow = _window.findChildByName("delete_photo_button");
            _local_5.visible = (!(_arg_1));
            _local_8 = _arg_1;
            _local_6.visible = _local_8;
            _local_3.visible = _local_8;
            _local_4.visible = _local_8;
        }

        private function onPurchaseError(_arg_1:Event):void
        {
            var _local_2:Object;
            try
            {
                _local_2 = com.adobe.serialization.json.JSON.decode(URLLoader(_arg_1.target).data);
                switch (_local_2.error.code)
                {
                    case "PURCHASING_FAILED":
                        _SafeStr_1324.windowManager.alert("Something went wrong", "sorry, purhcase failed. We will investigate the issue. #code 1", 0, null);
                        break;
                    case "MODERATED":
                        _SafeStr_1324.windowManager.alert("Inappropriate text", "Your photo caption contained inappropriate words. They were changed to bobba. Please edit the text and try again.", 0, null);
                        _SafeStr_1324.changeCaptionFieldText(_local_2.error.message, true);
                };
            }
            catch(error:Error)
            {
                _SafeStr_1324.windowManager.alert("Something went wrong", "sorry, purhcase failed. We will investigate the issue. # code 2", 0, null);
            };
        }

        private function getFromMemoryCache():Boolean
        {
            var _local_2:int;
            var _local_1:Boolean;
            _local_2 = 0;
            while (_local_2 < _SafeStr_3956.length)
            {
                if (_SafeStr_3956[_local_2].isEmpty == false)
                {
                    drawImageToSlot(_local_2, _SafeStr_3956[_local_2]);
                    _local_1 = true;
                };
                _local_2++;
            };
            return (_local_1);
        }

        private function drawImageToSlot(_arg_1:int, _arg_2:CameraSlotData):void
        {
            var _local_4:IBitmapWrapperWindow = (_window.findChildByName(("cameraSlot_" + _arg_1)) as IBitmapWrapperWindow);
            _local_4.bitmap = new BitmapData(_local_4.width, _local_4.height, false, 0);
            var _local_3:Number = ((_local_4.width - 2) / _imageWidth);
            var _local_5:Matrix = new Matrix();
            _local_5.scale(_local_3, _local_3);
            var _local_6:Number = 1;
            _local_5.ty = _local_6;
            _local_5.tx = _local_6;
            _local_4.bitmap.draw(_arg_2.image, _local_5, null, null, null, true);
        }

        private function getFromLocalCache():Boolean
        {
            var _local_2:SharedObject;
            try
            {
                _local_2 = SharedObject.getLocal(("camera_image_" + _SafeStr_3953));
            }
            catch(error:Error)
            {
                return (false);
            };
            if (((_local_2.size == 0) || (!(_local_2.data))))
            {
                return (false);
            };
            var _local_1:ByteArray = (_local_2.data.photo as ByteArray);
            if (!_local_1)
            {
                return (false);
            };
            if (!_imageLoader)
            {
                _imageLoader = new Loader();
            };
            _imageLoader.loadBytes(_local_1);
            _imageLoader.contentLoaderInfo.addEventListener("complete", onImageLoadedFromCache);
            var _local_3:CameraSlotData = new CameraSlotData();
            _local_3.setDate(new Date());
            if (_local_2.data.date > 0)
            {
                _local_3.setDate(new Date(_local_2.data.date));
            };
            _SafeStr_3956[_SafeStr_3953] = _local_3;
            return (true);
        }

        private function onImageLoadedFromCache(_arg_1:Event):void
        {
            var _local_2:BitmapData = new BitmapData(_imageLoader.width, _imageLoader.height, false);
            _local_2.draw(_imageLoader);
            _SafeStr_3956[_SafeStr_3953].image = _local_2.clone();
            addToCurrentSlot(_local_2, false, true);
            if (((_SafeStr_3953 < 5) && (_isLoadingFromCache)))
            {
                getFromLocalCache();
                if (_SafeStr_3953 == (5 - 1))
                {
                    _isLoadingFromCache = false;
                };
            }
            else
            {
                _SafeStr_3955 = true;
            };
        }

        private function findNextEmptySlotIndex():int
        {
            var _local_1:int;
            _local_1 = 0;
            while (_local_1 < _SafeStr_3956.length)
            {
                if (_SafeStr_3956[_local_1].isEmpty)
                {
                    return (_local_1);
                };
                _local_1++;
            };
            return (-1);
        }

        private function clearCurrentSlot(_arg_1:Boolean=false):void
        {
            if ((((_arg_1) && (_SafeStr_3956[_SafeStr_3953])) && (!(_SafeStr_3956[_SafeStr_3953].isEmpty))))
            {
                return;
            };
            _SafeStr_3956[_SafeStr_3953] = null;
            addToCurrentSlot(new BitmapData(320, 320, false, 0xD2D2D2), true);
            _SafeStr_3943.bitmap = _SafeStr_3956[_SafeStr_3953].image.clone();
            setMode(false);
        }

        private function addToCurrentSlot(_arg_1:BitmapData, _arg_2:Boolean=false, _arg_3:Boolean=false):void
        {
            var _local_5:int;
            var _local_4:CameraSlotData = new CameraSlotData();
            _local_4.image = _arg_1;
            if (_arg_2)
            {
                _local_4.isEmpty = true;
            }
            else
            {
                _local_4.setDate(new Date());
                _local_4.isEmpty = false;
            };
            if ((((!(_arg_3)) && (!(_arg_2))) || (_SafeStr_3956[_SafeStr_3953] == null)))
            {
                _SafeStr_3956[_SafeStr_3953] = _local_4;
            };
            drawImageToSlot(_SafeStr_3953, _local_4);
            if (!_arg_2)
            {
                _local_5 = findNextEmptySlotIndex();
                if (_local_5 >= 0)
                {
                    setActiveSlot(_local_5);
                }
                else
                {
                    if (((!(_SafeStr_3955)) && (!(_arg_3))))
                    {
                        _SafeStr_1324.windowManager.alert(_SafeStr_1324.localizations.getLocalization("camera.full.header"), _SafeStr_1324.localizations.getLocalization("camera.full.body"), 0, null);
                        _SafeStr_3955 = true;
                    };
                };
            };
        }

        public function getRenderRoomMessage():RenderRoomMessageComposer
        {
            return (_SafeStr_3957[_SafeStr_3953]);
        }


    }
}