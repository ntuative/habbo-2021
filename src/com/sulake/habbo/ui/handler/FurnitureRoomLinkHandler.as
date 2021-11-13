package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.habbo.window.utils._SafeStr_126;
    import __AS3__.vec.Vector;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.communication.messages.incoming.navigator.GetGuestRoomResultEvent;
    import com.sulake.habbo.communication.messages.parser.navigator.GetGuestRoomResultMessageParser;
    import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
    import com.sulake.core.runtime.Component;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import com.sulake.habbo.room.events.RoomEngineToWidgetEvent;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.object.IRoomObjectModel;
    import com.sulake.habbo.communication.messages.outgoing.navigator.GetGuestRoomMessageComposer;
    import flash.events.Event;

    public class FurnitureRoomLinkHandler implements IRoomWidgetHandler
    {

        private static const INTERNAL_LINK_KEY:String = "internalLink";

        private var _container:IRoomWidgetHandlerContainer;
        private var _confirmDialog:_SafeStr_126;
        private var _communicationManagerMessageEvents:Vector.<IMessageEvent> = new Vector.<IMessageEvent>();
        private var _communicationManager:IHabboCommunicationManager;
        private var _SafeStr_3869:int = 0;
        private var _SafeStr_2344:String;


        public function get type():String
        {
            return ("RWE_ROOM_LINK");
        }

        public function set container(_arg_1:IRoomWidgetHandlerContainer):void
        {
            _container = _arg_1;
        }

        public function set communicationManager(_arg_1:IHabboCommunicationManager):void
        {
            _communicationManager = _arg_1;
            _communicationManagerMessageEvents.push(_communicationManager.addHabboConnectionMessageEvent(new GetGuestRoomResultEvent(onRoomInfo)));
        }

        private function onRoomInfo(_arg_1:IMessageEvent):void
        {
            var event:IMessageEvent = _arg_1;
            var p:GetGuestRoomResultMessageParser = GetGuestRoomResultEvent(event).getParser();
            var roomData:GuestRoomData = p.data;
            if (((roomData) && (roomData.flatId == _SafeStr_3869)))
            {
                _SafeStr_3869 = 0;
                var message:String = "${room.link.confirmation.message}";
                var roomName:String = roomData.roomName;
                var ownerName:String = roomData.ownerName;
                message = _container.localization.getLocalization("room.link.confirmation.message");
                if (((!(message == null)) && (message.indexOf("%%room_name%%") > -1)))
                {
                    message = message.replace("%%room_name%%", roomName);
                };
                if (((!(message == null)) && (message.indexOf("%%room_owner%%") > -1)))
                {
                    message = message.replace("%%room_owner%%", ownerName);
                };
                _confirmDialog = _container.windowManager.confirm("${room.link.confirmation.title}", message, (0x10 | 0x20), function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
                {
                    if (((!(_container.roomEngine == null)) && (_arg_2.type == "WE_OK")))
                    {
                        if (((!(_SafeStr_2344 == null)) && (_SafeStr_2344.length > 0)))
                        {
                            (_container.roomEngine as Component).context.createLinkEvent(("navigator/goto/" + _SafeStr_2344));
                        };
                    };
                    _arg_1.dispose();
                });
            };
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
            return (["RETWE_REQUEST_ROOM_LINK"]);
        }

        public function processEvent(_arg_1:Event):void
        {
            var _local_5:RoomEngineToWidgetEvent;
            var _local_2:IRoomObject;
            var _local_4:IRoomObjectModel;
            var _local_3:String;
            switch (_arg_1.type)
            {
                case "RETWE_REQUEST_ROOM_LINK":
                    _local_5 = (_arg_1 as RoomEngineToWidgetEvent);
                    if (((!(_arg_1 == null)) && (!(_container.roomEngine == null))))
                    {
                        _local_2 = _container.roomEngine.getRoomObject(_local_5.roomId, _local_5.objectId, _local_5.category);
                        if (_local_2 != null)
                        {
                            _local_4 = _local_2.getModel();
                            _local_3 = _local_4.getStringToStringMap("furniture_data").getValue("internalLink");
                            if (((_local_3 == null) || (_local_3.length == 0)))
                            {
                                _local_3 = _local_4.getString("furniture_internal_link");
                            };
                            if (_local_3 == null) break;
                            if (((!(_container.navigator == null)) && (!(_container.localization == null))))
                            {
                                if (_confirmDialog != null)
                                {
                                    _confirmDialog.dispose();
                                    _confirmDialog = null;
                                };
                                _SafeStr_2344 = _local_3;
                                _SafeStr_3869 = parseInt(_local_3, 10);
                                _communicationManager.connection.send(new GetGuestRoomMessageComposer(_SafeStr_3869, false, false));
                            }
                            else
                            {
                                (_container.roomEngine as Component).context.createLinkEvent(("navigator/goto/" + _local_3));
                            };
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
            if (_communicationManager)
            {
                for each (var _local_1:IMessageEvent in _communicationManagerMessageEvents)
                {
                    _communicationManager.removeHabboConnectionMessageEvent(_local_1);
                };
                _communicationManagerMessageEvents = null;
                _communicationManager = null;
            };
            if (_confirmDialog != null)
            {
                _confirmDialog.dispose();
                _confirmDialog = null;
            };
            _container = null;
        }

        public function get disposed():Boolean
        {
            return (_container == null);
        }


    }
}