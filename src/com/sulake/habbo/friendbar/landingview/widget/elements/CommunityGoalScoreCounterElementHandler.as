package com.sulake.habbo.friendbar.landingview.widget.elements
{
    import com.sulake.habbo.friendbar.landingview.interfaces.elements.IElementHandler;
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.friendbar.landingview.interfaces.elements.IFloatingElement;
    import com.sulake.habbo.friendbar.landingview.interfaces.elements.ILayoutNameProvider;
    import com.sulake.habbo.friendbar.landingview.interfaces.elements.IDisableAwareElement;
    import com.sulake.habbo.friendbar.landingview.HabboLandingView;
    import com.sulake.core.window.IWindowContainer;
    import flash.utils.Timer;
    import com.sulake.habbo.communication.messages.incoming.quest.CommunityGoalProgressMessageEvent;
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.habbo.window.widgets.IRunningNumberWidget;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.friendbar.landingview.widget.GenericWidget;
    import com.sulake.habbo.communication.messages.outgoing.quest._SafeStr_42;
    import com.sulake.habbo.communication.messages.incoming.quest.CommunityGoalData;
    import flash.events.TimerEvent;

    public class CommunityGoalScoreCounterElementHandler implements IElementHandler, IDisposable, IFloatingElement, ILayoutNameProvider, IDisableAwareElement 
    {

        private var _landingView:HabboLandingView;
        private var _window:IWindowContainer;
        private var _SafeStr_2333:Boolean;
        private var _SafeStr_1467:Timer;
        private var _SafeStr_2334:Boolean;


        public function dispose():void
        {
            if (_landingView)
            {
                _landingView.communicationManager.removeHabboConnectionMessageEvent(new CommunityGoalProgressMessageEvent(onCommunityGoalProgress));
                _landingView = null;
            };
            if (_SafeStr_1467)
            {
                _SafeStr_1467.stop();
                _SafeStr_1467.removeEventListener("timer", onPollTimer);
                _SafeStr_1467 = null;
            };
            _window = null;
        }

        public function get disposed():Boolean
        {
            return (_landingView == null);
        }

        public function initialize(_arg_1:HabboLandingView, _arg_2:IWindow, _arg_3:Array, _arg_4:GenericWidget):void
        {
            _landingView = _arg_1;
            _window = IWindowContainer(_arg_2);
            var _local_7:int = _arg_3[1];
            var _local_6:int = _arg_3[2];
            var _local_8:int = _arg_3[3];
            _SafeStr_2333 = (_arg_3[4] == "true");
            var _local_5:IWidgetWindow = IWidgetWindow(_window.findChildByName("running_number_widget"));
            var _local_9:IRunningNumberWidget = IRunningNumberWidget(_local_5.widget);
            _local_9.digits = _local_7;
            _local_9.updateFrequency = _local_6;
            if (_SafeStr_2333)
            {
                _window.x = _arg_3[5];
                _window.y = _arg_3[6];
            };
            _landingView.communicationManager.addHabboConnectionMessageEvent(new CommunityGoalProgressMessageEvent(onCommunityGoalProgress));
            _SafeStr_1467 = new Timer(_local_8);
            _SafeStr_1467.addEventListener("timer", onPollTimer);
        }

        public function disable():void
        {
            _SafeStr_1467.stop();
        }

        public function refresh():void
        {
            _landingView.send(new _SafeStr_42());
            _SafeStr_2334 = false;
            _SafeStr_1467.start();
        }

        public function isFloating(_arg_1:Boolean):Boolean
        {
            return (_SafeStr_2333);
        }

        public function get layoutName():String
        {
            return ("element_community_goal_score");
        }

        private function onCommunityGoalProgress(_arg_1:CommunityGoalProgressMessageEvent):void
        {
            var _local_4:CommunityGoalData;
            var _local_2:IWidgetWindow;
            var _local_3:IRunningNumberWidget;
            if (_landingView)
            {
                _local_4 = _arg_1.getParser().data;
                _local_2 = IWidgetWindow(_window.findChildByName("running_number_widget"));
                _local_3 = IRunningNumberWidget(_local_2.widget);
                if (_SafeStr_2334)
                {
                    _local_3.number = _local_4.communityTotalScore;
                }
                else
                {
                    _local_3.initialNumber = _local_4.communityTotalScore;
                    _SafeStr_2334 = true;
                };
            };
        }

        private function onPollTimer(_arg_1:TimerEvent):void
        {
            _landingView.send(new _SafeStr_42());
        }


    }
}

