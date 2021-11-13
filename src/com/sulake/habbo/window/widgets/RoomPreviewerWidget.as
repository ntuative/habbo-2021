package com.sulake.habbo.window.widgets
{
    import com.sulake.core.window.utils.PropertyStruct;
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.habbo.window.HabboWindowManagerComponent;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IDisplayObjectWrapper;
    import com.sulake.habbo.room.preview.RoomPreviewer;
    import com.sulake.core.window.iterators.EmptyIterator;
    import com.sulake.core.window.utils.IIterator;
    import flash.display.DisplayObject;
    import com.sulake.habbo.room.events.RoomEngineEvent;
    import flash.geom.Point;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import flash.display.Bitmap;
    import flash.display.BitmapData;

    public class RoomPreviewerWidget implements IRoomPreviewerWidget
    {

        public static const TYPE:String = "room_previewer";
        private static const SCALE_KEY:String = "room_previewer:scale";
        private static const _SafeStr_4443:String = "room_previewer:offsetx";
        private static const _SafeStr_4444:String = "room_previewer:offsety";
        private static const _SafeStr_4445:String = "room_previewer:zoom";
        private static const SCALE_DEFAULT:PropertyStruct = new PropertyStruct("room_previewer:scale", 64, "int", false, [32, 64]);
        private static const OFFSET_X_DEFAULT:PropertyStruct = new PropertyStruct("room_previewer:offsetx", 0, "int", false);
        private static const OFFSET_Y_DEFAULT:PropertyStruct = new PropertyStruct("room_previewer:offsety", 0, "int", false);
        private static const ZOOM_DEFAULT:PropertyStruct = new PropertyStruct("room_previewer:zoom", 1, "int", false);

        private static var ROOM_ID_COUNTER:int = 2;

        private var _disposed:Boolean;
        private var _SafeStr_4407:IWidgetWindow;
        private var _windowManager:HabboWindowManagerComponent;
        private var _SafeStr_1165:IWindowContainer;
        private var _SafeStr_1598:IDisplayObjectWrapper;
        private var _roomPreviewer:RoomPreviewer;
        private var _scale:int = int(SCALE_DEFAULT.value);
        private var _offsetX:int = 0;
        private var _offsetY:int = 0;
        private var _zoom:int = int(ZOOM_DEFAULT.value);

        public function RoomPreviewerWidget(_arg_1:IWidgetWindow, _arg_2:HabboWindowManagerComponent)
        {
            _SafeStr_4407 = _arg_1;
            _windowManager = _arg_2;
            if (_arg_2.roomEngine)
            {
                _arg_2.roomEngine.events.addEventListener("REE_INITIALIZED", onRoomInitialized);
            };
            _SafeStr_1165 = (_windowManager.buildFromXML((_windowManager.assets.getAssetByName("room_previewer_xml").content as XML)) as IWindowContainer);
            _SafeStr_1598 = (_SafeStr_1165.findChildByName("room_canvas") as IDisplayObjectWrapper);
            _roomPreviewer = new RoomPreviewer(_arg_2.roomEngine, ROOM_ID_COUNTER++);
            _roomPreviewer.createRoomForPreviews();
            _SafeStr_1165.addEventListener("WME_CLICK", onClickRoomView);
            _SafeStr_1165.addEventListener("WE_RESIZE", onResizeCanvas);
            _SafeStr_4407.rootWindow = _SafeStr_1165;
            _SafeStr_1165.width = _SafeStr_4407.width;
            _SafeStr_1165.height = _SafeStr_4407.height;
            _roomPreviewer.modifyRoomCanvas(_SafeStr_1165.width, _SafeStr_1165.height);
        }

        public function get scale():int
        {
            return (_scale);
        }

        public function set scale(_arg_1:int):void
        {
            _scale = _arg_1;
            refresh();
        }

        public function get offsetX():int
        {
            return (_offsetX);
        }

        public function set offsetX(_arg_1:int):void
        {
            _offsetX = _arg_1;
            refresh();
        }

        public function get offsetY():int
        {
            return (_offsetY);
        }

        public function set offsetY(_arg_1:int):void
        {
            _offsetY = _arg_1;
            refresh();
        }

        public function get zoom():int
        {
            return (_zoom);
        }

        public function set zoom(_arg_1:int):void
        {
            _zoom = _arg_1;
            refresh();
        }

        public function get properties():Array
        {
            var _local_1:Array = [];
            if (_disposed)
            {
                return (_local_1);
            };
            _local_1.push(SCALE_DEFAULT.withValue(_scale));
            _local_1.push(OFFSET_X_DEFAULT.withValue(_offsetX));
            _local_1.push(OFFSET_Y_DEFAULT.withValue(_offsetY));
            _local_1.push(ZOOM_DEFAULT.withValue(_zoom));
            return (_local_1);
        }

        public function set properties(_arg_1:Array):void
        {
            for each (var _local_2:PropertyStruct in _arg_1)
            {
                switch (_local_2.key)
                {
                    case "room_previewer:scale":
                        scale = int(_local_2.value);
                        break;
                    case "room_previewer:offsetx":
                        offsetX = int(_local_2.value);
                        break;
                    case "room_previewer:offsety":
                        offsetY = int(_local_2.value);
                        break;
                    case "room_previewer:zoom":
                        zoom = int(_local_2.value);
                };
            };
        }

        public function dispose():void
        {
            if (!_disposed)
            {
                if (_roomPreviewer)
                {
                    _roomPreviewer.dispose();
                    _roomPreviewer = null;
                };
                if (_SafeStr_1165 != null)
                {
                    _SafeStr_1165.dispose();
                    _SafeStr_1165 = null;
                };
                if (_SafeStr_4407 != null)
                {
                    _SafeStr_4407.rootWindow = null;
                    _SafeStr_4407 = null;
                };
                if (((_windowManager) && (_windowManager.roomEngine)))
                {
                    _windowManager.roomEngine.events.removeEventListener("REE_INITIALIZED", onRoomInitialized);
                };
                _windowManager = null;
                _disposed = true;
            };
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get iterator():IIterator
        {
            return (EmptyIterator.INSTANCE);
        }

        private function onRoomInitialized(_arg_1:RoomEngineEvent):void
        {
            var _local_2:DisplayObject;
            switch (_arg_1.type)
            {
                case "REE_INITIALIZED":
                    if (((_roomPreviewer) && (_arg_1.roomId == _roomPreviewer.previewRoomId)))
                    {
                        _roomPreviewer.reset(false);
                        _local_2 = _roomPreviewer.getRoomCanvas(_SafeStr_1598.width, _SafeStr_1598.height);
                        if (_local_2 != null)
                        {
                            _SafeStr_1598.setDisplayObject(_local_2);
                        };
                    };
                    return;
            };
        }

        private function refresh():void
        {
            var _local_1:DisplayObject;
            if (((_roomPreviewer) && (_roomPreviewer.isRoomEngineReady)))
            {
                ((_scale == 64) ? _roomPreviewer.zoomIn() : _roomPreviewer.zoomOut());
                _roomPreviewer.addViewOffset = new Point(_offsetX, _offsetY);
                _local_1 = _SafeStr_1598.getDisplayObject();
                var _local_2:Number = zoom;
                _local_1.scaleY = _local_2;
                _local_1.scaleX = _local_2;
                _local_1.x = offsetX;
                _local_1.y = offsetY;
            };
        }

        public function toString():String
        {
            return ("RoomPreviewerWidget");
        }

        private function onResizeCanvas(_arg_1:WindowEvent, _arg_2:IWindow=null):void
        {
            var _local_3:int = _arg_1.window.width;
            var _local_4:int = _arg_1.window.height;
            _roomPreviewer.modifyRoomCanvas(_local_3, _local_4);
        }

        private function onClickRoomView(_arg_1:WindowMouseEvent):void
        {
            _roomPreviewer.changeRoomObjectState();
        }

        public function get roomPreviewer():RoomPreviewer
        {
            return (_roomPreviewer);
        }

        public function showPreview(_arg_1:BitmapData):void
        {
            var _local_2:Bitmap = new Bitmap(_arg_1);
            _local_2.scaleX = 2;
            _local_2.scaleY = 2;
            _SafeStr_1598.setDisplayObject(_local_2);
        }


    }
}