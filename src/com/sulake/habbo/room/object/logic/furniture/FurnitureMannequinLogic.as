package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
    import com.sulake.room.messages.RoomObjectUpdateMessage;
    import com.sulake.habbo.room.object.data.MapStuffData;
    import com.sulake.room.events.RoomSpriteMouseEvent;
    import com.sulake.room.utils.IRoomGeometry;
    import com.sulake.room.events.RoomObjectEvent;
    import com.sulake.habbo.room.events.RoomObjectWidgetRequestEvent;

    public class FurnitureMannequinLogic extends FurnitureLogic 
    {

        private static const KEY_GENDER:String = "GENDER";
        private static const KEY_FIGURE:String = "FIGURE";
        private static const KEY_OUTFIT_NAME:String = "OUTFIT_NAME";


        override public function getEventTypes():Array
        {
            var _local_1:Array = ["ROWRE_MANNEQUIN"];
            return (getAllEventTypes(super.getEventTypes(), _local_1));
        }

        override public function processUpdateMessage(_arg_1:RoomObjectUpdateMessage):void
        {
            super.processUpdateMessage(_arg_1);
            var _local_2:RoomObjectDataUpdateMessage = (_arg_1 as RoomObjectDataUpdateMessage);
            if (((!(_local_2 == null)) && (!(_local_2.data == null))))
            {
                _local_2.data.writeRoomObjectModel(object.getModelController());
                setObjectVariables();
            };
        }

        private function setObjectVariables():void
        {
            if (((object == null) || (object.getModelController() == null)))
            {
                return;
            };
            var _local_1:MapStuffData = new MapStuffData();
            _local_1.initializeFromRoomObjectModel(object.getModel());
            object.getModelController().setString("furniture_mannequin_gender", _local_1.getValue("GENDER"));
            object.getModelController().setString("furniture_mannequin_figure", _local_1.getValue("FIGURE"));
            object.getModelController().setString("furniture_mannequin_name", _local_1.getValue("OUTFIT_NAME"));
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
                _local_1 = new RoomObjectWidgetRequestEvent("ROWRE_MANNEQUIN", object);
                eventDispatcher.dispatchEvent(_local_1);
            };
        }


    }
}