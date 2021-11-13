package com.sulake.core.window.iterators
{
    import flash.utils.Proxy;
    import com.sulake.core.window.utils.IIterator;
    import com.sulake.core.window.components.DropListController;
    import com.sulake.core.window.IWindow;
    import flash.utils.flash_proxy; 

    use namespace flash.utils.flash_proxy;

    public class DropListIterator extends Proxy implements IIterator 
    {

        private var _SafeStr_1135:DropListController;

        public function DropListIterator(_arg_1:DropListController)
        {
            _SafeStr_1135 = _arg_1;
        }

        public function get length():uint
        {
            return (_SafeStr_1135.numMenuItems);
        }

        public function indexOf(_arg_1:*):int
        {
            return (_SafeStr_1135.getMenuItemIndex(_arg_1));
        }

        override flash_proxy function getProperty(_arg_1:*):*
        {
            return (_SafeStr_1135.getMenuItemAt(uint(_arg_1)));
        }

        override flash_proxy function setProperty(_arg_1:*, _arg_2:*):void
        {
            var _local_3:IWindow;
            _local_3 = (_arg_2 as IWindow);
            var _local_4:int = _SafeStr_1135.getMenuItemIndex(_local_3);
            if (_local_4 == _arg_1)
            {
                return;
            };
            if (_local_4 > -1)
            {
                _SafeStr_1135.removeMenuItem(_local_3);
            };
            _SafeStr_1135.addMenuItemAt(_local_3, _arg_1);
        }

        override flash_proxy function nextNameIndex(_arg_1:int):int
        {
            return ((_arg_1 < _SafeStr_1135.numMenuItems) ? (_arg_1 + 1) : 0);
        }

        override flash_proxy function nextValue(_arg_1:int):*
        {
            return (_SafeStr_1135.getMenuItemAt((_arg_1 - 1)));
        }


    }
}

