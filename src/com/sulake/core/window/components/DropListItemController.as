package com.sulake.core.window.components
{
    import com.sulake.core.window.utils.tablet.ITouchAwareWindow;
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;

    public class DropListItemController extends ContainerButtonController implements IDropListItemWindow, ITouchAwareWindow 
    {

        public function DropListItemController(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:WindowContext, _arg_6:Rectangle, _arg_7:IWindow, _arg_8:Function, _arg_9:Array=null, _arg_10:Array=null, _arg_11:uint=0)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11);
        }

        public function get menu():IDropMenuWindow
        {
            var _local_1:IWindow = parent;
            while (_local_1)
            {
                if ((_local_1 is IDropMenuWindow)) break;
                _local_1 = _local_1.parent;
            };
            return (_local_1 as IDropMenuWindow);
        }

        public function get value():IWindow
        {
            return (getChildAt(0));
        }

        public function set value(_arg_1:IWindow):void
        {
            var _local_2:IWindow = getChildAt(0);
            if (_local_2 != _arg_1)
            {
                removeChildAt(0);
                if (_arg_1)
                {
                    addChild(_arg_1);
                };
            };
        }


    }
}