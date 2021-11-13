package com.sulake.core.window.components
{
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.graphics.GraphicContext;
    import com.sulake.core.window.graphics.IGraphicContext;
    import flash.display.DisplayObject;
    import com.sulake.core.window.events.WindowEvent;

    public class DesktopController extends ActivatorController implements IDesktopWindow, IDisplayObjectWrapper 
    {

        public function DesktopController(_arg_1:String, _arg_2:WindowContext, _arg_3:Rectangle)
        {
            super(_arg_1, 0, 0, 0, _arg_2, _arg_3, null, defaultProcedure, null, null, 0);
        }

        public function get mouseX():int
        {
            return (getDisplayObject().stage.mouseX);
        }

        public function get mouseY():int
        {
            return (getDisplayObject().stage.mouseY);
        }

        override public function set parent(_arg_1:IWindow):void
        {
            throw (new Error("Desktop window doesn't have parent!"));
        }

        override public function set procedure(_arg_1:Function):void
        {
            _SafeStr_900 = ((_arg_1 != null) ? _arg_1 : defaultProcedure);
        }

        override public function get host():IWindow
        {
            return (this);
        }

        override public function get desktop():IDesktopWindow
        {
            return (this);
        }

        override public function getGraphicContext(_arg_1:Boolean):IGraphicContext
        {
            if (((_arg_1) && (!(_SafeStr_897))))
            {
                _SafeStr_897 = new GraphicContext((("GC {" + _name) + "}"), 0x0100, rectangle);
                GraphicContext(_SafeStr_897).mouseEnabled = true;
                GraphicContext(_SafeStr_897).doubleClickEnabled = true;
            };
            return (_SafeStr_897);
        }

        public function getActiveWindow():IWindow
        {
            return (getActiveChild());
        }

        public function setActiveWindow(_arg_1:IWindow):IWindow
        {
            return (setActiveChild(_arg_1));
        }

        public function getDisplayObject():DisplayObject
        {
            return (getGraphicContext(true) as DisplayObject);
        }

        public function setDisplayObject(_arg_1:DisplayObject):void
        {
            getGraphicContext(true).setDisplayObject(_arg_1);
        }

        override public function invalidate(_arg_1:Rectangle=null):void
        {
        }

        private function defaultProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
        }


    }
}

