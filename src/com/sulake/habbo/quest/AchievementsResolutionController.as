package com.sulake.habbo.quest
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.components.IFrameWindow;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.communication.messages.incoming.inventory.achievements.AchievementResolutionData;
    import com.sulake.core.window.components.IItemGridWindow;
    import com.sulake.habbo.communication.messages.outgoing.game.lobby.GetResolutionAchievementsMessageComposer;
    import com.sulake.habbo.communication.messages.incoming.notifications.AchievementLevelUpData;
    import com.sulake.habbo.communication.messages.incoming.inventory.achievements.AchievementData;
    import com.sulake.habbo.communication.messages.outgoing.game.lobby.ResetResolutionAchievementMessageComposer;
    import com.sulake.habbo.window.utils._SafeStr_126;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.habbo.window.widgets.ICountdownWidget;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.window.widgets.IBadgeImageWidget;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;

    public class AchievementsResolutionController implements IDisposable
    {

        private static const _SafeStr_3113:String = "header_button_close";
        private static const _SafeStr_3118:String = "save_button";
        private static const _SafeStr_3114:String = "cancel_button";
        private static const _SafeStr_3119:String = "ok_button";
        private static const ELEM_DISABLED_INFO:String = "disabled.reason";

        private var _questEngine:HabboQuestEngine;
        private var _window:IFrameWindow;
        private var _progressView:AchievementResolutionProgressView;
        private var _completedView:AchievementResolutionCompletedView;
        private var _stuffId:int;
        private var _SafeStr_1999:Vector.<AchievementResolutionData>;
        private var _selectedAchievementId:int = -1;
        private var _endTime:int = -1;

        public function AchievementsResolutionController(_arg_1:HabboQuestEngine)
        {
            _questEngine = _arg_1;
        }

        public function dispose():void
        {
            var _local_1:IItemGridWindow;
            _questEngine = null;
            if (_window)
            {
                _local_1 = (_window.findChildByName("achievements") as IItemGridWindow);
                if (_local_1)
                {
                    _local_1.destroyGridItems();
                };
                if (_progressView)
                {
                    _progressView.dispose();
                    _progressView = null;
                };
                if (_completedView)
                {
                    _completedView.dispose();
                    _completedView = null;
                };
                _window.dispose();
                _window = null;
            };
        }

        public function get disposed():Boolean
        {
            return (_questEngine == null);
        }

        public function onResolutionAchievements(_arg_1:int, _arg_2:Vector.<AchievementResolutionData>, _arg_3:int):void
        {
            _stuffId = _arg_1;
            _SafeStr_1999 = _arg_2;
            _endTime = _arg_3;
            if (_arg_2.length == 0)
            {
                return;
            };
            refresh();
            _window.visible = true;
            _selectedAchievementId = _SafeStr_1999[0].achievementId;
            populateAchievementGrid();
            selectAchievement(_selectedAchievementId);
        }

        public function onResolutionProgress(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:int, _arg_5:int, _arg_6:int):void
        {
            if (!_progressView)
            {
                _progressView = new AchievementResolutionProgressView(this);
            };
            _progressView.show(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6);
        }

        public function onResolutionCompleted(_arg_1:String, _arg_2:String):void
        {
            if (!_completedView)
            {
                _completedView = new AchievementResolutionCompletedView(this);
            };
            _completedView.show(_arg_2, _arg_1);
        }

        public function onLevelUp(_arg_1:AchievementLevelUpData):void
        {
            if ((((_progressView) && (_progressView.visible)) && (_arg_1.type == _progressView.achievementId)))
            {
                _questEngine.send(new GetResolutionAchievementsMessageComposer(_progressView.stuffId, 0));
            };
        }

        public function onAchievement(_arg_1:AchievementData):void
        {
            if ((((_progressView) && (_progressView.visible)) && (_arg_1.achievementId == _progressView.achievementId)))
            {
                _questEngine.send(new GetResolutionAchievementsMessageComposer(_progressView.stuffId, 0));
            };
        }

        public function resetResolution(_arg_1:int):void
        {
            var stuffId:int = _arg_1;
            if ((((_progressView) && (_progressView.visible)) && (stuffId == _progressView.stuffId)))
            {
                var title:String = "${resolution.reset.confirmation.title}";
                var summary:String = "${resolution.reset.confirmation.text}";
                _questEngine.windowManager.confirm(title, summary, 0, function (_arg_1:_SafeStr_126, _arg_2:WindowEvent):void
                {
                    _arg_1.dispose();
                    if (_arg_2.type == "WE_OK")
                    {
                        _questEngine.send(new ResetResolutionAchievementMessageComposer(stuffId));
                        _questEngine.send(new GetResolutionAchievementsMessageComposer(_progressView.stuffId, 0));
                    };
                });
            };
        }

        private function refresh():void
        {
            if (_window == null)
            {
                prepareWindow();
            };
            var _local_1:IWidgetWindow = IWidgetWindow(_window.findChildByName("countdown_widget"));
            var _local_2:ICountdownWidget = ICountdownWidget(_local_1.widget);
            _local_2.seconds = _endTime;
            _local_2.running = true;
        }

        private function prepareWindow():void
        {
            if (this._window != null)
            {
                return;
            };
            _window = IFrameWindow(_questEngine.getXmlWindow("AchievementsResolutions"));
            _window.findChildByTag("close").procedure = onWindowClose;
            _window.center();
            _window.visible = true;
            addClickListener("header_button_close");
            addClickListener("save_button");
            addClickListener("cancel_button");
        }

        private function onWindowClose(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                close();
            };
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
            var event:WindowMouseEvent = _arg_1;
            switch (event.target.name)
            {
                case "header_button_close":
                case "cancel_button":
                    close();
                    return;
                case "ok_button":
                    return;
                case "save_button":
                    var title:String = "${resolution.confirmation.title}";
                    var summary:String = "${resolution.confirmation.text}";
                    close();
                    _questEngine.windowManager.confirm(title, summary, 0, function (_arg_1:_SafeStr_126, _arg_2:WindowEvent):void
                    {
                        _arg_1.dispose();
                        if (_arg_2.type == "WE_OK")
                        {
                            _questEngine.send(new GetResolutionAchievementsMessageComposer(_stuffId, _selectedAchievementId));
                        }
                        else
                        {
                            _window.visible = true;
                        };
                    });
                    return;
            };
        }

        public function isVisible():Boolean
        {
            return ((_window) && (_window.visible));
        }

        public function close():void
        {
            if (_window)
            {
                _window.visible = false;
            };
        }

        private function populateAchievementGrid():void
        {
            var _local_3:IWindowContainer;
            var _local_2:IItemGridWindow = (_window.findChildByName("achievements") as IItemGridWindow);
            _local_2.destroyGridItems();
            var _local_4:IWindow = _questEngine.getXmlWindow("AchievementSimple");
            for each (var _local_1:AchievementResolutionData in _SafeStr_1999)
            {
                _local_3 = (_local_4.clone() as IWindowContainer);
                _local_3.id = _local_1.achievementId;
                refreshBadgeImage(_local_3, _local_1);
                _local_3.findChildByName("bg_region").procedure = onSelectAchievementProc;
                _local_3.findChildByName("bg_selected_bitmap").visible = false;
                _local_2.addGridItem(_local_3);
            };
        }

        private function hiliteGridItem(_arg_1:int, _arg_2:Boolean):void
        {
            var _local_4:IItemGridWindow = (_window.findChildByName("achievements") as IItemGridWindow);
            var _local_3:IWindowContainer = (_local_4.getGridItemByID(_arg_1) as IWindowContainer);
            if (_local_3)
            {
                _local_3.findChildByName("bg_selected_bitmap").visible = _arg_2;
            };
        }

        private function selectAchievement(_arg_1:int):void
        {
            if (_selectedAchievementId != -1)
            {
                hiliteGridItem(_selectedAchievementId, false);
            };
            var _local_2:AchievementResolutionData = findAchievement(_arg_1);
            if (_local_2 == null)
            {
                return;
            };
            _selectedAchievementId = _arg_1;
            hiliteGridItem(_selectedAchievementId, true);
            _window.findChildByName("achievement.name").caption = _questEngine.localization.getBadgeName(_local_2.badgeId);
            _window.findChildByName("achievement.description").caption = _questEngine.localization.getBadgeDesc(_local_2.badgeId);
            _window.findChildByName("achievement.level").caption = _local_2.level.toString();
            _questEngine.localization.registerParameter("resolution.achievement.target.value", "level", _local_2.requiredLevel.toString());
            refreshBadgeImageLarge(_local_2);
            ((_local_2.enabled) ? enable() : disable(_local_2.state)); //not popped
        }

        private function disable(_arg_1:int):void
        {
            _window.setVisibleChildren(false, ["save_button"]);
            _window.setVisibleChildren(true, ["disabled.reason"]);
            _window.findChildByName("disabled.reason").caption = (("${resolution.disabled." + _arg_1) + "}");
        }

        public function enable():void
        {
            _window.setVisibleChildren(true, ["save_button"]);
            _window.setVisibleChildren(false, ["disabled.reason"]);
        }

        private function onSelectAchievementProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            selectAchievement(_arg_2.parent.id);
        }

        private function refreshBadgeImage(_arg_1:IWindowContainer, _arg_2:AchievementResolutionData):void
        {
            var _local_4:IWidgetWindow = (_arg_1.findChildByName("achievement_pic_bitmap") as IWidgetWindow);
            var _local_3:IBadgeImageWidget = (_local_4.widget as IBadgeImageWidget);
            if (_arg_2 == null)
            {
                _local_4.visible = false;
                return;
            };
            IStaticBitmapWrapperWindow(IWindowContainer(_local_4.rootWindow).findChildByName("bitmap")).assetUri = "common_loading_icon";
            _local_3.badgeId = _arg_2.badgeId;
            _local_3.greyscale = (!(_arg_2.enabled));
            _local_4.visible = true;
        }

        private function refreshBadgeImageLarge(_arg_1:AchievementResolutionData):void
        {
            var _local_3:IWidgetWindow = (_window.findChildByName("achievement_badge") as IWidgetWindow);
            var _local_2:IBadgeImageWidget = (_local_3.widget as IBadgeImageWidget);
            IStaticBitmapWrapperWindow(IWindowContainer(_local_3.rootWindow).findChildByName("bitmap")).assetUri = "common_loading_icon";
            _local_2.badgeId = _arg_1.badgeId;
            _local_2.greyscale = (!(_arg_1.enabled));
            _local_3.visible = true;
        }

        private function findAchievement(_arg_1:int):AchievementResolutionData
        {
            for each (var _local_2:AchievementResolutionData in _SafeStr_1999)
            {
                if (_local_2.achievementId == _arg_1)
                {
                    return (_local_2);
                };
            };
            return (null);
        }

        public function get questEngine():HabboQuestEngine
        {
            return (_questEngine);
        }


    }
}