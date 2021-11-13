package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.habbo.ui.widget.furniture.friendfurni.FriendFurniEngravingWidget;
    import com.sulake.habbo.room.events.RoomEngineObjectEvent;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.object.IRoomObjectModel;
    import com.sulake.habbo.room.object.data.StringArrayStuffData;
    import flash.events.Event;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;

    public class FriendFurniEngravingWidgetHandler implements IRoomWidgetHandler 
    {

        private var _disposed:Boolean = false;
        private var _container:IRoomWidgetHandlerContainer = null;
        private var _SafeStr_1324:FriendFurniEngravingWidget = null;


        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get type():String
        {
            return ("RWE_FRIEND_FURNI_ENGRAVING");
        }

        public function get container():IRoomWidgetHandlerContainer
        {
            return (_container);
        }

        public function set container(_arg_1:IRoomWidgetHandlerContainer):void
        {
            _container = _arg_1;
        }

        public function set widget(_arg_1:FriendFurniEngravingWidget):void
        {
            _SafeStr_1324 = _arg_1;
        }

        public function dispose():void
        {
            _disposed = true;
            _container = null;
            _SafeStr_1324 = null;
        }

        public function getProcessedEvents():Array
        {
            return (["RETWE_REQUEST_FRIEND_FURNITURE_ENGRAVING"]);
        }

        public function processEvent(_arg_1:Event):void
        {
            var _local_4:RoomEngineObjectEvent;
            var _local_2:IRoomObject;
            var _local_5:IRoomObjectModel;
            var _local_3:StringArrayStuffData;
            if (((disposed) || (_arg_1 == null)))
            {
                return;
            };
            switch (_arg_1.type)
            {
                case "RETWE_REQUEST_FRIEND_FURNITURE_ENGRAVING":
                    _local_4 = RoomEngineObjectEvent(_arg_1);
                    _local_2 = _container.roomEngine.getRoomObject(_local_4.roomId, _local_4.objectId, _local_4.category);
                    if (_local_2 != null)
                    {
                        _local_5 = _local_2.getModel();
                        if (_local_5 != null)
                        {
                            _local_3 = new StringArrayStuffData();
                            _local_3.initializeFromRoomObjectModel(_local_5);
                            _SafeStr_1324.open(_local_2.getId(), _local_5.getNumber("furniture_friendfurni_engraving_type"), _local_3);
                        };
                    };
                    return;
            };
        }

        public function update():void
        {
        }

        public function getWidgetMessages():Array
        {
            return ([]);
        }

        public function processWidgetMessage(_arg_1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            return (null);
        }


    }
}

