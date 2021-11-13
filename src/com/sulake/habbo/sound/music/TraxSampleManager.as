package com.sulake.habbo.sound.music
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.sound.HabboSoundManagerFlash10;
    import com.sulake.core.utils.Map;
    import flash.utils.ByteArray;
    import flash.net.URLRequest;
    import flash.media.Sound;
    import flash.events.Event;
    import com.sulake.habbo.sound.events.TraxSongLoadEvent;
    import com.sulake.habbo.sound.trax.TraxSample;
    import flash.utils.getTimer;

    public class TraxSampleManager implements IDisposable 
    {

        private static const SAMPLE_PROCESS_LIMIT_MS:int = 60;
        private static const SAMPLE_LENGTH_MEMORY_LIMIT:int = 25165823;
        private static const SAMPLE_LENGTH_PURGE_TO:int = 0xFFFFFF;

        private var _soundManager:HabboSoundManagerFlash10;
        private var _SafeStr_3721:Map = new Map();
        private var _SafeStr_3720:Array = [];
        private var _traxSamples:Map = new Map();
        private var _SafeStr_3738:ByteArray = new ByteArray();
        private var _loadErrorCallback:Function;
        private var _SafeStr_3739:Boolean = false;
        private var _disposed:Boolean = false;

        public function TraxSampleManager(_arg_1:HabboSoundManagerFlash10, _arg_2:Function)
        {
            _loadErrorCallback = _arg_2;
            _soundManager = _arg_1;
            if (_soundManager.getBoolean("trax.player.sample.memory.purge.enabled"))
            {
                _SafeStr_3739 = true;
            };
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function dispose():void
        {
            if (!_disposed)
            {
                _SafeStr_3738 = null;
                _SafeStr_3720 = null;
                if (_traxSamples != null)
                {
                    _traxSamples.dispose();
                    _traxSamples = null;
                };
                if (_SafeStr_3721 != null)
                {
                    _SafeStr_3721.dispose();
                    _SafeStr_3721 = null;
                };
                _soundManager = null;
                _disposed = true;
            };
        }

        public function get traxSamples():Map
        {
            return (_traxSamples);
        }

        public function loadSample(_arg_1:int):void
        {
            var _local_4:String = _soundManager.getProperty("flash.dynamic.download.url");
            _local_4 = (_local_4 + _soundManager.getProperty("flash.dynamic.download.samples.template"));
            _local_4 = _local_4.replace(/%typeid%/, _arg_1.toString());
            var _local_2:URLRequest = new URLRequest(_local_4);
            var _local_3:Sound = new Sound();
            _local_3.addEventListener("complete", onSampleLoadComplete);
            _local_3.addEventListener("ioError", ioErrorHandler);
            _local_3.load(_local_2);
            _SafeStr_3721.add(_local_3, _arg_1);
        }

        public function update(_arg_1:uint):void
        {
            processLoadedSamples();
        }

        private function onSampleLoadComplete(_arg_1:Event):void
        {
            var _local_2:Sound = (_arg_1.target as Sound);
            _SafeStr_3720.push(_local_2);
        }

        private function ioErrorHandler(_arg_1:Event):void
        {
            _soundManager.events.dispatchEvent(new TraxSongLoadEvent("TSLE_TRAX_LOAD_FAILED", _soundManager.loadingSongId));
            _loadErrorCallback.call();
        }

        private function processLoadedSample(_arg_1:Sound):void
        {
            var _local_3:int;
            var _local_4:Number;
            var _local_2:TraxSample;
            if (_SafeStr_3721.getValue(_arg_1) != null)
            {
                _local_3 = _SafeStr_3721.remove(_arg_1);
                if (_traxSamples.getValue(_local_3) == null)
                {
                    _SafeStr_3738.clear();
                    _local_4 = _arg_1.length;
                    _arg_1.extract(_SafeStr_3738, (_local_4 * 44.1));
                    _local_2 = new TraxSample(_SafeStr_3738, _local_3, "sample_44khz", "sample_16bit");
                    _traxSamples.add(_local_3, _local_2);
                };
            };
        }

        private function processLoadedSamples():void
        {
            var _local_3:int;
            var _local_1:int;
            var _local_2:Sound;
            if (_SafeStr_3720.length > 0)
            {
                _local_3 = getTimer();
                _local_1 = _local_3;
                while ((((_local_1 - _local_3) < 60) && (_SafeStr_3720.length > 0)))
                {
                    _local_2 = _SafeStr_3720.splice(0, 1)[0];
                    processLoadedSample(_local_2);
                    _local_1 = getTimer();
                };
                if (((_SafeStr_3721.length == 0) && (!(_soundManager.loadingSongId == -1))))
                {
                    _soundManager.events.dispatchEvent(new TraxSongLoadEvent("TSLE_TRAX_LOAD_COMPLETE", _soundManager.loadingSongId));
                    if (_SafeStr_3739)
                    {
                        processSampleMemoryUsage();
                    };
                };
            };
        }

        private function logSampleUsage():void
        {
        }

        private function processSampleMemoryUsage():void
        {
            var _local_8:int;
            var _local_4:int;
            var _local_5:TraxSample;
            var _local_3:Array;
            var _local_6:uint;
            var _local_9:int;
            var _local_12:TraxSample;
            var _local_2:TraxSample;
            var _local_10:uint;
            var _local_7:Array = [];
            var _local_1:Array = _soundManager.musicController.samplesIdsInUse;
            _local_8 = 0;
            while (_local_8 < _traxSamples.length)
            {
                _local_4 = _traxSamples.getKey(_local_8);
                _local_5 = _traxSamples.getWithIndex(_local_8);
                if (((!(_local_5.usageCount == 0)) && (_local_1.indexOf(_local_4) == -1)))
                {
                    _local_7.push(_local_5);
                };
                _local_10 = (_local_10 + _local_5.length);
                _local_8++;
            };
            if (_local_10 > 25165823)
            {
                _local_3 = [];
                Logger.log("Sample memory limit reached, clearing the oldest and least frequently used samples");
                _local_7.sort(orderUsageAndTimeStamp);
                _local_6 = 0;
                _local_9 = 0;
                while (((_local_6 < (_local_10 - 0xFFFFFF)) && (_local_9 < _local_7.length)))
                {
                    _local_12 = _local_7[_local_9++];
                    _local_6 = (_local_6 + _local_12.length);
                    _local_3.push(_local_12.id);
                };
                _local_7 = null;
                if (_local_3.length > 0)
                {
                    for each (var _local_11:int in _local_3)
                    {
                        Logger.log(("Purging sample : " + _local_11));
                        _local_2 = (_traxSamples.getValue(_local_11) as TraxSample);
                        _local_2.dispose();
                        _traxSamples.remove(_local_11);
                    };
                    _soundManager.musicController.samplesUnloaded(_local_3);
                };
            };
        }

        private function orderUsageAndTimeStamp(_arg_1:TraxSample, _arg_2:TraxSample):int
        {
            if (_arg_1.usageCount < _arg_2.usageCount)
            {
                return (-1);
            };
            if (_arg_1.usageCount > _arg_2.usageCount)
            {
                return (1);
            };
            if (_arg_1.usageTimeStamp < _arg_2.usageTimeStamp)
            {
                return (-1);
            };
            if (_arg_1.usageTimeStamp > _arg_2.usageTimeStamp)
            {
                return (1);
            };
            return (0);
        }


    }
}

