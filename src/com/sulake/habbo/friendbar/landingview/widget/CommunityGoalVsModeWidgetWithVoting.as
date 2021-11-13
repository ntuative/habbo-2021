package com.sulake.habbo.friendbar.landingview.widget
{
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.friendbar.landingview.HabboLandingView;
    import com.sulake.habbo.communication.messages.parser.landingview.votes.CommunityVoteReceivedEvent;
    import com.sulake.core.window.events.WindowEvent;

    public class CommunityGoalVsModeWidgetWithVoting extends CommunityGoalVsModeWidget 
    {

        private var _voteOptionOneButton:IWindow;
        private var _voteOptionTwoButton:IWindow;
        private var _voteOption:String;

        public function CommunityGoalVsModeWidgetWithVoting(_arg_1:HabboLandingView)
        {
            super(_arg_1, true);
        }

        override public function initialize():void
        {
            super.initialize();
            _voteOptionOneButton = _SafeStr_2356.findChildByName("community_vote_one_button");
            _voteOptionOneButton.procedure = onVoteOptionOneClick;
            _voteOptionTwoButton = _SafeStr_2356.findChildByName("community_vote_two_button");
            _voteOptionTwoButton.procedure = onVoteOptionTwoClick;
            _landingView.communicationManager.addHabboConnectionMessageEvent(new CommunityVoteReceivedEvent(onInfo));
        }

        override public function refresh():void
        {
            super.refresh();
            if (communityProgress != null)
            {
                if (_voteOptionOneButton != null)
                {
                    _voteOptionOneButton.visible = (communityProgress.personalContributionScore == 0);
                };
                if (_voteOptionTwoButton != null)
                {
                    _voteOptionTwoButton.visible = (communityProgress.personalContributionScore == 0);
                };
            };
        }

        private function onVoteOptionOneClick(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                hideVoteButtons();
                _landingView.communityGoalVote(1);
                _landingView.tracking.trackGoogle("landingView", "click_voteoption_one");
            };
        }

        private function onVoteOptionTwoClick(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                hideVoteButtons();
                _landingView.communityGoalVote(2);
                _landingView.tracking.trackGoogle("landingView", "click_voteoption_two");
            };
        }

        private function onInfo(_arg_1:CommunityVoteReceivedEvent):void
        {
            if (_arg_1.getParser().acknowledged)
            {
                hideVoteButtons();
            };
        }

        private function hideVoteButtons():void
        {
            _voteOptionOneButton.visible = false;
            _voteOptionTwoButton.visible = false;
        }


    }
}

