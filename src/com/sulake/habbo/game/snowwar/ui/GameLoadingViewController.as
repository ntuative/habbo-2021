package com.sulake.habbo.game.snowwar.ui
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.avatar.IAvatarImageListener;
    import com.sulake.habbo.game.snowwar.SnowWarEngine;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.data.GameLobbyData;
    import com.sulake.habbo.game.snowwar.utils.SnowWarAnimatedWindowElement;
    import com.sulake.habbo.game.snowwar.utils.WindowUtils;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.communication.messages.outgoing.game.arena.Game2ExitGameMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.GetGuestRoomMessageComposer;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.assets.IAsset;
    import flash.display.BitmapData;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.data.GameLobbyPlayerData;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.components.IRegionWindow;
    import flash.geom.Point;
    import com.sulake.habbo.avatar.IAvatarFigureContainer;
    import com.sulake.habbo.avatar.IAvatarImage;

    public class GameLoadingViewController implements IDisposable, IAvatarImageListener 
    {

        private var _disposed:Boolean;
        private var _SafeStr_2499:SnowWarEngine;
        private var _window:IWindowContainer;
        private var _SafeStr_2550:Map;
        private var _SafeStr_2551:GameLobbyData;
        private var _SafeStr_2544:BackgroundViewController;
        private var _SafeStr_2552:Array = [];

        public function GameLoadingViewController(_arg_1:SnowWarEngine)
        {
            _SafeStr_2499 = _arg_1;
            _SafeStr_2550 = new Map();
            createMainWindow();
            _SafeStr_2544 = new BackgroundViewController(_SafeStr_2499);
            _SafeStr_2544.background.visible = true;
            _SafeStr_2499.windowManager.getDesktop(1).visible = false;
            _SafeStr_2499.roomUI.visible = false;
        }

        public function dispose():void
        {
            if (_disposed)
            {
                return;
            };
            _SafeStr_2499.windowManager.getDesktop(1).visible = true;
            _SafeStr_2499 = null;
            if (_SafeStr_2550)
            {
                for each (var _local_1:SnowWarAnimatedWindowElement in _SafeStr_2550)
                {
                    _local_1.dispose();
                };
                _SafeStr_2550.dispose();
                _SafeStr_2550 = null;
            };
            if (_window)
            {
                _window.dispose();
                _window = null;
            };
            if (_SafeStr_2544)
            {
                _SafeStr_2544.dispose();
                _SafeStr_2544 = null;
            };
            _disposed = true;
            _SafeStr_2552 = [];
        }

        private function createMainWindow():void
        {
            _window = (WindowUtils.createWindow("snowwar_ending") as IWindowContainer);
            _window.x = ((_window.desktop.width - _window.width) / 2);
            _window.y = ((_window.desktop.height > 685) ? 115 : 10);
            WindowUtils.setCaption(_window.findChildByName("endingInformation"), "${snowwar.loading.title}");
            WindowUtils.hideElement(_window, "buttonsContainer");
            WindowUtils.hideElement(_window, "mostKillsContainer");
            WindowUtils.hideElement(_window, "mostHitsContainer");
            WindowUtils.hideElement(_window, "team1Score");
            WindowUtils.hideElement(_window, "team2Score");
            WindowUtils.hideElement(_window, "statusContainer");
            _window.findChildByName("loadingContainer").visible = true;
            _window.findChildByName("leave_link_region").procedure = onCancel;
        }

        private function onCancel(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            onClose();
        }

        private function onClose():void
        {
            if (_SafeStr_2499 != null)
            {
                _SafeStr_2499.gameCancelled(true);
                _SafeStr_2499.send(new Game2ExitGameMessageComposer());
                if (_SafeStr_2499.roomBeforeGame > -1)
                {
                    _SafeStr_2499.send(new GetGuestRoomMessageComposer(_SafeStr_2499.roomBeforeGame, false, true));
                };
                _SafeStr_2499.disposeLoadingView();
            };
        }

        public function show(_arg_1:GameLobbyData):void
        {
            _SafeStr_2551 = _arg_1;
            var _local_2:IBitmapWrapperWindow = (_window.findChildByName("arenaPreview") as IBitmapWrapperWindow);
            var _local_3:IAsset = _SafeStr_2499.assets.getAssetByName((("arena_" + _arg_1.fieldType) + "_preview"));
            if (_local_3)
            {
                _local_2.bitmap = (_local_3.content as BitmapData);
                _local_2.disposesBitmap = false;
            };
            WindowUtils.setCaption(_window.findChildByName("arenaName"), _SafeStr_2499.getArenaName(_arg_1));
            renderPlayers();
        }

        private function renderPlayers():void
        {
            clearPlayers();
            for each (var _local_1:GameLobbyPlayerData in _SafeStr_2551.players.sort(GameLobbyPlayerData._SafeStr_340))
            {
                addPlayer(_local_1);
            };
        }

        private function clearPlayers():void
        {
            var _local_2:IItemListWindow;
            var _local_1:int = 1;
            while ((_local_2 = (_window.findChildByName((("team" + _local_1++) + "PlayersList")) as IItemListWindow)) != null)
            {
                _local_2.destroyListItems();
            };
        }

        private function addPlayer(_arg_1:GameLobbyPlayerData):void
        {
            var _local_12:int;
            var _local_5:int = _arg_1.teamId;
            var _local_8:IItemListWindow = (_window.findChildByName((("team" + _local_5) + "PlayersList")) as IItemListWindow);
            var _local_7:IItemListWindow = (WindowUtils.createWindow(("snowwar_results_player_team_" + _local_5)) as IItemListWindow);
            var _local_9:IWindowContainer = (_local_7.getListItemByName("playerImageContainer") as IWindowContainer);
            var _local_6:IWindowContainer = (_local_7.getListItemByName("playerDataContainer") as IWindowContainer);
            var _local_2:IWindowContainer = (_local_7.getListItemByName("playerScoreContainer") as IWindowContainer);
            if (_arg_1.userId == _SafeStr_2499.sessionDataManager.userId)
            {
                WindowUtils.setElementImage(_local_9.findChildByName("playerImageBackground"), getBitmap("green_square"));
            };
            switch (_local_5)
            {
                case 2:
                    _local_12 = 4;
                    break;
                default:
                    _local_12 = 2;
            };
            WindowUtils.setElementImage(getElement(_local_9, "playerImage"), getAvatarFigure(_arg_1.teamId, _arg_1.figure, _arg_1.gender, _local_12));
            WindowUtils.setCaption(getElement(_local_6, "playerName"), _arg_1.name);
            WindowUtils.hideElement(_local_6, "playerStats");
            WindowUtils.hideElement(_local_2, "playerScore");
            WindowUtils.hideElement(_local_6, "playerTotalStats");
            var _local_10:IBitmapWrapperWindow = (_local_6.findChildByName("skillLevel") as IBitmapWrapperWindow);
            if (_local_10.bitmap)
            {
                _local_10.bitmap.dispose();
            };
            _local_10.bitmap = getSkillLevelImage(_arg_1.skillLevel, _arg_1.teamId);
            var _local_3:IRegionWindow = (_local_6.findChildByName("scoreTooltip") as IRegionWindow);
            _local_3.toolTipCaption = ((_arg_1.totalScore.toString() + "/") + _arg_1.scoreToNextLevel.toString());
            _local_3.visible = true;
            _local_8.addListItem(_local_7);
            var _local_4:IBitmapWrapperWindow = (_local_2.findChildByName("loadingIcon") as IBitmapWrapperWindow);
            var _local_11:SnowWarAnimatedWindowElement = _SafeStr_2550.remove(_arg_1.userId);
            if (_local_11)
            {
                _local_11.dispose();
            };
            _local_11 = new SnowWarAnimatedWindowElement(_SafeStr_2499.assets, _local_4, "load_", 8);
            _SafeStr_2550.add(_arg_1.userId, _local_11);
            _local_4.visible = true;
        }

        private function getSkillLevelImage(_arg_1:int, _arg_2:int):BitmapData
        {
            var _local_6:BitmapData;
            var _local_8:int;
            var _local_7:Point;
            _arg_1 = Math.min(_arg_1, 30);
            var _local_3:BitmapData = (_SafeStr_2499.assets.getAssetByName("star_empty").content as BitmapData);
            var _local_11:BitmapData = (_SafeStr_2499.assets.getAssetByName("star_filled_bronze").content as BitmapData);
            var _local_9:BitmapData = (_SafeStr_2499.assets.getAssetByName("star_filled_silver").content as BitmapData);
            var _local_10:BitmapData = (_SafeStr_2499.assets.getAssetByName("star_filled_gold").content as BitmapData);
            var _local_5:int = ((_arg_1 > 0) ? (((_arg_1 - 1) % 10) + 1) : 0);
            var _local_4:BitmapData = new BitmapData(150, 13, true, 0);
            _local_8 = 0;
            while (_local_8 < 10)
            {
                _local_7 = ((_arg_2 == 1) ? new Point((_local_8 * 15), 0) : new Point(((9 - _local_8) * 15), 0));
                _local_6 = ((_arg_1 > 20) ? ((_local_5-- > 0) ? _local_10 : _local_3) : ((_arg_1 > 10) ? ((_local_5-- > 0) ? _local_9 : _local_3) : ((_local_5-- > 0) ? _local_11 : _local_3)));
                _local_4.copyPixels(_local_6, _local_6.rect, _local_7);
                _local_8++;
            };
            return (_local_4);
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function avatarImageReady(_arg_1:String):void
        {
            if (_SafeStr_2552.indexOf(_arg_1) == -1)
            {
                renderPlayers();
                _SafeStr_2552.push(_arg_1);
            };
        }

        private function getElement(_arg_1:IWindowContainer, _arg_2:String):IWindow
        {
            return (_arg_1.findChildByName(_arg_2));
        }

        private function getBitmap(_arg_1:String):BitmapData
        {
            return (_SafeStr_2499.assets.getAssetByName(_arg_1).content as BitmapData);
        }

        private function getAvatarFigure(_arg_1:int, _arg_2:String, _arg_3:String, _arg_4:int):BitmapData
        {
            var _local_5:IAvatarFigureContainer = _SafeStr_2499.avatarManager.createFigureContainer(_arg_2);
            switch (_arg_1)
            {
                case 1:
                    _local_5.updatePart("ch", 20000, [1]);
                    break;
                case 2:
                    _local_5.updatePart("ch", 20001, [1]);
                    break;
                default:
                    _local_5.updatePart("ch", 20000, [1]);
            };
            _local_5.removePart("cc");
            var _local_6:IAvatarImage = _SafeStr_2499.avatarManager.createAvatarImage(_local_5.getFigureString(), "h_50", _arg_3, this);
            if (_local_6)
            {
                _local_6.setDirection("full", _arg_4);
                return (_local_6.getCroppedImage("full"));
            };
            return (null);
        }

        public function showReadyPlayers(_arg_1:Array):void
        {
            var _local_3:SnowWarAnimatedWindowElement;
            for each (var _local_2:int in _arg_1)
            {
                _local_3 = _SafeStr_2550.remove(_local_2);
                if (_local_3)
                {
                    _local_3.dispose();
                };
            };
            if (_SafeStr_2550.length == 0)
            {
                _SafeStr_2550.add(-1, new SnowWarAnimatedWindowElement(_SafeStr_2499.assets, (_window.findChildByName("mainLoadingIcon") as IBitmapWrapperWindow), "load_", 8));
                WindowUtils.setCaption(_window.findChildByName("loadingText"), "${snowwar.loading_arena}");
            };
        }


    }
}

