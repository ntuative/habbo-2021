package com.sulake.habbo.ui.widget.roomtools
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import com.sulake.habbo.ui.handler.RoomToolsWidgetHandler;

    public class RoomToolsCtrlBase 
    {

        protected static const DISTANCE_FROM_BOTTOM:int = 55;
        protected static const TOOLBAR_X:int = -5;
        protected static const _SafeStr_4283:int = 100;

        protected var _window:IWindowContainer;
        protected var _SafeStr_1324:RoomToolsWidget;
        protected var _windowManager:IHabboWindowManager;
        protected var _assets:IAssetLibrary;
        protected var _SafeStr_4284:Boolean = true;
        protected var _SafeStr_4285:Timer;
        protected var _SafeStr_4286:Boolean;
        protected var _SafeStr_4287:int;

        public function RoomToolsCtrlBase(_arg_1:RoomToolsWidget, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary)
        {
            _SafeStr_1324 = _arg_1;
            _windowManager = _arg_2;
            _assets = _arg_3;
            _SafeStr_4287 = handler.container.config.getInteger("room.enter.info.collapse.delay", 5000);
        }

        public function dispose():void
        {
            if (_window)
            {
                _window.procedure = null;
                _window.dispose();
                _window = null;
            };
            if (_SafeStr_4285)
            {
                _SafeStr_4285.reset();
                _SafeStr_4285 = null;
                _SafeStr_4286 = false;
            };
            _SafeStr_1324 = null;
        }

        public function setElementVisible(_arg_1:String, _arg_2:Boolean):void
        {
            if (((!(_window)) || (!(_window.findChildByName(_arg_1)))))
            {
                return;
            };
            _window.findChildByName(_arg_1).visible = _arg_2;
        }

        protected function collapseAfterDelay():void
        {
            clearCollapseTimer();
            _SafeStr_4285 = new Timer(_SafeStr_4287, 1);
            _SafeStr_4285.addEventListener("timer", collapseTimerEventHandler);
            _SafeStr_4285.start();
        }

        protected function collapseIfPending():void
        {
            if (_SafeStr_4286)
            {
                collapseAfterDelay();
            };
        }

        protected function clearCollapseTimer():void
        {
            if (_SafeStr_4285 != null)
            {
                _SafeStr_4285.reset();
                _SafeStr_4285 = null;
            };
            _SafeStr_4286 = false;
        }

        private function collapseTimerEventHandler(_arg_1:TimerEvent):void
        {
            clearCollapseTimer();
            setCollapsed(true);
        }

        protected function cancelWindowCollapse():void
        {
            if (_SafeStr_4285 != null)
            {
                clearCollapseTimer();
                _SafeStr_4286 = true;
            };
        }

        public function setCollapsed(_arg_1:Boolean):void
        {
        }

        public function get isCollapsed():Boolean
        {
            return (_SafeStr_4284);
        }

        public function get window():IWindowContainer
        {
            return (_window);
        }

        public function get handler():RoomToolsWidgetHandler
        {
            return ((_SafeStr_1324) ? _SafeStr_1324.handler : null);
        }


    }
}

