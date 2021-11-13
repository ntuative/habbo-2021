package com.sulake.habbo.toolbar.extensions.purse
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
    import __AS3__.vec.Vector;
    import flash.utils.Timer;
    import flash.events.IEventDispatcher;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.components.ITextWindow;
    import flash.events.TimerEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.utils._SafeStr_25;

    public class CurrencyIndicatorBase implements ICurrencyIndicator 
    {

        protected static const _SafeStr_3771:int = 0;
        protected static const _SafeStr_3772:int = 1;
        private static const _SafeStr_3773:Number = 0.025;

        protected var _window:IWindowContainer;
        protected var _windowManager:IHabboWindowManager;
        protected var _assets:IAssetLibrary;
        private var _disposed:Boolean = false;
        private var _SafeStr_3774:IStaticBitmapWrapperWindow;
        private var _SafeStr_3775:uint;
        private var _SafeStr_3776:uint;
        private var _textElementName:String;
        private var _SafeStr_3777:Vector.<String> = new Vector.<String>();
        private var _SafeStr_3778:uint;
        private var _amountZeroText:String = null;
        private var _animDirection:uint = 0;
        private var _animOffset:int;
        private var _SafeStr_3779:Timer;
        private var _overlayTimer:Timer;
        private var _overlayPhase:Number;
        private var _overlayStartValue:int;
        private var _overlayEndValue:int;

        public function CurrencyIndicatorBase(_arg_1:IHabboWindowManager, _arg_2:IAssetLibrary)
        {
            _window = null;
            _windowManager = _arg_1;
            _assets = _arg_2;
            _SafeStr_3779 = null;
            _overlayTimer = new Timer(40);
            _overlayTimer.addEventListener("timer", onOverlayTimer);
        }

        protected function set bgColorLight(_arg_1:uint):void
        {
            _SafeStr_3775 = _arg_1;
        }

        protected function set bgColorDark(_arg_1:uint):void
        {
            _SafeStr_3776 = _arg_1;
        }

        protected function set textElementName(_arg_1:String):void
        {
            _textElementName = _arg_1;
        }

        protected function set iconAnimationDelay(_arg_1:uint):void
        {
            _SafeStr_3778 = _arg_1;
        }

        protected function set amountZeroText(_arg_1:String):void
        {
            _amountZeroText = _arg_1;
        }

        protected function get amountZeroText():String
        {
            return (_amountZeroText);
        }

        public function get window():IWindowContainer
        {
            return (_window);
        }

        public function dispose():void
        {
            if (_disposed)
            {
                return;
            };
            if (_overlayTimer != null)
            {
                _overlayTimer.stop();
                _overlayTimer = null;
            };
            if (_SafeStr_3779)
            {
                _SafeStr_3779.stop();
                _SafeStr_3779 = null;
            };
            if (_SafeStr_3777)
            {
                _SafeStr_3777 = null;
            };
            if (_window)
            {
                _window.dispose();
                _window = null;
            };
            _disposed = true;
        }

        public function registerUpdateEvents(_arg_1:IEventDispatcher):void
        {
        }

        public function unregisterUpdateEvents(_arg_1:IEventDispatcher):void
        {
        }

        protected function onContainerClick(_arg_1:WindowMouseEvent):void
        {
        }

        protected function createWindow(_arg_1:String, _arg_2:String):void
        {
            var _local_4:Array;
            var _local_3:XmlAsset = (_assets.getAssetByName(_arg_1) as XmlAsset);
            if (_local_3)
            {
                _window = (_windowManager.buildFromXML((_local_3.content as XML), 1) as IWindowContainer);
                if (_window)
                {
                    _window.addEventListener("WME_CLICK", onContainerClick);
                    _window.addEventListener("WME_OVER", onContainerMouseOver);
                    _window.addEventListener("WME_OUT", onContainerMouseOut);
                    _local_4 = [];
                    if (_window.groupChildrenWithTag("ICON", _local_4, -1) == 1)
                    {
                        _SafeStr_3774 = (_local_4[0] as IStaticBitmapWrapperWindow);
                        setIconBitmap(_arg_2);
                    };
                };
            };
        }

        protected function animateIcon(_arg_1:int):void
        {
            _animDirection = _arg_1;
            if (((_SafeStr_3774) && (_SafeStr_3777.length > 0)))
            {
                if (_animDirection == 0)
                {
                    _animOffset = 0;
                }
                else
                {
                    _animOffset = (_SafeStr_3777.length - 1);
                };
                _SafeStr_3779 = new Timer(_SafeStr_3778, _SafeStr_3777.length);
                _SafeStr_3779.addEventListener("timer", onAnimationTimer);
                _SafeStr_3779.addEventListener("timerComplete", onAnimationTimerComplete);
                _SafeStr_3779.start();
                onAnimationTimer(null);
            };
        }

        protected function setAmount(_arg_1:int, _arg_2:int=-1):void
        {
            setText(_arg_1.toString());
        }

        protected function setText(_arg_1:String):void
        {
            if (_window)
            {
                _window.findChildByName(_textElementName).caption = _arg_1;
            };
        }

        protected function setTextUnderline(_arg_1:Boolean):void
        {
            if (_window)
            {
                ITextWindow(_window.findChildByName(_textElementName)).underline = _arg_1;
            };
        }

        protected function set iconAnimationSequence(_arg_1:Array):void
        {
            var _local_2:String;
            for each (_local_2 in _arg_1)
            {
                _SafeStr_3777.push(_local_2);
            };
        }

        private function onAnimationTimer(_arg_1:TimerEvent):void
        {
            if (((_SafeStr_3774) && (_SafeStr_3777.length > 0)))
            {
                setIconBitmap(_SafeStr_3777[_animOffset]);
                if (_animDirection == 0)
                {
                    _animOffset++;
                    _animOffset = ((_animOffset < _SafeStr_3777.length) ? _animOffset : (_SafeStr_3777.length - 1));
                }
                else
                {
                    _animOffset--;
                    _animOffset = ((_animOffset >= 0) ? _animOffset : 0);
                };
            };
        }

        private function onAnimationTimerComplete(_arg_1:TimerEvent):void
        {
            if (_SafeStr_3777.length > 0)
            {
                setIconBitmap(_SafeStr_3777[0]);
            };
        }

        private function setIconBitmap(_arg_1:String):void
        {
            if (_SafeStr_3774)
            {
                _SafeStr_3774.assetUri = _arg_1;
            };
        }

        private function onContainerMouseOver(_arg_1:WindowMouseEvent):void
        {
            _window.findChildByTag("BGCOLOR").color = _SafeStr_3775;
        }

        private function onContainerMouseOut(_arg_1:WindowMouseEvent):void
        {
            _window.findChildByTag("BGCOLOR").color = _SafeStr_3776;
        }

        protected function animateChange(_arg_1:int, _arg_2:int):void
        {
            var _local_3:IWindow;
            _overlayPhase = 0;
            _overlayStartValue = _arg_1;
            _overlayEndValue = _arg_2;
            if (_window != null)
            {
                _local_3 = _window.findChildByName("change");
                if (_local_3 != null)
                {
                    _local_3.caption = (((_arg_2 > _arg_1) ? "+" : "") + (_arg_2 - _arg_1).toString());
                };
            };
            _overlayTimer.start();
            onOverlayTimer(null);
        }

        private function onOverlayTimer(_arg_1:TimerEvent):void
        {
            var _local_3:Number = ((Math.pow((_overlayPhase - 0.5), 3) * 4) + 0.5);
            setAmount(_SafeStr_25.lerp(Math.max(0, ((_overlayPhase * 2) - 1)), _overlayStartValue, _overlayEndValue));
            var _local_2:IWindowContainer = (_window.findChildByName("change_overlay") as IWindowContainer);
            if (_local_2 == null)
            {
                return;
            };
            _local_2.visible = true;
            _local_2.blend = (1 - (Math.abs((0.5 - _local_3)) * 2));
            _local_2.x = _SafeStr_25.lerp(_local_3, 0, (_window.width - _local_2.width));
            _overlayPhase = (_overlayPhase + 0.025);
            if (_overlayPhase >= 1)
            {
                _local_2.visible = false;
                _overlayTimer.stop();
                setAmount(_overlayEndValue);
            };
        }


    }
}

