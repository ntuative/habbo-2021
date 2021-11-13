package com.sulake.core.window.components
{
    import com.sulake.core.window.WindowController;
    import com.sulake.core.window.utils.IIterable;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.utils.IIterator;
    import com.sulake.core.window.events.WindowEvent;

    public class TabContextController extends WindowController implements ITabContextWindow, IIterable 
    {

        private static const TAG_TAB_CONTEXT_SELECTOR:String = "_SELECTOR";
        private static const TAG_TAB_CONTEXT_CONTENT:String = "_CONTENT";

        protected var _SafeStr_945:ISelectorListWindow;
        protected var _SafeStr_946:IWindowContainer;
        private var _SafeStr_943:Boolean = false;
        private var _SafeStr_527:Boolean = false;

        public function TabContextController(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:WindowContext, _arg_6:Rectangle, _arg_7:IWindow, _arg_8:Function=null, _arg_9:Array=null, _arg_10:Array=null, _arg_11:uint=0)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11);
            var _local_12:Array = [];
            groupChildrenWithTag("_INTERNAL", _local_12, -1);
            for each (var _local_13:IWindow in _local_12)
            {
                _local_13.style = _style;
                _local_13.procedure = selectorEventProc;
            };
            _SafeStr_527 = true;
        }

        public function get selector():ISelectorListWindow
        {
            if (_SafeStr_945 == null)
            {
                _SafeStr_945 = (findChildByTag("_SELECTOR") as ISelectorListWindow);
                if (_SafeStr_945 != null)
                {
                    _SafeStr_945.procedure = selectorEventProc;
                };
            };
            return (_SafeStr_945);
        }

        public function get container():IWindowContainer
        {
            if (_SafeStr_946 == null)
            {
                _SafeStr_946 = (findChildByTag("_CONTENT") as IWindowContainer);
            };
            return (_SafeStr_946);
        }

        public function get iterator():IIterator
        {
            return ((_SafeStr_527) ? selector.iterator : null);
        }

        public function get numTabItems():uint
        {
            return (_SafeStr_945.numSelectables);
        }

        public function addTabItem(_arg_1:ITabButtonWindow):ITabButtonWindow
        {
            return (selector.addSelectable(_arg_1) as ITabButtonWindow);
        }

        public function addTabItemAt(_arg_1:ITabButtonWindow, _arg_2:uint):ITabButtonWindow
        {
            return (selector.addSelectableAt(_arg_1, _arg_2) as ITabButtonWindow);
        }

        public function removeTabItem(_arg_1:ITabButtonWindow):void
        {
            selector.removeSelectable(_arg_1);
        }

        public function getTabItemAt(_arg_1:uint):ITabButtonWindow
        {
            return (selector.getSelectableAt(_arg_1) as ITabButtonWindow);
        }

        public function getTabItemByName(_arg_1:String):ITabButtonWindow
        {
            return (selector.getSelectableByName(_arg_1) as ITabButtonWindow);
        }

        public function getTabItemByID(_arg_1:uint):ITabButtonWindow
        {
            return (selector.getSelectableByID(_arg_1) as ITabButtonWindow);
        }

        public function getTabItemIndex(_arg_1:ITabButtonWindow):uint
        {
            return (selector.getSelectableIndex(_arg_1));
        }

        private function selectorEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WE_SELECTED")
            {
                notifyEventListeners(_arg_1);
            };
        }


    }
}

