package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.room.events.RoomObjectEvent;
    import com.sulake.habbo.room.events.RoomObjectWidgetRequestEvent;

    public class _SafeStr_103 extends FurnitureMultiStateLogic 
    {


        override public function get contextMenu():String
        {
            return ("PURCHASABLE_CLOTHING");
        }

        override public function getEventTypes():Array
        {
            return (getAllEventTypes(super.getEventTypes(), ["ROWRE_PURCHASABLE_CLOTHING_CONFIRMATION_DIALOG"]));
        }

        override public function useObject():void
        {
            var _local_1:RoomObjectEvent;
            if (((!(eventDispatcher == null)) && (!(object == null))))
            {
                _local_1 = new RoomObjectWidgetRequestEvent("ROWRE_PURCHASABLE_CLOTHING_CONFIRMATION_DIALOG", object);
                eventDispatcher.dispatchEvent(_local_1);
            };
        }


    }
}

