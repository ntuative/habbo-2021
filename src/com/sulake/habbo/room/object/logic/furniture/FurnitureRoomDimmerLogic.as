package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.room.events.RoomObjectEvent;
    import com.sulake.habbo.room.events.RoomObjectWidgetRequestEvent;
    import com.sulake.habbo.room.events.RoomObjectDimmerStateUpdateEvent;
    import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
    import com.sulake.room.messages.RoomObjectUpdateMessage;

    public class FurnitureRoomDimmerLogic extends FurnitureLogic 
    {

        private var _SafeStr_3197:Boolean = false;


        override public function getEventTypes():Array
        {
            var _local_1:Array = ["ROWRE_DIMMER", "ROWRE_WIDGET_REMOVE_DIMMER", "RODSUE_DIMMER_STATE"];
            return (getAllEventTypes(super.getEventTypes(), _local_1));
        }

        override public function useObject():void
        {
            var _local_1:RoomObjectEvent;
            if (((!(eventDispatcher == null)) && (!(object == null))))
            {
                _local_1 = new RoomObjectWidgetRequestEvent("ROWRE_DIMMER", object);
                eventDispatcher.dispatchEvent(_local_1);
            };
        }

        override public function dispose():void
        {
            var _local_3:RoomObjectDimmerStateUpdateEvent;
            var _local_1:int;
            var _local_2:int;
            var _local_4:RoomObjectEvent;
            if (_SafeStr_3197)
            {
                if (((!(eventDispatcher == null)) && (!(object == null))))
                {
                    if (object.getModelController().getNumber("furniture_real_room_object") == 1)
                    {
                        _local_1 = 0xFFFFFF;
                        _local_2 = 0xFF;
                        _local_3 = new RoomObjectDimmerStateUpdateEvent(object, 0, 1, 1, _local_1, _local_2);
                        eventDispatcher.dispatchEvent(_local_3);
                        _local_4 = new RoomObjectWidgetRequestEvent("ROWRE_WIDGET_REMOVE_DIMMER", object);
                        eventDispatcher.dispatchEvent(_local_4);
                    };
                    _SafeStr_3197 = false;
                };
            };
            super.dispose();
        }

        private function dispatchColorUpdateEvent(_arg_1:String):void
        {
            var _local_6:int;
            var _local_9:int;
            var _local_2:int;
            var _local_5:String;
            var _local_3:uint;
            var _local_4:int;
            var _local_8:RoomObjectDimmerStateUpdateEvent;
            if (_arg_1 == null)
            {
                return;
            };
            var _local_7:Array = _arg_1.split(",");
            if (_local_7.length >= 5)
            {
                _local_6 = readState(_arg_1);
                _local_9 = parseInt(_local_7[1]);
                _local_2 = parseInt(_local_7[2]);
                _local_5 = _local_7[3];
                _local_3 = parseInt(_local_5.substr(1), 16);
                _local_4 = parseInt(_local_7[4]);
                if (_local_6 == 0)
                {
                    _local_3 = 0xFFFFFF;
                    _local_4 = 0xFF;
                };
                if (((!(eventDispatcher == null)) && (!(object == null))))
                {
                    _local_8 = new RoomObjectDimmerStateUpdateEvent(object, _local_6, _local_9, _local_2, _local_3, _local_4);
                    eventDispatcher.dispatchEvent(_local_8);
                    _SafeStr_3197 = true;
                };
            };
        }

        private function readState(_arg_1:String):int
        {
            var _local_2:int;
            if (_arg_1 == null)
            {
                return (0);
            };
            var _local_3:Array = _arg_1.split(",");
            if (_local_3.length >= 5)
            {
                return (parseInt(_local_3[0]) - 1);
            };
            return (0);
        }

        override public function processUpdateMessage(_arg_1:RoomObjectUpdateMessage):void
        {
            var _local_2:int;
            var _local_3:RoomObjectDataUpdateMessage = (_arg_1 as RoomObjectDataUpdateMessage);
            if (_local_3 != null)
            {
                if (_local_3.data != null)
                {
                    if (object.getModelController().getNumber("furniture_real_room_object") == 1)
                    {
                        dispatchColorUpdateEvent(_local_3.data.getLegacyString());
                    };
                    _local_2 = readState(_local_3.data.getLegacyString());
                    _local_3 = new RoomObjectDataUpdateMessage(_local_2, _local_3.data);
                    super.processUpdateMessage(_local_3);
                };
                return;
            };
            super.processUpdateMessage(_arg_1);
        }

        override public function update(_arg_1:int):void
        {
            var _local_2:String;
            super.update(_arg_1);
            if (((!(object == null)) && (!(object.getModelController() == null))))
            {
                if (object.getModelController().getNumber("furniture_real_room_object") == 1)
                {
                    _local_2 = object.getModelController().getString("furniture_data");
                    if (((!(_local_2 == null)) && (_local_2.length > 0)))
                    {
                        object.getModelController().setString("furniture_data", "");
                        dispatchColorUpdateEvent(_local_2);
                    };
                };
            };
        }


    }
}

