package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.room.events.RoomObjectEvent;
    import com.sulake.habbo.room.events.RoomObjectWidgetRequestEvent;

    public class _SafeStr_105 extends FurnitureMultiStateLogic 
    {


        override public function get contextMenu():String
        {
            return ("EFFECT_BOX");
        }

        override public function getEventTypes():Array
        {
            return (getAllEventTypes(super.getEventTypes(), ["ROWRE_EFFECTBOX_OPEN_DIALOG"]));
        }

        override public function useObject():void
        {
            var _local_1:RoomObjectEvent;
            if (((!(eventDispatcher == null)) && (!(object == null))))
            {
                _local_1 = new RoomObjectWidgetRequestEvent("ROWRE_EFFECTBOX_OPEN_DIALOG", object);
                eventDispatcher.dispatchEvent(_local_1);
            };
        }


    }
}

