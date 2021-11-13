package com.sulake.habbo.ui.widget.furniture.friendfurni
{
    import com.sulake.habbo.avatar.IAvatarImageListener;
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.room.object.data.StringArrayStuffData;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.components.IDisplayObjectWrapper;
    import flash.display.BitmapData;
    import flash.geom.Point;
    import flash.display.Bitmap;
    import com.sulake.core.window.IWindow;
    import flash.errors.IllegalOperationError;
    import com.sulake.habbo.avatar.IAvatarImage;
    import com.sulake.core.window.events.WindowEvent;

    public class FriendFurniEngravingView implements IAvatarImageListener, IDisposable 
    {

        private var _stuffData:StringArrayStuffData;
        private var _widget:FriendFurniEngravingWidget;
        private var _window:IWindowContainer = null;
        private var _disposed:Boolean = false;

        public function FriendFurniEngravingView(_arg_1:FriendFurniEngravingWidget, _arg_2:StringArrayStuffData)
        {
            _widget = _arg_1;
            _stuffData = _arg_2;
        }

        private static function setElementImage(_arg_1:IWindow, _arg_2:BitmapData, _arg_3:int=0, _arg_4:int=0, _arg_5:int=0):void
        {
            var _local_9:IBitmapWrapperWindow;
            var _local_6:IDisplayObjectWrapper;
            if (_arg_2 == null)
            {
                return;
            };
            if (_arg_1 == null)
            {
                return;
            };
            if (_arg_1.disposed)
            {
                return;
            };
            var _local_10:int = ((_arg_3 > 0) ? _arg_3 : _arg_1.height);
            var _local_7:int = int((((_arg_1.width - _arg_2.width) / 2) + _arg_4));
            var _local_8:int = int((((_local_10 - _arg_2.height) / 2) + _arg_5));
            if ((_arg_1 as IBitmapWrapperWindow) != null)
            {
                _local_9 = IBitmapWrapperWindow(_arg_1);
                if (((_local_9.bitmap == null) || (_arg_3 > 0)))
                {
                    _local_9.bitmap = new BitmapData(_arg_1.width, _local_10, true, 0);
                };
                _local_9.bitmap.fillRect(_local_9.bitmap.rect, 0);
                _local_9.bitmap.copyPixels(_arg_2, _arg_2.rect, new Point(_local_7, _local_8), null, null, false);
                _arg_1.invalidate();
            }
            else
            {
                if ((_arg_1 as IDisplayObjectWrapper) != null)
                {
                    _local_6 = IDisplayObjectWrapper(_arg_1);
                    _local_6.setDisplayObject(new Bitmap(_arg_2));
                };
            };
        }


        protected function get stuffData():StringArrayStuffData
        {
            return (_stuffData);
        }

        protected function get widget():FriendFurniEngravingWidget
        {
            return (_widget);
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function dispose():void
        {
            if (!disposed)
            {
                destroyWindow();
                _widget = null;
                _stuffData = null;
                _disposed = true;
            };
        }

        public function open():void
        {
            createWindow();
        }

        public function close():void
        {
            destroyWindow();
        }

        protected function assetName():String
        {
            throw (new IllegalOperationError("Must implement in concrete view!"));
        }

        private function createWindow():void
        {
            var _local_2:IAvatarImage;
            var _local_1:IAvatarImage;
            if (!_window)
            {
                _window = IWindowContainer(widget.windowManager.buildFromXML(XML(widget.assets.getAssetByName(assetName()).content)));
                _window.procedure = windowProc;
                _window.center();
                _window.findChildByName("name_left").caption = stuffData.getValue(1);
                _window.findChildByName("name_right").caption = stuffData.getValue(2);
                _window.findChildByName("date").caption = stuffData.getValue(5);
                _local_2 = widget.engravingWidgetHandler.container.avatarRenderManager.createAvatarImage(stuffData.getValue(3), "h", null, this);
                _local_1 = widget.engravingWidgetHandler.container.avatarRenderManager.createAvatarImage(stuffData.getValue(4), "h", null, this);
                if (!_local_2.isPlaceholder())
                {
                    setAvatarImage("avatar_left", _local_2.getCroppedImage("full"));
                };
                if (!_local_1.isPlaceholder())
                {
                    _local_1.setDirection("full", 4);
                    setAvatarImage("avatar_right", _local_1.getCroppedImage("full"));
                };
            };
        }

        public function avatarImageReady(_arg_1:String):void
        {
            var _local_3:IAvatarImage;
            var _local_2:IAvatarImage;
            if (_arg_1 == stuffData.getValue(3))
            {
                _local_3 = widget.engravingWidgetHandler.container.avatarRenderManager.createAvatarImage(stuffData.getValue(3), "h", null, this);
                setAvatarImage("avatar_left", _local_3.getCroppedImage("full"));
            };
            if (_arg_1 == stuffData.getValue(4))
            {
                _local_2 = widget.engravingWidgetHandler.container.avatarRenderManager.createAvatarImage(stuffData.getValue(4), "h", null, this);
                _local_2.setDirection("full", 4);
                setAvatarImage("avatar_right", _local_2.getCroppedImage("full"));
            };
        }

        private function setAvatarImage(_arg_1:String, _arg_2:BitmapData):void
        {
            var _local_3:IBitmapWrapperWindow = IBitmapWrapperWindow(_window.findChildByName(_arg_1));
            setElementImage(_local_3, _arg_2, 0, 0, 0);
        }

        private function destroyWindow():void
        {
            if (_window)
            {
                _window.dispose();
                _window = null;
            };
        }

        private function windowProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                switch (_arg_2.name)
                {
                    case "header_button_close":
                        widget.close(widget.stuffId);
                        return;
                };
            };
        }


    }
}