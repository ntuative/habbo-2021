package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
    import com.sulake.room.object.IRoomObjectModelController;
    import com.sulake.room.messages.RoomObjectUpdateMessage;
    import com.sulake.room.events.RoomSpriteMouseEvent;
    import com.sulake.room.utils.IRoomGeometry;
    import com.sulake.room.events.RoomObjectEvent;
    import com.sulake.habbo.room.events.RoomObjectWidgetRequestEvent;
    import com.sulake.habbo.room.events.RoomObjectStateChangeEvent;
    import com.sulake.habbo.room.events.RoomObjectFurnitureActionEvent;

    public class FurnitureJukeboxLogic extends FurnitureMultiStateLogic 
    {

        private var _SafeStr_3190:Boolean;
        private var _SafeStr_573:Boolean = false;
        private var _SafeStr_2727:int = -1;


        override public function getEventTypes():Array
        {
            var _local_1:Array = ["ROFCAE_JUKEBOX_START", "ROFCAE_JUKEBOX_MACHINE_STOP", "ROFCAE_JUKEBOX_DISPOSE", "ROFCAE_JUKEBOX_INIT", "ROWRE_JUKEBOX_PLAYLIST_EDITOR"];
            return (getAllEventTypes(super.getEventTypes(), _local_1));
        }

        override public function dispose():void
        {
            requestDispose();
            super.dispose();
        }

        override public function processUpdateMessage(_arg_1:RoomObjectUpdateMessage):void
        {
            var _local_4:RoomObjectDataUpdateMessage;
            var _local_2:IRoomObjectModelController;
            var _local_3:int;
            super.processUpdateMessage(_arg_1);
            if (object == null)
            {
                return;
            };
            if (object.getModelController().getNumber("furniture_real_room_object") == 1)
            {
                if (!_SafeStr_573)
                {
                    requestInit();
                };
                object.getModelController().setString("RWEIEP_INFOSTAND_EXTRA_PARAM", "RWEIEP_JUKEBOX");
                _local_4 = (_arg_1 as RoomObjectDataUpdateMessage);
                if (_local_4 == null)
                {
                    return;
                };
                _local_2 = object.getModelController();
                if (_local_2 == null)
                {
                    return;
                };
                _local_3 = object.getState(0);
                if (_local_3 != _SafeStr_2727)
                {
                    _SafeStr_2727 = _local_3;
                    if (_local_3 == 1)
                    {
                        requestPlayList();
                    }
                    else
                    {
                        if (_local_3 == 0)
                        {
                            requestStopPlaying();
                        };
                    };
                };
            };
        }

        override public function mouseEvent(_arg_1:RoomSpriteMouseEvent, _arg_2:IRoomGeometry):void
        {
            if (((_arg_1 == null) || (_arg_2 == null)))
            {
                return;
            };
            if (object == null)
            {
                return;
            };
            switch (_arg_1.type)
            {
                case "doubleClick":
                    useObject();
                    return;
                default:
                    super.mouseEvent(_arg_1, _arg_2);
                    return;
            };
        }

        override public function useObject():void
        {
            var _local_1:RoomObjectEvent;
            if (((!(eventDispatcher == null)) && (!(object == null))))
            {
                _local_1 = new RoomObjectWidgetRequestEvent("ROWRE_JUKEBOX_PLAYLIST_EDITOR", object);
                eventDispatcher.dispatchEvent(_local_1);
                eventDispatcher.dispatchEvent(new RoomObjectStateChangeEvent("ROSCE_STATE_CHANGE", object, -1));
            };
        }

        private function requestInit():void
        {
            if (((object == null) || (eventDispatcher == null)))
            {
                return;
            };
            _SafeStr_3190 = true;
            var _local_1:RoomObjectFurnitureActionEvent = new RoomObjectFurnitureActionEvent("ROFCAE_JUKEBOX_INIT", object);
            eventDispatcher.dispatchEvent(_local_1);
            _SafeStr_573 = true;
        }

        private function requestPlayList():void
        {
            if (((object == null) || (eventDispatcher == null)))
            {
                return;
            };
            _SafeStr_3190 = true;
            var _local_1:RoomObjectFurnitureActionEvent = new RoomObjectFurnitureActionEvent("ROFCAE_JUKEBOX_START", object);
            eventDispatcher.dispatchEvent(_local_1);
        }

        private function requestStopPlaying():void
        {
            if (((object == null) || (eventDispatcher == null)))
            {
                return;
            };
            var _local_1:RoomObjectFurnitureActionEvent = new RoomObjectFurnitureActionEvent("ROFCAE_JUKEBOX_MACHINE_STOP", object);
            eventDispatcher.dispatchEvent(_local_1);
        }

        private function requestDispose():void
        {
            if (!_SafeStr_3190)
            {
                return;
            };
            if (((object == null) || (eventDispatcher == null)))
            {
                return;
            };
            var _local_1:RoomObjectFurnitureActionEvent = new RoomObjectFurnitureActionEvent("ROFCAE_JUKEBOX_DISPOSE", object);
            eventDispatcher.dispatchEvent(_local_1);
        }


    }
}

