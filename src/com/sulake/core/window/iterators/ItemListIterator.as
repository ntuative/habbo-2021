package com.sulake.core.window.iterators
{
    import flash.utils.Proxy;
    import com.sulake.core.window.utils.IIterator;
    import com.sulake.core.window.components.ItemListController;
    import com.sulake.core.window.IWindow;
    import flash.utils.flash_proxy; 

    use namespace flash.utils.flash_proxy;

    public class ItemListIterator extends Proxy implements IIterator 
    {

        private var _SafeStr_1135:ItemListController;

        public function ItemListIterator(_arg_1:ItemListController)
        {
            _SafeStr_1135 = _arg_1;
        }

        public function get length():uint
        {
            return (_SafeStr_1135.numListItems);
        }

        public function indexOf(_arg_1:*):int
        {
            return (_SafeStr_1135.getListItemIndex(_arg_1));
        }

        override flash_proxy function getProperty(_arg_1:*):*
        {
            return (_SafeStr_1135.getListItemAt(uint(_arg_1)));
        }

        override flash_proxy function setProperty(_arg_1:*, _arg_2:*):void
        {
            var _local_3:IWindow;
            _local_3 = (_arg_2 as IWindow);
            var _local_4:int = _SafeStr_1135.getListItemIndex(_local_3);
            if (_local_4 == _arg_1)
            {
                return;
            };
            if (_local_4 > -1)
            {
                _SafeStr_1135.removeListItem(_local_3);
            };
            _SafeStr_1135.addListItemAt(_local_3, _arg_1);
        }

        override flash_proxy function nextNameIndex(_arg_1:int):int
        {
            return ((_arg_1 < _SafeStr_1135.numListItems) ? (_arg_1 + 1) : 0);
        }

        override flash_proxy function nextValue(_arg_1:int):*
        {
            return (_SafeStr_1135.getListItemAt((_arg_1 - 1)));
        }


    }
}

