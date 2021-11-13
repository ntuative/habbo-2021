package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.habbo.room.events.RoomObjectFurnitureActionEvent;
    import com.sulake.room.events.RoomSpriteMouseEvent;
    import com.sulake.room.utils.IRoomGeometry;

    public class FurnitureMultiStateLogic extends FurnitureLogic 
    {


        override public function getEventTypes():Array
        {
            var _local_1:Array = ["ROFCAE_MOUSE_BUTTON", "ROFCAE_MOUSE_ARROW"];
            return (getAllEventTypes(super.getEventTypes(), _local_1));
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
                    break;
                case "rollOut":
                    eventDispatcher.dispatchEvent(new RoomObjectFurnitureActionEvent("ROFCAE_MOUSE_ARROW", object));
                    break;
                default:
            };
            super.mouseEvent(_arg_1, _arg_2);
        }


    }
}