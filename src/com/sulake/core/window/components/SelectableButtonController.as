package com.sulake.core.window.components
{
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.WindowController;
    import com.sulake.core.window.events.WindowEvent;

    public class SelectableButtonController extends ButtonController implements ISelectableWindow 
    {

        public function SelectableButtonController(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:WindowContext, _arg_6:Rectangle, _arg_7:IWindow, _arg_8:Function, _arg_9:Array=null, _arg_10:Array=null, _arg_11:uint=0)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11);
        }

        public function get selector():ISelectorWindow
        {
            var _local_1:IWindow;
            if (_parent)
            {
                _local_1 = (_parent as WindowController);
                while (_local_1)
                {
                    if ((_local_1 is ISelectorWindow))
                    {
                        return (_local_1 as ISelectorWindow);
                    };
                    _local_1 = _local_1.parent;
                };
            };
            return (null);
        }

        public function get isSelected():Boolean
        {
            return (testStateFlag(8));
        }

        public function set isSelected(_arg_1:Boolean):void
        {
            setStateFlag(8, _arg_1);
        }

        override public function update(_arg_1:WindowController, _arg_2:WindowEvent):Boolean
        {
            var _local_3:WindowController;
            var _local_4:WindowEvent;
            if (_arg_2.type == "WE_ACTIVATED")
            {
                if (_parent)
                {
                    if (!(_parent is ISelectorWindow))
                    {
                        _local_3 = (_parent.parent as WindowController);
                        while (_local_3)
                        {
                            if ((_local_3 is ISelectorWindow))
                            {
                                _local_4 = WindowEvent.allocate("WE_CHILD_ACTIVATED", this, null);
                                _local_3.update(this, _local_4);
                                _local_4.recycle();
                                break;
                            };
                            _local_3 = (_local_3.parent as WindowController);
                        };
                    };
                };
            };
            return (super.update(_arg_1, _arg_2));
        }

        public function select():Boolean
        {
            if (getStateFlag(8))
            {
                return (true);
            };
            var _local_1:WindowEvent = WindowEvent.allocate("WE_SELECT", this, null, true);
            update(this, _local_1);
            if (_local_1.isDefaultPrevented())
            {
                _local_1.recycle();
                return (false);
            };
            _local_1.recycle();
            setStateFlag(8, true);
            _local_1 = WindowEvent.allocate("WE_SELECTED", this, null);
            update(this, _local_1);
            _local_1.recycle();
            return (true);
        }

        public function unselect():Boolean
        {
            if (!getStateFlag(8))
            {
                return (true);
            };
            var _local_1:WindowEvent = WindowEvent.allocate("WE_UNSELECT", this, null, true);
            update(this, _local_1);
            if (_local_1.isDefaultPrevented())
            {
                _local_1.recycle();
                return (false);
            };
            _local_1.recycle();
            setStateFlag(8, false);
            _local_1 = WindowEvent.allocate("WE_UNSELECTED", this, null);
            update(this, _local_1);
            _local_1.recycle();
            return (true);
        }


    }
}