package com.sulake.habbo.window.widgets
{
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.core.window.utils.PropertyStruct;
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.habbo.window.HabboWindowManagerComponent;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.ITextWindow;
    import flash.utils.getTimer;
    import com.sulake.core.window.iterators.EmptyIterator;
    import com.sulake.core.window.utils.IIterator;

    public class CountdownWidget implements ICountdownWidget, IUpdateReceiver
    {

        public static const TYPE:String = "countdown";
        private static const RUNNING_KEY:String = "countdown:running";
        private static const _SafeStr_4417:String = "countdown:digits";
        private static const _SafeStr_4418:String = "countdown:seconds";
        private static const COLOR_STYLE_KEY:String = "countdown:color_style";
        private static const RUNNING_DEFAULT:PropertyStruct = new PropertyStruct("countdown:running", false, "Boolean");
        private static const DIGITS_DEFAULT:PropertyStruct = new PropertyStruct("countdown:digits", 3, "uint");
        private static const SECONDS_DEFAULT:PropertyStruct = new PropertyStruct("countdown:seconds", 0, "int");
        private static const COLOR_STYLE_DEFAULT:PropertyStruct = new PropertyStruct("countdown:color_style", 0, "int");
        private static const UNIT_KEY_PREFIX:String = "countdown_clock_unit_";
        private static const _SafeStr_4419:Array = ["weeks", "days", "hours", "minutes", "seconds"];
        private static const _SafeStr_4420:Array = [604800, 86400, 3600, 60, 1];
        private static const UNIT_MAX_VALUES:Array = [100, 7, 24, 60, 60];
        private static const COLOR_STYLES_VALUES:Array = [0, 0xFFFFFF];
        private static const COLOR_STYLES_ETCHING_VALUES:Array = [3003121663, 0];

        private var _disposed:Boolean;
        private var _SafeStr_4407:IWidgetWindow;
        private var _windowManager:HabboWindowManagerComponent;
        private var _SafeStr_1165:IItemListWindow;
        private var _SafeStr_4421:IWindowContainer;
        private var _SafeStr_4422:ITextWindow;
        private var _running:Boolean = RUNNING_DEFAULT.value;
        private var _startSeconds:int = int(SECONDS_DEFAULT.value);
        private var _startTime:int = getTimer();
        private var _colorStyle:int = int(COLOR_STYLE_DEFAULT.value);
        private var _displayedTime:int = -1;

        public function CountdownWidget(_arg_1:IWidgetWindow, _arg_2:HabboWindowManagerComponent)
        {
            _SafeStr_4407 = _arg_1;
            _windowManager = _arg_2;
            _SafeStr_1165 = (_windowManager.buildFromXML((_windowManager.assets.getAssetByName("clock_base_xml").content as XML)) as IItemListWindow);
            _SafeStr_4421 = (_SafeStr_1165.getListItemByName("counter") as IWindowContainer);
            _SafeStr_4422 = (_SafeStr_1165.getListItemByName("separator") as ITextWindow);
            digits = uint(DIGITS_DEFAULT.value);
            _windowManager.registerUpdateReceiver(this, 10);
            _SafeStr_4407.setParamFlag(147456);
            _SafeStr_4407.rootWindow = _SafeStr_1165;
        }

        private static function getMaxUnitIndex(_arg_1:int, _arg_2:int):int
        {
            var _local_3:int;
            _local_3 = 0;
            while (_local_3 < (_SafeStr_4420.length - _arg_1))
            {
                if (_arg_2 >= _SafeStr_4420[_local_3])
                {
                    return (_local_3);
                };
                _local_3++;
            };
            return (_local_3);
        }


        public function dispose():void
        {
            if (!_disposed)
            {
                if (_SafeStr_1165 != null)
                {
                    _SafeStr_1165.dispose();
                    _SafeStr_1165 = null;
                };
                if (_SafeStr_4421 != null)
                {
                    _SafeStr_4421.dispose();
                    _SafeStr_4421 = null;
                };
                if (_SafeStr_4422 != null)
                {
                    _SafeStr_4422.dispose();
                    _SafeStr_4422 = null;
                };
                if (_SafeStr_4407 != null)
                {
                    _SafeStr_4407.rootWindow = null;
                    _SafeStr_4407 = null;
                };
                _windowManager.removeUpdateReceiver(this);
                _windowManager = null;
                _disposed = true;
            };
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get iterator():IIterator
        {
            return (EmptyIterator.INSTANCE);
        }

        public function update(_arg_1:uint):void
        {
            updateTime();
        }

        public function get properties():Array
        {
            var _local_1:Array = [];
            if (_disposed)
            {
                return (_local_1);
            };
            _local_1.push(RUNNING_DEFAULT.withValue(_running));
            _local_1.push(DIGITS_DEFAULT.withValue(digits));
            _local_1.push(SECONDS_DEFAULT.withValue(seconds));
            return (_local_1);
        }

        public function set properties(_arg_1:Array):void
        {
            if (_disposed)
            {
                return;
            };
            for each (var _local_2:PropertyStruct in _arg_1)
            {
                switch (_local_2.key)
                {
                    case "countdown:running":
                        running = _local_2.value;
                        break;
                    case "countdown:digits":
                        digits = uint(_local_2.value);
                        break;
                    case "countdown:seconds":
                        seconds = int(_local_2.value);
                        break;
                    case "countdown:color_style":
                        colorStyle = int(_local_2.value);
                };
            };
        }

        public function get colorStyle():int
        {
            return (_colorStyle);
        }

        public function set colorStyle(_arg_1:int):void
        {
            var _local_3:int;
            var _local_2:IWindowContainer;
            var _local_5:ITextWindow;
            var _local_6:uint;
            var _local_7:uint;
            _colorStyle = _arg_1;
            var _local_4:int = _SafeStr_1165.numListItems;
            _local_3 = 0;
            while (_local_3 < _local_4)
            {
                _local_2 = (_SafeStr_1165.getListItemAt(_local_3) as IWindowContainer);
                if (_local_2 != null)
                {
                    _local_5 = (_local_2.getChildByName("unit") as ITextWindow);
                    if (_local_5 != null)
                    {
                        _local_6 = _local_5.textColor;
                        _local_7 = _local_5.etchingColor;
                        if (((colorStyle >= 0) && (colorStyle < COLOR_STYLES_VALUES.length)))
                        {
                            _local_6 = COLOR_STYLES_VALUES[colorStyle];
                            _local_7 = COLOR_STYLES_ETCHING_VALUES[colorStyle];
                        };
                        _local_5.textColor = _local_6;
                        _local_5.etchingColor = _local_7;
                    };
                };
                _local_3++;
            };
        }

        public function get running():Boolean
        {
            return (_running);
        }

        public function set running(_arg_1:Boolean):void
        {
            if (((_running) && (!(_arg_1))))
            {
                _startSeconds = seconds;
            };
            if (((!(_running)) && (_arg_1)))
            {
                _startTime = getTimer();
            };
            _running = _arg_1;
        }

        public function get digits():uint
        {
            return ((_SafeStr_1165.numListItems + 1) / 2);
        }

        public function set digits(_arg_1:uint):void
        {
            var _local_2:int;
            _arg_1 = Math.max(2, Math.min(4, _arg_1));
            if (_arg_1 != digits)
            {
                _SafeStr_1165.removeListItems();
                _local_2 = 0;
                while (_local_2 < _arg_1)
                {
                    if (_local_2 != 0)
                    {
                        _SafeStr_1165.addListItem(_SafeStr_4422.clone());
                    };
                    _SafeStr_1165.addListItem(_SafeStr_4421.clone());
                    _local_2++;
                };
                updateTime(true);
            };
        }

        public function get seconds():int
        {
            return ((_running) ? Math.max(0, (_startSeconds - ((getTimer() - _startTime) / 1000))) : _startSeconds);
        }

        public function set seconds(_arg_1:int):void
        {
            _startSeconds = _arg_1;
            _startTime = getTimer();
            updateTime();
        }

        private function updateTime(_arg_1:Boolean=false):void
        {
            var _local_5:int;
            var _local_8:int;
            var _local_3:IWindowContainer;
            var _local_7:int;
            var _local_6:int = seconds;
            if (((_local_6 == _displayedTime) && (!(_arg_1))))
            {
                return;
            };
            var _local_4:int = digits;
            var _local_2:int = getMaxUnitIndex(_local_4, _local_6);
            _local_5 = 0;
            while (_local_5 < _local_4)
            {
                _local_8 = (_local_2 + _local_5);
                _local_3 = (_SafeStr_1165.getListItemAt((_local_5 * 2)) as IWindowContainer);
                _local_7 = int(((_local_6 / _SafeStr_4420[_local_8]) % UNIT_MAX_VALUES[_local_8]));
                _local_3.getChildByName("value").caption = (((_local_7 < 10) ? "0" : "") + _local_7.toString());
                _local_3.getChildByName("unit").caption = (("${countdown_clock_unit_" + _SafeStr_4419[_local_8]) + "}");
                _local_5++;
            };
            _displayedTime = _local_6;
        }


    }
}