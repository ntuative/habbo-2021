package com.sulake.habbo.room.object.logic.room
{
    import com.sulake.room.object.logic.ObjectLogicBase;
    import com.sulake.room.object.IRoomObjectModelController;
    import com.sulake.habbo.room.messages.RoomObjectVisibilityUpdateMessage;
    import com.sulake.room.messages.RoomObjectUpdateMessage;

    public class _SafeStr_128 extends ObjectLogicBase 
    {


        override public function initialize(_arg_1:XML):void
        {
            var _local_2:IRoomObjectModelController;
            if (object != null)
            {
                _local_2 = object.getModelController();
                if (_local_2 != null)
                {
                    _local_2.setNumber("furniture_alpha_multiplier", 1);
                    object.setState(1, 0);
                };
            };
        }

        override public function processUpdateMessage(_arg_1:RoomObjectUpdateMessage):void
        {
            super.processUpdateMessage(_arg_1);
            var _local_2:RoomObjectVisibilityUpdateMessage = (_arg_1 as RoomObjectVisibilityUpdateMessage);
            if (_local_2 != null)
            {
                if (_local_2.type == "ROVUM_ENABLED")
                {
                    if (object != null)
                    {
                        object.setState(0, 0);
                    };
                }
                else
                {
                    if (_local_2.type == "ROVUM_DISABLED")
                    {
                        if (object != null)
                        {
                            object.setState(1, 0);
                        };
                    };
                };
            };
        }


    }
}

