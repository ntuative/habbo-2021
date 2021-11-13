package com.sulake.habbo.game.snowwar.ui
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.avatar.IAvatarImageListener;
    import com.sulake.habbo.game.snowwar.SnowWarEngine;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.habbo.game.snowwar.utils.SnowWarAnimatedWindowElement;
    import flash.utils.Timer;
    import com.sulake.habbo.game.snowwar.utils.WindowUtils;
    import com.sulake.core.window.IWindow;
    import flash.display.BitmapData;
    import com.sulake.habbo.avatar.IAvatarImage;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.communication.messages.outgoing.game.arena.Game2ExitGameMessageComposer;
    import flash.events.TimerEvent;
    import flash.geom.Point;
    import com.sulake.core.assets.BitmapDataAsset;

    public class SnowWarUI implements IDisposable, IAvatarImageListener
    {

        private static const EMPTY_AMMO_FLASH_FRAMES:int = 4;
        private static const EMPTY_AMMO_FRAME_LENGTH:int = 75;
        private static const SCORE_FLASH_FRAMES:int = 4;
        private static const SCORE_FRAME_LENGTH:int = 50;
        private static const MAX_SNOWBALLS:int = 5;
        private static const MAX_ENERGY:int = 5;

        private var _SafeStr_2499:SnowWarEngine;
        private var _SafeStr_2558:IWindowContainer;
        private var _snowballs:IWindowContainer;
        private var _SafeStr_2559:IWindowContainer;
        private var _SafeStr_1163:IWindowContainer;
        private var _SafeStr_2481:IWindowContainer;
        private var _exitConfirmation:IWindowContainer;
        private var _checksumIndicatorColor:RGBColor;
        private var _tweenColor:RGBColor;
        private var _SafeStr_2560:IBitmapWrapperWindow;
        private var _disposed:Boolean = false;
        private var _SafeStr_2561:int = 1;
        private var _timeSinceLastUpdate:uint;
        private var _SafeStr_2562:int = -1;
        private var _SafeStr_2563:int = 5;
        private var _makeSnowballButton:IBitmapWrapperWindow;
        private var _makingSnowballs:Boolean = false;
        private var _SafeStr_2564:int = 5;
        private var _progressIcon:IBitmapWrapperWindow;
        private var _loadIcon:SnowWarAnimatedWindowElement;
        private var _emptyAmmoFlash:IBitmapWrapperWindow;
        private var _emptyAmmoAnimation:SnowWarAnimatedWindowElement;
        private var _scoreBackground:IBitmapWrapperWindow;
        private var _SafeStr_2565:int = 0;
        private var _scoreBackgroundAsset:String = "";
        private var _SafeStr_2566:Timer;
        private var _SafeStr_2557:Boolean;

        public function SnowWarUI(_arg_1:SnowWarEngine)
        {
            _SafeStr_2499 = _arg_1;
            _SafeStr_2499.windowManager.getDesktop(1).visible = false;
            _SafeStr_2557 = _SafeStr_2499.sessionDataManager.hasSecurity(4);
            if (_SafeStr_2557)
            {
                _checksumIndicatorColor = new RGBColor();
                _tweenColor = new RGBColor(0xFFFFFF);
            };
        }

        public function dispose():void
        {
            _SafeStr_2499.windowManager.getDesktop(1).visible = true;
            _SafeStr_2499 = null;
            if (_SafeStr_2558)
            {
                _SafeStr_2558.dispose();
                _SafeStr_2558 = null;
            };
            if (_snowballs)
            {
                _makeSnowballButton = null;
                _progressIcon = null;
                _emptyAmmoFlash = null;
                _snowballs.dispose();
                _snowballs = null;
            };
            if (_SafeStr_2559)
            {
                _scoreBackground = null;
                _SafeStr_2559.dispose();
                _SafeStr_2559 = null;
            };
            if (_SafeStr_1163)
            {
                _SafeStr_1163.dispose();
                _SafeStr_1163 = null;
            };
            if (_SafeStr_2481)
            {
                _SafeStr_2481.dispose();
                _SafeStr_2481 = null;
            };
            if (_SafeStr_2560)
            {
                _SafeStr_2560.dispose();
                _SafeStr_2560 = null;
            };
            if (_emptyAmmoAnimation != null)
            {
                _emptyAmmoAnimation.dispose();
                _emptyAmmoAnimation = null;
            };
            if (_exitConfirmation)
            {
                _exitConfirmation.dispose();
                _exitConfirmation = null;
            };
            if (_SafeStr_2566)
            {
                _SafeStr_2566.removeEventListener("timerComplete", onTimerHider);
                _SafeStr_2566.stop();
                _SafeStr_2566 = null;
            };
            disposeLoadIcon();
            _disposed = true;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function init():void
        {
            _SafeStr_2558 = (WindowUtils.createWindow("snowwar_exit") as IWindowContainer);
            _SafeStr_2558.addEventListener("WME_CLICK", onExit);
            _SafeStr_2558.x = 0;
            _SafeStr_2558.y = 10;
            _snowballs = (WindowUtils.createWindow("snowwar_snowballs") as IWindowContainer);
            var _local_1:IWindow = _snowballs.findChildByName("make_snowball");
            _local_1.addEventListener("WME_DOWN", onMakeSnowballDown);
            _local_1.addEventListener("WME_UP", onMakeSnowballUp);
            _local_1.addEventListener("WME_OUT", onMakeSnowballUp);
            _snowballs.center();
            _snowballs.x = 10;
            _makeSnowballButton = (_snowballs.findChildByName("makeSnowballImage") as IBitmapWrapperWindow);
            _emptyAmmoFlash = (_snowballs.findChildByName("emptyFlashImage") as IBitmapWrapperWindow);
            _emptyAmmoFlash.visible = false;
            _emptyAmmoAnimation = new SnowWarAnimatedWindowElement(_SafeStr_2499.assets, _emptyAmmoFlash, "ui_no_balls_", 4, 75, true);
            _progressIcon = (_snowballs.findChildByName("ballProgress") as IBitmapWrapperWindow);
            _SafeStr_2559 = (WindowUtils.createWindow("snowwar_own_stats") as IWindowContainer);
            _SafeStr_2559.x = 10;
            _SafeStr_2559.y = ((_SafeStr_2559.desktop.height - _SafeStr_2559.height) - 10);
            _scoreBackground = (_SafeStr_2559.findChildByName("backgroundFlashImage") as IBitmapWrapperWindow);
            updateUserImage();
            _SafeStr_2481 = (WindowUtils.createWindow("snowwar_team_scores") as IWindowContainer);
            _SafeStr_2481.x = ((_SafeStr_2481.desktop.width - _SafeStr_2481.width) - 10);
            _SafeStr_2481.y = 10;
            _SafeStr_1163 = (WindowUtils.createWindow("snowwar_timer") as IWindowContainer);
            _SafeStr_1163.x = ((_SafeStr_1163.desktop.width - _SafeStr_1163.width) - 50);
            _SafeStr_1163.y = 105;
            timer = 0;
            _SafeStr_2560 = (WindowUtils.createWindow("counter") as IBitmapWrapperWindow);
            _SafeStr_2560.center();
            if (_SafeStr_2557)
            {
                _SafeStr_1163.getChildByName("checksumIndicator").visible = true;
                _checksumIndicatorColor.fromInt(_SafeStr_1163.color);
            };
            _SafeStr_2563 = 5;
        }

        public function avatarImageReady(_arg_1:String):void
        {
            updateUserImage();
        }

        private function updateUserImage():void
        {
            var _local_1:BitmapData;
            var _local_3:String = _SafeStr_2499.sessionDataManager.figure;
            var _local_2:String = _SafeStr_2499.sessionDataManager.gender;
            var _local_4:IAvatarImage = _SafeStr_2499.avatarManager.createAvatarImage(_local_3, "h", _local_2, this);
            if (_local_4 != null)
            {
                _local_4.setDirection("full", 2);
                _local_1 = _local_4.getCroppedImage("head");
                _local_4.dispose();
                WindowUtils.setElementImage(_SafeStr_2559.findChildByName("user_image"), _local_1);
                _local_1.dispose();
            };
        }

        private function getBitmap(_arg_1:String):BitmapData
        {
            return (_SafeStr_2499.assets.getAssetByName(_arg_1).content as BitmapData);
        }

        private function getElement(_arg_1:IWindowContainer, _arg_2:String):IWindow
        {
            return (_arg_1.findChildByName(_arg_2));
        }

        private function onMakeSnowballDown(_arg_1:WindowMouseEvent):void
        {
            makeSnowballButtonPressed(true);
            if (_SafeStr_2499.makeSnowball())
            {
                startWaitingForSnowball();
            };
        }

        private function onMakeSnowballUp(_arg_1:WindowMouseEvent):void
        {
            makeSnowballButtonPressed(false);
        }

        public function startWaitingForSnowball():void
        {
            if (_loadIcon != null)
            {
                _loadIcon.dispose();
                _loadIcon = null;
            };
            _loadIcon = new SnowWarAnimatedWindowElement(_SafeStr_2499.assets, _progressIcon, "load_", 8);
            SnowWarEngine.playSound("HBSTG_snowwar_make_snowball");
        }

        public function stopWaitingForSnowball():void
        {
            disposeLoadIcon();
            SnowWarEngine.stopSound("HBSTG_snowwar_make_snowball");
            if (_makingSnowballs)
            {
                onMakeSnowballDown(null);
            };
        }

        private function disposeLoadIcon():void
        {
            if (_loadIcon != null)
            {
                _loadIcon.dispose();
                _loadIcon = null;
            };
        }

        private function onExit(_arg_1:WindowMouseEvent):void
        {
            if (!_exitConfirmation)
            {
                _exitConfirmation = (WindowUtils.createWindow("snowwar_exit_confirmation") as IWindowContainer);
                _exitConfirmation.findChildByName("yes").addEventListener("WME_CLICK", confirmationHandler);
                _exitConfirmation.findChildByName("no").addEventListener("WME_CLICK", confirmationHandler);
                _exitConfirmation.findChildByTag("close").addEventListener("WME_CLICK", confirmationHandler);
            }
            else
            {
                _exitConfirmation.visible = true;
                _exitConfirmation.activate();
            };
        }

        private function confirmationHandler(_arg_1:WindowMouseEvent):void
        {
            if (_arg_1.window.name == "yes")
            {
                _SafeStr_2499.send(new Game2ExitGameMessageComposer());
                _SafeStr_2499.resetGameSession();
                _SafeStr_2499.resetRoomSession();
            }
            else
            {
                _exitConfirmation.visible = false;
            };
        }

        public function set snowballs(_arg_1:int):void
        {
            var _local_3:int;
            _local_3 = 0;
            while (_local_3 < 5)
            {
                _snowballs.findChildByName(("ball_" + _local_3)).visible = (_local_3 < _arg_1);
                _local_3++;
            };
            _SafeStr_2564 = _arg_1;
            var _local_2:IWindow = _snowballs.findChildByName(("ball_" + _arg_1));
            if (_local_2 != null)
            {
                _progressIcon.x = _local_2.x;
                _progressIcon.y = _local_2.y;
            };
        }

        public function set ownScore(_arg_1:int):void
        {
            WindowUtils.setCaption(_SafeStr_2559.findChildByName("personal_score"), _arg_1.toString());
        }

        public function set timer(_arg_1:int):void
        {
            if (_SafeStr_2557)
            {
                if (_checksumIndicatorColor)
                {
                    _checksumIndicatorColor.tweenTo(_tweenColor);
                    _SafeStr_1163.getChildByName("checksumIndicator").color = _checksumIndicatorColor.rgb;
                };
            };
            if (_SafeStr_2562 == _arg_1)
            {
                return;
            };
            _SafeStr_2562 = _arg_1;
            var _local_2:String = ("" + int((_arg_1 / 60)));
            var _local_3:String = ("" + (_arg_1 % 60));
            if (Number(_local_2) < 10)
            {
                _local_2 = ("0" + _local_2);
            };
            if (Number(_local_3) < 10)
            {
                _local_3 = ("0" + _local_3);
            };
            WindowUtils.showElement(_SafeStr_1163, "time_left");
            WindowUtils.setCaption(_SafeStr_1163.findChildByName("time_left"), ((_local_2 + ":") + _local_3));
            if (((_arg_1 <= 5) && (_arg_1 > 0)))
            {
                SnowWarEngine.playSound("HBST_call_for_help");
                if (!_SafeStr_2566)
                {
                    _SafeStr_2566 = new Timer(500, 1);
                    _SafeStr_2566.addEventListener("timerComplete", onTimerHider);
                };
                _SafeStr_2566.reset();
                _SafeStr_2566.start();
            };
        }

        private function onTimerHider(_arg_1:TimerEvent):void
        {
            if (_SafeStr_1163)
            {
                WindowUtils.hideElement(_SafeStr_1163, "time_left");
            };
        }

        public function set hitPoints(_arg_1:int):void
        {
            if (_SafeStr_2563 != _arg_1)
            {
                WindowUtils.setElementImage(getElement(_SafeStr_2559, "energy_bar"), getBitmap(("ui_me_health_" + Math.min(5, _arg_1))));
                _SafeStr_2563 = _arg_1;
            };
        }

        public function showChecksumError(_arg_1:uint):void
        {
            if (_SafeStr_2557)
            {
                _SafeStr_1163.color = _arg_1;
                if (_checksumIndicatorColor)
                {
                    _checksumIndicatorColor.fromInt(_arg_1);
                };
            };
        }

        public function initCounter():void
        {
            _timeSinceLastUpdate = 0;
            _SafeStr_2561 = 1;
        }

        public function update(_arg_1:uint):void
        {
            updateAmmoDisplay();
            updateCounterImage(_arg_1);
            updateScoreFlash(_arg_1);
            updateTeamScores();
        }

        private function updateScoreFlash(_arg_1:uint):void
        {
            var _local_2:int;
            if (_SafeStr_2565 > 0)
            {
                _local_2 = int(((_SafeStr_2565 / 50) + 1));
                if (_local_2 > 4)
                {
                    _SafeStr_2565 = 0;
                    _scoreBackground.visible = false;
                }
                else
                {
                    _SafeStr_2565 = (_SafeStr_2565 + _arg_1);
                    _scoreBackground.visible = true;
                    WindowUtils.setElementImage(_scoreBackground, getBitmap((_scoreBackgroundAsset + _local_2)));
                };
            };
        }

        public function flashOwnScore(_arg_1:Boolean):void
        {
            _SafeStr_2565 = 1;
            _scoreBackgroundAsset = ((_arg_1) ? "ui_me_plus_" : "ui_me_minus_");
        }

        private function updateAmmoDisplay():void
        {
            _emptyAmmoFlash.visible = ((_SafeStr_2564 == 0) && (_loadIcon == null));
        }

        private function updateCounterImage(_arg_1:uint):void
        {
            var _local_2:BitmapData;
            var _local_3:Point;
            var _local_5:Boolean;
            _timeSinceLastUpdate = (_timeSinceLastUpdate + _arg_1);
            if (_SafeStr_2561 < 6)
            {
                if (_timeSinceLastUpdate >= 1000)
                {
                    _local_5 = true;
                    _timeSinceLastUpdate = 0;
                };
            }
            else
            {
                if (_SafeStr_2561 < 11)
                {
                    if (_timeSinceLastUpdate > 100)
                    {
                        _local_5 = true;
                        _timeSinceLastUpdate = 0;
                    };
                }
                else
                {
                    if (_SafeStr_2560)
                    {
                        _SafeStr_2560.dispose();
                        _SafeStr_2560 = null;
                    };
                };
            };
            if ((((!(_local_5)) || (_disposed)) || (!(_SafeStr_2560))))
            {
                return;
            };
            var _local_4:BitmapDataAsset = (_SafeStr_2499.assets.getAssetByName(padName("explosion", _SafeStr_2561)) as BitmapDataAsset);
            if (_local_4)
            {
                _local_2 = (_local_4.content as BitmapData);
                if (!_SafeStr_2560.bitmap)
                {
                    _SafeStr_2560.bitmap = new BitmapData(_SafeStr_2560.width, _SafeStr_2560.height, true, 0xFFFFFF);
                };
                _SafeStr_2560.bitmap.fillRect(_SafeStr_2560.bitmap.rect, 0xFFFFFF);
                _local_3 = new Point(-(_local_4.offset.x), -(_local_4.offset.y));
                _SafeStr_2560.bitmap.copyPixels(_local_2, _local_2.rect, _local_3, null, null, true);
                _SafeStr_2560.invalidate();
            };
            _SafeStr_2561++;
        }

        private function padName(_arg_1:String, _arg_2:int, _arg_3:int=4):String
        {
            var _local_4:String = _arg_2.toString();
            while (_local_4.length < _arg_3)
            {
                _local_4 = ("0" + _local_4);
            };
            return (_arg_1 + _local_4);
        }

        private function updateTeamScores():void
        {
            var _local_1:Array = _SafeStr_2499.gameArena.getTeamScores();
            if (_local_1.length >= 2)
            {
                WindowUtils.setCaption(_SafeStr_2481.findChildByName("score_blue"), _local_1[0]);
                WindowUtils.setCaption(_SafeStr_2481.findChildByName("score_red"), _local_1[1]);
            };
        }

        private function makeSnowballButtonPressed(_arg_1:Boolean):void
        {
            if (_makingSnowballs != _arg_1)
            {
                WindowUtils.setElementImage(_makeSnowballButton, getBitmap(("ui_make_balls_" + ((_arg_1) ? "down" : "up"))));
            };
            _makingSnowballs = _arg_1;
        }


    }
}class RGBColor
{

    private var _r:uint;
    private var _g:uint;
    private var _b:uint;
    private var _a:uint;

    public function RGBColor(_arg_1:uint=0)
    {
        fromInt(_arg_1);
    }

    public function get r():uint
    {
        return (_r);
    }

    public function get g():uint
    {
        return (_g);
    }

    public function get b():uint
    {
        return (_b);
    }

    public function get a():uint
    {
        return (_a);
    }

    public function fromInt(_arg_1:uint):void
    {
        _a = ((_arg_1 >> 24) & 0xFF);
        _r = ((_arg_1 >> 16) & 0xFF);
        _g = ((_arg_1 >> 8) & 0xFF);
        _b = ((_arg_1 >> 0) & 0xFF);
    }

    public function get rgb():uint
    {
        return ((((_a << 24) | (_r << 16)) | (_g << 8)) | _b);
    }

    public function tweenTo(_arg_1:RGBColor):void
    {
        _a = (_a + ((_arg_1.a - a) / 24));
        _r = (_r + ((_arg_1.r - r) / 24));
        _g = (_g + ((_arg_1.g - g) / 24));
        _b = (_b + ((_arg_1.b - b) / 24));
    }


}


// _SafeStr_1163 = "_-Mw" (String#537, DoABC#4)
// _SafeStr_2481 = "_-D1R" (String#9649, DoABC#4)
// _SafeStr_2499 = "_-MS" (String#887, DoABC#4)
// _SafeStr_2557 = "_-9i" (String#29463, DoABC#4)
// _SafeStr_2558 = "_-314" (String#29119, DoABC#4)
// _SafeStr_2559 = "_-yp" (String#31961, DoABC#4)
// _SafeStr_2560 = "_-o14" (String#31468, DoABC#4)
// _SafeStr_2561 = "_-p3" (String#31533, DoABC#4)
// _SafeStr_2562 = "_-Q1k" (String#30293, DoABC#4)
// _SafeStr_2563 = "_-K1M" (String#29966, DoABC#4)
// _SafeStr_2564 = "_-f1W" (String#31027, DoABC#4)
// _SafeStr_2565 = "_-Y0" (String#30667, DoABC#4)
// _SafeStr_2566 = "_-BT" (String#29558, DoABC#4)
