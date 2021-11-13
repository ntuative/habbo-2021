package com.sulake.habbo.friendbar.landingview.widget.elements
{
    import com.sulake.habbo.friendbar.landingview.interfaces.elements.IElementHandler;
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.friendbar.landingview.HabboLandingView;
    import com.sulake.habbo.friendbar.landingview.widget.GenericWidget;
    import com.sulake.core.window.IWindowContainer;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
    import com.sulake.habbo.communication.messages.incoming.quest.ConcurrentUsersGoalProgressMessageEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.communication.messages.outgoing.quest.GetConcurrentUsersGoalProgressMessageComposer;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.communication.messages.outgoing.quest.GetConcurrentUsersRewardMessageComposer;

    public class ConcurrentUsersInfoElementHandler implements IElementHandler, IDisposable 
    {

        private static const STATE_DISABLED:int = 0;
        private static const STATE_ACTIVE:int = 1;
        private static const STATE_REDEEM:int = 2;
        private static const STATE_REWARDED:int = 3;
        private static const UPDATE_INTERVAL_MS:int = 5000;

        private var _landingView:HabboLandingView;
        private var _SafeStr_1324:GenericWidget;
        private var _localizationKey:String;
        private var _SafeStr_448:int = -1;
        private var _SafeStr_2335:int = -1;
        private var _SafeStr_2336:int = -1;
        private var _window:IWindowContainer;
        private var _SafeStr_1507:Timer;
        private var _disposed:Boolean = false;

        public function ConcurrentUsersInfoElementHandler()
        {
            _SafeStr_1507 = new Timer(5000);
            _SafeStr_1507.addEventListener("timer", onUpdateTimer);
        }

        private function onUpdateTimer(_arg_1:TimerEvent):void
        {
            if ((((_window == null) || (_window.visible == false)) || (!(_landingView.isLandingViewVisible))))
            {
                return;
            };
            refresh();
        }

        public function dispose():void
        {
            if (_SafeStr_1507)
            {
                _SafeStr_1507.stop();
            };
            _SafeStr_1507 = null;
            _disposed = true;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function initialize(_arg_1:HabboLandingView, _arg_2:IWindow, _arg_3:Array, _arg_4:GenericWidget):void
        {
            _SafeStr_1324 = _arg_4;
            _landingView = _arg_1;
            _window = (_arg_2 as IWindowContainer);
            _localizationKey = _arg_3[1];
            _window.findChildByName("users_desc").caption = (("${" + _localizationKey) + "}");
            var _local_5:IStaticBitmapWrapperWindow = IStaticBitmapWrapperWindow(_window.findChildByName("badge_image"));
            var _local_6:String = ((_arg_3.length > 2) ? _arg_3[2] : "ConcurrentUsersReward");
            var _local_7:String = (("${image.library.url}album1584/" + _local_6) + ".png");
            _local_5.assetUri = _local_7;
            updateLocalization();
            _arg_2.procedure = onButton;
            _arg_1.communicationManager.addHabboConnectionMessageEvent(new ConcurrentUsersGoalProgressMessageEvent(onConcurrentUsersGoalProgress));
            _SafeStr_1507.start();
        }

        public function refresh():void
        {
            _landingView.send(new GetConcurrentUsersGoalProgressMessageComposer());
        }

        private function updateLocalization():void
        {
            var _local_4:String = "landing.view.concurrentusers.caption";
            var _local_3:String = "landing.view.concurrentusers.bodytext";
            _landingView.windowManager.registerLocalizationParameter(_localizationKey, "userCount", _SafeStr_2335.toString());
            _landingView.windowManager.registerLocalizationParameter(_localizationKey, "userGoal", _SafeStr_2336.toString());
            _landingView.windowManager.registerLocalizationParameter("landing.view.concurrentusers.bodytext", "userCount", _SafeStr_2335.toString());
            _landingView.windowManager.registerLocalizationParameter("landing.view.concurrentusers.bodytext", "userGoal", _SafeStr_2336.toString());
            _landingView.windowManager.registerLocalizationParameter("landing.view.concurrentusers.bodytext", "domain", _landingView.localizationManager.getLocalization("landing.view.hotel.domain", "Habbo"));
            switch (_SafeStr_448)
            {
                case 0:
                    _window.findChildByName("state.active").visible = true;
                    _window.findChildByName("state.achieved").visible = false;
                    break;
                case 1:
                    _window.findChildByName("state.active").visible = true;
                    _window.findChildByName("state.achieved").visible = false;
                    break;
                case 2:
                    if (_SafeStr_1507)
                    {
                        _SafeStr_1507.stop();
                    };
                    _local_4 = (_local_4 + ".success");
                    _local_3 = (_local_3 + ".success");
                    _window.findChildByName("state.active").visible = false;
                    _window.findChildByName("state.active").enable();
                    _window.findChildByName("state.achieved").visible = true;
                    _window.findChildByName("action_button").visible = true;
                    break;
                case 3:
                    if (_SafeStr_1507)
                    {
                        _SafeStr_1507.stop();
                    };
                    _local_4 = (_local_4 + ".success");
                    _local_3 = (_local_3 + ".success");
                    _window.findChildByName("state.active").visible = false;
                    _window.findChildByName("state.achieved").visible = true;
                    _window.findChildByName("action_button").visible = false;
                default:
            };
            var _local_1:TextElementHandler = (_SafeStr_1324.getElementByName("bodytext") as TextElementHandler);
            if (_local_1)
            {
                _local_1.localizationKey = _local_3;
            };
            var _local_2:TextElementHandler = (_SafeStr_1324.getElementByName("caption") as TextElementHandler);
            if (_local_2)
            {
                _local_2.localizationKey = _local_4;
            };
        }

        private function onConcurrentUsersGoalProgress(_arg_1:ConcurrentUsersGoalProgressMessageEvent):void
        {
            _SafeStr_448 = _arg_1.getParser().state;
            _SafeStr_2335 = _arg_1.getParser().userCount;
            _SafeStr_2336 = _arg_1.getParser().userCountGoal;
            updateLocalization();
        }

        private function onButton(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                onClick();
            };
        }

        protected function onClick():void
        {
            _landingView.send(new GetConcurrentUsersRewardMessageComposer());
            _landingView.send(new GetConcurrentUsersGoalProgressMessageComposer());
            _window.findChildByName("state.active").disable();
        }


    }
}

