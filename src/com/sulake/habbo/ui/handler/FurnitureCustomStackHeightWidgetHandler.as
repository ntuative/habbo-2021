package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.habbo.ui.widget.furniture.CustomStackHeightWidget;
    import com.sulake.habbo.communication.messages.incoming.room.furniture.CustomStackingHeightUpdateMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.furniture.CustomStackingHeightUpdateMessageParser;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import com.sulake.habbo.room.events.RoomEngineToWidgetEvent;
    import com.sulake.room.object.IRoomObject;
    import flash.events.Event;

    public class FurnitureCustomStackHeightWidgetHandler implements IRoomWidgetHandler 
    {

        private var _container:IRoomWidgetHandlerContainer;
        private var _SafeStr_1324:CustomStackHeightWidget;
        private var _SafeStr_3865:int = -1;


        public function set widget(_arg_1:CustomStackHeightWidget):void
        {
            _SafeStr_1324 = _arg_1;
        }

        public function get type():String
        {
            return ("RWE_CUSTOM_STACK_HEIGHT");
        }

        public function set container(_arg_1:IRoomWidgetHandlerContainer):void
        {
            _container = _arg_1;
            _container.connection.addMessageEvent(new CustomStackingHeightUpdateMessageEvent(onStackHeightUpdate));
        }

        private function onStackHeightUpdate(_arg_1:CustomStackingHeightUpdateMessageEvent):void
        {
            var _local_2:CustomStackingHeightUpdateMessageParser = _arg_1.getParser();
            if (((_SafeStr_1324) && (validateRights())))
            {
                _SafeStr_1324.updateHeight(_local_2.furniId, _local_2.height);
            };
        }

        public function get container():IRoomWidgetHandlerContainer
        {
            return (_container);
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
            return ([]);
        }

        public function processEvent(_arg_1:Event):void
        {
            var _local_3:RoomEngineToWidgetEvent;
            var _local_2:IRoomObject;
            switch (_arg_1.type)
            {
                case "RETWE_OPEN_WIDGET":
                    _local_3 = (_arg_1 as RoomEngineToWidgetEvent);
                    if (((!(_arg_1 == null)) && (!(_container.roomEngine == null))))
                    {
                        _SafeStr_3865 = _local_3.objectId;
                        _local_2 = _container.roomEngine.getRoomObject(_local_3.roomId, _local_3.objectId, _local_3.category);
                        if (((_local_2) && (validateRights(_local_2))))
                        {
                            if (_SafeStr_1324)
                            {
                                _SafeStr_1324.open(_SafeStr_3865, _local_2.getLocation().z);
                            };
                        };
                    };
                    return;
                case "RETWE_CLOSE_WIDGET":
                    _local_3 = (_arg_1 as RoomEngineToWidgetEvent);
                    if ((((!(_arg_1 == null)) && (!(_container.roomEngine == null))) && (!(_SafeStr_1324 == null))))
                    {
                        if (_SafeStr_3865 == _local_3.objectId)
                        {
                            _SafeStr_1324.hide();
                        };
                    };
                    return;
            };
        }

        public function update():void
        {
        }

        public function dispose():void
        {
            _container = null;
            _SafeStr_1324 = null;
        }

        public function get disposed():Boolean
        {
            return (_container == null);
        }

        private function validateRights(_arg_1:IRoomObject=null):Boolean
        {
            var _local_2:Boolean = _container.roomSession.isRoomOwner;
            var _local_3:Boolean = (_container.roomSession.roomControllerLevel >= 1);
            var _local_4:Boolean = _container.sessionDataManager.isAnyRoomController;
            var _local_5:Boolean = ((_arg_1) && (_container.isOwnerOfFurniture(_arg_1)));
            return ((((_local_2) || (_local_4)) || (_local_3)) || (_local_5));
        }


    }
}

