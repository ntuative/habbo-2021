package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetFurniToWidgetMessage;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.object.IRoomObjectModel;
    import com.sulake.habbo.ui.widget.events.RoomWidgetStickieDataUpdateEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetStickieSendUpdateMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import flash.events.Event;

    public class FurnitureStickieWidgetHandler implements IRoomWidgetHandler 
    {

        private var _disposed:Boolean = false;
        private var _container:IRoomWidgetHandlerContainer = null;


        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get type():String
        {
            return ("RWE_FURNI_STICKIE_WIDGET");
        }

        public function set container(_arg_1:IRoomWidgetHandlerContainer):void
        {
            _container = _arg_1;
        }

        public function dispose():void
        {
            _disposed = true;
            _container = null;
        }

        public function getWidgetMessages():Array
        {
            return (["RWFWM_MESSAGE_REQUEST_STICKIE", "RWSUM_STICKIE_SEND_DELETE", "RWSUM_STICKIE_SEND_UPDATE"]);
        }

        public function processWidgetMessage(_arg_1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            var _local_6:RoomWidgetFurniToWidgetMessage;
            var _local_4:IRoomObject;
            var _local_10:IRoomObjectModel;
            var _local_2:String;
            var _local_5:String;
            var _local_8:String;
            var _local_3:Boolean;
            var _local_9:RoomWidgetStickieDataUpdateEvent;
            var _local_11:RoomWidgetStickieSendUpdateMessage;
            var _local_7:RoomWidgetStickieSendUpdateMessage;
            switch (_arg_1.type)
            {
                case "RWFWM_MESSAGE_REQUEST_STICKIE":
                    _local_6 = (_arg_1 as RoomWidgetFurniToWidgetMessage);
                    _local_4 = _container.roomEngine.getRoomObject(_local_6.roomId, _local_6.id, _local_6.category);
                    if (_local_4 != null)
                    {
                        _local_10 = _local_4.getModel();
                        if (_local_10 != null)
                        {
                            _local_2 = _local_10.getString("furniture_itemdata");
                            if (_local_2.length < 6)
                            {
                                return (null);
                            };
                            _local_8 = "";
                            if (_local_2.indexOf(" ") > 0)
                            {
                                _local_5 = _local_2.slice(0, _local_2.indexOf(" "));
                                _local_8 = _local_2.slice((_local_2.indexOf(" ") + 1), _local_2.length);
                            }
                            else
                            {
                                _local_5 = _local_2;
                            };
                            _local_3 = ((_container.roomSession.isRoomOwner) || (_container.sessionDataManager.isAnyRoomController));
                            _local_9 = new RoomWidgetStickieDataUpdateEvent("RWSDUE_STICKIE_DATA", _local_6.id, _local_4.getType(), _local_8, _local_5, _local_3);
                            _container.events.dispatchEvent(_local_9);
                        };
                    };
                    break;
                case "RWSUM_STICKIE_SEND_UPDATE":
                    _local_11 = (_arg_1 as RoomWidgetStickieSendUpdateMessage);
                    if (_local_11 == null)
                    {
                        return (null);
                    };
                    if (((!(_container == null)) && (!(_container.roomEngine == null))))
                    {
                        _container.roomEngine.modifyRoomObjectData(_local_11.objectId, 20, _local_11.colorHex, _local_11.text);
                    };
                    break;
                case "RWSUM_STICKIE_SEND_DELETE":
                    _local_7 = (_arg_1 as RoomWidgetStickieSendUpdateMessage);
                    if (_local_7 == null)
                    {
                        return (null);
                    };
                    if (((!(_container == null)) && (!(_container.roomEngine == null))))
                    {
                        _container.roomEngine.deleteRoomObject(_local_7.objectId, 20);
                    };
            };
            return (null);
        }

        public function getProcessedEvents():Array
        {
            return ([]);
        }

        public function processEvent(_arg_1:Event):void
        {
            var _local_2:Event;
        }

        public function update():void
        {
        }


    }
}