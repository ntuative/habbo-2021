package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.ui.widget.furniture.backgroundcolor.BackgroundColorFurniWidget;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import com.sulake.habbo.room.events.RoomEngineObjectEvent;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.object.IRoomObjectModel;
    import flash.events.Event;

    public class FurnitureBackgroundColorWidgetHandler implements IRoomWidgetHandler 
    {

        private var _disposed:Boolean = false;
        private var _SafeStr_1324:BackgroundColorFurniWidget;
        private var _container:IRoomWidgetHandlerContainer;


        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function dispose():void
        {
            if (!_disposed)
            {
                container = null;
                _disposed = true;
            };
        }

        public function get type():String
        {
            return ("RWE_ROOM_BACKGROUND_COLOR");
        }

        public function set widget(_arg_1:BackgroundColorFurniWidget):void
        {
            _SafeStr_1324 = _arg_1;
        }

        public function get container():IRoomWidgetHandlerContainer
        {
            return (_container);
        }

        public function set container(_arg_1:IRoomWidgetHandlerContainer):void
        {
            _container = _arg_1;
        }

        public function getWidgetMessages():Array
        {
            return (null);
        }

        public function processWidgetMessage(_arg_1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            return (null);
        }

        public function getProcessedEvents():Array
        {
            var _local_1:Array = [];
            _local_1.push("RETWE_REQUEST_BACKGROUND_COLOR");
            return (_local_1);
        }

        public function processEvent(_arg_1:Event):void
        {
            var _local_3:RoomEngineObjectEvent;
            var _local_4:IRoomObject;
            var _local_6:IRoomObjectModel;
            var _local_5:int;
            var _local_2:int;
            var _local_7:int;
            switch (_arg_1.type)
            {
                case "RETWE_REQUEST_BACKGROUND_COLOR":
                    if (validateRights())
                    {
                        _local_3 = (_arg_1 as RoomEngineObjectEvent);
                        _local_4 = _container.roomEngine.getRoomObject(_local_3.roomId, _local_3.objectId, _local_3.category);
                        _local_6 = _local_4.getModel();
                        _local_5 = _local_6.getNumber("furniture_room_background_color_hue");
                        _local_2 = _local_6.getNumber("furniture_room_background_color_saturation");
                        _local_7 = _local_6.getNumber("furniture_room_background_color_lightness");
                        _SafeStr_1324.open(_local_4.getId(), _local_5, _local_2, _local_7);
                    };
                    return;
            };
        }

        private function validateRights():Boolean
        {
            var _local_1:Boolean = _container.roomSession.isRoomOwner;
            var _local_2:Boolean = (_container.roomSession.roomControllerLevel >= 1);
            var _local_3:Boolean = _container.sessionDataManager.isAnyRoomController;
            return (((_local_1) || (_local_3)) || (_local_2));
        }

        public function update():void
        {
        }


    }
}

