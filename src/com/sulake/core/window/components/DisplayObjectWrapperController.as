package com.sulake.core.window.components
{
    import com.sulake.core.window.WindowController;
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.graphics.GraphicContext;
    import com.sulake.core.window.graphics.IGraphicContext;
    import com.sulake.core.window.graphics.IGraphicContextHost;
    import flash.display.DisplayObject;

    public class DisplayObjectWrapperController extends WindowController implements IDisplayObjectWrapper 
    {

        public function DisplayObjectWrapperController(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:WindowContext, _arg_6:Rectangle, _arg_7:IWindow, _arg_8:Function, _arg_9:Array=null, _arg_10:Array=null, _arg_11:uint=0)
        {
            _arg_4 = (_arg_4 & (~(0x10)));
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11);
            _SafeStr_899 = false;
        }

        override public function getGraphicContext(_arg_1:Boolean):IGraphicContext
        {
            if (((_arg_1) && (!(_SafeStr_897))))
            {
                _SafeStr_897 = new GraphicContext((("GC {" + _name) + "}"), 4, rectangle);
            };
            return (_SafeStr_897);
        }

        public function getDisplayObject():DisplayObject
        {
            return (IGraphicContextHost(this).getGraphicContext(true).getDisplayObject());
        }

        public function setDisplayObject(_arg_1:DisplayObject):void
        {
            IGraphicContextHost(this).getGraphicContext(true).setDisplayObject(_arg_1);
        }


    }
}

