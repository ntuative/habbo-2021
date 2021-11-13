package com.sulake.core.window.utils
{
    import com.sulake.core.window.graphics.IWindowRenderer;
    import com.sulake.core.window.components.IDesktopWindow;
    import com.sulake.core.window.IWindow;
    import __AS3__.vec.Vector;
    import com.sulake.core.window.IInputEventTracker;

    public class EventProcessorState 
    {

        public var renderer:IWindowRenderer;
        public var desktop:IDesktopWindow;
        public var _SafeStr_643:IWindow;
        public var lastClickTarget:IWindow;
        public var eventTrackers:Vector.<IInputEventTracker>;

        public function EventProcessorState(_arg_1:IWindowRenderer, _arg_2:IDesktopWindow, _arg_3:IWindow, _arg_4:IWindow, _arg_5:Vector.<IInputEventTracker>)
        {
            this.renderer = _arg_1;
            this.desktop = _arg_2;
            this._SafeStr_643 = _arg_3;
            this.lastClickTarget = _arg_4;
            this.eventTrackers = _arg_5;
        }

    }
}

