package com.sulake.core.window.components
{
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.WindowController;

    public class ScrollBarLiftController extends InteractiveController implements IDragBarWindow 
    {

        protected var _SafeStr_940:Number = 0;
        protected var _SafeStr_941:Number = 0;
        protected var _scrollBar:ScrollBarController;

        public function ScrollBarLiftController(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:WindowContext, _arg_6:Rectangle, _arg_7:IWindow, _arg_8:Function, _arg_9:Array=null, _arg_10:Array=null, _arg_11:uint=0)
        {
            _arg_4 = (_arg_4 | 0x20);
            _arg_4 = (_arg_4 | 0x8000);
            _arg_4 = (_arg_4 | 0x0101);
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11);
            var _local_12:IWindow = _arg_7;
            while (_local_12 != null)
            {
                if ((_local_12 is IScrollbarWindow))
                {
                    _scrollBar = ScrollBarController(_local_12);
                    _local_12 = null;
                }
                else
                {
                    _local_12 = _local_12.parent;
                };
            };
            if (_scrollBar.horizontal)
            {
                limits.minWidth = width;
            }
            else
            {
                limits.minHeight = height;
            };
        }

        public function get scrollbarOffsetX():Number
        {
            return (_SafeStr_940);
        }

        public function get scrollbarOffsetY():Number
        {
            return (_SafeStr_941);
        }

        public function set scrollbarOffsetX(_arg_1:Number):void
        {
        }

        public function set scrollbarOffsetY(_arg_1:Number):void
        {
        }

        override public function update(_arg_1:WindowController, _arg_2:WindowEvent):Boolean
        {
            var _local_3:WindowEvent;
            if (_arg_2.type == "WE_RELOCATED")
            {
                _SafeStr_940 = ((x != 0) ? (x / (_parent.width - width)) : 0);
                _SafeStr_941 = ((y != 0) ? (y / (_parent.height - height)) : 0);
                if (_parent != _scrollBar)
                {
                    _local_3 = WindowEvent.allocate("WE_CHILD_RELOCATED", this, null);
                    _scrollBar.update(this, _local_3);
                    _local_3.recycle();
                };
            };
            return (super.update(_arg_1, _arg_2));
        }


    }
}

