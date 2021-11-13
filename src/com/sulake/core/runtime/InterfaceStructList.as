package com.sulake.core.runtime
{
    import com.sulake.core.runtime.IDisposable;
    import flash.utils.getQualifiedClassName;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.core.runtime.*;

    internal final class InterfaceStructList implements IDisposable 
    {

        private var _SafeStr_853:Array = [];


        public function get length():uint
        {
            return (_SafeStr_853.length);
        }

        public function get disposed():Boolean
        {
            return (_SafeStr_853 == null);
        }

        public function dispose():void
        {
            var _local_1:InterfaceStruct;
            var _local_3:uint;
            var _local_2:uint = _SafeStr_853.length;
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _local_1 = _SafeStr_853.pop();
                _local_1.dispose();
                _local_3++;
            };
            _SafeStr_853 = null;
        }

        public function insert(_arg_1:InterfaceStruct):uint
        {
            _SafeStr_853.push(_arg_1);
            return (_SafeStr_853.length);
        }

        public function remove(_arg_1:uint):InterfaceStruct
        {
            var _local_2:InterfaceStruct;
            if (_arg_1 < _SafeStr_853.length)
            {
                _local_2 = _SafeStr_853[_arg_1];
                _SafeStr_853.splice(_arg_1, 1);
                return (_local_2);
            };
            throw (new Error("Index out of range!"));
        }

        public function find(_arg_1:IID):IUnknown
        {
            var _local_2:InterfaceStruct;
            var _local_5:uint;
            var _local_3:String = getQualifiedClassName(_arg_1);
            var _local_4:uint = _SafeStr_853.length;
            _local_5 = 0;
            while (_local_5 < _local_4)
            {
                _local_2 = (_SafeStr_853[_local_5] as InterfaceStruct);
                if (_local_2.iis == _local_3)
                {
                    return (_local_2.unknown);
                };
                _local_5++;
            };
            return (null);
        }

        public function getStructByInterface(_arg_1:IID):InterfaceStruct
        {
            var _local_2:InterfaceStruct;
            var _local_5:uint;
            var _local_3:String = getQualifiedClassName(_arg_1);
            var _local_4:uint = _SafeStr_853.length;
            _local_5 = 0;
            while (_local_5 < _local_4)
            {
                _local_2 = (_SafeStr_853[_local_5] as InterfaceStruct);
                if (_local_2.iis == _local_3)
                {
                    return (_local_2);
                };
                _local_5++;
            };
            return (null);
        }

        public function getIndexByInterface(_arg_1:IID):int
        {
            var _local_2:InterfaceStruct;
            var _local_5:int;
            var _local_3:String = getQualifiedClassName(_arg_1);
            var _local_4:uint = _SafeStr_853.length;
            _local_5 = 0;
            while (_local_5 < _local_4)
            {
                _local_2 = (_SafeStr_853[_local_5] as InterfaceStruct);
                if (_local_2.iis == _local_3)
                {
                    return (_local_5);
                };
                _local_5++;
            };
            return (-1);
        }

        public function mapStructsByInterface(_arg_1:IID, _arg_2:Array):uint
        {
            var _local_3:InterfaceStruct;
            var _local_7:uint;
            var _local_4:String = getQualifiedClassName(_arg_1);
            var _local_5:uint;
            var _local_6:uint = _SafeStr_853.length;
            _local_7 = 0;
            while (_local_7 < _local_6)
            {
                _local_3 = (_SafeStr_853[_local_7] as InterfaceStruct);
                if (_local_3.iis == _local_4)
                {
                    _arg_2.push(_local_3);
                    _local_5++;
                };
                _local_7++;
            };
            return (_local_5);
        }

        public function getStructByImplementor(_arg_1:IUnknown):InterfaceStruct
        {
            var _local_2:InterfaceStruct;
            var _local_4:uint;
            var _local_3:uint = _SafeStr_853.length;
            _local_4 = 0;
            while (_local_4 < _local_3)
            {
                _local_2 = (_SafeStr_853[_local_4] as InterfaceStruct);
                if (_local_2.unknown == _arg_1)
                {
                    return (_local_2);
                };
                _local_4++;
            };
            return (null);
        }

        public function getIndexByImplementor(_arg_1:IUnknown):int
        {
            var _local_2:InterfaceStruct;
            var _local_4:uint;
            var _local_3:uint = _SafeStr_853.length;
            _local_4 = 0;
            while (_local_4 < _local_3)
            {
                _local_2 = (_SafeStr_853[_local_4] as InterfaceStruct);
                if (_local_2.unknown == _arg_1)
                {
                    return (_local_4);
                };
                _local_4++;
            };
            return (-1);
        }

        public function mapStructsByImplementor(_arg_1:IUnknown, _arg_2:Array):uint
        {
            var _local_3:InterfaceStruct;
            var _local_6:uint;
            var _local_5:uint;
            var _local_4:uint = _SafeStr_853.length;
            _local_6 = 0;
            while (_local_6 < _local_4)
            {
                _local_3 = (_SafeStr_853[_local_6] as InterfaceStruct);
                if (_local_3.unknown == _arg_1)
                {
                    _arg_2.push(_local_3);
                    _local_5++;
                };
                _local_6++;
            };
            return (_local_5);
        }

        public function getStructByIndex(_arg_1:uint):InterfaceStruct
        {
            return ((_arg_1 < _SafeStr_853.length) ? _SafeStr_853[_arg_1] : null);
        }

        public function getTotalReferenceCount():uint
        {
            var _local_1:InterfaceStruct;
            var _local_4:uint;
            var _local_3:uint;
            var _local_2:uint = _SafeStr_853.length;
            _local_4 = 0;
            while (_local_4 < _local_2)
            {
                _local_1 = (_SafeStr_853[_local_4] as InterfaceStruct);
                _local_3 = (_local_3 + _local_1.references);
                _local_4++;
            };
            return (_local_3);
        }


    }
}

