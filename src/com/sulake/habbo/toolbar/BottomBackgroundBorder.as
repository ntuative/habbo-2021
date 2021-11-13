package com.sulake.habbo.toolbar
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import flash.geom.Point;

    public class BottomBackgroundBorder implements IDisposable 
    {

        private var _window:IWindowContainer;
        private var _disposed:Boolean = false;

        public function BottomBackgroundBorder(_arg_1:HabboToolbar)
        {
            _window = (_arg_1.windowManager.buildFromXML((_arg_1.assets.getAssetByName("bottom_background_border_xml").content as XML)) as IWindowContainer);
            _window.procedure = onWindowEvent;
            updatePosition();
        }

        public function dispose():void
        {
            if (disposed)
            {
                return;
            };
        }

        private function onWindowEvent(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WE_PARENT_RESIZED")
            {
                updatePosition();
            };
        }

        private function updatePosition():void
        {
            _window.position = new Point(-10, (_window.desktop.height - (_window.height - 3)));
            _window.width = (_window.desktop.width + 20);
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }


    }
}