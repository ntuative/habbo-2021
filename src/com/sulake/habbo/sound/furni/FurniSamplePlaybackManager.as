package com.sulake.habbo.sound.furni
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.sound.HabboSoundManagerFlash10;
    import flash.events.IEventDispatcher;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.sound.HabboSoundWithPitch;
    import com.sulake.habbo.room.events.RoomEngineObjectSamplePlaybackEvent;
    import flash.net.URLRequest;
    import flash.media.Sound;
    import flash.events.Event;
    import flash.events.IOErrorEvent;

    public class FurniSamplePlaybackManager implements IDisposable 
    {

        private var _soundManager:HabboSoundManagerFlash10;
        private var _roomEvents:IEventDispatcher;
        private var _disposed:Boolean = false;
        private var _SafeStr_3720:Map = new Map();
        private var _SafeStr_3721:Map = new Map();
        private var _SafeStr_3722:Map = new Map();
        private var _volume:Number = 1;

        public function FurniSamplePlaybackManager(_arg_1:HabboSoundManagerFlash10, _arg_2:IEventDispatcher)
        {
            _soundManager = _arg_1;
            _roomEvents = _arg_2;
            _roomEvents.addEventListener("REOSPE_ROOM_OBJECT_INITIALIZED", onRoomObjectInitializedEvent);
            _roomEvents.addEventListener("REOSPE_ROOM_OBJECT_DISPOSED", onRoomObjectDisposedEvent);
            _roomEvents.addEventListener("REOSPE_PLAY_SAMPLE", onRoomObjectPlaySampleEvent);
            _roomEvents.addEventListener("REOSPE_CHANGE_PITCH", onRoomObjectChangeSamplePitchEvent);
        }

        public function dispose():void
        {
            if (!_disposed)
            {
                if (_roomEvents)
                {
                    _roomEvents.removeEventListener("REOSPE_ROOM_OBJECT_INITIALIZED", onRoomObjectInitializedEvent);
                    _roomEvents.removeEventListener("REOSPE_ROOM_OBJECT_DISPOSED", onRoomObjectDisposedEvent);
                    _roomEvents.removeEventListener("REOSPE_PLAY_SAMPLE", onRoomObjectPlaySampleEvent);
                    _roomEvents.removeEventListener("REOSPE_CHANGE_PITCH", onRoomObjectChangeSamplePitchEvent);
                    _roomEvents = null;
                };
                if (_SafeStr_3720)
                {
                    _SafeStr_3720.dispose();
                    _SafeStr_3720 = null;
                };
                if (_SafeStr_3721)
                {
                    _SafeStr_3721.dispose();
                    _SafeStr_3721 = null;
                };
                if (_SafeStr_3722)
                {
                    _SafeStr_3722.dispose();
                    _SafeStr_3722 = null;
                };
                _soundManager = null;
            };
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function updateVolume(_arg_1:Number):void
        {
            _volume = _arg_1;
            for each (var _local_2:HabboSoundWithPitch in _SafeStr_3720.getValues())
            {
                _local_2.volume = _volume;
            };
        }

        private function onRoomObjectInitializedEvent(_arg_1:RoomEngineObjectSamplePlaybackEvent):void
        {
            if (_arg_1.sampleId != -1)
            {
                addSampleForFurni(_arg_1.objectId, _arg_1.sampleId);
                if (_SafeStr_3722.hasKey(_arg_1.objectId))
                {
                    _SafeStr_3722.remove(_arg_1.objectId);
                };
                _SafeStr_3722.add(_arg_1.objectId, _arg_1.pitch);
            };
        }

        private function onRoomObjectDisposedEvent(_arg_1:RoomEngineObjectSamplePlaybackEvent):void
        {
            removeSampleForFurni(_arg_1.objectId);
        }

        private function onRoomObjectPlaySampleEvent(_arg_1:RoomEngineObjectSamplePlaybackEvent):void
        {
            if (_SafeStr_3720.getValue(_arg_1.objectId) != null)
            {
                playSample(_arg_1.objectId);
            };
        }

        private function onRoomObjectChangeSamplePitchEvent(_arg_1:RoomEngineObjectSamplePlaybackEvent):void
        {
            if (_SafeStr_3720.getValue(_arg_1.objectId) != null)
            {
                changeSamplePitch(_arg_1.objectId, _arg_1.pitch);
            };
        }

        private function addSampleForFurni(_arg_1:int, _arg_2:int):void
        {
            if (((_SafeStr_3720.getValue(_arg_1) == null) && (_SafeStr_3721.getValues().indexOf(_arg_2) == -1)))
            {
                loadSample(_arg_2, _arg_1);
            };
        }

        private function removeSampleForFurni(_arg_1:int):void
        {
            var _local_2:HabboSoundWithPitch = _SafeStr_3720.getValue(_arg_1);
            if (_local_2 != null)
            {
                _soundManager.removeUpdateReceiver(_local_2);
                _local_2.dispose();
                _SafeStr_3720.remove(_arg_1);
            };
        }

        private function playSample(_arg_1:int):void
        {
            var _local_2:HabboSoundWithPitch = _SafeStr_3720.getValue(_arg_1);
            if (_local_2 != null)
            {
                _local_2.stop();
                _local_2.play();
            };
        }

        private function changeSamplePitch(_arg_1:int, _arg_2:Number):void
        {
            var _local_3:HabboSoundWithPitch = _SafeStr_3720.getValue(_arg_1);
            if (_local_3 != null)
            {
                _local_3.setPitch(_arg_2);
            };
        }

        private function loadSample(_arg_1:int, _arg_2:int):void
        {
            var _local_5:String = _soundManager.getProperty("flash.dynamic.download.url");
            _local_5 = (_local_5 + _soundManager.getProperty("flash.dynamic.download.samples.template"));
            _local_5 = _local_5.replace(/%typeid%/, _arg_1.toString());
            var _local_3:URLRequest = new URLRequest(_local_5);
            var _local_4:Sound = new Sound();
            _local_4.addEventListener("complete", onSampleLoadComplete);
            _local_4.addEventListener("ioError", ioErrorHandler);
            _local_4.load(_local_3);
            _SafeStr_3721.add(_local_4, _arg_2);
        }

        private function onSampleLoadComplete(_arg_1:Event):void
        {
            if (disposed)
            {
                return;
            };
            var _local_4:Sound = (_arg_1.target as Sound);
            if (((_local_4 == null) || (_SafeStr_3721.getValue(_local_4) == null)))
            {
                return;
            };
            var _local_3:int = _SafeStr_3721.getValue(_local_4);
            var _local_2:HabboSoundWithPitch = new HabboSoundWithPitch(_local_4, _SafeStr_3722.getValue(_local_3));
            _soundManager.registerUpdateReceiver(_local_2, 0);
            _local_2.volume = _volume;
            _SafeStr_3720.add(_local_3, _local_2);
            _SafeStr_3721.remove(_local_4);
        }

        private function ioErrorHandler(_arg_1:IOErrorEvent):void
        {
            Logger.log(((("Error loading sound " + _arg_1.target) + " text ") + _arg_1.text));
        }


    }
}

