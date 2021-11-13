package com.sulake.core.window.iterators
{
    import flash.utils.Proxy;
    import com.sulake.core.window.utils.IIterator;
    import com.sulake.core.window.WindowController;
    import com.sulake.core.window.IWindow;
    import flash.utils.flash_proxy; 

    use namespace flash.utils.flash_proxy;

    public class ContainerIterator extends Proxy implements IIterator 
    {

        private var _SafeStr_1135:WindowController;

        public function ContainerIterator(_arg_1:WindowController)
        {
            _SafeStr_1135 = _arg_1;
        }

        public function get length():uint
        {
            return (_SafeStr_1135.numChildren);
        }

        public function indexOf(_arg_1:*):int
        {
            return (_SafeStr_1135.getChildIndex(_arg_1));
        }

        override flash_proxy function getProperty(_arg_1:*):*
        {
            return (_SafeStr_1135.getChildAt(uint(_arg_1)));
        }

        override flash_proxy function setProperty(_arg_1:*, _arg_2:*):void
        {
            var _local_3:IWindow;
            _local_3 = (_arg_2 as IWindow);
            var _local_4:int = _SafeStr_1135.getChildIndex(_local_3);
            if (_local_4 == _arg_1)
            {
                return;
            };
            if (_local_4 > -1)
            {
                _SafeStr_1135.removeChild(_local_3);
            };
            _SafeStr_1135.addChildAt(_local_3, _arg_1);
        }

        override flash_proxy function nextNameIndex(_arg_1:int):int
        {
            return ((_arg_1 < _SafeStr_1135.numChildren) ? (_arg_1 + 1) : 0);
        }

        override flash_proxy function nextValue(_arg_1:int):*
        {
            return (_SafeStr_1135.getChildAt((_arg_1 - 1)));
        }


    }
}

