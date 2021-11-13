package com.sulake.core.window.components
{
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.WindowController;
    import com.sulake.core.window.events.WindowEvent;

    public class ActivatorController extends ContainerController 
    {

        protected var _SafeStr_883:IWindow;

        public function ActivatorController(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:WindowContext, _arg_6:Rectangle, _arg_7:IWindow, _arg_8:Function=null, _arg_9:Array=null, _arg_10:Array=null, _arg_11:uint=0)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11);
        }

        override public function update(_arg_1:WindowController, _arg_2:WindowEvent):Boolean
        {
            if (_arg_2.type == "WE_CHILD_ACTIVATED")
            {
                setActiveChild((_arg_1 as IWindow));
            }
            else
            {
                if (_arg_2.type == "WE_PARENT_ACTIVATED")
                {
                    return (true);
                };
            };
            return (super.update(_arg_1, _arg_2));
        }

        public function getActiveChild():IWindow
        {
            return (_SafeStr_883);
        }

        public function setActiveChild(_arg_1:IWindow):IWindow
        {
            if (_arg_1.parent != this)
            {
                while (true)
                {
                    _arg_1 = _arg_1.parent;
                    if (_arg_1 == null)
                    {
                        throw (new Error("Window passed to activator is not a child!"));
                    };
                    if (_arg_1.parent == this) break;
                };
            };
            var _local_2:IWindow = _SafeStr_883;
            if (_SafeStr_883 != _arg_1)
            {
                if (_SafeStr_883 != null)
                {
                    if (!_SafeStr_883.disposed)
                    {
                        _SafeStr_883.deactivate();
                    };
                };
                _SafeStr_883 = _arg_1;
                if (getChildIndex(_arg_1) != (numChildren - 1))
                {
                    setChildIndex(_arg_1, (numChildren - 1));
                };
            };
            return (_local_2);
        }


    }
}

