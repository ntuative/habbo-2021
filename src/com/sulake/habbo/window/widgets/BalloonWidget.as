package com.sulake.habbo.window.widgets
{
    import com.sulake.core.window.utils.PropertyStruct;
    import com.sulake.habbo.window.enum._SafeStr_220;
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.habbo.window.HabboWindowManagerComponent;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
    import com.sulake.core.window.iterators.EmptyIterator;
    import com.sulake.core.window.utils.IIterator;
    import com.sulake.core.window.events.WindowEvent;
    import flash.geom.Rectangle;
    import com.sulake.habbo.utils._SafeStr_25;

    public class BalloonWidget implements IBalloonWidget
    {

        public static const TYPE:String = "balloon";
        private static const ARROW_PIVOT_KEY:String = "balloon:arrow_pivot";
        private static const ARROW_DISPLACEMENT_KEY:String = "balloon:arrow_displacement";
        private static const ARROW_PIVOT_DEFAULT:PropertyStruct = new PropertyStruct("balloon:arrow_pivot", "up, center", "String", false, _SafeStr_220.ALL);
        private static const ARROW_DISPLACEMENT_DEFAULT:PropertyStruct = new PropertyStruct("balloon:arrow_displacement", 0, "int");
        private static const ARROW_ASSET_PREFIX:String = "illumina_light_balloon_arrow_";
        private static const ARROW_FREE_PADDING:int = 6;
        private static const ARROW_LENGTH:int = 6;
        private static const ARROW_WIDTH:int = 9;

        private var _disposed:Boolean;
        private var _SafeStr_4407:IWidgetWindow;
        private var _windowManager:HabboWindowManagerComponent;
        private var _SafeStr_4414:Boolean = false;
        private var _SafeStr_4415:Boolean = false;
        private var _SafeStr_1165:IWindowContainer;
        private var _SafeStr_4413:IWindowContainer;
        private var _SafeStr_4416:IStaticBitmapWrapperWindow;
        private var _arrowPivot:String = String(ARROW_PIVOT_DEFAULT.value);
        private var _arrowDisplacement:int = int(ARROW_DISPLACEMENT_DEFAULT.value);

        public function BalloonWidget(_arg_1:IWidgetWindow, _arg_2:HabboWindowManagerComponent)
        {
            _SafeStr_4407 = _arg_1;
            _windowManager = _arg_2;
            _SafeStr_1165 = (_windowManager.buildFromXML((_windowManager.assets.getAssetByName("balloon_xml").content as XML)) as IWindowContainer);
            _SafeStr_4416 = (_SafeStr_1165.findChildByName("bitmap") as IStaticBitmapWrapperWindow);
            _SafeStr_4413 = (_SafeStr_1165.findChildByName("border") as IWindowContainer);
            syncFlags();
            _SafeStr_4407.addEventListener("WE_RESIZE", onChange);
            _SafeStr_4407.addEventListener("WE_RESIZED", onChange);
            _SafeStr_4413.addEventListener("WE_RESIZE", onChange);
            _SafeStr_4413.addEventListener("WE_RESIZED", onChange);
            _SafeStr_4407.rootWindow = _SafeStr_1165;
            _SafeStr_1165.width = _SafeStr_4407.width;
            _SafeStr_1165.height = _SafeStr_4407.height;
        }

        public function dispose():void
        {
            if (!_disposed)
            {
                if (_SafeStr_4413 != null)
                {
                    _SafeStr_4413.removeEventListener("WE_RESIZE", onChange);
                    _SafeStr_4413.removeEventListener("WE_RESIZED", onChange);
                    _SafeStr_4413 = null;
                };
                _SafeStr_4416 = null;
                if (_SafeStr_1165 != null)
                {
                    _SafeStr_1165.dispose();
                    _SafeStr_1165 = null;
                };
                if (_SafeStr_4407 != null)
                {
                    _SafeStr_4407.removeEventListener("WE_RESIZE", onChange);
                    _SafeStr_4407.removeEventListener("WE_RESIZED", onChange);
                    _SafeStr_4407.rootWindow = null;
                    _SafeStr_4407 = null;
                };
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
            return ((_SafeStr_4413 == null) ? EmptyIterator.INSTANCE : _SafeStr_4413.iterator);
        }

        public function get properties():Array
        {
            var _local_1:Array = [];
            if (_disposed)
            {
                return (_local_1);
            };
            _local_1.push(ARROW_PIVOT_DEFAULT.withValue(_arrowPivot));
            _local_1.push(ARROW_DISPLACEMENT_DEFAULT.withValue(_arrowDisplacement));
            return (_local_1);
        }

        public function set properties(_arg_1:Array):void
        {
            _SafeStr_4414 = true;
            for each (var _local_2:PropertyStruct in _arg_1)
            {
                switch (_local_2.key)
                {
                    case "balloon:arrow_pivot":
                        arrowPivot = String(_local_2.value);
                        break;
                    case "balloon:arrow_displacement":
                        arrowDisplacement = int(_local_2.value);
                };
            };
            _SafeStr_4414 = false;
            refresh();
        }

        public function get arrowPivot():String
        {
            return (_arrowPivot);
        }

        public function set arrowPivot(_arg_1:String):void
        {
            _arrowPivot = _arg_1;
            clearFlags();
            refresh();
            syncFlags();
            refresh();
        }

        public function get arrowDisplacement():int
        {
            return (_arrowDisplacement);
        }

        public function set arrowDisplacement(_arg_1:int):void
        {
            _arrowDisplacement = _arg_1;
            refresh();
        }

        private function onChange(_arg_1:WindowEvent):void
        {
            refresh();
        }

        private function syncFlags():void
        {
            if (_SafeStr_4413 != null)
            {
                _SafeStr_4413.setParamFlag(0x20000, _SafeStr_4407.getParamFlag(0x20000));
                _SafeStr_4413.setParamFlag(147456, _SafeStr_4407.getParamFlag(147456));
            };
        }

        private function clearFlags():void
        {
            if (_SafeStr_4413 != null)
            {
                _SafeStr_4413.setParamFlag(0x20000, false);
                _SafeStr_4413.setParamFlag(147456, false);
            };
        }

        private function refresh():void
        {
            var _local_1:int;
            var _local_3:int;
            var _local_2:int;
            if (((((_SafeStr_4414) || (_SafeStr_4415)) || (_disposed)) || (_SafeStr_4413 == null)))
            {
                return;
            };
            var _local_4:String = _SafeStr_220.directionFromPivot(_arrowPivot);
            switch (_local_4)
            {
                case "up":
                case "down":
                    _local_1 = _SafeStr_4413.width;
                    _local_3 = ((_SafeStr_4413.height + 6) - 1);
                    break;
                case "left":
                case "right":
                    _local_1 = ((_SafeStr_4413.width + 6) - 1);
                    _local_3 = _SafeStr_4413.height;
            };
            _SafeStr_4415 = true;
            if (_SafeStr_4407.testParamFlag(147456))
            {
                _SafeStr_1165.width = _local_1;
                _SafeStr_1165.height = _local_3;
            }
            else
            {
                if (_SafeStr_4407.testParamFlag(0x20000))
                {
                    _SafeStr_1165.width = Math.max(_SafeStr_4407.width, _local_1);
                    _SafeStr_1165.height = Math.max(_SafeStr_4407.height, _local_3);
                }
                else
                {
                    _SafeStr_1165.width = _SafeStr_4407.width;
                    _SafeStr_1165.height = _SafeStr_4407.height;
                };
            };
            _SafeStr_4407.width = _SafeStr_1165.width;
            _SafeStr_4407.height = _SafeStr_1165.height;
            _SafeStr_4415 = false;
            _SafeStr_4416.assetUri = ("illumina_light_balloon_arrow_" + _local_4);
            switch (_local_4)
            {
                case "up":
                case "down":
                    switch (_SafeStr_220.positionFromPivot(_arrowPivot))
                    {
                        case "minimum":
                            _local_2 = 6;
                            break;
                        case "middle":
                            _local_2 = int(((_SafeStr_1165.width - 9) / 2));
                            break;
                        case "maximum":
                            _local_2 = ((_SafeStr_1165.width - 6) - 9);
                    };
                    _SafeStr_4415 = true;
                    _SafeStr_4413.rectangle = new Rectangle(0, ((_local_4 == "up") ? (6 - 1) : 0), _SafeStr_1165.width, ((_SafeStr_1165.height + 1) - 6));
                    _SafeStr_4415 = false;
                    _SafeStr_4416.rectangle = new Rectangle(_SafeStr_25.clamp((_local_2 + _arrowDisplacement), 6, (_SafeStr_1165.width - 6)), ((_local_4 == "up") ? 0 : (_SafeStr_4413.bottom - 1)), 9, 6);
                    return;
                case "left":
                case "right":
                    switch (_SafeStr_220.positionFromPivot(_arrowPivot))
                    {
                        case "minimum":
                            _local_2 = 6;
                            break;
                        case "middle":
                            _local_2 = int(((_SafeStr_1165.height - 9) / 2));
                            break;
                        case "maximum":
                            _local_2 = ((_SafeStr_1165.height - 6) - 9);
                    };
                    _SafeStr_4415 = true;
                    _SafeStr_4413.rectangle = new Rectangle(((_local_4 == "left") ? (6 - 1) : 0), 0, ((_SafeStr_1165.width + 1) - 6), _SafeStr_1165.height);
                    _SafeStr_4415 = false;
                    _SafeStr_4416.rectangle = new Rectangle(((_local_4 == "left") ? 0 : (_SafeStr_4413.right - 1)), _SafeStr_25.clamp((_local_2 + _arrowDisplacement), 6, (_SafeStr_1165.height - 6)), 6, 9);
                    return;
            };
        }


    }
}