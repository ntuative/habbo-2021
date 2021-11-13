package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import __AS3__.vec.Vector;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.navigator.IHabboNavigator;
    import com.sulake.habbo.ui.widget.roomtools.RoomToolsWidget;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.habbo.communication.messages.incoming.navigator.GetGuestRoomResultEvent;
    import com.sulake.habbo.communication.messages.parser.navigator.GetGuestRoomResultMessageParser;
    import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import flash.events.Event;
    import com.sulake.habbo.session.events.SessionDataPreferencesEvent;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.habbo.communication.messages.outgoing.navigator.RateFlatMessageComposer;

    public class RoomToolsWidgetHandler implements IRoomWidgetHandler 
    {

        private var _disposed:Boolean;
        private var _communicationManagerMessageEvents:Vector.<IMessageEvent> = new Vector.<IMessageEvent>();
        private var _communicationManager:IHabboCommunicationManager;
        private var _navigator:IHabboNavigator;
        private var _SafeStr_1324:RoomToolsWidget;
        private var _container:IRoomWidgetHandlerContainer;


        public function set widget(_arg_1:RoomToolsWidget):void
        {
            _SafeStr_1324 = _arg_1;
        }

        private function onRoomInfo(_arg_1:IMessageEvent):void
        {
            var _local_3:String;
            var _local_2:GetGuestRoomResultMessageParser = GetGuestRoomResultEvent(_arg_1).getParser();
            var _local_4:GuestRoomData = _local_2.data;
            if (_local_4)
            {
                _SafeStr_1324.updateRoomData(_local_4);
            };
            if (_local_2.enterRoom)
            {
                if (_local_4)
                {
                    _local_3 = ((_local_4.showOwner) ? ((_SafeStr_1324.localizations.getLocalizationWithParams("room.tool.room.owner.prefix", "By") + " ") + _local_4.ownerName) : _SafeStr_1324.localizations.getLocalizationWithParams("room.tool.public.room", "Public room"));
                    _SafeStr_1324.showRoomInfo(true, _local_4.roomName, _local_3, _local_4.tags);
                    _SafeStr_1324.storeRoomData(_local_4);
                    _SafeStr_1324.enterNewRoom(_local_4.flatId);
                };
            };
        }

        public function toggleRoomInfoWindow():void
        {
            _navigator.toggleRoomInfoVisibility();
        }

        public function goToPrivateRoom(_arg_1:int):void
        {
            _navigator.goToPrivateRoom(_arg_1);
        }

        public function get type():String
        {
            return ("RWE_ROOM_TOOLS");
        }

        public function set container(_arg_1:IRoomWidgetHandlerContainer):void
        {
            _container = _arg_1;
            _container.sessionDataManager.events.addEventListener("APUE_UPDATED", onSessionDataPreferences);
        }

        public function get container():IRoomWidgetHandlerContainer
        {
            return (_container);
        }

        public function getWidgetMessages():Array
        {
            return (["RWZTM_ZOOM_TOGGLE"]);
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
        }

        private function onSessionDataPreferences(_arg_1:SessionDataPreferencesEvent):void
        {
        }

        public function update():void
        {
        }

        public function dispose():void
        {
            _disposed = true;
            if (_communicationManager)
            {
                for each (var _local_1:IMessageEvent in _communicationManagerMessageEvents)
                {
                    _communicationManager.removeHabboConnectionMessageEvent(_local_1);
                };
                _communicationManagerMessageEvents = null;
                _communicationManager = null;
            };
            if (((_container) && (_container.sessionDataManager)))
            {
                _container.sessionDataManager.events.removeEventListener("APUE_UPDATED", onSessionDataPreferences);
            };
            _navigator = null;
            _SafeStr_1324 = null;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function set navigator(_arg_1:IHabboNavigator):void
        {
            _navigator = _arg_1;
        }

        public function get navigator():IHabboNavigator
        {
            return (_navigator);
        }

        public function get sessionDataManager():ISessionDataManager
        {
            return (_container.sessionDataManager);
        }

        public function set communicationManager(_arg_1:IHabboCommunicationManager):void
        {
            _communicationManager = _arg_1;
            _communicationManagerMessageEvents.push(_communicationManager.addHabboConnectionMessageEvent(new GetGuestRoomResultEvent(onRoomInfo)));
        }

        public function rateRoom():void
        {
            _container.connection.send(new RateFlatMessageComposer(1));
        }

        public function get canRate():Boolean
        {
            return (_navigator.canRateRoom());
        }


    }
}

