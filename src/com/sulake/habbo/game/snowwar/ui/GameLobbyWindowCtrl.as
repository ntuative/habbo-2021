package com.sulake.habbo.game.snowwar.ui
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.avatar.IAvatarImageListener;
    import com.sulake.habbo.game.snowwar.SnowWarEngine;
    import com.sulake.core.window.IWindowContainer;
    import flash.utils.Timer;
    import com.sulake.core.utils.Map;
    import com.sulake.core.window.components.IItemGridWindow;
    import com.sulake.habbo.game.snowwar.utils.WindowUtils;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.communication.messages.outgoing.game.directory.Game2LeaveGameMessageComposer;
    import com.sulake.habbo.game.snowwar.utils.SnowWarAnimatedWindowElement;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.data.GameLobbyPlayerData;
    import flash.events.TimerEvent;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.habbo.avatar.IAvatarImage;
    import flash.display.BitmapData;
    import flash.geom.Point;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.habbo.localization.IHabboLocalizationManager;

    public class GameLobbyWindowCtrl implements IDisposable, IAvatarImageListener
    {

        private var _SafeStr_461:GamesMainViewController;
        private var _SafeStr_2499:SnowWarEngine;
        private var _levelName:String;
        private var _numberOfTeams:int;
        private var _numberOfPlayers:int;
        private var _maxNumberOfPlayers:int;
        private var _SafeStr_1665:IWindowContainer;
        private var _SafeStr_2547:Timer;
        private var _SafeStr_795:int = -1;
        private var _queuePosition:int = -1;
        private var _disposed:Boolean = false;
        private var _SafeStr_2553:Map;
        private var _SafeStr_2550:Map;

        public function GameLobbyWindowCtrl(_arg_1:GamesMainViewController, _arg_2:String, _arg_3:int, _arg_4:int)
        {
            _SafeStr_461 = _arg_1;
            _SafeStr_2499 = _arg_1.gameEngine;
            _SafeStr_2553 = new Map();
            _SafeStr_2550 = new Map();
            _levelName = _arg_2;
            _numberOfTeams = _arg_3;
            _numberOfPlayers = numberOfPlayers;
            _maxNumberOfPlayers = _arg_4;
        }

        private function createLobbyView():void
        {
            var _local_3:int;
            _SafeStr_1665 = (_SafeStr_461.rootWindow.findChildByName("snowwar_lobby_cont") as IWindowContainer);
            _SafeStr_1665.center();
            _SafeStr_1665.findChildByName("cancel_link_region").procedure = onCancel;
            var _local_2:IItemGridWindow = (_SafeStr_1665.findChildByName("players_grid") as IItemGridWindow);
            var _local_4:IWindowContainer = (WindowUtils.createWindow("snowwar_lobby_player") as IWindowContainer);
            _local_3 = 0;
            while (_local_3 < _maxNumberOfPlayers)
            {
                _local_2.addGridItem(_local_4.clone());
                _local_3++;
            };
            _local_4.dispose();
            _SafeStr_1665.visible = false;
        }

        private function createWindow(_arg_1:String):IWindowContainer
        {
            var _local_2:XmlAsset = (_SafeStr_2499.assets.getAssetByName(_arg_1) as XmlAsset);
            return (_SafeStr_2499.windowManager.buildFromXML((_local_2.content as XML)) as IWindowContainer);
        }

        private function onCancel(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            onClose(true);
            if (!_SafeStr_2499.gameCenterEnabled)
            {
                _SafeStr_461.openMainWindow(true);
            }
            else
            {
                _SafeStr_461.close(true);
            };
        }

        public function onClose(_arg_1:Boolean):void
        {
            if (_arg_1)
            {
                _SafeStr_2499.communication.connection.send(new Game2LeaveGameMessageComposer());
            };
            disposeCountdownTimer();
            _queuePosition = -1;
        }

        public function set visible(_arg_1:Boolean):void
        {
            if (!_SafeStr_1665)
            {
                createLobbyView();
            };
            _SafeStr_1665.visible = _arg_1;
        }

        public function get visible():Boolean
        {
            if (_SafeStr_1665)
            {
                return (_SafeStr_1665.visible);
            };
            return (false);
        }

        public function dispose():void
        {
            _disposed = true;
            if (_SafeStr_2550)
            {
                for each (var _local_1:SnowWarAnimatedWindowElement in _SafeStr_2550)
                {
                    _local_1.dispose();
                };
                _SafeStr_2550.dispose();
                _SafeStr_2550 = null;
            };
            if (_SafeStr_1665 != null)
            {
                _SafeStr_1665.dispose();
                _SafeStr_1665 = null;
            };
            disposeCountdownTimer();
            if (_SafeStr_2553)
            {
                _SafeStr_2553.dispose();
                _SafeStr_2553 = null;
            };
            _queuePosition = -1;
        }

        private function disposeCountdownTimer():void
        {
            if (_SafeStr_2547 != null)
            {
                _SafeStr_2547.removeEventListener("timer", onTick);
                _SafeStr_2547.stop();
                _SafeStr_2547 = null;
            };
            _SafeStr_795 = -1;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function playerLeft(_arg_1:int):void
        {
            _SafeStr_2553.remove(_arg_1);
            updateDialog(true);
        }

        public function playerJoined(_arg_1:GameLobbyPlayerData):void
        {
            if (_arg_1)
            {
                _SafeStr_2553.add(_arg_1.userId, _arg_1);
                updateDialog(true, _arg_1.figure);
            };
        }

        public function clearPlayerList():void
        {
            _SafeStr_2553.reset();
        }

        public function startCountdown(_arg_1:int):void
        {
            disposeCountdownTimer();
            _SafeStr_795 = _arg_1;
            _SafeStr_2547 = new Timer(1000, _arg_1);
            _SafeStr_2547.addEventListener("timer", onTick);
            _SafeStr_2547.start();
            updateDialog(false);
        }

        private function onTick(_arg_1:TimerEvent):void
        {
            if (_disposed)
            {
                return;
            };
            if (((_SafeStr_795) && (_SafeStr_795 > 0)))
            {
                _SafeStr_795--;
                HabboGamesCom.log(("on tick " + _SafeStr_795));
                updateDialog(false);
            };
        }

        public function stopCountdown():void
        {
            disposeCountdownTimer();
            updateDialog(false);
        }

        public function set queuePosition(_arg_1:int):void
        {
            _queuePosition = _arg_1;
        }

        private function updateDialog(_arg_1:Boolean, _arg_2:String=null):void
        {
            var _local_16:String;
            var _local_13:String;
            var _local_9:IRegionWindow;
            var _local_8:IBitmapWrapperWindow;
            var _local_15:SnowWarAnimatedWindowElement;
            var _local_10:IAvatarImage;
            var _local_4:BitmapData;
            var _local_6:Point;
            var _local_14:IWindow = (_SafeStr_1665.findChildByName("wait_text") as ITextWindow);
            var _local_5:IWindow = (_SafeStr_1665.findChildByName("wait_text_stroke") as ITextWindow);
            var _local_3:IHabboLocalizationManager = _SafeStr_2499.localization;
            if (_SafeStr_795 >= 0)
            {
                _local_16 = "snowwar.lobby_game_start_countdown";
                _local_3.registerParameter(_local_16, "seconds", String(_SafeStr_795));
                _local_13 = ((((_local_16 + " ") + "%seconds%") + " ") + _SafeStr_795);
            }
            else
            {
                if (_queuePosition >= 0)
                {
                    _local_16 = "snowwar.lobby_arena_queue_position";
                    _local_3.registerParameter(_local_16, "position", String(_queuePosition));
                    _local_13 = ((((_local_16 + " ") + "%position%") + " ") + _queuePosition);
                }
                else
                {
                    _local_16 = "snowwar.lobby_waiting_for_more_players";
                    _local_13 = _local_16;
                };
            };
            var _local_11:String = _local_3.getLocalization(_local_16);
            if (_local_11)
            {
                _local_14.caption = _local_11;
                _local_5.caption = _local_11;
            }
            else
            {
                _local_14.caption = _local_13;
                _local_5.caption = _local_13;
            };
            var _local_7:int;
            var _local_12:IItemGridWindow = (_SafeStr_1665.findChildByName("players_grid") as IItemGridWindow);
            if (_arg_1)
            {
                for each (var _local_17:GameLobbyPlayerData in _SafeStr_2553.getValues())
                {
                    _local_10 = null;
                    if (((_local_17.figure == _arg_2) || (!(_arg_2))))
                    {
                        _local_10 = _SafeStr_2499.avatarManager.createAvatarImage(_local_17.figure, "h", _local_17.gender, this);
                    };
                    if (_local_10)
                    {
                        _local_10.setDirection("head", 2);
                        _local_4 = _local_10.getCroppedImage("head");
                        _local_9 = (_local_12.getGridItemAt(_local_7) as IRegionWindow);
                        if (_local_9)
                        {
                            _local_9.toolTipCaption = _local_17.name;
                            _local_9.mouseThreshold = 0;
                            _local_8 = (_local_9.findChildByName("image") as IBitmapWrapperWindow);
                            _local_15 = _SafeStr_2550.remove(_local_8);
                            if (_local_15)
                            {
                                _local_15.dispose();
                            };
                            if (_local_8.bitmap)
                            {
                                _local_8.bitmap.dispose();
                            };
                            _local_8.bitmap = new BitmapData(_local_8.width, _local_8.height, true, 0);
                            _local_6 = new Point(((_local_8.width - _local_4.width) / 2), ((_local_8.height - _local_4.height) / 2));
                            _local_8.bitmap.copyPixels(_local_4, _local_4.rect, _local_6);
                        };
                        _local_4.dispose();
                        _local_10.dispose();
                    };
                    _local_7++;
                };
                while (_local_7 < maxNumberOfPlayers)
                {
                    _local_9 = (_local_12.getGridItemAt(_local_7) as IRegionWindow);
                    _local_8 = (_local_9.findChildByName("image") as IBitmapWrapperWindow);
                    if (!_SafeStr_2550.hasKey(_local_8))
                    {
                        _local_15 = new SnowWarAnimatedWindowElement(_SafeStr_2499.assets, _local_8, "load_", 8);
                        _SafeStr_2550.add(_local_8, _local_15);
                    };
                    _local_7++;
                };
            };
        }

        public function avatarImageReady(_arg_1:String):void
        {
            updateDialog(true, _arg_1);
        }

        public function get levelName():String
        {
            return (_levelName);
        }

        public function get numberOfTeams():int
        {
            return (_numberOfTeams);
        }

        public function get numberOfPlayers():int
        {
            return (_numberOfPlayers);
        }

        public function get maxNumberOfPlayers():int
        {
            return (_maxNumberOfPlayers);
        }

        public function set levelName(_arg_1:String):void
        {
            _levelName = _arg_1;
        }

        public function set maxNumberOfPlayers(_arg_1:int):void
        {
            _maxNumberOfPlayers = _arg_1;
        }

        public function set numberOfTeams(_arg_1:int):void
        {
            _numberOfTeams = _arg_1;
        }

        public function set numberOfPlayers(_arg_1:int):void
        {
            _numberOfPlayers = _arg_1;
        }

        public function set counter(_arg_1:int):void
        {
            _SafeStr_795 = _arg_1;
        }


    }
}