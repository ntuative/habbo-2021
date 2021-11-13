package com.sulake.core.utils
{
    import flash.utils.Proxy;
    import com.sulake.core.runtime.IDisposable;
    import flash.utils.Dictionary;
    import flash.utils.flash_proxy; 

    use namespace flash.utils.flash_proxy;

        public class Map extends Proxy implements IDisposable 
    {

        private var _length:uint;
        private var _SafeStr_747:Dictionary;
        private var _SafeStr_875:Array;
        private var _SafeStr_876:Array;

        public function Map()
        {
            _length = 0;
            _SafeStr_747 = new Dictionary();
            _SafeStr_875 = [];
            _SafeStr_876 = [];
        }

        public function get length():uint
        {
            return (_length);
        }

        public function get disposed():Boolean
        {
            return (_SafeStr_747 == null);
        }

        public function dispose():void
        {
            var _local_1:Object;
            if (_SafeStr_747 != null)
            {
                for (_local_1 in _SafeStr_747)
                {
                    delete _SafeStr_747[_local_1];
                };
                _SafeStr_747 = null;
            };
            _length = 0;
            _SafeStr_875 = null;
            _SafeStr_876 = null;
        }

        public function reset():void
        {
            var _local_1:Object;
            for (_local_1 in _SafeStr_747)
            {
                delete _SafeStr_747[_local_1];
            };
            _length = 0;
            _SafeStr_875 = [];
            _SafeStr_876 = [];
        }

        public function unshift(_arg_1:*, _arg_2:*):Boolean
        {
            if (_SafeStr_747[_arg_1] != null)
            {
                return (false);
            };
            _SafeStr_747[_arg_1] = _arg_2;
            _SafeStr_875.unshift(_arg_2);
            _SafeStr_876.unshift(_arg_1);
            _length++;
            return (true);
        }

        public function add(_arg_1:*, _arg_2:*):Boolean
        {
            if (_SafeStr_747[_arg_1] != null)
            {
                return (false);
            };
            _SafeStr_747[_arg_1] = _arg_2;
            _SafeStr_875[_length] = _arg_2;
            _SafeStr_876[_length] = _arg_1;
            _length++;
            return (true);
        }

        public function remove(_arg_1:*):*
        {
            var _local_2:Object = _SafeStr_747[_arg_1];
            if (_local_2 == null)
            {
                return (null);
            };
            var _local_3:int = _SafeStr_875.indexOf(_local_2);
            if (_local_3 >= 0)
            {
                _SafeStr_875.splice(_local_3, 1);
                _SafeStr_876.splice(_local_3, 1);
                _length--;
            };
            delete _SafeStr_747[_arg_1];
            return (_local_2);
        }

        public function getWithIndex(_arg_1:int):*
        {
            if (((_arg_1 < 0) || (_arg_1 >= _length)))
            {
                return (null);
            };
            return (_SafeStr_875[_arg_1]);
        }

        public function getKey(_arg_1:int):*
        {
            if (((_arg_1 < 0) || (_arg_1 >= _length)))
            {
                return (null);
            };
            return (_SafeStr_876[_arg_1]);
        }

        public function getKeys():Array
        {
            return (_SafeStr_876.slice());
        }

        public function hasKey(_arg_1:*):Boolean
        {
            return (_SafeStr_876.indexOf(_arg_1) > -1);
        }

        public function getValue(_arg_1:*):*
        {
            return (_SafeStr_747[_arg_1]);
        }

        public function getValues():Array
        {
            return (_SafeStr_875.slice());
        }

        public function hasValue(_arg_1:*):Boolean
        {
            return (_SafeStr_875.indexOf(_arg_1) > -1);
        }

        public function indexOf(_arg_1:*):int
        {
            return (_SafeStr_875.indexOf(_arg_1));
        }

        public function concatenate(_arg_1:Map):void
        {
            var _local_3:*;
            var _local_2:Array = _arg_1._SafeStr_876;
            for each (_local_3 in _local_2)
            {
                add(_local_3, _arg_1[_local_3]);
            };
        }

        public function clone():Map
        {
            var _local_1:Map = new Map();
            _local_1.concatenate(this);
            return (_local_1);
        }

        override flash_proxy function getProperty(_arg_1:*):*
        {
            if ((_arg_1 is QName))
            {
                _arg_1 = QName(_arg_1).localName;
            };
            return (_SafeStr_747[_arg_1]);
        }

        override flash_proxy function setProperty(_arg_1:*, _arg_2:*):void
        {
            if ((_arg_1 is QName))
            {
                _arg_1 = QName(_arg_1).localName;
            };
            _SafeStr_747[_arg_1] = _arg_2;
            var _local_3:int = _SafeStr_876.indexOf(_arg_1);
            if (_local_3 == -1)
            {
                _SafeStr_875[_length] = _arg_2;
                _SafeStr_876[_length] = _arg_1;
                _length++;
            }
            else
            {
                _SafeStr_875.splice(_local_3, 1, _arg_2);
            };
        }

        override flash_proxy function nextNameIndex(_arg_1:int):int
        {
            return ((_arg_1 < _length) ? (_arg_1 + 1) : 0);
        }

        override flash_proxy function nextName(_arg_1:int):String
        {
            return (_SafeStr_876[(_arg_1 - 1)]);
        }

        override flash_proxy function nextValue(_arg_1:int):*
        {
            return (_SafeStr_875[(_arg_1 - 1)]);
        }

        override flash_proxy function callProperty(_arg_1:*, ... _args):*
        {
            return ((_arg_1.localName == "toString") ? "Map" : null);
        }


    }
}

