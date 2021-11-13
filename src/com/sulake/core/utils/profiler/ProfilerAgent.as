package com.sulake.core.utils.profiler
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.runtime.IUpdateReceiver;
    import flash.utils.getQualifiedClassName;

    public class ProfilerAgent extends ProfilerAgentTask implements IDisposable 
    {

        protected var _receiver:IUpdateReceiver;

        public function ProfilerAgent(_arg_1:IUpdateReceiver)
        {
            _receiver = _arg_1;
            var _local_2:String = getQualifiedClassName(_receiver);
            super(_local_2.slice((_local_2.lastIndexOf(":") + 1), _local_2.length));
        }

        public function get receiver():IUpdateReceiver
        {
            return (_receiver);
        }

        override public function dispose():void
        {
            _receiver = null;
            super.dispose();
        }

        public function update(_arg_1:int):void
        {
            if (!paused)
            {
                super.start();
                _receiver.update(_arg_1);
                super.stop();
            };
        }


    }
}