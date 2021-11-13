package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.habbo.room.events.RoomObjectWidgetRequestEvent;

    public class _SafeStr_110 extends FurnitureGuildCustomizedLogic 
    {


        override protected function openContextMenu():void
        {
        }

        override protected function updateGuildId(_arg_1:String):void
        {
            super.updateGuildId(_arg_1);
            object.getModelController().setString("furniture_internal_link", ("groupforum/" + _arg_1));
        }

        override public function useObject():void
        {
            if (((!(eventDispatcher == null)) && (!(object == null))))
            {
                eventDispatcher.dispatchEvent(new RoomObjectWidgetRequestEvent("ROWRE_INTERNAL_LINK", object));
            };
            super.useObject();
        }

        override public function getEventTypes():Array
        {
            return (getAllEventTypes(super.getEventTypes(), ["ROWRE_INTERNAL_LINK"]));
        }


    }
}

