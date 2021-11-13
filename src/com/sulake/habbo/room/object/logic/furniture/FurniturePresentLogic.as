package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectModelDataUpdateMessage;
    import com.sulake.room.messages.RoomObjectUpdateMessage;
    import com.sulake.habbo.room.object.data.MapStuffData;
    import com.sulake.habbo.room.events.RoomObjectFurnitureActionEvent;
    import com.sulake.room.events.RoomSpriteMouseEvent;
    import com.sulake.room.utils.IRoomGeometry;
    import com.sulake.room.events.RoomObjectEvent;
    import com.sulake.habbo.room.events.RoomObjectWidgetRequestEvent;
    import com.sulake.room.object.IRoomObjectModelController;

    public class FurniturePresentLogic extends FurnitureLogic 
    {

        private static const MESSAGE:String = "MESSAGE";
        private static const PRODUCT_CODE:String = "PRODUCT_CODE";
        private static const EXTRA_PARAM:String = "EXTRA_PARAM";
        private static const PURCHASER_NAME:String = "PURCHASER_NAME";
        private static const PURCHASER_FIGURE:String = "PURCHASER_FIGURE";


        override public function getEventTypes():Array
        {
            var _local_1:Array = ["ROWRE_PRESENT"];
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
            var _local_3:RoomObjectModelDataUpdateMessage = (_arg_1 as RoomObjectModelDataUpdateMessage);
            if (_local_3 != null)
            {
                if (_local_3.numberKey == "furniture_disable_picking_animation")
                {
                    object.getModelController().setNumber("furniture_disable_picking_animation", _local_3.numberValue);
                };
            };
        }

        private function setObjectVariables():void
        {
            if (((object == null) || (object.getModelController() == null)))
            {
                return;
            };
            var _local_2:MapStuffData = new MapStuffData();
            _local_2.initializeFromRoomObjectModel(object.getModel());
            var _local_1:String = _local_2.getValue("MESSAGE");
            var _local_3:String = object.getModel().getString("furniture_data");
            if (((_local_1 == null) && (!(_local_3 == null))))
            {
                object.getModelController().setString("furniture_data", _local_3.substr(1));
            }
            else
            {
                object.getModelController().setString("furniture_data", _local_2.getValue("MESSAGE"));
            };
            setObjectVariable("furniture_type_id", _local_2.getValue("PRODUCT_CODE"));
            setObjectVariable("furniture_purchaser_name", _local_2.getValue("PURCHASER_NAME"));
            setObjectVariable("furniture_purchaser_figure", _local_2.getValue("PURCHASER_FIGURE"));
        }

        private function setObjectVariable(_arg_1:String, _arg_2:String):void
        {
            if (_arg_2 != null)
            {
                object.getModelController().setString(_arg_1, _arg_2);
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
                case "rollOver":
                    eventDispatcher.dispatchEvent(new RoomObjectFurnitureActionEvent("ROFCAE_MOUSE_BUTTON", object));
                    super.mouseEvent(_arg_1, _arg_2);
                    return;
                case "rollOut":
                    eventDispatcher.dispatchEvent(new RoomObjectFurnitureActionEvent("ROFCAE_MOUSE_ARROW", object));
                    super.mouseEvent(_arg_1, _arg_2);
                    return;
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
                _local_1 = new RoomObjectWidgetRequestEvent("ROWRE_PRESENT", object);
                eventDispatcher.dispatchEvent(_local_1);
            };
        }

        override public function initialize(_arg_1:XML):void
        {
            var _local_3:IRoomObjectModelController;
            super.initialize(_arg_1);
            if (_arg_1 == null)
            {
                return;
            };
            var _local_2:XMLList = _arg_1.particlesystems;
            if (((_local_2 == null) || (_local_2.length() == 0)))
            {
                return;
            };
            if (object != null)
            {
                _local_3 = object.getModelController();
                if (_local_3 != null)
                {
                    _local_3.setString("furniture_fireworks_data", _local_2);
                };
            };
        }


    }
}