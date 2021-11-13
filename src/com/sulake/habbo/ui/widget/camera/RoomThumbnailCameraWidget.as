package com.sulake.habbo.ui.widget.camera
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.core.runtime.events.ILinkEventTracker;
    import com.sulake.habbo.ui.RoomUI;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.runtime.Component;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.runtime.ICoreConfiguration;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.habbo.ui.handler.RoomThumbnailCameraWidgetHandler;
    import com.sulake.habbo.room.IRoomEngine;
    import flash.geom.Point;
    import flash.geom.Matrix;
    import com.sulake.habbo.session.IRoomSession;
    import flash.display.BitmapData;
    import flash.geom.Rectangle;
    import com.sulake.habbo.room.events.RoomEngineEvent;
    import com.sulake.habbo.communication.messages.outgoing.camera.RenderRoomThumbnailMessageComposer;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class RoomThumbnailCameraWidget extends RoomWidgetBase implements IUpdateReceiver, ILinkEventTracker 
    {

        private var _SafeStr_659:RoomUI;
        private var _window:IFrameWindow = null;
        private var _SafeStr_3943:IBitmapWrapperWindow;

        public function RoomThumbnailCameraWidget(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary, _arg_4:ICoreConfiguration, _arg_5:IHabboLocalizationManager, _arg_6:RoomUI)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_5);
            _SafeStr_659 = _arg_6;
            this.handler.widget = this;
            if (roomEngine)
            {
                roomEngine.events.addEventListener("REE_DISPOSED", onRoomDisposed);
                roomEngine.events.addEventListener("REE_ROOM_ZOOMED", onRoomZoomed);
            };
            (_arg_2 as Component).context.addLinkEventTracker(this);
        }

        override public function dispose():void
        {
            if (disposed)
            {
                return;
            };
            (windowManager as Component).context.removeLinkEventTracker(this);
            super.dispose();
        }

        public function get container():IRoomWidgetHandlerContainer
        {
            return ((handler) ? handler.container : null);
        }

        public function get handler():RoomThumbnailCameraWidgetHandler
        {
            return (_SafeStr_3915 as RoomThumbnailCameraWidgetHandler);
        }

        public function get roomEngine():IRoomEngine
        {
            return ((container) ? container.roomEngine : null);
        }

        public function update(_arg_1:uint):void
        {
            var _local_2:Point;
            var _local_3:Matrix;
            var _local_4:IRoomSession;
            if (((_window) && (_SafeStr_3943)))
            {
                if (_SafeStr_3943.bitmap == null)
                {
                    _SafeStr_3943.bitmap = new BitmapData(_SafeStr_3943.width, _SafeStr_3943.height, false, 0);
                };
                _SafeStr_3943.bitmap.fillRect(_SafeStr_3943.bitmap.rect, handler.roomDesktop.roomBackgroundColor);
                _local_2 = new Point(0, 0);
                _SafeStr_3943.getGlobalPosition(_local_2);
                _local_3 = new Matrix();
                _local_3.translate(-(_local_2.x), -(_local_2.y));
                _local_4 = container.roomSession;
                roomEngine.snapshotRoomCanvasToBitmap(_local_4.roomId, container.getFirstCanvasId(), _SafeStr_3943.bitmap, _local_3, false);
                _SafeStr_3943.invalidate();
            };
        }

        public function startTakingPhoto():void
        {
            if (((roomEngine) && (!(roomEngine.getRoomCanvasScale() == 1))))
            {
                windowManager.alert("Camera only works on normal zoom!", "Return to normal zoom level and try again!", 0, null);
                return;
            };
            if (!_window)
            {
                createWindow();
            };
        }

        private function createWindow():void
        {
            if (_window)
            {
                destroy();
            };
            _window = IFrameWindow(windowManager.buildFromXML(XML(_SafeStr_659.assets.getAssetByName("iro_room_thumbnail_camera_xml").content)));
            _SafeStr_3943 = IBitmapWrapperWindow(_window.findChildByName("viewfinder"));
            _window.procedure = windowProcedure;
            _window.center();
            _SafeStr_659.registerUpdateReceiver(this, 10);
        }

        public function destroy():void
        {
            if (_window)
            {
                _window.destroy();
                _window = null;
                _SafeStr_659.removeUpdateReceiver(this);
            };
        }

        public function get viewPort():Rectangle
        {
            var _local_1:Point = new Point(0, 0);
            _SafeStr_3943.getGlobalPosition(_local_1);
            return (new Rectangle(_local_1.x, _local_1.y, _SafeStr_3943.width, _SafeStr_3943.height));
        }

        private function onRoomDisposed(_arg_1:RoomEngineEvent):void
        {
            destroy();
        }

        private function onRoomZoomed(_arg_1:RoomEngineEvent):void
        {
            if (((roomEngine) && (!(roomEngine.getRoomCanvasScale() == 1))))
            {
                destroy();
            };
        }

        public function triggerCameraShutterSound():void
        {
            container.soundManager.playSound("CAMERA_shutter");
        }

        private function windowProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:RenderRoomThumbnailMessageComposer;
            var _local_4:WindowMouseEvent = (_arg_1 as WindowMouseEvent);
            if (((_local_4) && (_local_4.type == "WME_CLICK")))
            {
                switch (_arg_2.name)
                {
                    case "button_capture":
                        triggerCameraShutterSound();
                        _local_3 = RoomThumbnailCameraWidgetHandler(handler).collectPhotoData();
                        if (((!(_local_3 == null)) && (_local_3.isSendable())))
                        {
                            handler.sendPhotoData(_local_3);
                            _window.findChildByName("button_capture").disable();
                            _window.findChildByName("button_cancel").disable();
                            _SafeStr_659.removeUpdateReceiver(this);
                        }
                        else
                        {
                            windowManager.alert("${generic.alert.title}", "${camera.alert.too_much_stuff}", 0, null);
                        };
                        return;
                    case "header_button_close":
                    case "button_cancel":
                        destroy();
                        return;
                };
            };
        }

        public function get linkPattern():String
        {
            return ("roomThumbnailCamera");
        }

        public function linkReceived(_arg_1:String):void
        {
            var _local_2:Array = _arg_1.split("/");
            var _local_3:int = _local_2.length;
            if (_local_3 < 2)
            {
                return;
            };
            if (_local_2[1] == "open")
            {
                startTakingPhoto();
            };
        }


    }
}

