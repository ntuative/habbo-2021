package com.sulake.habbo.quest
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.communication.messages.parser.competition.CompetitionEntrySubmitResultMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.quest.QuestCancelledMessageEvent;
    import com.sulake.habbo.communication.messages.parser.game.lobby.AchievementResolutionCompletedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.notifications.HabboAchievementNotificationMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.notifications.ActivityPointsMessageEvent;
    import com.sulake.habbo.communication.messages.parser.game.lobby.AchievementResolutionsMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.achievements.AchievementEvent;
    import com.sulake.habbo.communication.messages.incoming.quest.SeasonalQuestsMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.quest.QuestCompletedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.achievements.AchievementsScoreEvent;
    import com.sulake.habbo.communication.messages.incoming.notifications.HabboActivityPointNotificationMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.IsFirstLoginOfDayEvent;
    import com.sulake.habbo.communication.messages.parser.competition.CompetitionVotingInfoMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.RoomEntryInfoMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.session.CloseConnectionMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.users.ScrSendUserInfoEvent;
    import com.sulake.habbo.communication.messages.incoming.quest.QuestMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectAddMessageEvent;
    import com.sulake.habbo.communication.messages.parser.game.lobby.AchievementResolutionProgressMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.quest.QuestsMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectRemoveMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.achievements.AchievementsEvent;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.RoomSettingsSavedEvent;
    import com.sulake.habbo.communication.messages.parser.quest.QuestCompletedMessageParser;
    import com.sulake.habbo.quest.events.QuestCompletedEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.quest.QuestsMessageParser;
    import com.sulake.habbo.quest.events.QuestsListEvent;
    import com.sulake.habbo.communication.messages.parser.quest.SeasonalQuestsMessageParser;
    import com.sulake.habbo.communication.messages.parser.quest.QuestMessageParser;
    import com.sulake.habbo.communication.messages.parser.inventory.achievements.AchievementsMessageParser;
    import com.sulake.habbo.communication.messages.parser.game.lobby.AchievementResolutionsMessageParser;
    import com.sulake.habbo.communication.messages.parser.game.lobby.AchievementResolutionProgressMessageParser;
    import com.sulake.habbo.communication.messages.parser.game.lobby.AchievementResolutionCompletedMessageParser;
    import com.sulake.habbo.communication.messages.parser.inventory.achievements.AchievementMessageParser;
    import com.sulake.habbo.communication.messages.parser.inventory.achievements.AchievementsScoreMessageParser;
    import com.sulake.habbo.communication.messages.parser.notifications.HabboAchievementNotificationMessageParser;
    import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
    import com.sulake.habbo.communication.messages.parser.handshake.IsFirstLoginOfDayParser;
    import flash.utils.Dictionary;
    import com.sulake.habbo.catalog.purse._SafeStr_139;

        public class IncomingMessages implements IDisposable
    {

        private var _questEngine:HabboQuestEngine;
        private var _SafeStr_3124:IAlertDialog;
        private var _disposed:Boolean = false;

        public function IncomingMessages(_arg_1:HabboQuestEngine)
        {
            _questEngine = _arg_1;
            var _local_2:IHabboCommunicationManager = _questEngine.communication;
            _local_2.addHabboConnectionMessageEvent(new CompetitionEntrySubmitResultMessageEvent(onCompetitionEntrySubmitResult));
            _local_2.addHabboConnectionMessageEvent(new QuestCancelledMessageEvent(onQuestCancelled));
            _local_2.addHabboConnectionMessageEvent(new AchievementResolutionCompletedMessageEvent(onAchievementResolutionCompleted));
            _local_2.addHabboConnectionMessageEvent(new HabboAchievementNotificationMessageEvent(onLevelUp));
            _local_2.addHabboConnectionMessageEvent(new ActivityPointsMessageEvent(onActivityPoints));
            _local_2.addHabboConnectionMessageEvent(new AchievementResolutionsMessageEvent(onAchievementResolutions));
            _local_2.addHabboConnectionMessageEvent(new AchievementEvent(onAchievement));
            _local_2.addHabboConnectionMessageEvent(new SeasonalQuestsMessageEvent(onSeasonalQuests));
            _local_2.addHabboConnectionMessageEvent(new QuestCompletedMessageEvent(onQuestCompleted));
            _local_2.addHabboConnectionMessageEvent(new AchievementsScoreEvent(onAchievementsScore));
            _local_2.addHabboConnectionMessageEvent(new HabboActivityPointNotificationMessageEvent(onActivityPointsNotification));
            _local_2.addHabboConnectionMessageEvent(new IsFirstLoginOfDayEvent(onIsFirstLoginOfDay));
            _local_2.addHabboConnectionMessageEvent(new CompetitionVotingInfoMessageEvent(onCompetitionVotingInfo));
            _local_2.addHabboConnectionMessageEvent(new RoomEntryInfoMessageEvent(onRoomEnter));
            _local_2.addHabboConnectionMessageEvent(new CloseConnectionMessageEvent(onRoomExit));
            _local_2.addHabboConnectionMessageEvent(new ScrSendUserInfoEvent(onSubscriptionUserInfoEvent));
            _local_2.addHabboConnectionMessageEvent(new QuestMessageEvent(onQuest));
            _local_2.addHabboConnectionMessageEvent(new ObjectAddMessageEvent(onFurnisChanged));
            _local_2.addHabboConnectionMessageEvent(new AchievementResolutionProgressMessageEvent(onAchievementResolutionProgress));
            _local_2.addHabboConnectionMessageEvent(new QuestsMessageEvent(onQuests));
            _local_2.addHabboConnectionMessageEvent(new ObjectRemoveMessageEvent(onFurnisChanged));
            _local_2.addHabboConnectionMessageEvent(new AchievementsEvent(onAchievements));
            _local_2.addHabboConnectionMessageEvent(new RoomSettingsSavedEvent(onRoomSettingsSaved));
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        private function onQuestCompleted(_arg_1:IMessageEvent):void
        {
            var _local_2:QuestCompletedMessageParser = (_arg_1 as QuestCompletedMessageEvent).getParser();
            Logger.log(((("Quest Completed: " + _local_2.questData.campaignCode) + " quest: ") + _local_2.questData.id));
            _questEngine.questController.onQuestCompleted(_local_2.questData, _local_2.showDialog);
            if (_questEngine.isSeasonalQuest(_local_2.questData))
            {
                _questEngine.events.dispatchEvent(new QuestCompletedEvent("qce_seasonal", _local_2.questData));
            };
        }

        private function onQuestCancelled(_arg_1:IMessageEvent):void
        {
            Logger.log("Quest Cancelled: ");
            _questEngine.questController.onQuestCancelled();
            if (QuestCancelledMessageEvent(_arg_1).getParser().expired)
            {
                _questEngine.windowManager.alert("${quests.expired.title}", "${quests.expired.body}", 0, null);
            };
        }

        private function onQuests(_arg_1:IMessageEvent):void
        {
            var _local_2:QuestsMessageParser = (_arg_1 as QuestsMessageEvent).getParser();
            Logger.log(((("Got Quests: " + _local_2.quests) + ", ") + _local_2.openWindow));
            _questEngine.events.dispatchEvent(new QuestsListEvent("qu_quests", _local_2.quests, _local_2.openWindow));
        }

        private function onSeasonalQuests(_arg_1:IMessageEvent):void
        {
            var _local_2:SeasonalQuestsMessageParser = (_arg_1 as SeasonalQuestsMessageEvent).getParser();
            Logger.log(("Got seasonal Quests: " + _local_2.quests));
            _questEngine.events.dispatchEvent(new QuestsListEvent("qe_quests_seasonal", _local_2.quests, true));
        }

        private function onQuest(_arg_1:IMessageEvent):void
        {
            var _local_2:QuestMessageParser = (_arg_1 as QuestMessageEvent).getParser();
            Logger.log(("Got Quest: " + _local_2.quest));
            _questEngine.questController.onQuest(_local_2.quest);
        }

        public function dispose():void
        {
            if (_SafeStr_3124)
            {
                _SafeStr_3124.dispose();
                _SafeStr_3124 = null;
            };
            _disposed = true;
        }

        private function onRoomEnter(_arg_1:RoomEntryInfoMessageEvent):void
        {
            _questEngine.roomCompetitionController.onRoomEnter(_arg_1);
            _questEngine.currentlyInRoom = true;
        }

        private function onRoomExit(_arg_1:IMessageEvent):void
        {
            _questEngine.questController.onRoomExit();
            _questEngine.achievementController.onRoomExit();
            _questEngine.roomCompetitionController.onRoomExit();
            _questEngine.currentlyInRoom = false;
        }

        private function onFurnisChanged(_arg_1:IMessageEvent):void
        {
            _questEngine.roomCompetitionController.onContextChanged();
        }

        private function onRoomSettingsSaved(_arg_1:IMessageEvent):void
        {
            _questEngine.roomCompetitionController.onContextChanged();
        }

        private function onAchievements(_arg_1:IMessageEvent):void
        {
            var _local_2:AchievementsEvent = (_arg_1 as AchievementsEvent);
            var _local_3:AchievementsMessageParser = (_local_2.getParser() as AchievementsMessageParser);
            _questEngine.achievementController.onAchievements(_local_3.achievements, _local_3.defaultCategory);
        }

        private function onAchievementResolutions(_arg_1:AchievementResolutionsMessageEvent):void
        {
            var _local_2:AchievementResolutionsMessageParser = _arg_1.getParser();
            _questEngine.achievementsResolutionController.onResolutionAchievements(_local_2.stuffId, _local_2.achievements, _local_2.endTime);
        }

        private function onAchievementResolutionProgress(_arg_1:AchievementResolutionProgressMessageEvent):void
        {
            var _local_2:AchievementResolutionProgressMessageParser = _arg_1.getParser();
            _questEngine.achievementsResolutionController.onResolutionProgress(_local_2.stuffId, _local_2.achievementId, _local_2.requiredLevelBadgeCode, _local_2.userProgress, _local_2.totalProgress, _local_2.endTime);
        }

        private function onAchievementResolutionCompleted(_arg_1:AchievementResolutionCompletedMessageEvent):void
        {
            var _local_2:AchievementResolutionCompletedMessageParser = _arg_1.getParser();
            _questEngine.achievementsResolutionController.onResolutionCompleted(_local_2.badgeCode, _local_2.stuffCode);
        }

        private function onAchievement(_arg_1:IMessageEvent):void
        {
            var _local_2:AchievementEvent = (_arg_1 as AchievementEvent);
            var _local_3:AchievementMessageParser = (_local_2.getParser() as AchievementMessageParser);
            _questEngine.achievementController.onAchievement(_local_3.achievement);
            _questEngine.achievementsResolutionController.onAchievement(_local_3.achievement);
        }

        private function onAchievementsScore(_arg_1:IMessageEvent):void
        {
            var _local_2:AchievementsScoreEvent = (_arg_1 as AchievementsScoreEvent);
            var _local_3:AchievementsScoreMessageParser = (_local_2.getParser() as AchievementsScoreMessageParser);
            _questEngine.localization.registerParameter("achievements.categories.score", "score", _local_3.score.toString());
        }

        private function onLevelUp(_arg_1:IMessageEvent):void
        {
            var _local_2:HabboAchievementNotificationMessageEvent = (_arg_1 as HabboAchievementNotificationMessageEvent);
            var _local_3:HabboAchievementNotificationMessageParser = _local_2.getParser();
            var _local_4:String = _questEngine.localization.getBadgeBaseName(_local_3.data.badgeCode);
            _questEngine.send(new EventLogMessageComposer("Achievements", _local_4, "Leveled", "", _local_3.data.level));
            _questEngine.achievementsResolutionController.onLevelUp(_local_3.data);
        }

        private function onIsFirstLoginOfDay(_arg_1:IMessageEvent):void
        {
            var _local_2:IsFirstLoginOfDayParser = (_arg_1 as IsFirstLoginOfDayEvent).getParser();
            _questEngine.setIsFirstLoginOfDay(_local_2.isFirstLoginOfDay);
        }

        private function onCompetitionEntrySubmitResult(_arg_1:CompetitionEntrySubmitResultMessageEvent):void
        {
            _questEngine.roomCompetitionController.onCompetitionEntrySubmitResult(_arg_1);
        }

        private function onCompetitionVotingInfo(_arg_1:CompetitionVotingInfoMessageEvent):void
        {
            _questEngine.roomCompetitionController.onCompetitionVotingInfo(_arg_1);
        }

        private function onSubscriptionUserInfoEvent(_arg_1:ScrSendUserInfoEvent):void
        {
            if (((_arg_1.getParser().isVIP) && (_arg_1.getParser().responseType == 2)))
            {
                _questEngine.roomCompetitionController.sendRoomCompetitionInit();
            };
        }

        private function onActivityPoints(_arg_1:IMessageEvent):void
        {
            var _local_3:Dictionary = ActivityPointsMessageEvent(_arg_1).points;
            for each (var _local_4:int in _SafeStr_139.values())
            {
                _questEngine.questController.onActivityPoints(_local_4, 0);
            };
            for (var _local_2:Object in _local_3)
            {
                _questEngine.questController.onActivityPoints(int(_local_2), _local_3[_local_2]);
            };
        }

        private function onActivityPointsNotification(_arg_1:HabboActivityPointNotificationMessageEvent):void
        {
            _questEngine.questController.onActivityPoints(_arg_1.type, _arg_1.amount);
        }


    }
}