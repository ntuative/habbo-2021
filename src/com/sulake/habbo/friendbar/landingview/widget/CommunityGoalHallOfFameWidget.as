package com.sulake.habbo.friendbar.landingview.widget
{
    import com.sulake.habbo.communication.messages.incoming.quest.CommunityGoalHallOfFame;
    import com.sulake.habbo.friendbar.landingview.HabboLandingView;
    import com.sulake.habbo.communication.messages.incoming.quest.CommunityGoalHallOfFameMessageEvent;
    import com.sulake.habbo.communication.messages.parser.competition.CurrentTimingCodeMessageEvent;
    import com.sulake.habbo.communication.messages.outgoing.competition.GetCurrentTimingCodeMessageComposer;
    import com.sulake.habbo.communication.messages.incoming.quest.HallOfFameEntryData;
    import com.sulake.habbo.communication.messages.incoming.quest.ILandingPageUserEntry;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.communication.messages.outgoing.competition.ForwardToACompetitionRoomMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.quest.GetCommunityGoalHallOfFameMessageComposer;
    import com.sulake.habbo.friendbar.landingview.*;

    public class CommunityGoalHallOfFameWidget extends UserListWidget 
    {

        private var _SafeStr_690:CommunityGoalHallOfFame;
        private var _SafeStr_2327:String;

        public function CommunityGoalHallOfFameWidget(_arg_1:HabboLandingView)
        {
            super(_arg_1);
        }

        override public function initialize():void
        {
            super.initialize();
            _SafeStr_2327 = landingView.getProperty("landing.view.dynamic.slot.6.conf");
        }

        override protected function registerMessageListeners():void
        {
            landingView.communicationManager.addHabboConnectionMessageEvent(new CommunityGoalHallOfFameMessageEvent(onCommunityGoalHallOfFame));
            landingView.communicationManager.addHabboConnectionMessageEvent(new CurrentTimingCodeMessageEvent(onTimingCode));
        }

        override public function refresh():void
        {
            landingView.send(new GetCurrentTimingCodeMessageComposer(_SafeStr_2327));
        }

        override protected function get users():Array
        {
            return ((_SafeStr_690 == null) ? null : _SafeStr_690.hof);
        }

        override protected function refreshPopup(_arg_1:ILandingPageUserEntry, _arg_2:IWindowContainer):void
        {
            var _local_4:HallOfFameEntryData = HallOfFameEntryData(_arg_1);
            _arg_2.findChildByName("user_name_txt").caption = _local_4.userName;
            var _local_3:String = "landing.view.competition.hof.points";
            landingView.localizationManager.registerParameter(_local_3, "points", ("" + _local_4.currentScore));
            _arg_2.findChildByName("score_txt").caption = getText(_local_3);
            _arg_2.findChildByName("rank_desc_txt").caption = getText((("landing.view.competition.hof." + _SafeStr_690.goalCode) + ".rankdesc.leader"));
        }

        override protected function getPopupXml():String
        {
            return ("competition_user_popup");
        }

        private function onCommunityGoalHallOfFame(_arg_1:CommunityGoalHallOfFameMessageEvent):void
        {
            _SafeStr_690 = _arg_1.getParser().data;
            refreshContent();
        }

        override protected function hasExtraLink():Boolean
        {
            return (landingView.getBoolean("landing.view.communitygoalhof.hasroomlink"));
        }

        override protected function extraLinkClicked(_arg_1:ILandingPageUserEntry):void
        {
            landingView.send(new ForwardToACompetitionRoomMessageComposer(_SafeStr_690.goalCode, _arg_1.userId));
        }

        private function onTimingCode(_arg_1:CurrentTimingCodeMessageEvent):void
        {
            var _local_2:String = _arg_1.getParser().code;
            if ((((_arg_1.getParser().schedulingStr == _SafeStr_2327) && (!(_local_2 == ""))) && (!(disposed))))
            {
                loadConfigurationOverrides(_local_2);
                landingView.send(new GetCommunityGoalHallOfFameMessageComposer(_arg_1.getParser().code));
            };
        }

        private function loadConfigurationOverrides(_arg_1:String):void
        {
            var _local_4:Array;
            var _local_3:int;
            var _local_6:String = (("landing.view." + _arg_1) + ".avatarlist.yoffsets.array");
            if (landingView.propertyExists(_local_6))
            {
                _local_4 = landingView.getProperty(_local_6).split(",");
                _local_3 = 0;
                while (_local_3 < _local_4.length)
                {
                    _local_4[_local_3] = parseInt(_local_4[_local_3]);
                    _local_3++;
                };
                avatarOffsetsY = _local_4;
            };
            var _local_5:String = (("landing.view." + _arg_1) + ".avatarlist.widths.array");
            if (landingView.propertyExists(_local_5))
            {
                _local_4 = landingView.getProperty(_local_5).split(",");
                _local_3 = 0;
                while (_local_3 < _local_4.length)
                {
                    _local_4[_local_3] = parseInt(_local_4[_local_3]);
                    _local_3++;
                };
                avatarContainerWidths = _local_4;
            };
            var _local_2:String = (("landing.view." + _arg_1) + ".avatarlist.startoffset");
            if (landingView.propertyExists(_local_2))
            {
                startOffset = parseInt(landingView.getProperty(_local_2));
            };
        }


    }
}

