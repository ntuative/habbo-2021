package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.habbo.room.IStuffData;
    import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
    import com.sulake.room.messages.RoomObjectUpdateMessage;
    import com.sulake.room.events.RoomSpriteMouseEvent;
    import com.sulake.room.utils.IRoomGeometry;
    import com.sulake.room.events.RoomObjectEvent;
    import com.sulake.habbo.room.events.RoomObjectWidgetRequestEvent;

    public class FurnitureClothingChangeLogic extends FurnitureLogic 
    {


        override public function getEventTypes():Array
        {
            var _local_1:Array = ["ROWRE_CLOTHING_CHANGE"];
            return (getAllEventTypes(super.getEventTypes(), _local_1));
        }

        override public function initialize(_arg_1:XML):void
        {
            super.initialize(_arg_1);
            if (((object == null) || (object.getModel() == null)))
            {
                return;
            };
            var _local_2:String = object.getModel().getString("furniture_data");
            updateClothingData(_local_2);
        }

        override public function processUpdateMessage(_arg_1:RoomObjectUpdateMessage):void
        {
            var _local_2:IStuffData;
            super.processUpdateMessage(_arg_1);
            var _local_3:RoomObjectDataUpdateMessage = (_arg_1 as RoomObjectDataUpdateMessage);
            if (_local_3 != null)
            {
                _local_2 = _local_3.data;
                if (_local_2 != null)
                {
                    updateClothingData(_local_2.getLegacyString());
                };
            };
        }

        private function updateClothingData(_arg_1:String):void
        {
            var _local_2:Array;
            if (((!(_arg_1 == null)) && (_arg_1.length > 0)))
            {
                _local_2 = _arg_1.split(",");
                if (_local_2.length > 0)
                {
                    object.getModelController().setString("furniture_clothing_boy", _local_2[0]);
                };
                if (_local_2.length > 1)
                {
                    object.getModelController().setString("furniture_clothing_girl", _local_2[1]);
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
                _local_1 = new RoomObjectWidgetRequestEvent("ROWRE_CLOTHING_CHANGE", object);
                eventDispatcher.dispatchEvent(_local_1);
            };
        }


    }
}