package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import flash.geom.Rectangle;
    import flash.geom.Point;
    import com.sulake.habbo.session.IUserData;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetGetObjectLocationMessage;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUserLocationUpdateEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import flash.events.Event;

    public class ObjectLocationRequestHandler implements IRoomWidgetHandler 
    {

        private var _disposed:Boolean = false;
        private var _container:IRoomWidgetHandlerContainer = null;


        public function dispose():void
        {
            _disposed = true;
            _container = null;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get type():String
        {
            return (null);
        }

        public function set container(_arg_1:IRoomWidgetHandlerContainer):void
        {
            _container = _arg_1;
        }

        public function getWidgetMessages():Array
        {
            var _local_1:Array = [];
            _local_1.push("RWGOI_MESSAGE_GET_OBJECT_LOCATION");
            _local_1.push("RWGOI_MESSAGE_GET_GAME_OBJECT_LOCATION");
            return (_local_1);
        }

        public function processWidgetMessage(_arg_1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            var _local_2:Rectangle;
            var _local_7:Point;
            var _local_5:Rectangle;
            var _local_3:IUserData;
            if (((!(_arg_1)) || (!(_container))))
            {
                return (null);
            };
            var _local_4:RoomWidgetGetObjectLocationMessage = (_arg_1 as RoomWidgetGetObjectLocationMessage);
            if (!_local_4)
            {
                return (null);
            };
            var _local_6:IRoomSession = _container.roomSession;
            switch (_arg_1.type)
            {
                case "RWGOI_MESSAGE_GET_OBJECT_LOCATION":
                    if (((!(_local_6)) || (!(_local_6.userDataManager))))
                    {
                        return (null);
                    };
                    _local_3 = _local_6.userDataManager.getUserDataByType(_local_4.objectId, _local_4.objectType);
                    if (_local_3)
                    {
                        _local_2 = _container.roomEngine.getRoomObjectBoundingRectangle(_local_6.roomId, _local_3.roomObjectId, 100, _container.getFirstCanvasId());
                        _local_7 = _container.roomEngine.getRoomObjectScreenLocation(_local_6.roomId, _local_3.roomObjectId, 100, _container.getFirstCanvasId());
                        _local_5 = _container.getRoomViewRect();
                        if ((((_local_2) && (_local_5)) && (_local_7)))
                        {
                            _local_2.offset(_local_5.x, _local_5.y);
                            _local_7.offset(_local_5.x, _local_5.y);
                        };
                    };
                    return (new RoomWidgetUserLocationUpdateEvent(_local_4.objectId, _local_2, _local_7));
                case "RWGOI_MESSAGE_GET_GAME_OBJECT_LOCATION":
                    _local_2 = _container.roomEngine.getRoomObjectBoundingRectangle(_local_6.roomId, _local_4.objectId, 100, _container.getFirstCanvasId());
                    _local_7 = _container.roomEngine.getRoomObjectScreenLocation(_local_6.roomId, _local_4.objectId, 100, _container.getFirstCanvasId());
                    _local_5 = _container.getRoomViewRect();
                    if ((((_local_2) && (_local_5)) && (_local_7)))
                    {
                        _local_2.offset(_local_5.x, _local_5.y);
                        _local_7.offset(_local_5.x, _local_5.y);
                    };
                    return (new RoomWidgetUserLocationUpdateEvent(_local_4.objectId, _local_2, _local_7));
            };
            return (null);
        }

        public function getProcessedEvents():Array
        {
            return ([]);
        }

        public function processEvent(_arg_1:Event):void
        {
        }

        public function update():void
        {
        }


    }
}