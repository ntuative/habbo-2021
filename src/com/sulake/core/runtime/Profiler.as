package com.sulake.core.runtime
{
    import com.sulake.core.runtime.Component;
    import com.sulake.core.runtime.IProfiler;
    import flash.utils.Dictionary;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.AssetLibrary;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.utils.profiler.tracking.TrackedBitmapData;
    import com.sulake.core.runtime.IDisposable;
    import flash.system.System;
    import flash.events.Event;
    import flash.utils.getTimer;
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.core.utils.profiler.ProfilerAgent;
    import com.sulake.core.runtime.*;

    internal class Profiler extends Component implements IProfiler 
    {

        public static const PROFILER_START:String = "PROFILER_START";
        public static const PROFILER_STOP:String = "PROFILER_STOP";

        private var _SafeStr_854:Dictionary = new Dictionary(true);
        private var _startTime:int;
        private var _roundTime:int;

        public function Profiler(_arg_1:IContext)
        {
            super(_arg_1, 0, null);
        }

        public function get numAssetLibraryInstances():uint
        {
            return (AssetLibrary.numAssetLibraryInstances);
        }

        public function get numBitmapAssetInstances():uint
        {
            return (BitmapDataAsset.instances);
        }

        public function get numAllocatedBitmapDataBytes():uint
        {
            return (BitmapDataAsset.allocatedByteCount);
        }

        public function get numTrackedBitmapDataInstances():uint
        {
            return (TrackedBitmapData.numInstances);
        }

        public function get numTrackedBitmapDataBytes():uint
        {
            return (TrackedBitmapData.allocatedByteCount);
        }

        override public function dispose():void
        {
            var _local_1:Object;
            if (!disposed)
            {
                for (_local_1 in _SafeStr_854)
                {
                    IDisposable(_SafeStr_854[_local_1]).dispose();
                    delete _SafeStr_854[_local_1];
                };
                super.dispose();
            };
        }

        public function gc():void
        {
            System.pauseForGCIfCollectionImminent(0.25);
        }

        public function start():void
        {
            events.dispatchEvent(new Event("PROFILER_START", false, false));
            _startTime = getTimer();
        }

        public function stop():void
        {
            _roundTime = (getTimer() - _startTime);
            events.dispatchEvent(new Event("PROFILER_STOP", false, false));
        }

        public function update(_arg_1:IUpdateReceiver, _arg_2:uint):void
        {
            getProfilerAgentForReceiver(_arg_1).update(_arg_2);
        }

        public function get numProfilerAgents():uint
        {
            var _local_1:uint;
            for (var _local_2:Object in _SafeStr_854)
            {
                if (!IDisposable(_local_2).disposed)
                {
                    _local_1++;
                };
            };
            return (_local_1);
        }

        public function getProfilerAgentsInArray():Array
        {
            var _local_2:IUpdateReceiver;
            var _local_1:Array = [];
            for (var _local_3:Object in _SafeStr_854)
            {
                _local_2 = (_local_3 as IUpdateReceiver);
                if (IDisposable(_local_3).disposed)
                {
                    IDisposable(_SafeStr_854[_local_3]).dispose();
                    delete _SafeStr_854[_local_3];
                }
                else
                {
                    _local_1.push(_SafeStr_854[_local_3]);
                };
            };
            return (_local_1);
        }

        public function getProfilerAgentForReceiver(_arg_1:IUpdateReceiver):ProfilerAgent
        {
            var _local_2:ProfilerAgent = _SafeStr_854[_arg_1];
            return ((_local_2 != null) ? _local_2 : addProfilerAgentForReceiver(_arg_1));
        }

        public function addProfilerAgentForReceiver(_arg_1:IUpdateReceiver):ProfilerAgent
        {
            if (_SafeStr_854[_arg_1] != null)
            {
                throw (new Error("Profiler for receiver already exists!"));
            };
            var _local_2:ProfilerAgent = new ProfilerAgent(_arg_1);
            _SafeStr_854[_arg_1] = _local_2;
            return (_local_2);
        }

        public function addStartEventListener(_arg_1:Function):void
        {
            events.addEventListener("PROFILER_START", _arg_1);
        }

        public function addStopEventListener(_arg_1:Function):void
        {
            events.addEventListener("PROFILER_STOP", _arg_1);
        }

        public function removeStartEventListener(_arg_1:Function):void
        {
            events.removeEventListener("PROFILER_START", _arg_1);
        }

        public function removeStopEventListener(_arg_1:Function):void
        {
            events.removeEventListener("PROFILER_STOP", _arg_1);
        }


    }
}

