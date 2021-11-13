package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.room.object.IRoomObjectModelController;
    import com.sulake.room.events.RoomSpriteMouseEvent;
    import com.sulake.room.utils.IRoomGeometry;
    import com.sulake.room.events.RoomObjectEvent;
    import com.sulake.habbo.room.events.RoomObjectWidgetRequestEvent;

    public class FurnitureCreditLogic extends FurnitureLogic 
    {


        override public function getEventTypes():Array
        {
            var _local_1:Array = ["ROWRE__CREDITFURNI"];
            return (getAllEventTypes(super.getEventTypes(), _local_1));
        }

        override public function dispose():void
        {
            super.dispose();
        }

        override public function initialize(_arg_1:XML):void
        {
            var _local_2:IRoomObjectModelController;
            super.initialize(_arg_1);
            if (_arg_1 == null)
            {
                return;
            };
            var _local_4:XMLList = _arg_1.credits;
            if (_local_4.length() == 0)
            {
                return;
            };
            var _local_3:Number = Number(_local_4[0].@value);
            if (object != null)
            {
                _local_2 = object.getModelController();
                if (_local_2 != null)
                {
                    _local_2.setNumber("furniture_credit_value", _local_3);
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
                _local_1 = new RoomObjectWidgetRequestEvent("ROWRE__CREDITFURNI", object);
                eventDispatcher.dispatchEvent(_local_1);
            };
            super.useObject();
        }


    }
}