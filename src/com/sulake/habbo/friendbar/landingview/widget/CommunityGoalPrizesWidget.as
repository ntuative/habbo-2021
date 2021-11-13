package com.sulake.habbo.friendbar.landingview.widget
{
    import com.sulake.habbo.friendbar.landingview.interfaces.ILandingViewWidget;
    import com.sulake.habbo.friendbar.landingview.interfaces.ISettingsAwareWidget;
    import com.sulake.habbo.friendbar.landingview.HabboLandingView;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.communication.messages.incoming.quest.CommunityGoalData;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.communication.messages.incoming.quest.CommunityGoalProgressMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.UserObjectEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.UserChangeMessageEvent;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.habbo.window.widgets.IAvatarImageWidget;
    import com.sulake.habbo.friendbar.landingview.layout.WidgetContainerLayout;
    import com.sulake.habbo.friendbar.landingview.layout.CommonWidgetSettings;
    import com.sulake.habbo.friendbar.landingview.*;

    public class CommunityGoalPrizesWidget implements ILandingViewWidget, ISettingsAwareWidget 
    {

        private var _landingView:HabboLandingView;
        private var _container:IWindowContainer;
        private var _SafeStr_690:CommunityGoalData;
        private var _SafeStr_1382:String;

        public function CommunityGoalPrizesWidget(_arg_1:HabboLandingView)
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
            _SafeStr_690 = null;
        }

        public function initialize():void
        {
            _container = IWindowContainer(_landingView.getXmlWindow("achievement_competition_prizes"));
            _landingView.communicationManager.addHabboConnectionMessageEvent(new CommunityGoalProgressMessageEvent(onCommunityGoalProgress));
            _landingView.communicationManager.addHabboConnectionMessageEvent(new UserObjectEvent(onUserObject));
            _landingView.communicationManager.addHabboConnectionMessageEvent(new UserChangeMessageEvent(onUserChange));
        }

        public function refresh():void
        {
            refreshContent();
        }

        public function get disposed():Boolean
        {
            return (_landingView == null);
        }

        private function refreshContent():void
        {
            if (_SafeStr_690 == null)
            {
                _container.visible = false;
                return;
            };
            _container.visible = true;
            setPrizeRankLimits(1);
            setPrizeRankLimits(2);
            setPrizeRankLimits(3);
            _landingView.localizationManager.registerParameter(getCompetitionSpecificKey("yourrankinfo"), "points", ("" + _SafeStr_690.personalContributionScore));
            _container.findChildByName("caption_txt").caption = getCompetitionSpecificText("caption");
            _container.findChildByName("info_txt").caption = getCompetitionSpecificText("info");
            _container.findChildByName("reward_name_txt").caption = getCompetitionSpecificText("rewardname");
            _container.findChildByName("reward_info_txt").caption = getCompetitionSpecificText("rewardinfo");
            _container.findChildByName("rank_1_txt").caption = getCompetitionSpecificText("rank1");
            _container.findChildByName("rank_2_txt").caption = getCompetitionSpecificText("rank2");
            _container.findChildByName("rank_3_txt").caption = getCompetitionSpecificText("rank3");
            _container.findChildByName("user_rank_border").visible = ((!(_SafeStr_690.hasGoalExpired)) || (_SafeStr_690.personalContributionRank > 0));
            var _local_1:String = ((_SafeStr_690.hasGoalExpired) ? "yourfinalrank" : ((_SafeStr_690.personalContributionRank > 0) ? "yourrank" : "youarenotranked"));
            _landingView.localizationManager.registerParameter(getKey(_local_1), "rank", ("" + _SafeStr_690.personalContributionRank));
            _container.findChildByName("user_rank_txt").caption = getText(_local_1);
            _container.findChildByName("user_rank_info_txt").visible = (!(_SafeStr_690.hasGoalExpired));
            _container.findChildByName("user_rank_info_txt").caption = getCompetitionSpecificText(((_SafeStr_690.personalContributionRank > 0) ? "yourrankinfo" : "youarenotrankedinfo"));
            IStaticBitmapWrapperWindow(_container.findChildByName("reward_image")).assetUri = (("${image.library.url}reception/" + _SafeStr_690.goalCode) + "Reward.png");
        }

        private function setPrizeRankLimits(_arg_1:int):void
        {
            var _local_3:int = resolveStartRank(_arg_1);
            var _local_2:int = resolveEndRank(_arg_1);
            var _local_4:String = ((_local_3 == _local_2) ? getKey("rank") : getKey("ranks"));
            _landingView.localizationManager.registerParameter(_local_4, "start", ("" + _local_3));
            _landingView.localizationManager.registerParameter(_local_4, "end", ("" + _local_2));
            _container.findChildByName((("rank_" + _arg_1) + "_info_txt")).caption = (("${" + _local_4) + "}");
        }

        private function resolveStartRank(_arg_1:int):int
        {
            var _local_2:int = _SafeStr_690.rewardUserLimits[(_arg_1 - 2)];
            return (_local_2 + 1);
        }

        private function resolveEndRank(_arg_1:int):int
        {
            return (_SafeStr_690.rewardUserLimits[(_arg_1 - 1)]);
        }

        private function onCommunityGoalProgress(_arg_1:CommunityGoalProgressMessageEvent):void
        {
            _SafeStr_690 = _arg_1.getParser().data;
            refreshContent();
        }

        private function getKey(_arg_1:String):String
        {
            return ("landing.view.competition.prizes." + _arg_1);
        }

        private function getCompetitionSpecificKey(_arg_1:String):String
        {
            return (getKey(((_SafeStr_690.goalCode + ".") + _arg_1)));
        }

        private function getCompetitionSpecificText(_arg_1:String):String
        {
            var _local_2:String = getCompetitionSpecificKey(_arg_1);
            return (("${" + _local_2) + "}");
        }

        private function getText(_arg_1:String):String
        {
            var _local_2:String = getKey(_arg_1);
            return (("${" + _local_2) + "}");
        }

        private function onUserObject(_arg_1:UserObjectEvent):void
        {
            _SafeStr_1382 = _arg_1.getParser().figure;
            refreshAvatarInfo();
        }

        private function onUserChange(_arg_1:UserChangeMessageEvent):void
        {
            if (((!(_arg_1 == null)) && (_arg_1.id == -1)))
            {
                _SafeStr_1382 = _arg_1.figure;
                refreshAvatarInfo();
            };
        }

        private function refreshAvatarInfo():void
        {
            var _local_1:IWidgetWindow = IWidgetWindow(_container.findChildByName("avatar_image"));
            var _local_2:IAvatarImageWidget = IAvatarImageWidget(_local_1.widget);
            _local_2.figure = _SafeStr_1382;
        }

        public function set settings(_arg_1:CommonWidgetSettings):void
        {
            WidgetContainerLayout.applyCommonWidgetSettings(_container, _arg_1);
        }


    }
}

