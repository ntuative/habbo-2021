package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.habbo.ui.widget.furniture.rentablespace.RentableSpaceDisplayWidget;
    import com.sulake.habbo.communication.messages.incoming.room.furniture.RentableSpaceStatusMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.furniture.RentableSpaceRentOkMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.furniture.RentableSpaceRentFailedMessageEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import com.sulake.habbo.room.events.RoomEngineToWidgetEvent;
    import com.sulake.room.object.IRoomObject;
    import flash.events.Event;
    import com.sulake.habbo.communication.messages.parser.room.furniture.RentableSpaceRentFailedMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.furniture.RentableSpaceStatusMessageParser;
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.RentableSpaceStatusMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.RentableSpaceCancelRentMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.RentableSpaceRentMessageComposer;

    public class FurnitureRentableSpaceWidgetHandler implements IRoomWidgetHandler 
    {

        private var _container:IRoomWidgetHandlerContainer;
        private var _SafeStr_1324:RentableSpaceDisplayWidget;
        private var _SafeStr_3866:RentableSpaceStatusMessageEvent;
        private var _SafeStr_3867:RentableSpaceRentOkMessageEvent;
        private var _SafeStr_3868:RentableSpaceRentFailedMessageEvent;


        public function get type():String
        {
            return ("RWE_RENTABLESPACE");
        }

        public function set widget(_arg_1:RentableSpaceDisplayWidget):void
        {
            _SafeStr_1324 = _arg_1;
        }

        public function set container(_arg_1:IRoomWidgetHandlerContainer):void
        {
            _container = _arg_1;
            _SafeStr_3866 = new RentableSpaceStatusMessageEvent(onRentableSpaceStatusMessage);
            _container.connection.addMessageEvent(_SafeStr_3866);
            _SafeStr_3867 = new RentableSpaceRentOkMessageEvent(onRentableSpaceRentOkMessage);
            _container.connection.addMessageEvent(_SafeStr_3867);
            _SafeStr_3868 = new RentableSpaceRentFailedMessageEvent(onRentableSpaceRentFailedMessage);
            _container.connection.addMessageEvent(_SafeStr_3868);
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
            if (_container.roomEngine == null)
            {
                return;
            };
            var _local_3:RoomEngineToWidgetEvent = (_arg_1 as RoomEngineToWidgetEvent);
            if (_local_3 == null)
            {
                return;
            };
            var _local_2:IRoomObject = _container.roomEngine.getRoomObject(_local_3.roomId, _local_3.objectId, _local_3.category);
            switch (_arg_1.type)
            {
                case "RETWE_OPEN_WIDGET":
                    if (_local_2 != null)
                    {
                        _SafeStr_1324.show(_local_2);
                    };
                    return;
                case "RETWE_CLOSE_WIDGET":
                    _SafeStr_1324.hide(_local_2);
                    return;
            };
        }

        public function update():void
        {
        }

        public function dispose():void
        {
            if (disposed)
            {
                return;
            };
            if (_SafeStr_3866 != null)
            {
                _container.connection.removeMessageEvent(_SafeStr_3866);
                _SafeStr_3866 = null;
            };
            if (_SafeStr_3867 != null)
            {
                _container.connection.removeMessageEvent(_SafeStr_3867);
                _SafeStr_3867 = null;
            };
            if (_SafeStr_3868 != null)
            {
                _container.connection.removeMessageEvent(_SafeStr_3868);
                _SafeStr_3868 = null;
            };
            _container = null;
        }

        public function get disposed():Boolean
        {
            return (_container == null);
        }

        public function onRentableSpaceRentOkMessage(_arg_1:RentableSpaceRentOkMessageEvent):void
        {
            _SafeStr_1324.updateWidgetState();
        }

        public function onRentableSpaceRentFailedMessage(_arg_1:RentableSpaceRentFailedMessageEvent):void
        {
            var _local_2:RentableSpaceRentFailedMessageParser = _arg_1.getParser();
            _SafeStr_1324.showErrorView(_local_2.reason);
        }

        public function onRentableSpaceStatusMessage(_arg_1:RentableSpaceStatusMessageEvent):void
        {
            var _local_2:RentableSpaceStatusMessageParser = _arg_1.getParser();
            _SafeStr_1324.populateRentInfo(_local_2.rented, _local_2.canRent, _local_2.canRentErrorCode, _local_2.renterId, _local_2.renterName, _local_2.timeRemaining, _local_2.price);
        }

        public function getRentableSpaceStatus(_arg_1:int):void
        {
            _container.connection.send(new RentableSpaceStatusMessageComposer(_arg_1));
        }

        public function cancelRent(_arg_1:int):void
        {
            _container.connection.send(new RentableSpaceCancelRentMessageComposer(_arg_1));
        }

        public function rentSpace(_arg_1:int):void
        {
            _container.connection.send(new RentableSpaceRentMessageComposer(_arg_1));
        }

        public function getUsersClubLevel():int
        {
            return (_container.sessionDataManager.clubLevel);
        }

        public function getUsersCreditAmount():int
        {
            return (_container.catalog.getPurse().credits);
        }

        public function get container():IRoomWidgetHandlerContainer
        {
            return (_container);
        }


    }
}

