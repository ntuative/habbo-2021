package com.sulake.core.runtime
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.runtime.IID;
    import __AS3__.vec.Vector;

        internal class ComponentInterfaceQueue implements IDisposable 
    {

        private var _identifier:IID;
        private var _disposed:Boolean;
        private var _receivers:Vector.<Function>;

        public function ComponentInterfaceQueue(_arg_1:IID)
        {
            _identifier = _arg_1;
            _receivers = new Vector.<Function>();
            _disposed = false;
        }

        public function get identifier():IID
        {
            return (_identifier);
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get receivers():Vector.<Function>
        {
            return (_receivers);
        }

        public function dispose():void
        {
            if (!_disposed)
            {
                _disposed = true;
                _identifier = null;
                while (_receivers.length > 0)
                {
                    _receivers.pop();
                };
                _receivers = null;
            };
        }


    }
}