package com.sulake.habbo.ui.widget.crafting.controller
{
    import com.sulake.habbo.ui.widget.crafting.CraftingWidget;
    import flash.utils.Timer;
    import com.sulake.core.window.IWindow;
    import flash.events.TimerEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindowContainer;

    public class CraftingProgressBarController 
    {

        private var _SafeStr_1324:CraftingWidget;
        private var _SafeStr_4004:Timer;
        private var _SafeStr_4005:Number;

        public function CraftingProgressBarController(_arg_1:CraftingWidget)
        {
            _SafeStr_1324 = _arg_1;
            _SafeStr_4004 = new Timer(70);
            _SafeStr_4004.addEventListener("timer", onProgressTimerEvent);
        }

        public function dispose():void
        {
            _SafeStr_1324 = null;
        }

        private function setProgress(_arg_1:Number):void
        {
            var _local_3:IWindow;
            var _local_2:IWindow = container.findChildByName("btn_cancel");
            var _local_4:IWindow = ((container) ? container.findChildByName("bar") : null);
            if (_local_4)
            {
                _local_3 = _local_4.parent;
                _local_4.width = (_local_2.width * _arg_1);
            };
        }

        private function onProgressTimerEvent(_arg_1:TimerEvent):void
        {
            var _local_2:Number = (_SafeStr_4005 + 0.02);
            _SafeStr_4005 = _local_2;
            setProgress(_local_2);
            if (_SafeStr_4005 >= 1)
            {
                hide();
                _SafeStr_1324.infoCtrl.onProgressBarComplete();
            };
        }

        public function hide():void
        {
            if (_SafeStr_4004)
            {
                _SafeStr_4004.stop();
            };
            if (container)
            {
                container.visible = false;
                container.procedure = null;
            };
        }

        public function show():void
        {
            _SafeStr_4004.start();
            _SafeStr_4005 = 0;
            if (container)
            {
                container.visible = true;
                container.procedure = onTriggered;
            };
        }

        private function onTriggered(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_DOWN")
            {
                return;
            };
            _SafeStr_1324.infoCtrl.cancelCrafting();
        }

        private function get container():IWindowContainer
        {
            if (((!(_SafeStr_1324)) || (!(_SafeStr_1324.window))))
            {
                return (null);
            };
            return (_SafeStr_1324.window.findChildByName("progress_bar") as IWindowContainer);
        }


    }
}

