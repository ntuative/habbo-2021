package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.room.utils.IVector3d;
    import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
    import com.sulake.room.messages.RoomObjectUpdateMessage;
    import com.sulake.habbo.room.events.RoomObjectPlaySoundIdEvent;

    public class FurnitureCuckooClockLogic extends FurnitureMultiStateLogic 
    {

        private var _SafeStr_448:int = -1;
        private var _SafeStr_3181:IVector3d;


        override public function getEventTypes():Array
        {
            var _local_1:Array = ["ROPSIE_PLAY_SOUND_AT_PITCH"];
            return (getAllEventTypes(super.getEventTypes(), _local_1));
        }

        override public function processUpdateMessage(_arg_1:RoomObjectUpdateMessage):void
        {
            super.processUpdateMessage(_arg_1);
            var _local_2:RoomObjectDataUpdateMessage = (_arg_1 as RoomObjectDataUpdateMessage);
            if (_local_2 != null)
            {
                if (((!(_SafeStr_448 == -1)) && (!(_local_2.state == _SafeStr_448))))
                {
                    playSoundAt(_SafeStr_3181.z);
                };
                _SafeStr_448 = _local_2.state;
            }
            else
            {
                _SafeStr_3181 = _arg_1.loc;
            };
        }

        private function playSoundAt(_arg_1:Number):void
        {
            var _local_2:Number = Math.pow(2, (_arg_1 - 1.2));
            eventDispatcher.dispatchEvent(new RoomObjectPlaySoundIdEvent("ROPSIE_PLAY_SOUND_AT_PITCH", object, "FURNITURE_cuckoo_clock", _local_2));
        }


    }
}

