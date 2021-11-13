package com.sulake.habbo.quest
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.habbo.window.widgets.IBadgeImageWidget;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
    import com.sulake.core.window.IWindowContainer;

    public class AchievementResolutionCompletedView implements IDisposable 
    {

        private static const _SafeStr_3113:String = "header_button_close";
        private static const _SafeStr_3114:String = "cancel_button";

        private var _SafeStr_1284:AchievementsResolutionController;
        private var _window:IFrameWindow;
        private var _SafeStr_3115:String;
        private var _SafeStr_3116:String;

        public function AchievementResolutionCompletedView(_arg_1:AchievementsResolutionController)
        {
            _SafeStr_1284 = _arg_1;
        }

        public function dispose():void
        {
            _SafeStr_1284 = null;
            if (_window)
            {
                _window.dispose();
                _window = null;
            };
        }

        public function get disposed():Boolean
        {
            return (!(_SafeStr_1284 == null));
        }

        public function get visible():Boolean
        {
            if (!_window)
            {
                return (false);
            };
            return (_window.visible);
        }

        public function show(_arg_1:String, _arg_2:String):void
        {
            if (_window == null)
            {
                createWindow();
            };
            initializeWindow();
            _SafeStr_3116 = _arg_1;
            _SafeStr_3115 = _arg_2;
            setBadge(_SafeStr_3115);
            _window.visible = true;
        }

        private function createWindow():void
        {
            _window = IFrameWindow(_SafeStr_1284.questEngine.getXmlWindow("AchievementResolutionCompleted"));
            addClickListener("header_button_close");
            addClickListener("cancel_button");
        }

        private function addClickListener(_arg_1:String):void
        {
            var _local_2:IWindow = _window.findChildByName(_arg_1);
            if (_local_2 != null)
            {
                _local_2.addEventListener("WME_CLICK", onMouseClick);
            };
        }

        private function onMouseClick(_arg_1:WindowMouseEvent):void
        {
            switch (_arg_1.target.name)
            {
                case "header_button_close":
                case "cancel_button":
                    close();
                    return;
            };
        }

        private function initializeWindow():void
        {
            _window.center();
        }

        private function setBadge(_arg_1:String):void
        {
            var _local_3:IWidgetWindow = (_window.findChildByName("achievement_badge") as IWidgetWindow);
            var _local_2:IBadgeImageWidget = (_local_3.widget as IBadgeImageWidget);
            IStaticBitmapWrapperWindow(IWindowContainer(_local_3.rootWindow).findChildByName("bitmap")).assetUri = "common_loading_icon";
            _local_2.badgeId = _arg_1;
            _local_3.visible = true;
        }

        public function close():void
        {
            if (_window)
            {
                _window.visible = false;
            };
        }


    }
}

