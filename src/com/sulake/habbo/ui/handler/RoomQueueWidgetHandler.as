package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetRoomQueueMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import com.sulake.habbo.session.events.RoomSessionQueueEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetRoomQueueUpdateEvent;
    import flash.events.Event;

    public class RoomQueueWidgetHandler implements IRoomWidgetHandler 
    {

        private var _disposed:Boolean = false;
        private var _container:IRoomWidgetHandlerContainer = null;


        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get type():String
        {
            return ("RWE_CHAT_WIDGET");
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
            var _local_1:Array = [];
            _local_1.push("RWRQM_EXIT_QUEUE");
            _local_1.push("RWRQM_CHANGE_TO_SPECTATOR_QUEUE");
            _local_1.push("RWRQM_CHANGE_TO_VISITOR_QUEUE");
            _local_1.push("RWRQM_CLUB_LINK");
            return (_local_1);
        }

        public function processWidgetMessage(_arg_1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            if (((_container == null) || (_container.roomSession == null)))
            {
                return (null);
            };
            var _local_2:RoomWidgetRoomQueueMessage = (_arg_1 as RoomWidgetRoomQueueMessage);
            if (_local_2 == null)
            {
                return (null);
            };
            switch (_arg_1.type)
            {
                case "RWRQM_EXIT_QUEUE":
                    _container.roomSession.quit();
                    break;
                case "RWRQM_CHANGE_TO_SPECTATOR_QUEUE":
                    _container.roomSession.changeQueue(1);
                    break;
                case "RWRQM_CHANGE_TO_VISITOR_QUEUE":
                    _container.roomSession.changeQueue(2);
                    break;
                case "RWRQM_CLUB_LINK":
                    if (_container.catalog != null)
                    {
                        _container.catalog.openClubCenter();
                    };
            };
            return (null);
        }

        public function getProcessedEvents():Array
        {
            return (["RSQE_QUEUE_STATUS"]);
        }

        public function processEvent(_arg_1:Event):void
        {
            var _local_5:RoomSessionQueueEvent;
            var _local_8:String;
            var _local_2:Boolean;
            var _local_6:Array;
            var _local_7:int;
            var _local_3:Boolean;
            var _local_4:RoomWidgetRoomQueueUpdateEvent;
            if (((_container == null) || (_container.events == null)))
            {
                return;
            };
            switch (_arg_1.type)
            {
                case "RSQE_QUEUE_STATUS":
                    _local_5 = (_arg_1 as RoomSessionQueueEvent);
                    if (_local_5 == null)
                    {
                        return;
                    };
                    switch (_local_5.queueSetTarget)
                    {
                        case 2:
                            _local_8 = "RWRQUE_VISITOR_QUEUE_STATUS";
                            break;
                        case 1:
                            _local_8 = "RWRQUE_SPECTATOR_QUEUE_STATUS";
                        default:
                    };
                    if (_local_8 == null)
                    {
                        return;
                    };
                    _local_2 = true;
                    if (_container.inventory != null)
                    {
                        _local_2 = (_container.inventory.clubDays > 0);
                    };
                    _local_6 = _local_5.queueTypes;
                    _local_3 = false;
                    if (_local_6.length > 1)
                    {
                        if (((_local_2) && (!(_local_5.queueTypes.indexOf("c") == -1))))
                        {
                            _local_7 = (_local_5.getQueueSize("c") + 1);
                            _local_3 = true;
                        }
                        else
                        {
                            _local_7 = (_local_5.getQueueSize("d") + 1);
                        };
                    }
                    else
                    {
                        _local_7 = (_local_5.getQueueSize(_local_6[0]) + 1);
                    };
                    _local_4 = new RoomWidgetRoomQueueUpdateEvent(_local_8, _local_7, _local_2, _local_5.isActive, _local_3);
                    _container.events.dispatchEvent(_local_4);
                    return;
            };
        }

        public function update():void
        {
        }


    }
}