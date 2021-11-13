package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetDimmerSavePresetMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetDimmerPreviewMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import com.sulake.habbo.session.events.RoomSessionDimmerPresetsEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetDimmerUpdateEvent;
    import com.sulake.habbo.session.events.RoomSessionDimmerPresetsEventPresetItem;
    import com.sulake.habbo.room.events.RoomEngineDimmerStateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetDimmerStateUpdateEvent;
    import flash.events.Event;

    public class FurnitureDimmerWidgetHandler implements IRoomWidgetHandler 
    {

        private var _disposed:Boolean = false;
        private var _container:IRoomWidgetHandlerContainer = null;


        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get type():String
        {
            return ("RWE_ROOM_DIMMER");
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
            return (["RWFWM_MESSAGE_REQUEST_DIMMER", "RWSDPM_SAVE_PRESET", "RWCDSM_CHANGE_STATE", "RWDPM_PREVIEW_DIMMER_PRESET"]);
        }

        public function processWidgetMessage(_arg_1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            var _local_3:RoomWidgetDimmerSavePresetMessage;
            var _local_4:int;
            var _local_2:RoomWidgetDimmerPreviewMessage;
            switch (_arg_1.type)
            {
                case "RWFWM_MESSAGE_REQUEST_DIMMER":
                    if (validateRights())
                    {
                        _container.roomSession.sendRoomDimmerGetPresetsMessage();
                    };
                    break;
                case "RWSDPM_SAVE_PRESET":
                    if (validateRights())
                    {
                        _local_3 = (_arg_1 as RoomWidgetDimmerSavePresetMessage);
                        _container.roomSession.sendRoomDimmerSavePresetMessage(_local_3.presetNumber, _local_3.effectTypeId, _local_3.color, _local_3.brightness, _local_3.apply);
                    };
                    break;
                case "RWCDSM_CHANGE_STATE":
                    if (validateRights())
                    {
                        _container.roomSession.sendRoomDimmerChangeStateMessage();
                    };
                    break;
                case "RWDPM_PREVIEW_DIMMER_PRESET":
                    _local_4 = _container.roomSession.roomId;
                    _local_2 = (_arg_1 as RoomWidgetDimmerPreviewMessage);
                    if (((_local_2 == null) || (_container.roomEngine == null)))
                    {
                        return (null);
                    };
                    _container.roomEngine.updateObjectRoomColor(_local_4, _local_2.color, _local_2.brightness, _local_2.bgOnly);
            };
            return (null);
        }

        private function validateRights():Boolean
        {
            var _local_1:Boolean = _container.roomSession.isRoomOwner;
            var _local_2:Boolean = (_container.roomSession.roomControllerLevel >= 1);
            var _local_3:Boolean = _container.sessionDataManager.isAnyRoomController;
            return (((_local_1) || (_local_3)) || (_local_2));
        }

        public function getProcessedEvents():Array
        {
            var _local_1:Array = [];
            _local_1.push("RSDPE_PRESETS");
            _local_1.push("REDSE_ROOM_COLOR");
            _local_1.push("RETWE_REMOVE_DIMMER");
            return (_local_1);
        }

        public function processEvent(_arg_1:Event):void
        {
            var _local_5:RoomSessionDimmerPresetsEvent;
            var _local_2:RoomWidgetDimmerUpdateEvent;
            var _local_6:int;
            var _local_7:RoomSessionDimmerPresetsEventPresetItem;
            var _local_3:RoomEngineDimmerStateEvent;
            var _local_4:RoomWidgetDimmerStateUpdateEvent;
            if (((_container == null) || (_container.events == null)))
            {
                return;
            };
            switch (_arg_1.type)
            {
                case "RSDPE_PRESETS":
                    _local_5 = (_arg_1 as RoomSessionDimmerPresetsEvent);
                    _local_2 = new RoomWidgetDimmerUpdateEvent("RWDUE_PRESETS");
                    _local_2.selectedPresetId = _local_5.selectedPresetId;
                    _local_6 = 0;
                    while (_local_6 < _local_5.presetCount)
                    {
                        _local_7 = _local_5.getPreset(_local_6);
                        if (_local_7 != null)
                        {
                            _local_2.storePreset(_local_7.id, _local_7.type, _local_7.color, _local_7.light);
                        };
                        _local_6++;
                    };
                    _container.events.dispatchEvent(_local_2);
                    return;
                case "REDSE_ROOM_COLOR":
                    _local_3 = (_arg_1 as RoomEngineDimmerStateEvent);
                    _local_4 = new RoomWidgetDimmerStateUpdateEvent(_local_3.state, _local_3.presetId, _local_3.effectId, _local_3.color, _local_3.brightness);
                    _container.events.dispatchEvent(_local_4);
                    return;
                case "RETWE_REMOVE_DIMMER":
                    _container.events.dispatchEvent(new RoomWidgetDimmerUpdateEvent("RWDUE_HIDE"));
                    return;
            };
        }

        public function update():void
        {
        }


    }
}