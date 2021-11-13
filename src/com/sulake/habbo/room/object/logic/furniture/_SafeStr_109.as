package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.room.messages.RoomObjectUpdateMessage;

    public class _SafeStr_109 extends FurnitureLogic 
    {


        override public function processUpdateMessage(_arg_1:RoomObjectUpdateMessage):void
        {
            super.processUpdateMessage(_arg_1);
            if (object == null)
            {
                return;
            };
            if (object.getModelController().getNumber("furniture_real_room_object") == 1)
            {
                object.getModelController().setString("RWEIEP_INFOSTAND_EXTRA_PARAM", "RWEIEP_CRACKABLE_FURNI");
            };
        }


    }
}

