package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetLetUserInMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import com.sulake.habbo.session.events.RoomSessionDoorbellEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetDoorbellEvent;
    import flash.events.Event;

    public class DoorbellWidgetHandler implements IRoomWidgetHandler 
    {

        private var _disposed:Boolean = false;
        private var _container:IRoomWidgetHandlerContainer = null;


        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get type():String
        {
            return ("RWE_DOORBELL");
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
            return (["RWLUIM_LET_USER_IN"]);
        }

        public function processWidgetMessage(_arg_1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            var _local_2:RoomWidgetLetUserInMessage;
            switch (_arg_1.type)
            {
                case "RWLUIM_LET_USER_IN":
                    _local_2 = (_arg_1 as RoomWidgetLetUserInMessage);
                    _container.roomSession.letUserIn(_local_2.userName, _local_2.canEnter);
            };
            return (null);
        }

        public function getProcessedEvents():Array
        {
            return (["RSDE_DOORBELL", "RSDE_REJECTED", "RSDE_ACCEPTED"]);
        }

        public function processEvent(_arg_1:Event):void
        {
            var _local_2:RoomSessionDoorbellEvent;
            switch (_arg_1.type)
            {
                case "RSDE_DOORBELL":
                    _local_2 = (_arg_1 as RoomSessionDoorbellEvent);
                    if (_local_2 == null)
                    {
                        return;
                    };
                    _container.events.dispatchEvent(new RoomWidgetDoorbellEvent("RWDE_RINGING", _local_2.userName));
                    return;
                case "RSDE_REJECTED":
                    _local_2 = (_arg_1 as RoomSessionDoorbellEvent);
                    if (_local_2 == null)
                    {
                        return;
                    };
                    _container.events.dispatchEvent(new RoomWidgetDoorbellEvent("RWDE_REJECTED", _local_2.userName));
                    return;
                case "RSDE_ACCEPTED":
                    _local_2 = (_arg_1 as RoomSessionDoorbellEvent);
                    if (_local_2 == null)
                    {
                        return;
                    };
                    _container.events.dispatchEvent(new RoomWidgetDoorbellEvent("RWDE_ACCEPTED", _local_2.userName));
                    return;
            };
        }

        public function update():void
        {
        }


    }
}