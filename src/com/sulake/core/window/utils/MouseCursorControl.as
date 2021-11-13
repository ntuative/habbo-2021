package com.sulake.core.window.utils
{
    import flash.display.Stage;
    import flash.display.DisplayObject;
    import flash.utils.Dictionary;
    import flash.ui.Mouse;
    import flash.events.MouseEvent;
    import flash.events.Event;

    public class MouseCursorControl 
    {

        private static var _type:uint = 0;
        private static var _SafeStr_1161:Stage;
        private static var _visible:Boolean = true;
        private static var _disposed:Boolean = false;
        private static var _SafeStr_1198:Boolean = true;
        private static var _SafeStr_1199:DisplayObject;
        private static var _SafeStr_1200:Dictionary = new Dictionary();

        public function MouseCursorControl(_arg_1:DisplayObject)
        {
            _SafeStr_1161 = _arg_1.stage;
        }

        public static function dispose():void
        {
            if (!_disposed)
            {
                if (_SafeStr_1199)
                {
                    _SafeStr_1161.removeChild(_SafeStr_1199);
                    _SafeStr_1161.removeEventListener("mouseLeave", onStageMouseLeave);
                    _SafeStr_1161.removeEventListener("mouseMove", onStageMouseMove);
                    _SafeStr_1161.removeEventListener("mouseOver", onStageMouseMove);
                    _SafeStr_1161.removeEventListener("mouseOut", onStageMouseMove);
                };
                _disposed = true;
            };
        }

        public static function get disposed():Boolean
        {
            return (_disposed);
        }

        public static function get type():uint
        {
            return (_type);
        }

        public static function set type(_arg_1:uint):void
        {
            if (_type != _arg_1)
            {
                _type = _arg_1;
                _SafeStr_1198 = true;
            };
        }

        public static function get visible():Boolean
        {
            return (_visible);
        }

        public static function set visible(_arg_1:Boolean):void
        {
            _visible = _arg_1;
            if (_visible)
            {
                if (_SafeStr_1199)
                {
                    _SafeStr_1199.visible = true;
                }
                else
                {
                    Mouse.show();
                };
            }
            else
            {
                if (_SafeStr_1199)
                {
                    _SafeStr_1199.visible = false;
                }
                else
                {
                    Mouse.hide();
                };
            };
        }

        public static function change():void
        {
            var _local_1:DisplayObject;
            if (_SafeStr_1198)
            {
                _local_1 = _SafeStr_1200[_type];
                if (_local_1)
                {
                    if (_SafeStr_1199)
                    {
                        _SafeStr_1161.removeChild(_SafeStr_1199);
                    }
                    else
                    {
                        _SafeStr_1161.addEventListener("mouseLeave", onStageMouseLeave);
                        _SafeStr_1161.addEventListener("mouseMove", onStageMouseMove);
                        _SafeStr_1161.addEventListener("mouseOver", onStageMouseMove);
                        _SafeStr_1161.addEventListener("mouseOut", onStageMouseMove);
                        Mouse.hide();
                    };
                    _SafeStr_1199 = _local_1;
                    _SafeStr_1161.addChild(_SafeStr_1199);
                }
                else
                {
                    if (_SafeStr_1199)
                    {
                        _SafeStr_1161.removeChild(_SafeStr_1199);
                        _SafeStr_1161.removeEventListener("mouseLeave", onStageMouseLeave);
                        _SafeStr_1161.removeEventListener("mouseMove", onStageMouseMove);
                        _SafeStr_1161.removeEventListener("mouseOver", onStageMouseMove);
                        _SafeStr_1161.removeEventListener("mouseOut", onStageMouseMove);
                        _SafeStr_1199 = null;
                        Mouse.show();
                    };
                    switch (_type)
                    {
                        case 0:
                        case 1:
                            Mouse.cursor = "auto";
                            break;
                        case 2:
                            Mouse.cursor = "button";
                            break;
                        case 5:
                        case 6:
                        case 7:
                        case 8:
                            Mouse.cursor = "hand";
                            break;
                        case 0xFFFFFFFE:
                            Mouse.cursor = "auto";
                            Mouse.hide();
                    };
                };
                _SafeStr_1198 = false;
            };
        }

        public static function defineCustomCursorType(_arg_1:uint, _arg_2:DisplayObject):void
        {
            _SafeStr_1200[_arg_1] = _arg_2;
        }

        private static function onStageMouseMove(_arg_1:MouseEvent):void
        {
            if (_SafeStr_1199)
            {
                _SafeStr_1199.x = (_arg_1.stageX - 2);
                _SafeStr_1199.y = _arg_1.stageY;
                if (_type == 0)
                {
                    _visible = false;
                    Mouse.show();
                }
                else
                {
                    _visible = true;
                    Mouse.hide();
                };
            };
        }

        private static function onStageMouseLeave(_arg_1:Event):void
        {
            if (((_SafeStr_1199) && (!(_type == 0))))
            {
                Mouse.hide();
                _visible = false;
            };
        }


    }
}

