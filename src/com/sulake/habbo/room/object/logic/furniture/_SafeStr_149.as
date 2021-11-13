package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.habbo.room.events.RoomObjectDataRequestEvent;
    import com.sulake.room.object.IRoomObjectModel;

    public class _SafeStr_149 extends FurnitureLogic
    {


        override public function get widget():String
        {
            return ("RWE_RENTABLESPACE");
        }

        override public function getEventTypes():Array
        {
            return (getAllEventTypes(super.getEventTypes(), ["RODRE_CURRENT_USER_ID"]));
        }

        override public function update(_arg_1:int):void
        {
            super.update(_arg_1);
            if (!object.getModel().hasNumber("session_current_user_id"))
            {
                eventDispatcher.dispatchEvent(new RoomObjectDataRequestEvent("RODRE_CURRENT_USER_ID", object));
            };
            var _local_4:IRoomObjectModel = object.getModel();
            var _local_2:String = _local_4.getStringToStringMap("furniture_data").getValue("renterId");
            var _local_3:Number = _local_4.getNumber("session_current_user_id");
            if (_local_2 != null)
            {
                if (Number(_local_2) == _local_3)
                {
                    object.setState(2, 0);
                }
                else
                {
                    object.setState(1, 0);
                };
            }
            else
            {
                object.setState(0, 0);
            };
        }


    }
}