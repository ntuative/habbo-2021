package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.room.events.RoomObjectEvent;
    import com.sulake.habbo.room.events.RoomObjectStateChangeEvent;
    import com.sulake.room.events.RoomSpriteMouseEvent;
    import com.sulake.room.utils.IRoomGeometry;

    public class _SafeStr_146 extends FurnitureLogic 
    {


        override public function getEventTypes():Array
        {
            var _local_1:Array = ["ROSCE_STATE_CHANGE"];
            return (getAllEventTypes(super.getEventTypes(), _local_1));
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
                    switch (_arg_1.spriteTag)
                    {
                        case "start_stop":
                            _local_3 = new RoomObjectStateChangeEvent("ROSCE_STATE_CHANGE", object, 1);
                            break;
                        case "reset":
                            _local_3 = new RoomObjectStateChangeEvent("ROSCE_STATE_CHANGE", object, 2);
                    };
                    if (((!(eventDispatcher == null)) && (!(_local_3 == null))))
                    {
                        eventDispatcher.dispatchEvent(_local_3);
                        return;
                    };
            };
            super.mouseEvent(_arg_1, _arg_2);
        }

        override public function useObject():void
        {
            var _local_1:RoomObjectEvent;
            if (object != null)
            {
                _local_1 = new RoomObjectStateChangeEvent("ROSCE_STATE_CHANGE", object, 1);
                if (eventDispatcher != null)
                {
                    eventDispatcher.dispatchEvent(_local_1);
                };
            };
        }


    }
}

