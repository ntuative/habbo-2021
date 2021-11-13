package com.sulake.core.window.components
{
    import com.sulake.core.window.utils.IIterable;
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.iterators.SelectorIterator;
    import com.sulake.core.window.utils.IIterator;
    import com.sulake.core.window.WindowController;
    import com.sulake.core.window.events.WindowEvent;

    public class SelectorController extends InteractiveController implements ISelectorWindow, IIterable 
    {

        private var _selected:ISelectableWindow;
        protected var _SafeStr_942:Boolean = true;

        public function SelectorController(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:WindowContext, _arg_6:Rectangle, _arg_7:IWindow, _arg_8:Function=null, _arg_9:Array=null, _arg_10:Array=null, _arg_11:uint=0)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11);
        }

        public function get iterator():IIterator
        {
            return (new SelectorIterator(this));
        }

        override public function update(_arg_1:WindowController, _arg_2:WindowEvent):Boolean
        {
            if (_arg_2.type == "WE_CHILD_ACTIVATED")
            {
                if ((_arg_1 is ISelectableWindow))
                {
                    setSelected((_arg_1 as ISelectableWindow));
                };
            };
            return (super.update(_arg_1, _arg_2));
        }

        public function get numSelectables():uint
        {
            return (numChildren);
        }

        public function getSelected():ISelectableWindow
        {
            return (_selected as ISelectableWindow);
        }

        public function setSelected(_arg_1:ISelectableWindow):void
        {
            var _local_2:ISelectableWindow;
            if (_arg_1 != null)
            {
                if (_arg_1 != _selected)
                {
                    if (_selected != null)
                    {
                        if (!_selected.unselect())
                        {
                            return;
                        };
                    };
                    _local_2 = _selected;
                    _selected = _arg_1;
                    if (_selected.select())
                    {
                        if (getChildIndex(_arg_1) > -1)
                        {
                            if (_SafeStr_942)
                            {
                                if (getChildIndex(_arg_1) != (numChildren - 1))
                                {
                                    setChildIndex(_arg_1, (numChildren - 1));
                                };
                            };
                        };
                    }
                    else
                    {
                        _selected = _local_2;
                        if (_selected != null)
                        {
                            _selected.select();
                        };
                    };
                };
            };
        }

        public function addSelectable(_arg_1:ISelectableWindow):ISelectableWindow
        {
            return (ISelectableWindow(addChild(_arg_1)));
        }

        public function addSelectableAt(_arg_1:ISelectableWindow, _arg_2:int):ISelectableWindow
        {
            return (ISelectableWindow(addChildAt(_arg_1, _arg_2)));
        }

        public function getSelectableAt(_arg_1:int):ISelectableWindow
        {
            return (getChildAt(_arg_1) as ISelectableWindow);
        }

        public function getSelectableByID(_arg_1:uint):ISelectableWindow
        {
            return (getChildByID(_arg_1) as ISelectableWindow);
        }

        public function getSelectableByTag(_arg_1:String):ISelectableWindow
        {
            return (getChildByTag(_arg_1) as ISelectableWindow);
        }

        public function getSelectableByName(_arg_1:String):ISelectableWindow
        {
            return (getChildByName(_arg_1) as ISelectableWindow);
        }

        public function getSelectableIndex(_arg_1:ISelectableWindow):int
        {
            return (getChildIndex(_arg_1));
        }

        public function removeSelectable(_arg_1:ISelectableWindow):ISelectableWindow
        {
            var _local_2:int = getChildIndex(_arg_1);
            if (_local_2 > -1)
            {
                if (_arg_1 == _selected)
                {
                    if (numSelectables > 1)
                    {
                        setSelected(getSelectableAt(((_local_2 == 0) ? 1 : 0)));
                    }
                    else
                    {
                        _selected = null;
                    };
                };
                return (ISelectableWindow(removeChild(_arg_1)));
            };
            return (null);
        }


    }
}

