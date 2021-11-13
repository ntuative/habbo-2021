package com.sulake.habbo.window.widgets
{
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.core.window.utils.PropertyStruct;
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.habbo.window.HabboWindowManagerComponent;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.iterators.EmptyIterator;
    import com.sulake.core.window.utils.IIterator;
    import com.sulake.core.window.components.ITextWindow;

    public class RunningNumberWidget implements IRunningNumberWidget, IUpdateReceiver
    {

        public static const TYPE:String = "running_number";
        private static const NUMBER_KEY:String = "running_number:number";
        private static const _SafeStr_4417:String = "running_number:digits";
        private static const COLOR_STYLE_KEY:String = "running_number:color_style";
        private static const _SafeStr_4446:String = "running_number:update_frequency";
        private static const NUMBER_DEFAULT:PropertyStruct = new PropertyStruct("running_number:number", 0, "int");
        private static const DIGITS_DEFAULT:PropertyStruct = new PropertyStruct("running_number:digits", 8, "uint");
        private static const COLOR_STYLE_DEFAULT:PropertyStruct = new PropertyStruct("running_number:color_style", 0, "int");
        private static const UPDATE_FREQUENCY_DEFAULT:PropertyStruct = new PropertyStruct("running_number:update_frequency", 50, "int");

        private var _disposed:Boolean;
        private var _SafeStr_4407:IWidgetWindow;
        private var _windowManager:HabboWindowManagerComponent;
        private var _SafeStr_1165:IWindowContainer;
        private var _colorStyle:int = int(COLOR_STYLE_DEFAULT.value);
        private var _digits:uint = uint(DIGITS_DEFAULT.value);
        private var _updateFrequency:int = int(UPDATE_FREQUENCY_DEFAULT.value);
        private var _number:int = int(NUMBER_DEFAULT.value);
        private var _displayedNumber:Number = 0;
        private var _millisSinceLastUpdate:uint = 0;

        public function RunningNumberWidget(_arg_1:IWidgetWindow, _arg_2:HabboWindowManagerComponent)
        {
            _SafeStr_4407 = _arg_1;
            _windowManager = _arg_2;
            _SafeStr_1165 = (_windowManager.buildFromXML((_windowManager.assets.getAssetByName("running_number_xml").content as XML)) as IWindowContainer);
            _windowManager.registerUpdateReceiver(this, _updateFrequency);
            _SafeStr_4407.setParamFlag(147456);
            _SafeStr_4407.rootWindow = _SafeStr_1165;
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

        public function get properties():Array
        {
            var _local_1:Array = [];
            if (_disposed)
            {
                return (_local_1);
            };
            _local_1.push(NUMBER_DEFAULT.withValue(colorStyle));
            _local_1.push(COLOR_STYLE_DEFAULT.withValue(colorStyle));
            _local_1.push(DIGITS_DEFAULT.withValue(digits));
            _local_1.push(UPDATE_FREQUENCY_DEFAULT.withValue(updateFrequency));
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
                    case "running_number:number":
                        number = int(_local_2.value);
                        break;
                    case "running_number:digits":
                        digits = uint(_local_2.value);
                        break;
                    case "running_number:color_style":
                        colorStyle = int(_local_2.value);
                        break;
                    case "running_number:update_frequency":
                        updateFrequency = int(_local_2.value);
                };
            };
        }

        public function get iterator():IIterator
        {
            return (EmptyIterator.INSTANCE);
        }

        public function update(_arg_1:uint):void
        {
            if (_displayedNumber < number)
            {
                _millisSinceLastUpdate = (_millisSinceLastUpdate + _arg_1);
                if (_millisSinceLastUpdate > _updateFrequency)
                {
                    _displayedNumber = Math.min(_number, (_displayedNumber + (_millisSinceLastUpdate / _updateFrequency)));
                    _millisSinceLastUpdate = (_millisSinceLastUpdate - _updateFrequency);
                };
                fieldValue = _displayedNumber;
            };
        }

        private function set fieldValue(_arg_1:uint):void
        {
            var _local_3:String = _arg_1.toString();
            while (_local_3.length < _digits)
            {
                _local_3 = ("0" + _local_3);
            };
            var _local_2:ITextWindow = ITextWindow(_SafeStr_1165.findChildByName("number_field"));
            _local_2.text = _local_3;
            _local_2.invalidate();
        }

        public function get digits():uint
        {
            return (_digits);
        }

        public function set digits(_arg_1:uint):void
        {
            _digits = _arg_1;
        }

        public function get colorStyle():int
        {
            return (_colorStyle);
        }

        public function set colorStyle(_arg_1:int):void
        {
            _colorStyle = _arg_1;
        }

        public function get updateFrequency():int
        {
            return (_updateFrequency);
        }

        public function set updateFrequency(_arg_1:int):void
        {
            _updateFrequency = _arg_1;
        }

        public function get number():int
        {
            return (_number);
        }

        public function set number(_arg_1:int):void
        {
            _number = _arg_1;
        }

        public function set initialNumber(_arg_1:int):void
        {
            _displayedNumber = _arg_1;
            _number = _arg_1;
            fieldValue = _displayedNumber;
        }


    }
}