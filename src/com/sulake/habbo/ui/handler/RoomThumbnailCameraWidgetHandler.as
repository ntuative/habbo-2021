package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.habbo.ui.RoomDesktop;
    import com.sulake.habbo.ui.widget.camera.RoomThumbnailCameraWidget;
    import com.sulake.habbo.communication.messages.parser.camera.ThumbnailStatusMessageEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import flash.events.Event;
    import com.sulake.habbo.communication.messages.outgoing.camera.RenderRoomThumbnailMessageComposer;

    public class RoomThumbnailCameraWidgetHandler implements IRoomWidgetHandler, IDisposable 
    {

        private var _container:IRoomWidgetHandlerContainer = null;
        private var _roomDesktop:RoomDesktop;
        private var _SafeStr_1324:RoomThumbnailCameraWidget;
        private var _SafeStr_3876:ThumbnailStatusMessageEvent;

        public function RoomThumbnailCameraWidgetHandler(_arg_1:RoomDesktop)
        {
            _roomDesktop = _arg_1;
        }

        public function get roomDesktop():RoomDesktop
        {
            return (_roomDesktop);
        }

        public function getProcessedEvents():Array
        {
            return ([]);
        }

        public function getWidgetMessages():Array
        {
            return (null);
        }

        public function processWidgetMessage(_arg_1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            return (null);
        }

        public function set widget(_arg_1:RoomThumbnailCameraWidget):void
        {
            _SafeStr_1324 = _arg_1;
        }

        public function set container(_arg_1:IRoomWidgetHandlerContainer):void
        {
            _container = _arg_1;
            _SafeStr_3876 = new ThumbnailStatusMessageEvent(onThumbnailStatus);
            _container.connection.addMessageEvent(_SafeStr_3876);
        }

        public function dispose():void
        {
            if ((((_container) && (_container.connection)) && (_SafeStr_3876)))
            {
                _container.connection.removeMessageEvent(_SafeStr_3876);
            };
        }

        public function get disposed():Boolean
        {
            return (false);
        }

        public function processEvent(_arg_1:Event):void
        {
        }

        public function update():void
        {
        }

        public function get type():String
        {
            return ("RWE_ROOM_THUMBNAIL_CAMERA");
        }

        public function get container():IRoomWidgetHandlerContainer
        {
            return (_container);
        }

        public function collectPhotoData():RenderRoomThumbnailMessageComposer
        {
            return (RenderRoomThumbnailMessageComposer(_roomDesktop.roomEngine.getRenderRoomMessage(_SafeStr_1324.viewPort, _roomDesktop.roomBackgroundColor, true)));
        }

        public function sendPhotoData(_arg_1:RenderRoomThumbnailMessageComposer):void
        {
            _container.connection.send(_arg_1);
        }

        private function onThumbnailStatus(_arg_1:ThumbnailStatusMessageEvent):void
        {
            _SafeStr_1324.destroy();
            if (_arg_1.getParser().isOk())
            {
                _container.windowManager.alert("${navigator.thumbnail.camera.title}", "${navigator.thumbnail.camera.success}", 16, null);
            }
            else
            {
                if (_arg_1.getParser().isRenderLimitHit())
                {
                    _container.windowManager.alert("${generic.alert.title}", "${camera.render.count.info}", 0, null);
                };
            };
        }


    }
}

