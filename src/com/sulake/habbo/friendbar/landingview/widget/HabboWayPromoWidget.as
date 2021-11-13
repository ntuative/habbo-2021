package com.sulake.habbo.friendbar.landingview.widget
{
    import com.sulake.habbo.friendbar.landingview.interfaces.ILandingViewWidget;
    import com.sulake.habbo.friendbar.landingview.HabboLandingView;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.communication.messages.incoming.quest.CommunityGoalProgressMessageEvent;
    import com.sulake.habbo.communication.messages.outgoing.quest._SafeStr_42;
    import com.sulake.core.window.events.WindowEvent;

    public class HabboWayPromoWidget implements ILandingViewWidget 
    {

        private var _landingView:HabboLandingView;
        private var _container:IWindowContainer;
        private var _SafeStr_2369:int;

        public function HabboWayPromoWidget(_arg_1:HabboLandingView)
        {
            _landingView = _arg_1;
        }

        public function get container():IWindow
        {
            return (_container);
        }

        public function dispose():void
        {
            _landingView = null;
            _container = null;
        }

        public function initialize():void
        {
            _container = IWindowContainer(_landingView.getXmlWindow("habbo_way_promo"));
            _container.findChildByName("go_button").procedure = onGoButton;
            _landingView.communicationManager.addHabboConnectionMessageEvent(new CommunityGoalProgressMessageEvent(onCommunityGoalProgress));
        }

        public function refresh():void
        {
            _landingView.send(new _SafeStr_42());
            refreshContent();
        }

        public function get disposed():Boolean
        {
            return (_landingView == null);
        }

        private function onGoButton(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                _landingView.habboHelp.showHabboWay();
            };
        }

        private function onCommunityGoalProgress(_arg_1:CommunityGoalProgressMessageEvent):void
        {
            _SafeStr_2369 = _arg_1.getParser().data.communityTotalScore;
            refreshContent();
        }

        private function refreshContent():void
        {
            var _local_1:String = ("" + _SafeStr_2369);
            while (_local_1.length < 8)
            {
                _local_1 = ("0" + _local_1);
            };
            _container.findChildByName("counter_txt").caption = _local_1;
        }


    }
}

