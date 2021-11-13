package com.sulake.habbo.game.snowwar.ui
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.game.snowwar.SnowWarEngine;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.game.snowwar.utils.SnowWarAnimatedWindowElement;
    import flash.utils.Timer;
    import com.sulake.habbo.game.snowwar.utils.WindowUtils;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.assets.IAsset;
    import flash.display.BitmapData;
    import com.sulake.core.window.components.ITextWindow;
    import flash.events.TimerEvent;

    public class GamesMainViewController implements IDisposable 
    {

        private static const INSTRUCTION_ASSETS:Array = ["move_", "throw_1_", "throw_2_", "throw_3_", "balls_"];
        private static const INSTRUCTION_FRAME_COUNTS:Array = [4, 4, 5, 5, 5];
        private static const INSTRUCTION_FRAME_LENGTH:int = 1000;

        private var _gameEngine:SnowWarEngine;
        private var _rootWindow:IWindowContainer;
        private var _SafeStr_2554:IWindowContainer;
        private var _lobbyView:GameLobbyWindowCtrl;
        private var _disposed:Boolean;
        private var _instructionsAnimation:SnowWarAnimatedWindowElement;
        private var _SafeStr_2555:Timer;
        private var _SafeStr_2556:int = 0;
        private var _currentInstruction:int = 0;

        public function GamesMainViewController(_arg_1:SnowWarEngine)
        {
            _gameEngine = _arg_1;
        }

        public function get gameEngine():SnowWarEngine
        {
            return (_gameEngine);
        }

        public function get rootWindow():IWindowContainer
        {
            return (_rootWindow);
        }

        public function get lobbyView():GameLobbyWindowCtrl
        {
            return (_lobbyView);
        }

        public function toggleVisibility():void
        {
            if (_rootWindow)
            {
                _rootWindow.visible = (!(rootWindow.visible));
            }
            else
            {
                openMainWindow(true);
            };
        }

        private function createWindow():void
        {
            var _local_1:int;
            _rootWindow = (WindowUtils.createWindow("games_main", 1) as IWindowContainer);
            _rootWindow.findChildByTag("close").addEventListener("WME_CLICK", onClose);
            _rootWindow.visible = true;
            _rootWindow.center();
            _SafeStr_2554 = (_rootWindow.findChildByName("quick_play_container") as IWindowContainer);
            _SafeStr_2554.findChildByName("play.button").addEventListener("WME_CLICK", onPlay);
            _SafeStr_2554.visible = false;
            _SafeStr_2554.findChildByName("instructions_link").addEventListener("WME_CLICK", onInstructions);
            _SafeStr_2554.findChildByName("leaderboard_link").addEventListener("WME_CLICK", onLeaderboard);
            _SafeStr_2554.findChildByName("instructions_back").addEventListener("WME_CLICK", onBack);
            _SafeStr_2554.findChildByName("instructions_next").addEventListener("WME_CLICK", onNext);
            _SafeStr_2554.findChildByName("instructions_prev").addEventListener("WME_CLICK", onPrevious);
            _SafeStr_2554.findChildByName("games_vip_region").addEventListener("WME_CLICK", onOpenClubCenter);
            _SafeStr_2554.procedure = windowEventProc;
            _SafeStr_2554.findChildByName("leaderboard_link").visible = _gameEngine.config.getBoolean("games.highscores.enabled");
            var _local_2:IItemListWindow = (_SafeStr_2554.findChildByName("page_list") as IItemListWindow);
            _local_1 = 0;
            while (_local_1 < _local_2.numListItems)
            {
                _local_2.getListItemAt(_local_1).addEventListener("WME_CLICK", onSelectPage);
                _local_1++;
            };
            _disposed = false;
            updateGameStartingStatus();
        }

        private function windowEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (((_arg_1.type == "WME_OVER") || (_arg_1.type == "WME_OUT")))
            {
                switch (_arg_2.name)
                {
                    case "btn_more_games_10":
                        WindowUtils.setElementImage(_arg_2, getBitmap(("btn_more_games_10" + ((_arg_1.type == "WME_OVER") ? "_hi" : ""))));
                        break;
                    case "btn_more_games_100":
                        WindowUtils.setElementImage(_arg_2, getBitmap(("btn_more_games_100" + ((_arg_1.type == "WME_OVER") ? "_hi" : ""))));
                        break;
                    case "btn_more_games_300":
                        WindowUtils.setElementImage(_arg_2, getBitmap(("btn_more_games_300" + ((_arg_1.type == "WME_OVER") ? "_hi" : ""))));
                };
            };
            if (_arg_1.type == "WME_CLICK")
            {
                switch (_arg_2.name)
                {
                    case "btn_more_games_10":
                        _gameEngine.catalog.buySnowWarTokensOffer("GET_SNOWWAR_TOKENS");
                        _gameEngine.logGameEvent("gameFramework.buyTokens.clicked.frontView");
                        return;
                    case "btn_more_games_100":
                        _gameEngine.catalog.buySnowWarTokensOffer("GET_SNOWWAR_TOKENS2");
                        _gameEngine.logGameEvent("gameFramework.buyTokens.clicked.frontView");
                        return;
                    case "btn_more_games_300":
                        _gameEngine.catalog.buySnowWarTokensOffer("GET_SNOWWAR_TOKENS3");
                        _gameEngine.logGameEvent("gameFramework.buyTokens.clicked.frontView");
                        return;
                };
            };
        }

        public function close(_arg_1:Boolean):void
        {
            if (((_lobbyView) && (_lobbyView.visible)))
            {
                _lobbyView.onClose(_arg_1);
            };
            disposeViews();
        }

        private function onClose(_arg_1:WindowMouseEvent):void
        {
            close(true);
        }

        private function onPlay(_arg_1:WindowMouseEvent):void
        {
            if (_gameEngine.freeGamesLeft != 0)
            {
                _gameEngine.startQuickServerGame();
            }
            else
            {
                _gameEngine.openGetMoreGames("gameFramework.onPlay.clicked.frontView");
            };
        }

        private function updateGettingMoreGamesOption():void
        {
            var _local_1:IWindow = _SafeStr_2554.findChildByName("play.button");
            if (_gameEngine.freeGamesLeft == 0)
            {
                _local_1.visible = false;
            }
            else
            {
                _local_1.visible = true;
            };
        }

        private function onInstructions(_arg_1:WindowMouseEvent):void
        {
            showInstructions(true);
        }

        private function onLeaderboard(_arg_1:WindowMouseEvent):void
        {
            _gameEngine.showLeaderboard();
        }

        private function onBack(_arg_1:WindowMouseEvent):void
        {
            showInstructions(false);
        }

        private function onNext(_arg_1:WindowMouseEvent):void
        {
            _currentInstruction++;
            _currentInstruction = (_currentInstruction % INSTRUCTION_ASSETS.length);
            showInstructions(true);
        }

        private function onPrevious(_arg_1:WindowMouseEvent):void
        {
            _currentInstruction = ((_currentInstruction - 1) + INSTRUCTION_ASSETS.length);
            _currentInstruction = (_currentInstruction % INSTRUCTION_ASSETS.length);
            showInstructions(true);
        }

        private function onSelectPage(_arg_1:WindowMouseEvent):void
        {
            _currentInstruction = parseInt(_arg_1.window.name.replace("page_", ""));
            showInstructions(true);
        }

        private function showInstructions(_arg_1:Boolean):void
        {
            var _local_3:int;
            var _local_7:IWindowContainer;
            _SafeStr_2554.findChildByName("teaser_container").visible = (!(_arg_1));
            _SafeStr_2554.findChildByName("instructions_container").visible = _arg_1;
            if (_instructionsAnimation)
            {
                _instructionsAnimation.dispose();
                _instructionsAnimation = null;
            };
            if (!_arg_1)
            {
                return;
            };
            var _local_4:IBitmapWrapperWindow = (_SafeStr_2554.findChildByName("instructions_image") as IBitmapWrapperWindow);
            var _local_6:String = INSTRUCTION_ASSETS[_currentInstruction];
            var _local_2:int = INSTRUCTION_FRAME_COUNTS[_currentInstruction];
            _instructionsAnimation = new SnowWarAnimatedWindowElement(_gameEngine.assets, _local_4, _local_6, _local_2, 1000);
            _SafeStr_2554.findChildByName("instruction_text").caption = (("${snowwar.instructions." + (_currentInstruction + 1)) + "}");
            var _local_5:IItemListWindow = (_SafeStr_2554.findChildByName("page_list") as IItemListWindow);
            _local_3 = 0;
            while (_local_3 < _local_5.numListItems)
            {
                _local_7 = (_local_5.getListItemAt(_local_3) as IWindowContainer);
                _local_6 = ((_local_3 <= _currentInstruction) ? "pagination_ball_hilite" : "pagination_ball");
                WindowUtils.setElementImage(_local_7.getChildAt(0), getBitmap(_local_6));
                _local_3++;
            };
        }

        private function getBitmap(_arg_1:String):BitmapData
        {
            var _local_2:IAsset = _gameEngine.assets.getAssetByName(_arg_1);
            if (_local_2)
            {
                return (_local_2.content as BitmapData);
            };
            return (null);
        }

        private function onOpenClubCenter(_arg_1:WindowMouseEvent):void
        {
            _gameEngine.openClubCenter("gameFramework.getVip.clicked.frontView");
        }

        public function openMainWindow(_arg_1:Boolean):void
        {
            if (((!(_rootWindow)) && (_arg_1)))
            {
                createWindow();
            }
            else
            {
                if (((!(rootWindow)) && (!(_arg_1))))
                {
                    return;
                };
            };
            if (_lobbyView)
            {
                _lobbyView.visible = false;
            };
            _SafeStr_2554.visible = true;
        }

        public function openGameLobbyWindow(_arg_1:String, _arg_2:int, _arg_3:int):void
        {
            if (!_rootWindow)
            {
                createWindow();
            };
            if (!_lobbyView)
            {
                _lobbyView = new GameLobbyWindowCtrl(this, _arg_1, _arg_2, _arg_3);
            }
            else
            {
                _lobbyView.levelName = _arg_1;
                _lobbyView.numberOfTeams = _arg_2;
                _lobbyView.maxNumberOfPlayers = _arg_3;
                _lobbyView.clearPlayerList();
            };
            _SafeStr_2554.visible = false;
            _lobbyView.visible = true;
        }

        public function dispose():void
        {
            if (!_disposed)
            {
                disposeViews();
                _disposed = true;
                disposeCounter();
            };
        }

        private function disposeViews():void
        {
            if (_instructionsAnimation)
            {
                _instructionsAnimation.dispose();
                _instructionsAnimation = null;
            };
            if (_lobbyView)
            {
                _lobbyView.dispose();
                _lobbyView = null;
            };
            if (_SafeStr_2554)
            {
                _SafeStr_2554.dispose();
                _SafeStr_2554 = null;
            };
            if (_rootWindow)
            {
                _rootWindow.dispose();
                _rootWindow = null;
            };
        }

        private function disposeCounter():void
        {
            if (_SafeStr_2555)
            {
                _SafeStr_2555.removeEventListener("timer", onTick);
                _SafeStr_2555.stop();
                _SafeStr_2555 = null;
            };
            _SafeStr_2556 = NaN;
        }

        public function get gameLobbyWindowActive():Boolean
        {
            return ((_lobbyView) && (_lobbyView.visible));
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function updateGameStartingStatus():void
        {
            var _local_1:IWindowContainer;
            var _local_3:ITextWindow;
            var _local_2:IWindow;
            if (((_SafeStr_2554) && (_SafeStr_2554.visible)))
            {
                WindowUtils.setCaption(_SafeStr_2554.findChildByName("games_left"), _gameEngine.freeGamesLeft.toString());
                _local_1 = (_SafeStr_2554.findChildByName("games_left_region") as IWindowContainer);
                _local_3 = (_SafeStr_2554.findChildByName("games_left_stroke") as ITextWindow);
                _local_2 = _SafeStr_2554.findChildByName("play.button");
                _local_2.visible = true;
                updateGettingMoreGamesOption();
                if (checkGameAmountStatus(_local_1, _local_3, _local_2))
                {
                    checkBlockStatus(_local_2);
                };
            };
        }

        private function checkGameAmountStatus(_arg_1:IWindowContainer, _arg_2:ITextWindow, _arg_3:IWindow):Boolean
        {
            if (_gameEngine.hasUnlimitedGames)
            {
                _arg_1.visible = false;
                return (true);
            };
            _arg_1.visible = true;
            var _local_4:IWindow = ITextWindow(_SafeStr_2554.findChildByName("play_text"));
            _arg_3.color = 0x55CC00;
            switch (_gameEngine.freeGamesLeft)
            {
                case -1:
                    _arg_1.visible = false;
                    WindowUtils.setCaption(_local_4, "${snowwar.play}");
                    return (true);
                case 0:
                    _arg_1.visible = true;
                    _arg_2.textColor = 0xFF0000;
                    WindowUtils.setCaption(_local_4, "${catalog.vip.buy.title}");
                    return (false);
                default:
                    _arg_1.visible = true;
                    _arg_2.textColor = 1079212;
                    WindowUtils.setCaption(_local_4, "${snowwar.play}");
                    return (true);
            };
        }

        private function checkBlockStatus(_arg_1:IWindow):void
        {
            var _local_3:int;
            var _local_2:int;
            var _local_4:IWindow = ITextWindow(_SafeStr_2554.findChildByName("play_text"));
            if (_SafeStr_2556 > 0)
            {
                _arg_1.disable();
                _arg_1.color = 0xCCCCCC;
                _local_3 = int(Math.floor((_SafeStr_2556 / 60)));
                _local_2 = (_SafeStr_2556 % 60);
                _local_4.caption = ((_local_3 + ":") + ((_local_2 < 10) ? ("0" + _local_2) : _local_2));
            }
            else
            {
                if (_SafeStr_2556 <= 0)
                {
                    _arg_1.enable();
                    _arg_1.color = 0x55CC00;
                    WindowUtils.setCaption(_local_4, "${snowwar.play}");
                };
            };
        }

        private function onTick(_arg_1:TimerEvent):void
        {
            if (((_SafeStr_2556) && (_SafeStr_2556 > 0)))
            {
                _SafeStr_2556--;
                HabboGamesCom.log(("on block tick " + _SafeStr_2556));
                updateGameStartingStatus();
            };
            if (_SafeStr_2556 <= 0)
            {
                updateGameStartingStatus();
                disposeCounter();
            };
        }

        public function changeBlockStatus(_arg_1:int):void
        {
            if (_arg_1 > 0)
            {
                _SafeStr_2556 = _arg_1;
                if (!_SafeStr_2555)
                {
                    _SafeStr_2555 = new Timer(1000, _SafeStr_2556);
                    _SafeStr_2555.addEventListener("timer", onTick);
                    _SafeStr_2555.start();
                };
            };
            updateGameStartingStatus();
        }


    }
}

