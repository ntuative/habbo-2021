package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.habbo.room.events.RoomObjectDataRequestEvent;

    public class _SafeStr_151 extends FurnitureLogic 
    {


        override public function get widget():String
        {
            return ("RWE_YOUTUBE");
        }

        override public function getEventTypes():Array
        {
            return (getAllEventTypes(super.getEventTypes(), ["RODRE_URL_PREFIX"]));
        }

        override public function update(_arg_1:int):void
        {
            super.update(_arg_1);
            if (!object.getModel().hasString("session_url_prefix"))
            {
                eventDispatcher.dispatchEvent(new RoomObjectDataRequestEvent("RODRE_URL_PREFIX", object));
            };
        }


    }
}

