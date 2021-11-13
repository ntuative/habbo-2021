package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
    import com.sulake.room.messages.RoomObjectUpdateMessage;
    import com.sulake.habbo.room.object.data.IntArrayStuffData;
    import com.sulake.habbo.room.events.RoomObjectHSLColorEnableEvent;
    import com.sulake.room.events.RoomObjectEvent;
    import com.sulake.habbo.room.events.RoomObjectWidgetRequestEvent;
    import com.sulake.room.events.RoomSpriteMouseEvent;
    import com.sulake.room.utils.IRoomGeometry;

    public class FurnitureRoomBackgroundColorLogic extends FurnitureMultiStateLogic
    {

        private var _SafeStr_3197:Boolean = false;


        override public function getEventTypes():Array
        {
            var _local_1:Array = ["ROWRE_BACKGROUND_COLOR", "ROHSLCEE_ROOM_BACKGROUND_COLOR"];
            return (getAllEventTypes(super.getEventTypes(), _local_1));
        }

        override public function processUpdateMessage(_arg_1:RoomObjectUpdateMessage):void
        {
            super.processUpdateMessage(_arg_1);
            var _local_2:RoomObjectDataUpdateMessage = (_arg_1 as RoomObjectDataUpdateMessage);
            if (((!(_local_2 == null)) && (!(_local_2.data == null))))
            {
                _local_2.data.writeRoomObjectModel(object.getModelController());
                if (object.getModelController().getNumber("furniture_real_room_object") == 1)
                {
                    setupObject();
                };
            };
        }

        private function setupObject():void
        {
            if (((object == null) || (object.getModelController() == null)))
            {
                return;
            };
            var _local_2:IntArrayStuffData = new IntArrayStuffData();
            _local_2.initializeFromRoomObjectModel(object.getModel());
            var _local_5:int = _local_2.getValue(0);
            var _local_4:int = _local_2.getValue(1);
            var _local_1:int = _local_2.getValue(2);
            var _local_3:int = _local_2.getValue(3);
            if (((((_local_5 > -1) && (_local_4 > -1)) && (_local_1 > -1)) && (_local_3 > -1)))
            {
                object.getModelController().setNumber("furniture_room_background_color_hue", _local_4);
                object.getModelController().setNumber("furniture_room_background_color_saturation", _local_1);
                object.getModelController().setNumber("furniture_room_background_color_lightness", _local_3);
                object.setState(_local_5, 0);
                if (((!(eventDispatcher == null)) && (!(object == null))))
                {
                    eventDispatcher.dispatchEvent(new RoomObjectHSLColorEnableEvent("ROHSLCEE_ROOM_BACKGROUND_COLOR", object, !!_local_5, _local_4, _local_1, _local_3));
                };
                _SafeStr_3197 = true;
            };
        }

        override public function dispose():void
        {
            if (_SafeStr_3197)
            {
                if (((!(eventDispatcher == null)) && (!(object == null))))
                {
                    if (object.getModelController().getNumber("furniture_real_room_object") == 1)
                    {
                        eventDispatcher.dispatchEvent(new RoomObjectHSLColorEnableEvent("ROHSLCEE_ROOM_BACKGROUND_COLOR", object, false, 0, 0, 0));
                    };
                };
                _SafeStr_3197 = false;
            };
            super.dispose();
        }

        override public function mouseEvent(_arg_1:RoomSpriteMouseEvent, _arg_2:IRoomGeometry):void
        {
            var _local_3:RoomObjectEvent;
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
                    if (((!(eventDispatcher == null)) && (!(object == null))))
                    {
                        _local_3 = new RoomObjectWidgetRequestEvent("ROWRE_BACKGROUND_COLOR", object);
                        eventDispatcher.dispatchEvent(_local_3);
                    };
                    return;
                default:
                    super.mouseEvent(_arg_1, _arg_2);
                    return;
            };
        }


    }
}