package com.sulake.core.window.components
{
    import com.sulake.core.window.utils.IIterable;
    import com.sulake.core.window.utils.tablet.ITouchAwareWindow;
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.iterators.DropListIterator;
    import com.sulake.core.window.utils.IIterator;

    public class DropListController extends DropBaseController implements IDropListWindow, IIterable, ITouchAwareWindow 
    {

        public function DropListController(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:WindowContext, _arg_6:Rectangle, _arg_7:IWindow, _arg_8:Function, _arg_9:Array=null, _arg_10:Array=null, _arg_11:uint=0)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11);
        }

        public function get iterator():IIterator
        {
            return (new DropListIterator(this));
        }

        public function addMenuItem(_arg_1:IWindow):IWindow
        {
            return (addMenuItemAt(_arg_1, _itemArray.length));
        }

        public function addMenuItemAt(_arg_1:IWindow, _arg_2:int):IWindow
        {
            if (((_arg_1) && (_itemArray.indexOf(_arg_1) == -1)))
            {
                if (!getTitleLabel())
                {
                    if ((_arg_1 is ILabelWindow))
                    {
                        if (_arg_1.name == "_DROPLIST_TITLETEXT")
                        {
                            return (addChild(_arg_1));
                        };
                    };
                };
                if (!getItemList())
                {
                    if ((_arg_1 is IItemListWindow))
                    {
                        if (_arg_1.name == "_DROPLIST_ITEMLIST")
                        {
                            return (addChild(_arg_1));
                        };
                    };
                };
                if (!getRegion())
                {
                    if ((_arg_1 is IRegionWindow))
                    {
                        if (_arg_1.name == "_DROPLIST_REGION")
                        {
                            return (addChild(_arg_1));
                        };
                    };
                };
                if (_menuIsOpen)
                {
                    closeExpandedMenuView();
                    _itemArray.push(_arg_1);
                    openExpandedMenuView();
                }
                else
                {
                    _itemArray.push(_arg_1);
                };
                return (_arg_1);
            };
            return (null);
        }

        public function getMenuItemAt(_arg_1:int):IWindow
        {
            return ((((!(_itemArray == null)) && (_arg_1 > -1)) && (_arg_1 < _itemArray.length)) ? _itemArray[_arg_1] : null);
        }

        public function removeMenuItem(_arg_1:IWindow):IWindow
        {
            var _local_2:int = _itemArray.indexOf(_arg_1);
            if (_local_2 > -1)
            {
                if (_local_2 == _SafeStr_903)
                {
                    _SafeStr_903 = -1;
                };
                _itemArray.splice(_local_2, 1);
                if (_menuIsOpen)
                {
                    closeExpandedMenuView();
                    openExpandedMenuView();
                };
                return (_arg_1);
            };
            return (null);
        }

        public function removeMenuItemAt(_arg_1:int):IWindow
        {
            var _local_2:IWindow = _itemArray[_arg_1];
            return ((_local_2) ? removeMenuItem(_local_2) : null);
        }

        public function getMenuItemIndex(_arg_1:IWindow):int
        {
            return (_itemArray.indexOf(_arg_1));
        }


    }
}

