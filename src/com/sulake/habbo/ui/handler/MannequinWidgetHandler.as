package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.ui.widget.furniture.mannequin.MannequinWidget;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import com.sulake.habbo.room.events.RoomEngineObjectEvent;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.object.IRoomObjectModel;
    import flash.events.Event;

    public class MannequinWidgetHandler implements IRoomWidgetHandler 
    {

        private var _disposed:Boolean = false;
        private var _SafeStr_1324:MannequinWidget;
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
            return ("RWE_MANNEQUIN");
        }

        public function set widget(_arg_1:MannequinWidget):void
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
            _local_1.push("RETWE_REQUEST_MANNEQUIN");
            return (_local_1);
        }

        public function processEvent(_arg_1:Event):void
        {
            var _local_2:RoomEngineObjectEvent;
            var _local_3:IRoomObject;
            var _local_5:IRoomObjectModel;
            var _local_4:String;
            var _local_6:String;
            var _local_7:String;
            switch (_arg_1.type)
            {
                case "RETWE_REQUEST_MANNEQUIN":
                    _local_2 = (_arg_1 as RoomEngineObjectEvent);
                    _local_3 = _container.roomEngine.getRoomObject(_local_2.roomId, _local_2.objectId, _local_2.category);
                    _local_5 = _local_3.getModel();
                    _local_4 = _local_5.getString("furniture_mannequin_figure");
                    _local_6 = _local_5.getString("furniture_mannequin_gender");
                    _local_7 = _local_5.getString("furniture_mannequin_name");
                    if (((!(_local_4 == null)) && (!(_local_6 == null))))
                    {
                        _SafeStr_1324.open(_local_3.getId(), _local_4, _local_6, _local_7);
                    };
                    return;
            };
        }

        public function update():void
        {
        }


    }
}

