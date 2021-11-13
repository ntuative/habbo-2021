package com.sulake.core.runtime
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import flash.utils.getQualifiedClassName;

    internal final class InterfaceStruct implements IDisposable 
    {

        private var _iid:IID;
        private var _iis:String;
        private var _unknown:IUnknown;
        private var _references:uint;

        public function InterfaceStruct(_arg_1:IID, _arg_2:IUnknown)
        {
            _iid = _arg_1;
            _iis = getQualifiedClassName(_iid);
            _unknown = _arg_2;
            _references = 0;
        }

        public function get iid():IID
        {
            return (_iid);
        }

        public function get iis():String
        {
            return (_iis);
        }

        public function get unknown():IUnknown
        {
            return (_unknown);
        }

        public function get references():uint
        {
            return (_references);
        }

        public function get disposed():Boolean
        {
            return (_unknown == null);
        }

        public function dispose():void
        {
            _iid = null;
            _iis = null;
            _unknown = null;
            _references = 0;
        }

        public function reserve():uint
        {
            return (++_references);
        }

        public function release():uint
        {
            return ((references > 0) ? --_references : 0);
        }


    }
}