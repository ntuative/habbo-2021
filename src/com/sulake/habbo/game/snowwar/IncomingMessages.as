package com.sulake.habbo.game.snowwar
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.communication.messages.parser.game.directory.Game2StopCounterMessageEvent;
    import com.sulake.habbo.communication.messages.parser.game.directory.Game2GameStartedMessageEvent;
    import com.sulake.habbo.communication.messages.parser.game.directory.Game2UserJoinedGameMessageEvent;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.arena.Game2GameRejoinMessageEvent;
    import com.sulake.habbo.communication.messages.parser.game.score.Game2WeeklyLeaderboardEvent;
    import com.sulake.habbo.communication.messages.parser.game.score.Game2TotalGroupLeaderboardEvent;
    import com.sulake.habbo.communication.messages.parser.game.directory.Game2GameCreatedMessageEvent;
    import com.sulake.habbo.communication.messages.parser.game.score.Game2WeeklyFriendsLeaderboardEvent;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.arena.Game2StageEndingMessageEvent;
    import com.sulake.habbo.communication.messages.parser.game.directory.Game2UserBlockedMessageEvent;
    import com.sulake.habbo.communication.messages.parser.game.score.Game2TotalLeaderboardEvent;
    import com.sulake.habbo.communication.messages.parser.game.score.Game2WeeklyGroupLeaderboardEvent;
    import com.sulake.habbo.communication.messages.parser.game.directory.Game2UserLeftGameMessageEvent;
    import com.sulake.habbo.communication.messages.parser.game.directory.Game2GameCancelledMessageEvent;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.ingame.Game2FullGameStatusMessageEvent;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.arena.Game2PlayerExitedGameArenaMessageEvent;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.ingame.Game2GameStatusMessageEvent;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.arena.Game2StageLoadMessageEvent;
    import com.sulake.habbo.communication.messages.parser.game.score.Game2FriendsLeaderboardEvent;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.arena.Game2GameEndingMessageEvent;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.arena.Game2PlayerRematchesMessageEvent;
    import com.sulake.habbo.communication.messages.parser.game.directory.Game2GameDirectoryStatusMessageEvent;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.arena.Game2StageRunningMessageEvent;
    import com.sulake.habbo.communication.messages.parser.game.directory.Game2AccountGameStatusMessageEvent;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.arena.Game2ArenaEnteredMessageEvent;
    import com.sulake.habbo.communication.messages.parser.game.directory.Game2GameLongDataMessageEvent;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.arena.Game2StageStartingMessageEvent;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.arena.Game2EnterArenaMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.RoomEntryInfoMessageEvent;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.arena.Game2StageStillLoadingMessageEvent;
    import com.sulake.habbo.communication.messages.parser.game.directory.Game2StartingGameFailedMessageEvent;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.arena.Game2GameChatFromPlayerMessageEvent;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.arena.Game2EnterArenaFailedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.users.ScrSendUserInfoEvent;
    import com.sulake.habbo.communication.messages.parser.game.directory.Game2InArenaQueueMessageEvent;
    import com.sulake.habbo.communication.messages.parser.game.directory.Game2StartCounterMessageEvent;
    import com.sulake.habbo.communication.messages.parser.game.directory.Game2JoiningGameFailedMessageEvent;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.arena.Game2EnterArenaMessageParser;
    import com.sulake.habbo.game.snowwar.arena.SynchronizedGameArena;
    import com.sulake.habbo.game.snowwar.arena.SynchronizedGameStage;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.arena.Game2EnterArenaFailedMessageParser;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.arena.Game2ArenaEnteredMessageParser;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.data.Game2PlayerData;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.arena.Game2StageLoadMessageParser;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.arena.Game2StageStillLoadingMessageParser;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.arena.Game2StageStartingMessageParser;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.data.GameObjectsData;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.arena.Game2StageRunningMessageParser;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.arena.Game2StageEndingMessageParser;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.arena.Game2GameEndingMessageParser;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.arena.Game2PlayerExitedGameArenaMessageParser;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.arena.Game2GameRejoinMessageParser;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.arena.Game2PlayerRematchesMessageParser;
    import com.sulake.habbo.communication.messages.parser.game.directory.Game2GameDirectoryStatusMessageParser;
    import com.sulake.habbo.communication.messages.parser.game.directory.Game2AccountGameStatusMessageParser;
    import com.sulake.habbo.communication.messages.parser.game.directory.Game2GameCreatedMessageParser;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.data.GameLobbyData;
    import com.sulake.habbo.communication.messages.parser.game.directory.Game2GameStartedMessageParser;
    import com.sulake.habbo.communication.messages.parser.game.directory.Game2StartCounterMessageParser;
    import com.sulake.habbo.communication.messages.parser.game.directory.Game2InArenaQueueMessageParser;
    import com.sulake.habbo.communication.messages.parser.game.directory.Game2UserJoinedGameMessageParser;
    import com.sulake.habbo.communication.messages.parser.game.directory.Game2UserLeftGameMessageParser;
    import com.sulake.habbo.communication.messages.parser.game.directory.Game2GameLongDataMessageParser;
    import com.sulake.habbo.communication.messages.parser.game.directory.Game2JoiningGameFailedMessageParser;
    import com.sulake.habbo.communication.messages.parser.game.directory.Game2UserBlockedMessageParser;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.data.GameStatusData;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.ingame.Game2FullGameStatusMessageParser;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.data.FullGameStatusData;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.ingame.Game2GameStatusMessageParser;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.data.object.HumanGameObjectData;
    import com.sulake.habbo.game.snowwar.gameobjects.HumanGameObject;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.data.object.SnowballGameObjectData;
    import com.sulake.habbo.game.snowwar.gameobjects.SnowBallGameObject;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.data.object.SnowballMachineGameObjectData;
    import com.sulake.habbo.game.snowwar.gameobjects.SnowballMachineGameObject;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.data.object.SnowballPileGameObjectData;
    import com.sulake.habbo.game.snowwar.gameobjects.SnowballPileGameObject;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.data.object.TreeGameObjectData;
    import com.sulake.habbo.game.snowwar.gameobjects.TreeGameObject;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.data.object.SnowWarGameObjectData;
    import com.sulake.habbo.game.snowwar.arena.ISynchronizedGameEvent;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.data.event.SnowWarGameEventData;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.data.event.CreateSnowballEventData;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.data.event.HumanGetsSnowballsFromMachineEventData;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.data.event.HumanStartsToMakeASnowballEventData;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.data.event.MachineCreatesSnowballEventData;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.data.event.NewMoveTargetEventData;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.data.event.HumanThrowsSnowballAtHumanEventData;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.data.event.HumanThrowsSnowballAtPositionEventData;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.data.event.HumanLeftGameEventData;
    import com.sulake.habbo.game.snowwar.gameobjects.SnowballGivingGameObject;
    import com.sulake.habbo.game.snowwar.events.HumanGetsSnowballsFromMachineEvent;
    import com.sulake.habbo.game.snowwar.events.MachineCreatesSnowballEvent;
    import com.sulake.habbo.game.snowwar.events.HumanThrowsSnowballAtPositionEvent;
    import com.sulake.habbo.game.snowwar.events.HumanThrowsSnowballAtHumanEvent;
    import com.sulake.habbo.game.snowwar.events.HumanStartsToMakeASnowballEvent;
    import com.sulake.habbo.game.snowwar.events.CreateSnowballEvent;
    import com.sulake.habbo.game.snowwar.events.NewMoveTargetEvent;
    import com.sulake.habbo.game.snowwar.events.HumanLeftGameEvent;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.arena.Game2GameChatFromPlayerMessageParser;
    import com.sulake.habbo.communication.messages.outgoing.game.directory.Game2GetAccountGameStatusMessageComposer;
    import com.sulake.habbo.communication.messages.parser.game.score.Game2LeaderboardParser;
    import com.sulake.habbo.communication.messages.parser.game.score.Game2GroupLeaderboardParser;
    import com.sulake.habbo.communication.messages.parser.game.score.Game2WeeklyGroupLeaderboardParser;
    import com.sulake.habbo.communication.messages.parser.game.score.Game2WeeklyLeaderboardParser;

        public class IncomingMessages implements IDisposable 
    {

        private var _SafeStr_458:SnowWarEngine;
        private var _disposed:Boolean = false;

        public function IncomingMessages(_arg_1:SnowWarEngine)
        {
            _SafeStr_458 = _arg_1;
            var _local_2:IHabboCommunicationManager = _SafeStr_458.communication;
            _local_2.addHabboConnectionMessageEvent(new Game2StopCounterMessageEvent(onLobbyCounterStop));
            _local_2.addHabboConnectionMessageEvent(new Game2GameStartedMessageEvent(onGameStarted));
            _local_2.addHabboConnectionMessageEvent(new Game2UserJoinedGameMessageEvent(onUserJoined));
            _local_2.addHabboConnectionMessageEvent(new Game2GameRejoinMessageEvent(onRejoinGame));
            _local_2.addHabboConnectionMessageEvent(new Game2WeeklyLeaderboardEvent(onWeeklyLeaderboard));
            _local_2.addHabboConnectionMessageEvent(new Game2TotalGroupLeaderboardEvent(onTotalGroupLeaderboard));
            _local_2.addHabboConnectionMessageEvent(new Game2GameCreatedMessageEvent(onGameCreated));
            _local_2.addHabboConnectionMessageEvent(new Game2WeeklyFriendsLeaderboardEvent(onWeeklyFriendsLeaderboard));
            _local_2.addHabboConnectionMessageEvent(new Game2StageEndingMessageEvent(onStageEnding));
            _local_2.addHabboConnectionMessageEvent(new Game2UserBlockedMessageEvent(onPlayerBlockStatusChange));
            _local_2.addHabboConnectionMessageEvent(new Game2TotalLeaderboardEvent(onTotalLeaderboard));
            _local_2.addHabboConnectionMessageEvent(new Game2WeeklyGroupLeaderboardEvent(onWeeklyGroupLeaderboard));
            _local_2.addHabboConnectionMessageEvent(new Game2UserLeftGameMessageEvent(onUserLeft));
            _local_2.addHabboConnectionMessageEvent(new Game2GameCancelledMessageEvent(onGameCancelled));
            _local_2.addHabboConnectionMessageEvent(new Game2FullGameStatusMessageEvent(onFullGameStatus));
            _local_2.addHabboConnectionMessageEvent(new Game2PlayerExitedGameArenaMessageEvent(onPlayerExitedArena));
            _local_2.addHabboConnectionMessageEvent(new Game2GameStatusMessageEvent(onGameStatus));
            _local_2.addHabboConnectionMessageEvent(new Game2StageLoadMessageEvent(onStageLoad));
            _local_2.addHabboConnectionMessageEvent(new Game2FriendsLeaderboardEvent(onFriendsLeaderboard));
            _local_2.addHabboConnectionMessageEvent(new Game2GameEndingMessageEvent(onGameEnding));
            _local_2.addHabboConnectionMessageEvent(new Game2PlayerRematchesMessageEvent(onPlayerRematches));
            _local_2.addHabboConnectionMessageEvent(new Game2GameDirectoryStatusMessageEvent(onGameDirectoryStatus));
            _local_2.addHabboConnectionMessageEvent(new Game2StageRunningMessageEvent(onStageRunning));
            _local_2.addHabboConnectionMessageEvent(new Game2AccountGameStatusMessageEvent(onAccountGameStatus));
            _local_2.addHabboConnectionMessageEvent(new Game2ArenaEnteredMessageEvent(onArenaEntered));
            _local_2.addHabboConnectionMessageEvent(new Game2GameLongDataMessageEvent(onGameLongData));
            _local_2.addHabboConnectionMessageEvent(new Game2StageStartingMessageEvent(onStageStarting));
            _local_2.addHabboConnectionMessageEvent(new Game2EnterArenaMessageEvent(onEnterArena));
            _local_2.addHabboConnectionMessageEvent(new RoomEntryInfoMessageEvent(onRoomEnter));
            _local_2.addHabboConnectionMessageEvent(new Game2StageStillLoadingMessageEvent(onStageStillLoading));
            _local_2.addHabboConnectionMessageEvent(new Game2StartingGameFailedMessageEvent(onStartingGameFailed));
            _local_2.addHabboConnectionMessageEvent(new Game2GameChatFromPlayerMessageEvent(onGameChat));
            _local_2.addHabboConnectionMessageEvent(new Game2EnterArenaFailedMessageEvent(onEnterArenaFailed));
            _local_2.addHabboConnectionMessageEvent(new ScrSendUserInfoEvent(onSubscriptionStatus));
            _local_2.addHabboConnectionMessageEvent(new Game2InArenaQueueMessageEvent(onInArenaQueue));
            _local_2.addHabboConnectionMessageEvent(new Game2StartCounterMessageEvent(onLobbyCounterStart));
            _local_2.addHabboConnectionMessageEvent(new Game2JoiningGameFailedMessageEvent(onJoiningGameFailed));
        }

        public function dispose():void
        {
            _SafeStr_458 = null;
            _disposed = true;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        private function onEnterArena(_arg_1:Game2EnterArenaMessageEvent):void
        {
            var _local_3:Game2EnterArenaMessageParser = _arg_1.getParser();
            _SafeStr_458.initArena(_local_3.gameType, _local_3.fieldType, _local_3.numberOfTeams, _local_3.players);
            var _local_2:SynchronizedGameArena = _SafeStr_458.gameArena;
            var _local_4:SynchronizedGameStage = _local_2.getCurrentStage();
            _local_4.initialize(_SafeStr_458.gameArena, _local_3.gameLevel);
            _SafeStr_458.mainView.close(false);
        }

        private function onEnterArenaFailed(_arg_1:Game2EnterArenaFailedMessageEvent):void
        {
            var _local_2:Game2EnterArenaFailedMessageParser = _arg_1.getParser();
            var _local_3:String = "snowwar.error.generic";
            switch (_local_2.reason)
            {
                case 1:
                    _local_3 = "snowwar.error.game_already_started";
                default:
                    _SafeStr_458.alert((("${" + _local_3) + "}"));
                    return;
            };
        }

        private function onArenaEntered(_arg_1:Game2ArenaEnteredMessageEvent):void
        {
            var _local_2:Game2ArenaEnteredMessageParser = _arg_1.getParser();
            var _local_3:Game2PlayerData = _local_2.player;
        }

        private function onStageLoad(_arg_1:Game2StageLoadMessageEvent):void
        {
            var _local_2:Game2StageLoadMessageParser = _arg_1.getParser();
            _SafeStr_458.initView();
        }

        private function onStageStillLoading(_arg_1:Game2StageStillLoadingMessageEvent):void
        {
            var _local_2:Game2StageStillLoadingMessageParser = _arg_1.getParser();
            _SafeStr_458.stageLoading(_local_2.percentage, _local_2.finishedPlayers);
        }

        private function onStageStarting(_arg_1:Game2StageStartingMessageEvent):void
        {
            var _local_3:Game2StageStartingMessageParser = _arg_1.getParser();
            HabboGamesCom.log(("[HabbosnowWarEngine] On stage start: " + _local_3.countDown));
            var _local_2:GameObjectsData = _local_3.gameObjects;
            initializeGameObjects(_local_2);
            _SafeStr_458.startStage(_local_3.countDown);
        }

        private function onStageRunning(_arg_1:Game2StageRunningMessageEvent):void
        {
            var _local_2:Game2StageRunningMessageParser = _arg_1.getParser();
            HabboGamesCom.log(("[HabbosnowWarEngine] On stage running: " + _local_2.timeToStageEnd));
            _SafeStr_458.stageRunning(_local_2.timeToStageEnd);
        }

        private function onStageEnding(_arg_1:Game2StageEndingMessageEvent):void
        {
            var _local_2:Game2StageEndingMessageParser = _arg_1.getParser();
            HabboGamesCom.log(("[HabbosnowWarEngine] On stage ending: " + _local_2.timeToNextState));
            if (_local_2.timeToNextState == 0)
            {
                _SafeStr_458.resetGameSession();
            };
        }

        private function onGameEnding(_arg_1:Game2GameEndingMessageEvent):void
        {
            var _local_2:Game2GameEndingMessageParser = _arg_1.getParser();
            HabboGamesCom.log(("[HabbosnowWarEngine] On game ending: " + _local_2.timeToNextState));
            _SafeStr_458.gameOver(_local_2.timeToNextState, _local_2.teams, _local_2.generalStats, _local_2.gameResult);
        }

        private function onPlayerExitedArena(_arg_1:Game2PlayerExitedGameArenaMessageEvent):void
        {
            var _local_2:Game2PlayerExitedGameArenaMessageParser = _arg_1.getParser();
            HabboGamesCom.log(((("[HabbosnowWarEngine] On player exited arena. userId:" + _local_2.userId) + " gameObjectId:") + _local_2.playerGameObjectId));
        }

        private function onRejoinGame(_arg_1:Game2GameRejoinMessageEvent):void
        {
            var _local_2:Game2GameRejoinMessageParser = _arg_1.getParser();
            HabboGamesCom.log(("Rejoin game! Room Before game: " + _local_2.roomBeforeGame));
            _SafeStr_458.rejoinGame(_local_2.roomBeforeGame);
        }

        private function onPlayerRematches(_arg_1:Game2PlayerRematchesMessageEvent):void
        {
            var _local_2:Game2PlayerRematchesMessageParser = _arg_1.getParser();
            HabboGamesCom.log((("User " + _local_2.userId) + " rematches"));
            _SafeStr_458.playerRematches(_local_2.userId);
        }

        private function onGameDirectoryStatus(_arg_1:Game2GameDirectoryStatusMessageEvent):void
        {
            var _local_2:Game2GameDirectoryStatusMessageParser = _arg_1.getParser();
            if (_local_2.status == 0)
            {
                _SafeStr_458.mainView.changeBlockStatus(_local_2.blockLength);
                _SafeStr_458.gamesPlayed = _local_2.gamesPlayed;
                _SafeStr_458.onGameDirectoryAvailable(true);
                _SafeStr_458.gamesLeft(0, (_local_2.freeGamesLeft == -1), _local_2.freeGamesLeft);
            }
            else
            {
                _SafeStr_458.onGameDirectoryAvailable(false);
                HabboGamesCom.log(("Game directory not available, status:" + _local_2.status));
            };
        }

        private function onAccountGameStatus(_arg_1:Game2AccountGameStatusMessageEvent):void
        {
            var _local_2:Game2AccountGameStatusMessageParser = _arg_1.getParser();
            HabboGamesCom.log(((("FREE GAMES LEFT: " + _local_2.freeGamesLeft) + " OR HAS UNLIMITED GAMES: ") + _local_2.hasUnlimitedGames));
            _SafeStr_458.gamesLeft(_local_2.gameTypeId, _local_2.hasUnlimitedGames, _local_2.freeGamesLeft);
        }

        private function onGameCreated(_arg_1:Game2GameCreatedMessageEvent):void
        {
            var _local_2:Game2GameCreatedMessageParser = _arg_1.getParser();
            var _local_3:GameLobbyData = _local_2.gameLobbyData;
            _SafeStr_458.createLobby(_local_3);
        }

        private function onGameStarted(_arg_1:Game2GameStartedMessageEvent):void
        {
            var _local_2:Game2GameStartedMessageParser = _arg_1.getParser();
            HabboGamesCom.log("Game started!");
            _SafeStr_458.gameStarted(_local_2.lobbyData);
        }

        private function onLobbyCounterStart(_arg_1:Game2StartCounterMessageEvent):void
        {
            var _local_2:Game2StartCounterMessageParser = _arg_1.getParser();
            HabboGamesCom.log(("Start Lobby Counter: " + _local_2.countDownLength));
            _SafeStr_458.startLobbyCounter(_local_2.countDownLength);
        }

        private function onLobbyCounterStop(_arg_1:Game2StopCounterMessageEvent):void
        {
            _SafeStr_458.stopLobbyCounter();
        }

        private function onGameCancelled(_arg_1:Game2GameCancelledMessageEvent):void
        {
            _SafeStr_458.gameCancelled(false);
        }

        private function onInArenaQueue(_arg_1:Game2InArenaQueueMessageEvent):void
        {
            var _local_2:Game2InArenaQueueMessageParser = _arg_1.getParser();
            if (_SafeStr_458.lobbyView)
            {
                _SafeStr_458.lobbyView.queuePosition = _local_2.position;
            };
        }

        private function onUserJoined(_arg_1:Game2UserJoinedGameMessageEvent):void
        {
            var _local_2:Game2UserJoinedGameMessageParser = _arg_1.getParser();
            _SafeStr_458.userJoined(_local_2.user);
        }

        private function onUserLeft(_arg_1:Game2UserLeftGameMessageEvent):void
        {
            var _local_2:Game2UserLeftGameMessageParser = _arg_1.getParser();
            _SafeStr_458.userLeft(_local_2.userId);
        }

        private function onGameLongData(_arg_1:Game2GameLongDataMessageEvent):void
        {
            var _local_2:Game2GameLongDataMessageParser = _arg_1.getParser();
            var _local_3:GameLobbyData = _local_2.gameLobbyData;
            HabboGamesCom.log(("Long data received: " + [_local_3.fieldType, _local_3.numberOfTeams, _local_3.maximumPlayers]));
            _SafeStr_458.createLobby(_local_3);
        }

        private function onJoiningGameFailed(_arg_1:Game2JoiningGameFailedMessageEvent):void
        {
            var _local_2:Game2JoiningGameFailedMessageParser = _arg_1.getParser();
            var _local_3:String = "snowwar.error.generic";
            switch (_local_2.reason)
            {
                case 6:
                case 7:
                    _local_3 = "snowwar.error.has_active_instance";
                    break;
                case 8:
                    _local_3 = "snowwar.error.no_free_games_left";
                    break;
                case 2:
                    _local_3 = "snowwar.error.duplicate_machineid";
                default:
            };
            _SafeStr_458.alert((("${" + _local_3) + "}"));
        }

        private function onStartingGameFailed(_arg_1:Game2StartingGameFailedMessageEvent):void
        {
            _SafeStr_458.alert("${snowwar.error.generic}");
        }

        private function onPlayerBlockStatusChange(_arg_1:Game2UserBlockedMessageEvent):void
        {
            var _local_2:Game2UserBlockedMessageParser = _arg_1.getParser();
            _SafeStr_458.mainView.changeBlockStatus(_local_2.playerBlockLength);
        }

        private function onFullGameStatus(_arg_1:Game2FullGameStatusMessageEvent):void
        {
            var _local_4:GameStatusData;
            var _local_3:Game2FullGameStatusMessageParser = _arg_1.getParser();
            var _local_2:SynchronizedGameArena = _SafeStr_458.gameArena;
            HabboGamesCom.log("On full game status: ");
            var _local_5:FullGameStatusData = _local_3.fullStatus;
            (_local_2.getCurrentStage() as SnowWarGameStage).resetTiles();
            initializeGameObjects(_local_5.gameObjects);
            if (_local_2)
            {
                _local_4 = _local_5.gameStatus;
                _local_2.seekToTurn(_local_4.turn, _local_4.checksum);
                handleGameStatus(_local_4, true);
            };
        }

        private function onGameStatus(_arg_1:Game2GameStatusMessageEvent):void
        {
            var _local_2:Game2GameStatusMessageParser = _arg_1.getParser();
            HabboGamesCom.log("[HabbosnowWarEngine] On game status: ");
            handleGameStatus(_local_2.status);
        }

        private function initializeGameObjects(_arg_1:GameObjectsData):void
        {
            var _local_4:HumanGameObjectData;
            var _local_8:Boolean;
            var _local_16:HumanGameObject;
            var _local_12:HumanGameObject;
            var _local_3:SnowballGameObjectData;
            var _local_11:SnowBallGameObject;
            var _local_13:HumanGameObject;
            var _local_7:SnowballMachineGameObjectData;
            var _local_15:SnowballMachineGameObject;
            var _local_9:SnowballPileGameObjectData;
            var _local_5:SnowballPileGameObject;
            var _local_17:TreeGameObjectData;
            var _local_6:TreeGameObject;
            var _local_10:SynchronizedGameArena = _SafeStr_458.gameArena;
            if (!_local_10)
            {
                return;
            };
            var _local_14:SnowWarGameStage = (_local_10.getCurrentStage() as SnowWarGameStage);
            _local_14.removeAllGameObjects();
            for each (var _local_2:SnowWarGameObjectData in _arg_1.gameObjects)
            {
                switch (_local_2.type)
                {
                    case 5:
                        _local_4 = (_local_2 as HumanGameObjectData);
                        _local_8 = (_local_4.name == _SafeStr_458.sessionDataManager.userName);
                        if (_local_8)
                        {
                            _SafeStr_458.ownId = _local_4.id;
                        };
                        _local_16 = new HumanGameObject(_local_14, _local_4, false, _SafeStr_458);
                        _local_14.addGameObject(_local_16.gameObjectId, _local_16);
                        _local_16.visualizationMode = 0;
                        if (((_local_8) && (_SafeStr_458.isGhostEnabled)))
                        {
                            if (_SafeStr_458.isGhostVisualizationEnabled)
                            {
                                _local_16.visualizationMode = 1;
                            }
                            else
                            {
                                _local_16.visualizationMode = 2;
                            };
                            if (_SafeStr_458.gameArena.getCurrentStage().getGameObject(_local_16.ghostObjectId) == null)
                            {
                                _local_12 = new HumanGameObject(_local_14, _local_4, true, _SafeStr_458);
                                _local_12.gameObjectId = _local_16.ghostObjectId;
                                _local_14.addGameObject(_local_12.gameObjectId, _local_12);
                            };
                        };
                        HabboGamesCom.log(((((("human id:" + _local_4.id) + " x:") + _local_4.currentLocationX) + " y:") + _local_4.currentLocationY));
                        break;
                    case 1:
                        _local_3 = (_local_2 as SnowballGameObjectData);
                        _local_11 = new SnowBallGameObject(_local_3.id);
                        _local_13 = (_local_14.getGameObject(_local_3.throwingHuman) as HumanGameObject);
                        _local_11.initializeFromData(_local_3, _local_13);
                        _local_14.addGameObject(_local_11.gameObjectId, _local_11);
                        HabboGamesCom.log(((("snowball x:" + _local_3.locationX3D) + " y:") + _local_3.locationY3D));
                        break;
                    case 4:
                        _local_7 = (_local_2 as SnowballMachineGameObjectData);
                        _local_15 = new SnowballMachineGameObject(_local_7, _local_14);
                        _local_14.addGameObject(_local_7.id, _local_15);
                        HabboGamesCom.log(("machine id:" + _local_7.id));
                        break;
                    case 3:
                        _local_9 = (_local_2 as SnowballPileGameObjectData);
                        _local_5 = new SnowballPileGameObject(_local_9, _local_14);
                        _local_14.addGameObject(_local_9.id, _local_5);
                        HabboGamesCom.log(("pile id:" + _local_9.id));
                        break;
                    case 2:
                        _local_17 = (_local_2 as TreeGameObjectData);
                        _local_6 = new TreeGameObject(_local_17, _local_14);
                        _local_14.addGameObject(_local_6.gameObjectId, _local_6);
                        HabboGamesCom.log(("tree id:" + _local_6.gameObjectId));
                        break;
                    default:
                        HabboGamesCom.log(("Unkonwn game-object:" + _local_2.type));
                };
            };
        }

        private function handleGameStatus(_arg_1:GameStatusData, _arg_2:Boolean=false):void
        {
            var _local_11:Array;
            var _local_7:ISynchronizedGameEvent;
            var _local_6:ISynchronizedGameEvent;
            var _local_3:Map = (_arg_1.events as Map);
            var _local_4:SynchronizedGameArena = _SafeStr_458.gameArena;
            if (!_local_4)
            {
                return;
            };
            var _local_10:int = _arg_1.turn;
            for each (var _local_5:int in _local_3.getKeys())
            {
                _local_11 = (_local_3.getValue(_local_5) as Array);
                for each (var _local_9:SnowWarGameEventData in _local_11)
                {
                    switch (_local_9.id)
                    {
                        case 8:
                            _local_7 = handleCreateSnowballEvent((_local_9 as CreateSnowballEventData));
                            break;
                        case 12:
                            _local_7 = handleHumanGetsSnowballFromMachineEvent((_local_9 as HumanGetsSnowballsFromMachineEventData));
                            break;
                        case 7:
                            _local_7 = handleHumanStartsToMakeASnowball((_local_9 as HumanStartsToMakeASnowballEventData));
                            _local_6 = handleGhostStartsToMakeASnowball((_local_9 as HumanStartsToMakeASnowballEventData));
                            break;
                        case 11:
                            _local_7 = handleMachineCreatesSnowballEvent((_local_9 as MachineCreatesSnowballEventData));
                            break;
                        case 2:
                            _local_7 = handleNewMoveTargetEvent((_local_9 as NewMoveTargetEventData));
                            break;
                        case 3:
                            _local_7 = handleThrowSnowballAtHuman((_local_9 as HumanThrowsSnowballAtHumanEventData));
                            _local_6 = handleGhostThrowSnowballAtHuman((_local_9 as HumanThrowsSnowballAtHumanEventData));
                            break;
                        case 4:
                            _local_7 = handleThrowSnowballAtPosition((_local_9 as HumanThrowsSnowballAtPositionEventData));
                            _local_6 = handleGhostThrowSnowballAtPosition((_local_9 as HumanThrowsSnowballAtPositionEventData));
                            break;
                        case 1:
                            _local_7 = handleHumanLeftGameEvent((_local_9 as HumanLeftGameEventData));
                            break;
                        default:
                            HabboGamesCom.log(("Unknown event id " + _local_9.id));
                    };
                    if (_local_7)
                    {
                        _local_4.addGameEvent((_local_10 + 1), _local_5, _local_7);
                    };
                    if (_local_6)
                    {
                        _local_4.addGameEvent((_local_10 + 1), _local_5, _local_6);
                    };
                };
            };
            var _local_8:int = _arg_1.checksum;
            _SafeStr_458.nextTurn(_local_10, _local_8, _arg_2);
        }

        private function handleHumanGetsSnowballFromMachineEvent(_arg_1:HumanGetsSnowballsFromMachineEventData):HumanGetsSnowballsFromMachineEvent
        {
            var _local_2:SynchronizedGameArena = _SafeStr_458.gameArena;
            var _local_3:SynchronizedGameStage = _local_2.getCurrentStage();
            var _local_4:HumanGameObject = (_local_3.getGameObject(_arg_1.humanGameObjectId) as HumanGameObject);
            var _local_5:SnowballGivingGameObject = (_local_3.getGameObject(_arg_1.snowBallMachineReference) as SnowballGivingGameObject);
            return (new HumanGetsSnowballsFromMachineEvent(_local_4, _local_5));
        }

        private function handleMachineCreatesSnowballEvent(_arg_1:MachineCreatesSnowballEventData):MachineCreatesSnowballEvent
        {
            var _local_2:SynchronizedGameArena = _SafeStr_458.gameArena;
            var _local_3:SynchronizedGameStage = _local_2.getCurrentStage();
            var _local_4:SnowballMachineGameObject = (_local_3.getGameObject(_arg_1.snowBallMachineReference) as SnowballMachineGameObject);
            return (new MachineCreatesSnowballEvent(_local_4));
        }

        private function handleThrowSnowballAtPosition(_arg_1:HumanThrowsSnowballAtPositionEventData):HumanThrowsSnowballAtPositionEvent
        {
            var _local_2:SynchronizedGameArena = _SafeStr_458.gameArena;
            var _local_3:SynchronizedGameStage = _local_2.getCurrentStage();
            var _local_4:HumanGameObject = (_local_3.getGameObject(_arg_1.humanGameObjectId) as HumanGameObject);
            return (new HumanThrowsSnowballAtPositionEvent(_local_4, _arg_1.targetX, _arg_1.targetY, _arg_1.trajectory));
        }

        private function handleThrowSnowballAtHuman(_arg_1:HumanThrowsSnowballAtHumanEventData):HumanThrowsSnowballAtHumanEvent
        {
            var _local_3:SynchronizedGameArena = _SafeStr_458.gameArena;
            var _local_4:SynchronizedGameStage = _local_3.getCurrentStage();
            var _local_5:HumanGameObject = (_local_4.getGameObject(_arg_1.humanGameObjectId) as HumanGameObject);
            var _local_2:HumanGameObject = (_local_4.getGameObject(_arg_1.targetHumanGameObjectId) as HumanGameObject);
            return (new HumanThrowsSnowballAtHumanEvent(_local_5, _local_2, _arg_1.trajectory));
        }

        private function handleHumanStartsToMakeASnowball(_arg_1:HumanStartsToMakeASnowballEventData):HumanStartsToMakeASnowballEvent
        {
            var _local_2:SynchronizedGameArena = _SafeStr_458.gameArena;
            var _local_3:SynchronizedGameStage = _local_2.getCurrentStage();
            var _local_4:HumanGameObject = (_local_3.getGameObject(_arg_1.humanGameObjectId) as HumanGameObject);
            return (new HumanStartsToMakeASnowballEvent(_local_4));
        }

        private function handleCreateSnowballEvent(_arg_1:CreateSnowballEventData):CreateSnowballEvent
        {
            var _local_2:SynchronizedGameArena = _SafeStr_458.gameArena;
            var _local_3:SynchronizedGameStage = _local_2.getCurrentStage();
            var _local_4:HumanGameObject = (_local_3.getGameObject(_arg_1.humanGameObjectId) as HumanGameObject);
            return (new CreateSnowballEvent(_arg_1.snowBallGameObjectId, _local_4, _arg_1.targetX, _arg_1.targetY, _arg_1.trajectory));
        }

        private function handleNewMoveTargetEvent(_arg_1:NewMoveTargetEventData):NewMoveTargetEvent
        {
            var _local_2:SynchronizedGameArena = _SafeStr_458.gameArena;
            var _local_3:SynchronizedGameStage = _local_2.getCurrentStage();
            var _local_4:HumanGameObject = (_local_3.getGameObject(_arg_1.humanGameObjectId) as HumanGameObject);
            return (new NewMoveTargetEvent(_local_4, _arg_1.x, _arg_1.y));
        }

        private function handleHumanLeftGameEvent(_arg_1:HumanLeftGameEventData):HumanLeftGameEvent
        {
            var _local_2:SynchronizedGameArena = _SafeStr_458.gameArena;
            var _local_3:SynchronizedGameStage = _local_2.getCurrentStage();
            var _local_4:HumanGameObject = (_local_3.getGameObject(_arg_1.humanGameObjectId) as HumanGameObject);
            return (new HumanLeftGameEvent(_local_4));
        }

        private function handleGhostThrowSnowballAtPosition(_arg_1:HumanThrowsSnowballAtPositionEventData):HumanThrowsSnowballAtPositionEvent
        {
            var _local_2:SynchronizedGameArena;
            var _local_3:SynchronizedGameStage;
            if (_SafeStr_458.isGhostEnabled)
            {
                _local_2 = _SafeStr_458.gameArena;
                _local_3 = _local_2.getCurrentStage();
                if (_arg_1.humanGameObjectId == _SafeStr_458.ownId)
                {
                    return (new HumanThrowsSnowballAtPositionEvent(_SafeStr_458.getGhostPlayer(), _arg_1.targetX, _arg_1.targetY, _arg_1.trajectory));
                };
            };
            return (null);
        }

        private function handleGhostThrowSnowballAtHuman(_arg_1:HumanThrowsSnowballAtHumanEventData):HumanThrowsSnowballAtHumanEvent
        {
            var _local_3:SynchronizedGameArena;
            var _local_4:SynchronizedGameStage;
            var _local_2:HumanGameObject;
            if (_SafeStr_458.isGhostEnabled)
            {
                _local_3 = _SafeStr_458.gameArena;
                _local_4 = _local_3.getCurrentStage();
                _local_2 = (_local_4.getGameObject(_arg_1.targetHumanGameObjectId) as HumanGameObject);
                if (_arg_1.humanGameObjectId == _SafeStr_458.ownId)
                {
                    return (new HumanThrowsSnowballAtHumanEvent(_SafeStr_458.getGhostPlayer(), _local_2, _arg_1.trajectory));
                };
            };
            return (null);
        }

        private function handleGhostStartsToMakeASnowball(_arg_1:HumanStartsToMakeASnowballEventData):HumanStartsToMakeASnowballEvent
        {
            var _local_2:SynchronizedGameArena;
            var _local_3:SynchronizedGameStage;
            var _local_4:HumanGameObject;
            if (_SafeStr_458.isGhostEnabled)
            {
                _local_2 = _SafeStr_458.gameArena;
                _local_3 = _local_2.getCurrentStage();
                _local_4 = (_local_3.getGameObject(_arg_1.humanGameObjectId) as HumanGameObject);
                if (_arg_1.humanGameObjectId == _SafeStr_458.ownId)
                {
                    return (new HumanStartsToMakeASnowballEvent(_SafeStr_458.getGhostPlayer()));
                };
            };
            return (null);
        }

        private function onGameChat(_arg_1:Game2GameChatFromPlayerMessageEvent):void
        {
            var _local_2:Game2GameChatFromPlayerMessageParser = _arg_1.getParser();
            _SafeStr_458.addChatMessage(_local_2.userId, _local_2.chatMessage);
        }

        private function onSubscriptionStatus(_arg_1:ScrSendUserInfoEvent):void
        {
            if (_SafeStr_458 != null)
            {
                _SafeStr_458.send(new Game2GetAccountGameStatusMessageComposer(0));
                if (_SafeStr_458.mainView.gameLobbyWindowActive)
                {
                    return;
                };
                if (!_SafeStr_458.gameCenterEnabled)
                {
                    _SafeStr_458.mainView.openMainWindow(false);
                };
            };
        }

        private function onRoomEnter(_arg_1:RoomEntryInfoMessageEvent):void
        {
            _SafeStr_458.promoteGame();
        }

        private function onFriendsLeaderboard(_arg_1:Game2FriendsLeaderboardEvent):void
        {
            var _local_2:Game2LeaderboardParser = _arg_1.getParser();
            if (_SafeStr_458.leaderboard)
            {
                _SafeStr_458.leaderboard.addFriendAllTimeData(_local_2.leaderboard, _local_2.totalListSize);
            };
        }

        private function onTotalLeaderboard(_arg_1:Game2TotalLeaderboardEvent):void
        {
            var _local_2:Game2LeaderboardParser = _arg_1.getParser();
            if (_SafeStr_458.leaderboard)
            {
                _SafeStr_458.leaderboard.addAllTimeData(_local_2.leaderboard, _local_2.totalListSize);
            };
        }

        private function onTotalGroupLeaderboard(_arg_1:Game2TotalGroupLeaderboardEvent):void
        {
            var _local_2:Game2GroupLeaderboardParser = _arg_1.getParser();
            if (_SafeStr_458.leaderboard)
            {
                _SafeStr_458.leaderboard.addAllTimeGroupData(_local_2.leaderboard, _local_2.totalListSize, _local_2.favouriteGroupId);
            };
        }

        private function onWeeklyGroupLeaderboard(_arg_1:Game2WeeklyGroupLeaderboardEvent):void
        {
            var _local_2:Game2WeeklyGroupLeaderboardParser = _arg_1.getParser();
            if (_SafeStr_458.leaderboard)
            {
                _SafeStr_458.leaderboard.addWeeklyGroupData(_local_2.year, _local_2.week, _local_2.leaderboard, _local_2.totalListSize, _local_2.maxOffset, _local_2.minutesUntilReset, _local_2.favouriteGroupId);
            };
        }

        private function onWeeklyLeaderboard(_arg_1:Game2WeeklyLeaderboardEvent):void
        {
            var _local_2:Game2WeeklyLeaderboardParser = _arg_1.getParser();
            if (_SafeStr_458.leaderboard)
            {
                _SafeStr_458.leaderboard.addWeeklyData(_local_2.year, _local_2.week, _local_2.leaderboard, _local_2.totalListSize, _local_2.maxOffset, _local_2.minutesUntilReset);
            };
        }

        private function onWeeklyFriendsLeaderboard(_arg_1:Game2WeeklyFriendsLeaderboardEvent):void
        {
            var _local_2:Game2WeeklyLeaderboardParser = _arg_1.getParser();
            if (_SafeStr_458.leaderboard)
            {
                _SafeStr_458.leaderboard.addFriendWeeklyData(_local_2.year, _local_2.week, _local_2.leaderboard, _local_2.totalListSize, _local_2.maxOffset, _local_2.minutesUntilReset);
            };
        }


    }
}

