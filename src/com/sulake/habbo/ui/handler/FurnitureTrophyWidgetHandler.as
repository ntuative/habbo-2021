package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetFurniToWidgetMessage;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.object.IRoomObjectModel;
    import com.sulake.habbo.ui.widget.events.RoomWidgetTrophyDataUpdateEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import flash.events.Event;

    public class FurnitureTrophyWidgetHandler implements IRoomWidgetHandler 
    {

        private var _disposed:Boolean = false;
        private var _container:IRoomWidgetHandlerContainer = null;


        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get type():String
        {
            return ("RWE_FURNI_TROPHY_WIDGET");
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
            return (["RWFWM_MESSAGE_REQUEST_TROPHY"]);
        }

        public function processWidgetMessage(_arg_1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            var _local_6:RoomWidgetFurniToWidgetMessage;
            var _local_3:IRoomObject;
            var _local_11:IRoomObjectModel;
            var _local_4:Number;
            var _local_5:String;
            var _local_7:int;
            var _local_8:String;
            var _local_2:String;
            var _local_9:String;
            var _local_10:RoomWidgetTrophyDataUpdateEvent;
            if (((disposed) || (_arg_1 == null)))
            {
                return (null);
            };
            switch (_arg_1.type)
            {
                case "RWFWM_MESSAGE_REQUEST_TROPHY":
                    _local_6 = (_arg_1 as RoomWidgetFurniToWidgetMessage);
                    _local_3 = _container.roomEngine.getRoomObject(_local_6.roomId, _local_6.id, _local_6.category);
                    if (_local_3 != null)
                    {
                        _local_11 = _local_3.getModel();
                        if (_local_11 != null)
                        {
                            _local_4 = _local_11.getNumber("furniture_color");
                            _local_5 = _local_11.getString("furniture_data");
                            _local_7 = parseInt(_local_11.getString("furniture_extras"));
                            _local_8 = _local_5.substring(0, _local_5.indexOf("\t"));
                            _local_5 = _local_5.substring((_local_8.length + 1), _local_5.length);
                            _local_2 = _local_5.substring(0, _local_5.indexOf("\t"));
                            _local_9 = _local_5.substring((_local_2.length + 1), _local_5.length);
                            _local_10 = new RoomWidgetTrophyDataUpdateEvent("RWTDUE_TROPHY_DATA", _local_4, _local_8, _local_2, _local_9, _local_7);
                            _container.events.dispatchEvent(_local_10);
                        };
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