package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.habbo.room.events.RoomObjectWidgetRequestEvent;
    import com.sulake.habbo.room.messages.RoomObjectItemDataUpdateMessage;
    import com.sulake.room.messages.RoomObjectUpdateMessage;
    import com.sulake.room.events.RoomSpriteMouseEvent;
    import com.sulake.room.utils.IRoomGeometry;
    import com.sulake.room.events.RoomObjectEvent;
    import com.sulake.habbo.room.events.RoomObjectFurnitureActionEvent;

    public class FurnitureStickieLogic extends FurnitureLogic 
    {


        override public function getEventTypes():Array
        {
            var _local_1:Array = ["ROWRE__STICKIE", "ROFCAE_STICKIE"];
            return (getAllEventTypes(super.getEventTypes(), _local_1));
        }

        override public function initialize(_arg_1:XML):void
        {
            super.initialize(_arg_1);
            setColorIndexFromItemData();
            if (object != null)
            {
                object.getModelController().setString("furniture_is_stickie", "");
            };
        }

        override public function processUpdateMessage(_arg_1:RoomObjectUpdateMessage):void
        {
            var _local_2:RoomObjectWidgetRequestEvent;
            super.processUpdateMessage(_arg_1);
            if ((_arg_1 is RoomObjectItemDataUpdateMessage))
            {
                _local_2 = new RoomObjectWidgetRequestEvent("ROWRE__STICKIE", object);
                if (_local_2 != null)
                {
                    eventDispatcher.dispatchEvent(_local_2);
                };
            };
            setColorIndexFromItemData();
        }

        protected function setColorIndexFromItemData():void
        {
            var _local_3:String;
            var _local_1:Array;
            var _local_2:int;
            if (object != null)
            {
                _local_3 = object.getModel().getString("furniture_data");
                _local_1 = new Array("9CCEFF", "FF9CFF", "9CFF9C", "FFFF33");
                _local_2 = _local_1.indexOf(_local_3);
                if (_local_2 < 0)
                {
                    _local_2 = 3;
                };
                object.getModelController().setNumber("furniture_color", (_local_2 + 1));
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
                _local_1 = new RoomObjectFurnitureActionEvent("ROFCAE_STICKIE", object);
                eventDispatcher.dispatchEvent(_local_1);
            };
        }


    }
}