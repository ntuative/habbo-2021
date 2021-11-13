package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetFurniToWidgetMessage;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.object.IRoomObjectModel;
    import com.sulake.habbo.ui.widget.events.RoomWidgetCreditFurniUpdateEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetCreditFurniRedeemMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import flash.events.Event;

    public class FurnitureCreditWidgetHandler implements IRoomWidgetHandler 
    {

        private var _disposed:Boolean = false;
        private var _container:IRoomWidgetHandlerContainer = null;


        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get type():String
        {
            return ("RWE_FURNI_CREDIT_WIDGET");
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
            return (["RWFWM_MESSAGE_REQUEST_CREDITFURNI", "RWFCRM_REDEEM"]);
        }

        public function processWidgetMessage(_arg_1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            var _local_3:RoomWidgetFurniToWidgetMessage;
            var _local_2:IRoomObject;
            var _local_7:IRoomObjectModel;
            var _local_6:Number;
            var _local_4:RoomWidgetCreditFurniUpdateEvent;
            var _local_5:RoomWidgetCreditFurniRedeemMessage;
            switch (_arg_1.type)
            {
                case "RWFWM_MESSAGE_REQUEST_CREDITFURNI":
                    _local_3 = (_arg_1 as RoomWidgetFurniToWidgetMessage);
                    _local_2 = _container.roomEngine.getRoomObject(_local_3.roomId, _local_3.id, _local_3.category);
                    if (((!(_local_2 == null)) && (_container.isOwnerOfFurniture(_local_2))))
                    {
                        _local_7 = _local_2.getModel();
                        if (_local_7 != null)
                        {
                            _local_6 = _local_7.getNumber("furniture_credit_value");
                            _local_4 = new RoomWidgetCreditFurniUpdateEvent("RWCFUE_CREDIT_FURNI_UPDATE", _local_3.id, _local_6);
                            _container.events.dispatchEvent(_local_4);
                        };
                    };
                    break;
                case "RWFCRM_REDEEM":
                    _local_5 = (_arg_1 as RoomWidgetCreditFurniRedeemMessage);
                    if (((!(_container == null)) && (!(_container.roomSession == null))))
                    {
                        _container.roomSession.sendCreditFurniRedeemMessage(_local_5.objectId);
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
            if ((((!(_container == null)) && (!(_container.events == null))) && (!(_local_2 == null))))
            {
                _container.events.dispatchEvent(_local_2);
            };
        }

        public function update():void
        {
        }


    }
}