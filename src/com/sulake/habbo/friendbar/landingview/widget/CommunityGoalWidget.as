package com.sulake.habbo.friendbar.landingview.widget
{
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.habbo.friendbar.landingview.interfaces.ILandingViewWidget;
    import com.sulake.habbo.friendbar.landingview.interfaces.ISettingsAwareWidget;
    import com.sulake.habbo.friendbar.landingview.HabboLandingView;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
    import com.sulake.habbo.communication.messages.incoming.quest.CommunityGoalData;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.runtime.Component;
    import com.sulake.habbo.communication.messages.incoming.quest.CommunityGoalProgressMessageEvent;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.habbo.communication.messages.outgoing.quest._SafeStr_42;
    import com.sulake.habbo.communication.messages.parser.quest.CommunityGoalProgressMessageParser;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.friendbar.landingview.layout.WidgetContainerLayout;
    import com.sulake.habbo.friendbar.landingview.layout.CommonWidgetSettings;
    import com.sulake.habbo.friendbar.landingview.*;

    public class CommunityGoalWidget implements IUpdateReceiver, ILandingViewWidget, ISettingsAwareWidget 
    {

        private static const CHALLENGE_LEVEL_NEEDLE_BASE_FRAMES:Array = [0, 8, 16, 23];
        private static const METER_INITIAL_DELAY_MS:int = 1500;
        private static const METER_BUILDUP_TIME_MS:int = 1000;

        protected var _landingView:HabboLandingView;
        protected var _SafeStr_2356:IWindowContainer;
        private var _SafeStr_2357:IStaticBitmapWrapperWindow;
        protected var _SafeStr_2358:CommunityGoalData;
        private var _SafeStr_2359:Boolean = false;
        private var _SafeStr_2360:Number = 0;
        private var _SafeStr_2361:Number = 0;
        private var _SafeStr_573:Boolean = false;
        private var _SafeStr_2362:Boolean = true;
        private var _SafeStr_2363:Boolean = false;

        public function CommunityGoalWidget(_arg_1:HabboLandingView, _arg_2:Boolean=false)
        {
            _landingView = _arg_1;
            _SafeStr_2363 = _arg_2;
        }

        public function get container():IWindow
        {
            return (_SafeStr_2356);
        }

        public function dispose():void
        {
            if (((!(_landingView == null)) && (_landingView.windowManager)))
            {
                Component(_landingView.windowManager).removeUpdateReceiver(this);
            };
            _landingView = null;
            _SafeStr_2356 = null;
            _SafeStr_2358 = null;
        }

        public function get disposed():Boolean
        {
            return (_landingView == null);
        }

        public function initialize():void
        {
            var _local_1:IWindow;
            _landingView.communicationManager.addHabboConnectionMessageEvent(new CommunityGoalProgressMessageEvent(onCommunityGoalProgress));
            _SafeStr_2356 = IWindowContainer(((_SafeStr_2363) ? _landingView.getXmlWindow("community_goal_voting") : _landingView.getXmlWindow("community_goal")));
            _SafeStr_2357 = IStaticBitmapWrapperWindow(_SafeStr_2356.findChildByName("meter_needle"));
            if (!_SafeStr_2363)
            {
                _local_1 = _SafeStr_2356.findChildByName("community_catalog_button");
                _SafeStr_2362 = _landingView.getBoolean("landing.view.community.interactive");
                _local_1.visible = _SafeStr_2362;
                _local_1.procedure = onCommunityCatalogButtonClick;
            };
            HabboLandingView.positionAfterAndStretch(_SafeStr_2356, "community_title", "hdr_line");
        }

        private function campaignizeMeterElementAssetUri(_arg_1:IWindow):void
        {
            var _local_3:IStaticBitmapWrapperWindow = IStaticBitmapWrapperWindow(_arg_1);
            var _local_2:int = _local_3.assetUri.indexOf(".png");
            _local_3.assetUri = (((_local_3.assetUri.substr(0, _local_2) + "_") + _SafeStr_2358.goalCode) + ".png");
        }

        protected function setCampaignLocalization(_arg_1:String, _arg_2:String):void
        {
            var _local_3:IWindow = _SafeStr_2356.findChildByName(_arg_1);
            if (_local_3 != null)
            {
                _local_3.caption = (((("${" + _arg_2) + ".") + _SafeStr_2358.goalCode) + "}");
            };
        }

        protected function getCurrentNeedleFrame():int
        {
            if (_SafeStr_2358.communityHighestAchievedLevel >= (CHALLENGE_LEVEL_NEEDLE_BASE_FRAMES.length - 1))
            {
                return (CHALLENGE_LEVEL_NEEDLE_BASE_FRAMES[(CHALLENGE_LEVEL_NEEDLE_BASE_FRAMES.length - 1)]);
            };
            var _local_1:int = CHALLENGE_LEVEL_NEEDLE_BASE_FRAMES[_SafeStr_2358.communityHighestAchievedLevel];
            var _local_2:int = (CHALLENGE_LEVEL_NEEDLE_BASE_FRAMES[(_SafeStr_2358.communityHighestAchievedLevel + 1)] - _local_1);
            return (_local_1 + Math.floor(((_SafeStr_2358.percentCompletionTowardsNextLevel * (_local_2 + 0.001)) / 100)));
        }

        private function initializeLocalizations():void
        {
            var _local_1:int;
            if (((!(_SafeStr_2358 == null)) && (!(_SafeStr_2358.goalCode == null))))
            {
                _local_1 = 0;
                while (_local_1 < CHALLENGE_LEVEL_NEEDLE_BASE_FRAMES.length)
                {
                    campaignizeMeterElementAssetUri(_SafeStr_2356.findChildByName(("meter_level_" + _local_1)));
                    if (_local_1 > 0)
                    {
                        campaignizeMeterElementAssetUri(_SafeStr_2356.findChildByName((("meter_level_" + _local_1) + "_icon")));
                        campaignizeMeterElementAssetUri(_SafeStr_2356.findChildByName((("meter_level_" + _local_1) + "_icon_locked")));
                    };
                    _local_1++;
                };
                setCampaignLocalization("community_title", "landing.view.community.headline");
                setCampaignLocalization("goal_caption", "landing.view.community.caption");
                setCampaignLocalization("goal_info", "landing.view.community.info");
                setCampaignLocalization("community_catalog_button", "landing.view.community_catalog_button.text");
                _SafeStr_573 = true;
            };
        }

        private function refreshContent():void
        {
            var _local_3:int;
            if (_SafeStr_2358 == null)
            {
                _SafeStr_2356.visible = false;
                return;
            };
            if (!_SafeStr_573)
            {
                initializeLocalizations();
            };
            _local_3 = 1;
            while (_local_3 < CHALLENGE_LEVEL_NEEDLE_BASE_FRAMES.length)
            {
                _SafeStr_2356.findChildByName(("meter_level_" + _local_3)).visible = false;
                _SafeStr_2356.findChildByName((("meter_level_" + _local_3) + "_icon")).visible = false;
                _SafeStr_2356.findChildByName((("meter_level_" + _local_3) + "_icon_locked")).visible = false;
                _local_3++;
            };
            var _local_2:String = "landing.view.community.meter";
            _landingView.localizationManager.registerParameter(_local_2, "userRank", _SafeStr_2358.personalContributionRank.toString());
            _landingView.localizationManager.registerParameter(_local_2, "userAmount", _SafeStr_2358.personalContributionScore.toString());
            _landingView.localizationManager.registerParameter(_local_2, "totalAmount", _SafeStr_2358.communityTotalScore.toString());
            if (((!(_SafeStr_2358 == null)) && (!(_SafeStr_2358.goalCode == null))))
            {
                _landingView.localizationManager.registerParameter(("landing.view.community.meter." + _SafeStr_2358.goalCode), "totalAmount", _SafeStr_2358.communityTotalScore.toString());
                setCampaignLocalization("community_total_status", "landing.view.community.meter");
                if (_SafeStr_2363)
                {
                    setCampaignLocalization("community_vote_one_button", "landing.view.vote_one_button.text");
                    setCampaignLocalization("community_vote_two_button", "landing.view.vote_two_button.text");
                };
            };
            var _local_1:ITextWindow = ITextWindow(_SafeStr_2356.findChildByName("goal_info"));
            _local_1.height = (_local_1.textHeight + 6);
            if (!_SafeStr_2363)
            {
                _SafeStr_2356.findChildByName("community_catalog_button").visible = _SafeStr_2362;
            };
            _SafeStr_2356.visible = true;
            _SafeStr_2356.invalidate();
        }

        protected function updateMeter(_arg_1:int, _arg_2:Boolean=true):void
        {
            var _local_3:int;
            var _local_4:Boolean;
            _local_3 = 1;
            while (_local_3 < CHALLENGE_LEVEL_NEEDLE_BASE_FRAMES.length)
            {
                _local_4 = ((_arg_2) && (_arg_1 >= CHALLENGE_LEVEL_NEEDLE_BASE_FRAMES[_local_3]));
                _SafeStr_2356.findChildByName(("meter_level_" + _local_3)).visible = _local_4;
                _SafeStr_2356.findChildByName((("meter_level_" + _local_3) + "_icon")).visible = _local_4;
                _SafeStr_2356.findChildByName((("meter_level_" + _local_3) + "_icon_locked")).visible = (!(_local_4));
                _local_3++;
            };
            _SafeStr_2357.assetUri = ("landing_view_needle_meter_needle" + _arg_1);
        }

        public function refresh():void
        {
            requestCommunityGoalProgress();
            refreshContent();
        }

        private function requestCommunityGoalProgress():void
        {
            if (!_SafeStr_2359)
            {
                _landingView.send(new _SafeStr_42());
                _SafeStr_2359 = true;
            };
        }

        public function update(_arg_1:uint):void
        {
            _SafeStr_2360 = (_SafeStr_2360 + _arg_1);
            if (_SafeStr_2360 > 1500)
            {
                _SafeStr_2361 = (_SafeStr_2361 + (_arg_1 / 1000));
                if (_SafeStr_2361 > 1)
                {
                    _SafeStr_2361 = 1;
                    Component(_landingView.windowManager).removeUpdateReceiver(this);
                };
                updateMeter(Math.floor((getCurrentNeedleFrame() * _SafeStr_2361)));
            };
        }

        private function onCommunityGoalProgress(_arg_1:IMessageEvent):void
        {
            _SafeStr_2358 = CommunityGoalProgressMessageParser(_arg_1.parser).data;
            _SafeStr_2359 = false;
            refreshContent();
            Component(_landingView.windowManager).registerUpdateReceiver(this, 10);
        }

        private function onCommunityCatalogButtonClick(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:String;
            if (_arg_1.type == "WME_CLICK")
            {
                _local_3 = _landingView.getProperty("landing.view.community.catalog.target");
                _landingView.catalog.openCatalogPage(_local_3);
                _landingView.tracking.trackGoogle("landingView", "click_communityCatalogTarget");
            };
        }

        public function set settings(_arg_1:CommonWidgetSettings):void
        {
            WidgetContainerLayout.applyCommonWidgetSettings(_SafeStr_2356, _arg_1);
        }

        protected function get communityProgress():CommunityGoalData
        {
            return (_SafeStr_2358);
        }


    }
}

