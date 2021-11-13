package com.sulake.habbo.quest
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.habbo.window.widgets.IBadgeImageWidget;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.window.widgets.ICountdownWidget;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class AchievementResolutionProgressView implements IDisposable 
    {

        private static const PROGRESSBAR_LEFT:String = "achieved_left";
        private static const PROGRESSBAR_MID:String = "achieved_mid";
        private static const PROGRESSBAR_RIGHT:String = "achieved_right";

        private var _SafeStr_3117:int;
        private var _SafeStr_1284:AchievementsResolutionController;
        private var _window:IFrameWindow;
        private var _stuffId:int;
        private var _achievementId:int;
        private var _SafeStr_3115:String;

        public function AchievementResolutionProgressView(_arg_1:AchievementsResolutionController)
        {
            _SafeStr_1284 = _arg_1;
        }

        public function dispose():void
        {
            if (_window)
            {
                _window.dispose();
                _window = null;
            };
            _SafeStr_1284 = null;
        }

        public function get disposed():Boolean
        {
            return (_SafeStr_1284 == null);
        }

        public function get achievementId():int
        {
            return (_achievementId);
        }

        public function get stuffId():int
        {
            return (_stuffId);
        }

        public function get visible():Boolean
        {
            if (!_window)
            {
                return (false);
            };
            return (_window.visible);
        }

        public function show(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:int, _arg_5:int, _arg_6:int):void
        {
            if (_window == null)
            {
                createWindow();
            };
            if (_arg_2 != _achievementId)
            {
                initializeWindow();
                _window.center();
            };
            _stuffId = _arg_1;
            _achievementId = _arg_2;
            _SafeStr_3115 = _arg_3;
            setProgress(_arg_4, _arg_5);
            setBadge(_SafeStr_3115);
            setLocalizations();
            setCountdown(_arg_6);
            _window.visible = true;
        }

        private function setProgress(_arg_1:int, _arg_2:int):void
        {
            var _local_3:Number = Math.min(1, (_arg_1 / _arg_2));
            if (_local_3 > 0)
            {
                _window.setVisibleChildren(true, ["achieved_left", "achieved_mid"]);
                _window.findChildByName("achieved_right").visible = (_local_3 == 1);
            };
            _window.findChildByName("achieved_mid").width = (_SafeStr_3117 * _local_3);
            _SafeStr_1284.questEngine.localization.registerParameter("resolution.progress.progress", "progress", _arg_1.toString());
            _SafeStr_1284.questEngine.localization.registerParameter("resolution.progress.progress", "total", _arg_2.toString());
        }

        private function setBadge(_arg_1:String):void
        {
            var _local_3:IWidgetWindow = (_window.findChildByName("achievement_badge") as IWidgetWindow);
            var _local_2:IBadgeImageWidget = (_local_3.widget as IBadgeImageWidget);
            IStaticBitmapWrapperWindow(IWindowContainer(_local_3.rootWindow).findChildByName("bitmap")).assetUri = "common_loading_icon";
            _local_2.badgeId = _arg_1;
            _local_3.visible = true;
        }

        private function setLocalizations():void
        {
            _window.findChildByName("achievement.name").caption = _SafeStr_1284.questEngine.localization.getBadgeName(_SafeStr_3115);
            _window.findChildByName("achievement.desc").caption = _SafeStr_1284.questEngine.localization.getBadgeDesc(_SafeStr_3115);
        }

        private function setCountdown(_arg_1:int):void
        {
            var _local_2:IWidgetWindow = IWidgetWindow(_window.findChildByName("time_left_widget"));
            var _local_3:ICountdownWidget = ICountdownWidget(_local_2.widget);
            _local_3.seconds = _arg_1;
            _local_3.running = true;
        }

        private function createWindow():void
        {
            _window = IFrameWindow(_SafeStr_1284.questEngine.getXmlWindow("AchievementResolutionProgress"));
            _window.findChildByTag("close").procedure = onWindowClose;
            _window.findChildByName("reset_button").procedure = onResetButton;
            _SafeStr_3117 = _window.findChildByName("achieved_mid").width;
        }

        private function initializeWindow():void
        {
            _window.center();
            _window.setVisibleChildren(false, ["achieved_left", "achieved_mid", "achieved_right"]);
        }

        public function close():void
        {
            if (_window)
            {
                _window.visible = false;
            };
        }

        private function onWindowClose(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                close();
            };
        }

        private function onResetButton(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                _SafeStr_1284.resetResolution(_stuffId);
                close();
            };
        }


    }
}

