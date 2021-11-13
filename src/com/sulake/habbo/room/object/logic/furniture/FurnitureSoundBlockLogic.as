package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.habbo.room.events.RoomObjectSamplePlaybackEvent;
    import com.sulake.room.utils.IVector3d;
    import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
    import com.sulake.room.messages.RoomObjectUpdateMessage;

    public class FurnitureSoundBlockLogic extends FurnitureMultiStateLogic 
    {

        private static const _SafeStr_3201:int = 12;
        private static const _SafeStr_3202:int = -12;
        private static const STATE_UNINITIALIZED:int = -1;

        private var _SafeStr_448:int = -1;
        private var _SafeStr_3203:int = -1;
        private var _SafeStr_3204:Boolean = false;
        private var _SafeStr_3205:Number = 0;


        override public function dispose():void
        {
            if (_SafeStr_448 != -1)
            {
                eventDispatcher.dispatchEvent(new RoomObjectSamplePlaybackEvent("ROPSPE_ROOM_OBJECT_DISPOSED", object, _SafeStr_3203));
            };
            super.dispose();
        }

        override public function getEventTypes():Array
        {
            var _local_1:Array = ["ROPSPE_PLAY_SAMPLE", "ROPSPE_ROOM_OBJECT_DISPOSED", "ROPSPE_ROOM_OBJECT_INITIALIZED"];
            return (getAllEventTypes(super.getEventTypes(), _local_1));
        }

        override public function initialize(_arg_1:XML):void
        {
            super.initialize(_arg_1);
            if (_arg_1 == null)
            {
                return;
            };
            var _local_2:XMLList = _arg_1.sound;
            if (_local_2.length() == 0)
            {
                return;
            };
            var _local_3:XMLList = _arg_1.sound.sample;
            if (_local_3.length() == 0)
            {
                return;
            };
            _SafeStr_3203 = int(_local_3.@id);
            _SafeStr_3204 = (_local_3.@nopitch == "true");
            object.getModelController().setNumber("furniture_soundblock_relative_animation_speed", 1);
        }

        override public function processUpdateMessage(_arg_1:RoomObjectUpdateMessage):void
        {
            super.processUpdateMessage(_arg_1);
            var _local_2:IVector3d = object.getLocation();
            var _local_3:RoomObjectDataUpdateMessage = (_arg_1 as RoomObjectDataUpdateMessage);
            if (_local_3 != null)
            {
                if (((_SafeStr_448 == -1) && (object.getModelController().getNumber("furniture_real_room_object") == 1)))
                {
                    _SafeStr_3205 = _local_2.z;
                    eventDispatcher.dispatchEvent(new RoomObjectSamplePlaybackEvent("ROPSPE_ROOM_OBJECT_INITIALIZED", object, _SafeStr_3203, getPitchForHeight(_local_2.z)));
                };
                if (((!(_SafeStr_448 == -1)) && (!(_local_2 == null))))
                {
                    if (_SafeStr_3205 != _local_2.z)
                    {
                        eventDispatcher.dispatchEvent(new RoomObjectSamplePlaybackEvent("ROPSPE_CHANGE_PITCH", object, _SafeStr_3203, getPitchForHeight(_local_2.z)));
                        _SafeStr_3205 = _local_2.z;
                    };
                };
                if ((((!(_SafeStr_448 == -1)) && (!(_local_3.state == _SafeStr_448))) && (!(_local_2 == null))))
                {
                    playSoundAt(_local_2.z);
                };
                _SafeStr_448 = _local_3.state;
            };
        }

        private function playSoundAt(_arg_1:Number):void
        {
            var _local_2:Number = getPitchForHeight(_arg_1);
            object.getModelController().setNumber("furniture_soundblock_relative_animation_speed", _local_2);
            eventDispatcher.dispatchEvent(new RoomObjectSamplePlaybackEvent("ROPSPE_PLAY_SAMPLE", object, _SafeStr_3203, _local_2));
        }

        private function getPitchForHeight(_arg_1:Number):Number
        {
            var _local_2:int = (_arg_1 * 2);
            if (_local_2 > 12)
            {
                _local_2 = Math.min(0, (-12 + ((_local_2 - 12) - 1)));
            };
            return ((_SafeStr_3204) ? 1 : Math.pow(2, (_local_2 / 12)));
        }


    }
}

