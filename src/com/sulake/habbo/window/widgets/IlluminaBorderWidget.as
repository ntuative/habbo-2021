package com.sulake.habbo.window.widgets
{
    import com.sulake.core.window.utils.PropertyStruct;
    import flash.geom.Matrix;
    import flash.utils.Dictionary;
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.habbo.window.HabboWindowManagerComponent;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.display.BitmapData;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.utils.IIterator;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.window.IWindow;
    import flash.geom.Rectangle;

    public class IlluminaBorderWidget implements IIlluminaBorderWidget
    {

        public static const TYPE:String = "illumina_border";
        public static const BORDER_STYLE_ILLUMINA_LIGHT:String = "illumina_light";
        public static const BORDER_STYLE_ILLUMINA_DARK:String = "illumina_dark";
        public static const BORDER_STYLES:Array = ["illumina_light", "illumina_dark"];
        public static const BORDER_STYLE_KEY:String = "illumina_border:border_style";
        private static const CONTENT_CHILD_KEY:String = "illumina_border:content_child";
        private static const CONTENT_PADDING_KEY:String = "illumina_border:content_padding";
        private static const SIDE_PADDING_KEY:String = "illumina_border:side_padding";
        private static const CHILD_MARGIN_KEY:String = "illumina_border:child_margin";
        private static const TOP_LEFT_CHILD_KEY:String = "illumina_border:top_left_child";
        private static const TOP_CENTER_CHILD_KEY:String = "illumina_border:top_center_child";
        private static const TOP_RIGHT_CHILD_KEY:String = "illumina_border:top_right_child";
        private static const BOTTOM_LEFT_CHILD_KEY:String = "illumina_border:bottom_left_child";
        private static const BOTTOM_CENTER_CHILD_KEY:String = "illumina_border:bottom_center_child";
        private static const BOTTOM_RIGHT_CHILD_KEY:String = "illumina_border:bottom_right_child";
        private static const LANDING_VIEW_MODE_KEY:String = "illumina_border:landing_view_mode";
        private static const CONTENT_CHILD_DEFAULT:PropertyStruct = new PropertyStruct("illumina_border:content_child", "", "String");
        private static const CONTENT_PADDING_DEFAULT:PropertyStruct = new PropertyStruct("illumina_border:content_padding", 5, "uint");
        private static const SIDE_PADDING_DEFAULT:PropertyStruct = new PropertyStruct("illumina_border:side_padding", 15, "uint");
        private static const CHILD_MARGIN_DEFAULT:PropertyStruct = new PropertyStruct("illumina_border:child_margin", 3, "uint");
        private static const TOP_LEFT_CHILD_DEFAULT:PropertyStruct = new PropertyStruct("illumina_border:top_left_child", "", "String");
        private static const TOP_CENTER_CHILD_DEFAULT:PropertyStruct = new PropertyStruct("illumina_border:top_center_child", "", "String");
        private static const TOP_RIGHT_CHILD_DEFAULT:PropertyStruct = new PropertyStruct("illumina_border:top_right_child", "", "String");
        private static const BOTTOM_LEFT_CHILD_DEFAULT:PropertyStruct = new PropertyStruct("illumina_border:bottom_left_child", "", "String");
        private static const BOTTOM_CENTER_CHILD_DEFAULT:PropertyStruct = new PropertyStruct("illumina_border:bottom_center_child", "", "String");
        private static const BOTTOM_RIGHT_CHILD_DEFAULT:PropertyStruct = new PropertyStruct("illumina_border:bottom_right_child", "", "String");
        private static const LANDING_VIEW_MODE_DEFAULT:PropertyStruct = new PropertyStruct("illumina_border:landing_view_mode", false, "Boolean");
        private static const MATRIX:Matrix = new Matrix();
        private static const TOP_LEFT:String = "top_left";
        private static const TOP:String = "top_center";
        private static const TOP_RIGHT:String = "top_right";
        private static const RIGHT:String = "center_right";
        private static const BOTTOM_RIGHT:String = "bottom_right";
        private static const BOTTOM:String = "bottom_center";
        private static const BOTTOM_LEFT:String = "bottom_left";
        private static const _SafeStr_1033:String = "center_left";
        private static const BORDER_PIECES:Array = ["top_left", "top_center", "top_right", "center_right", "bottom_right", "bottom_center", "bottom_left", "center_left"];

        private var _SafeStr_4428:Dictionary;
        private var _disposed:Boolean;
        private var _SafeStr_4407:IWidgetWindow;
        private var _windowManager:HabboWindowManagerComponent;
        private var _SafeStr_1165:IWindowContainer;
        private var _SafeStr_1267:IBitmapWrapperWindow;
        private var _SafeStr_4429:BitmapData;
        private var _children:IWindowContainer;
        private var _SafeStr_4414:Boolean = false;
        private var _SafeStr_4415:Boolean = false;
        private var _borderStyle:String;
        private var _contentChild:String = String(CONTENT_CHILD_DEFAULT.value);
        private var _contentPadding:uint = uint(CONTENT_PADDING_DEFAULT.value);
        private var _sidePadding:uint = uint(SIDE_PADDING_DEFAULT.value);
        private var _childMargin:uint = uint(CHILD_MARGIN_DEFAULT.value);
        private var _topLeftChild:String = String(TOP_LEFT_CHILD_DEFAULT.value);
        private var _topCenterChild:String = String(TOP_CENTER_CHILD_DEFAULT.value);
        private var _topRightChild:String = String(TOP_RIGHT_CHILD_DEFAULT.value);
        private var _bottomLeftChild:String = String(BOTTOM_LEFT_CHILD_DEFAULT.value);
        private var _bottomCenterChild:String = String(BOTTOM_CENTER_CHILD_DEFAULT.value);
        private var _bottomRightChild:String = String(BOTTOM_RIGHT_CHILD_DEFAULT.value);
        private var _landingViewMode:Boolean = LANDING_VIEW_MODE_DEFAULT.value;

        public function IlluminaBorderWidget(_arg_1:IWidgetWindow, _arg_2:HabboWindowManagerComponent)
        {
            _SafeStr_4407 = _arg_1;
            _windowManager = _arg_2;
            _SafeStr_1165 = (_windowManager.buildFromXML((_windowManager.assets.getAssetByName("illumina_border_xml").content as XML)) as IWindowContainer);
            _SafeStr_1267 = (_SafeStr_1165.getChildByName("canvas") as IBitmapWrapperWindow);
            _children = (_SafeStr_1165.getChildByName("children") as IWindowContainer);
            borderStyle = String(_SafeStr_4407.getDefaultProperty("illumina_border:border_style").value);
            _SafeStr_4407.addEventListener("WE_RESIZE", onChange);
            _SafeStr_4407.addEventListener("WE_RESIZED", onChange);
            _children.addEventListener("WE_CHILD_ADDED", onChange);
            _children.addEventListener("WE_CHILD_REMOVED", onChange);
            _children.addEventListener("WE_CHILD_RELOCATED", onChange);
            _children.addEventListener("WE_CHILD_RESIZED", onChange);
            _SafeStr_4407.rootWindow = _SafeStr_1165;
            _SafeStr_1165.width = _SafeStr_4407.width;
            _SafeStr_1165.height = _SafeStr_4407.height;
        }

        private function onChange(_arg_1:WindowEvent):void
        {
            refresh();
        }

        public function dispose():void
        {
            if (!_disposed)
            {
                if (_SafeStr_4429 != null)
                {
                    _SafeStr_4429.dispose();
                    _SafeStr_4429 = null;
                };
                if (_SafeStr_1267 != null)
                {
                    _SafeStr_1267.removeEventListener("WE_RESIZE", onChange);
                    _SafeStr_1267.removeEventListener("WE_RESIZED", onChange);
                    _SafeStr_1267 = null;
                };
                if (_children != null)
                {
                    _children.removeEventListener("WE_CHILD_ADDED", onChange);
                    _children.removeEventListener("WE_CHILD_REMOVED", onChange);
                    _children.removeEventListener("WE_CHILD_RELOCATED", onChange);
                    _children.removeEventListener("WE_CHILD_RESIZED", onChange);
                    _children = null;
                };
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
                _SafeStr_4428 = null;
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
            return (_children.iterator);
        }

        public function get properties():Array
        {
            var _local_1:Array = [];
            if (_disposed)
            {
                return (_local_1);
            };
            _local_1.push(_SafeStr_4407.createProperty("illumina_border:border_style", _borderStyle));
            _local_1.push(CONTENT_CHILD_DEFAULT.withValue(_contentChild));
            _local_1.push(CONTENT_PADDING_DEFAULT.withValue(_contentPadding));
            _local_1.push(SIDE_PADDING_DEFAULT.withValue(_sidePadding));
            _local_1.push(CHILD_MARGIN_DEFAULT.withValue(_childMargin));
            _local_1.push(TOP_LEFT_CHILD_DEFAULT.withValue(_topLeftChild));
            _local_1.push(TOP_CENTER_CHILD_DEFAULT.withValue(_topCenterChild));
            _local_1.push(TOP_RIGHT_CHILD_DEFAULT.withValue(_topRightChild));
            _local_1.push(BOTTOM_LEFT_CHILD_DEFAULT.withValue(_bottomLeftChild));
            _local_1.push(BOTTOM_CENTER_CHILD_DEFAULT.withValue(_bottomCenterChild));
            _local_1.push(BOTTOM_RIGHT_CHILD_DEFAULT.withValue(_bottomRightChild));
            _local_1.push(LANDING_VIEW_MODE_DEFAULT.withValue(_landingViewMode));
            return (_local_1);
        }

        public function set properties(_arg_1:Array):void
        {
            if (_disposed)
            {
                return;
            };
            _SafeStr_4414 = true;
            for each (var _local_2:PropertyStruct in _arg_1)
            {
                switch (_local_2.key)
                {
                    case "illumina_border:border_style":
                        borderStyle = String(_local_2.value);
                        break;
                    case "illumina_border:content_child":
                        contentChild = String(_local_2.value);
                        break;
                    case "illumina_border:content_padding":
                        contentPadding = uint(_local_2.value);
                        break;
                    case "illumina_border:side_padding":
                        sidePadding = uint(_local_2.value);
                        break;
                    case "illumina_border:child_margin":
                        childMargin = uint(_local_2.value);
                        break;
                    case "illumina_border:top_left_child":
                        topLeftChild = String(_local_2.value);
                        break;
                    case "illumina_border:top_center_child":
                        topCenterChild = String(_local_2.value);
                        break;
                    case "illumina_border:top_right_child":
                        topRightChild = String(_local_2.value);
                        break;
                    case "illumina_border:bottom_left_child":
                        bottomLeftChild = String(_local_2.value);
                        break;
                    case "illumina_border:bottom_center_child":
                        bottomCenterChild = String(_local_2.value);
                        break;
                    case "illumina_border:bottom_right_child":
                        bottomRightChild = String(_local_2.value);
                        break;
                    case "illumina_border:landing_view_mode":
                        landingViewMode = _local_2.value;
                };
            };
            _SafeStr_4414 = false;
            refresh();
        }

        public function get borderStyle():String
        {
            return (_borderStyle);
        }

        public function set borderStyle(_arg_1:String):void
        {
            _borderStyle = _arg_1;
            _SafeStr_4428 = new Dictionary();
            for each (var _local_2:String in BORDER_PIECES)
            {
                _SafeStr_4428[_local_2] = _windowManager.assets.getAssetByName(((_borderStyle + "_border_") + _local_2));
            };
            refresh();
        }

        public function get contentChild():String
        {
            return (_contentChild);
        }

        public function set contentChild(_arg_1:String):void
        {
            _contentChild = ((_arg_1 != null) ? _arg_1 : "");
            refresh();
        }

        public function get contentPadding():uint
        {
            return (_contentPadding);
        }

        public function set contentPadding(_arg_1:uint):void
        {
            _contentPadding = _arg_1;
            refresh();
        }

        public function get sidePadding():uint
        {
            return (_sidePadding);
        }

        public function set sidePadding(_arg_1:uint):void
        {
            _sidePadding = _arg_1;
            refresh();
        }

        public function get childMargin():uint
        {
            return (_childMargin);
        }

        public function set childMargin(_arg_1:uint):void
        {
            _childMargin = _arg_1;
            refresh();
        }

        public function get topLeftChild():String
        {
            return (_topLeftChild);
        }

        public function set topLeftChild(_arg_1:String):void
        {
            _topLeftChild = ((_arg_1 != null) ? _arg_1 : "");
            refresh();
        }

        public function get topCenterChild():String
        {
            return (_topCenterChild);
        }

        public function set topCenterChild(_arg_1:String):void
        {
            _topCenterChild = ((_arg_1 != null) ? _arg_1 : "");
            refresh();
        }

        public function get topRightChild():String
        {
            return (_topRightChild);
        }

        public function set topRightChild(_arg_1:String):void
        {
            _topRightChild = ((_arg_1 != null) ? _arg_1 : "");
            refresh();
        }

        public function get bottomLeftChild():String
        {
            return (_bottomLeftChild);
        }

        public function set bottomLeftChild(_arg_1:String):void
        {
            _bottomLeftChild = ((_arg_1 != null) ? _arg_1 : "");
            refresh();
        }

        public function get bottomCenterChild():String
        {
            return (_bottomCenterChild);
        }

        public function set bottomCenterChild(_arg_1:String):void
        {
            _bottomCenterChild = ((_arg_1 != null) ? _arg_1 : "");
            refresh();
        }

        public function get bottomRightChild():String
        {
            return (_bottomRightChild);
        }

        public function set bottomRightChild(_arg_1:String):void
        {
            _bottomRightChild = ((_arg_1 != null) ? _arg_1 : "");
            refresh();
        }

        public function get landingViewMode():Boolean
        {
            return (_landingViewMode);
        }

        public function set landingViewMode(_arg_1:Boolean):void
        {
            _landingViewMode = _arg_1;
            refresh();
        }

        private function getPiece(_arg_1:String):BitmapDataAsset
        {
            return (_SafeStr_4428[_arg_1]);
        }

        private function getChildHeight(_arg_1:String):int
        {
            var _local_2:IWindow = _children.getChildByName(_arg_1);
            return ((((!(_arg_1 == null)) && (_arg_1.length > 0)) && (!(_local_2 == null))) ? _local_2.height : 0);
        }

        private function get topPadding():int
        {
            return (Math.max(getChildHeight(_topCenterChild), Math.max(getChildHeight(_topLeftChild), getChildHeight(_topRightChild))) / 2);
        }

        private function get bottomPadding():int
        {
            return (Math.max(getChildHeight(_bottomCenterChild), Math.max(getChildHeight(_bottomLeftChild), getChildHeight(_bottomRightChild))) / 2);
        }

        private function refresh():void
        {
            var _local_3:int;
            var _local_9:int;
            var _local_10:BitmapDataAsset;
            var _local_6:BitmapData;
            var _local_13:Rectangle;
            var _local_4:Rectangle;
            var _local_1:int;
            var _local_8:int;
            if ((((_SafeStr_4414) || (_SafeStr_4415)) || (disposed)))
            {
                return;
            };
            _SafeStr_1165.limits.setEmpty();
            _SafeStr_1165.width = _SafeStr_4407.width;
            _SafeStr_1165.height = _SafeStr_4407.height;
            var _local_2:IWindow = _children.getChildByName(_contentChild);
            if (_local_2 != null)
            {
                _local_3 = Math.max(1, (_local_2.width + (2 * _contentPadding)));
                _local_9 = Math.max(1, (((_local_2.height + (2 * _contentPadding)) + topPadding) + bottomPadding));
                _SafeStr_4415 = true;
                if (_SafeStr_4407.testParamFlag(0x20000))
                {
                    _SafeStr_1165.limits.minWidth = _local_3;
                    _SafeStr_1165.limits.minHeight = _local_9;
                };
                if (_SafeStr_4407.testParamFlag(147456))
                {
                    _SafeStr_1165.limits.minWidth = _local_3;
                    _SafeStr_1165.limits.minHeight = _local_9;
                    _SafeStr_1165.limits.maxWidth = _local_3;
                    _SafeStr_1165.limits.maxHeight = _local_9;
                };
                _SafeStr_4415 = false;
            };
            if ((((_SafeStr_4429 == null) || (!(_SafeStr_4429.width == _SafeStr_1165.width))) || (!(_SafeStr_4429.height == _SafeStr_1165.height))))
            {
                _SafeStr_1267.width = _SafeStr_1165.width;
                _SafeStr_1267.height = _SafeStr_1165.height;
                _children.width = _SafeStr_1165.width;
                _children.height = _SafeStr_1165.height;
                if (_SafeStr_4429 != null)
                {
                    _SafeStr_4429.dispose();
                };
                _SafeStr_4429 = new BitmapData(_SafeStr_1267.width, _SafeStr_1267.height, true, 0);
                _SafeStr_1267.bitmap = _SafeStr_4429;
            };
            var _local_12:Rectangle = _SafeStr_1267.rectangle;
            _local_12.y = (_local_12.y + topPadding);
            _local_12.height = (_local_12.height - (topPadding + bottomPadding));
            _SafeStr_4429.lock();
            _SafeStr_4429.fillRect(new Rectangle(0, 0, _SafeStr_1267.width, _SafeStr_1267.height), 0);
            _loop_1:
            for (var _local_5:String in _SafeStr_4428)
            {
                _local_10 = getPiece(_local_5);
                if (!((_local_10 == null) || ((_landingViewMode) && (((_local_5 == "top_left") || (_local_5 == "center_left")) || (_local_5 == "bottom_left")))))
                {
                    _local_6 = (_local_10.content as BitmapData);
                    _local_13 = _local_10.rectangle;
                    _local_4 = new Rectangle(_local_12.x, _local_12.y, _local_13.width, _local_13.height);
                    switch (_local_5)
                    {
                        case "top_left":
                            break;
                        case "top_center":
                            _local_4.x = (_local_4.x + getPiece("top_left").rectangle.width);
                            _local_4.width = ((_local_12.width - getPiece("top_left").rectangle.width) - getPiece("top_right").rectangle.width);
                            break;
                        case "top_right":
                            _local_4.x = (_local_4.x + (_local_12.width - _local_13.width));
                            break;
                        case "center_right":
                            _local_4.x = (_local_4.x + (_local_12.width - _local_13.width));
                            _local_4.y = (_local_4.y + getPiece("top_right").rectangle.height);
                            _local_4.height = ((_local_12.height - getPiece("top_right").rectangle.height) - getPiece("bottom_right").rectangle.height);
                            break;
                        case "bottom_right":
                            _local_4.x = (_local_4.x + (_local_12.width - _local_13.width));
                            _local_4.y = (_local_4.y + (_local_12.height - _local_13.height));
                            break;
                        case "bottom_center":
                            _local_4.x = (_local_4.x + getPiece("bottom_left").rectangle.width);
                            _local_4.y = (_local_4.y + (_local_12.height - _local_13.height));
                            _local_4.width = ((_local_12.width - getPiece("bottom_left").rectangle.width) - getPiece("bottom_right").rectangle.width);
                            if (_landingViewMode)
                            {
                                _local_1 = int((_local_4.width / 2));
                                _local_4.x = (_local_4.x + _local_1);
                                _local_4.width = (_local_4.width - _local_1);
                            };
                            break;
                        case "bottom_left":
                            _local_4.y = (_local_4.y + (_local_12.height - _local_13.height));
                            break;
                        case "center_left":
                            _local_4.y = (_local_4.y + getPiece("top_left").rectangle.height);
                            _local_4.height = ((_local_12.height - getPiece("top_left").rectangle.height) - getPiece("bottom_left").rectangle.height);
                            break;
                        default:
                            continue _loop_1;
                    };
                    MATRIX.a = (_local_4.width / _local_13.width);
                    MATRIX.d = (_local_4.height / _local_13.height);
                    MATRIX.tx = (_local_4.x - (_local_13.x * MATRIX.a));
                    MATRIX.ty = (_local_4.y - (_local_13.y * MATRIX.d));
                    _SafeStr_4429.draw(_local_6, MATRIX, null, null, _local_4, false);
                };
            };
            var _local_11:Array = [_topLeftChild, _topCenterChild, _topRightChild, _bottomLeftChild, _bottomCenterChild, _bottomRightChild];
            for each (var _local_7:IWindow in _children.iterator)
            {
                if (((!(_local_7.name == null)) && (_local_7.name.length > 0)))
                {
                    _local_8 = _local_11.indexOf(_local_7.name);
                    if (_local_8 < 0)
                    {
                        if (_local_7.name == _contentChild)
                        {
                            _local_7.x = (_local_12.x + contentPadding);
                            _local_7.y = (_local_12.y + contentPadding);
                            _local_7.visible = true;
                        }
                        else
                        {
                            _local_7.visible = false;
                        };
                    }
                    else
                    {
                        switch ((_local_8 % 3))
                        {
                            case 0:
                                _local_7.x = Math.min(_sidePadding, (_SafeStr_1267.width - _local_7.width));
                                break;
                            case 1:
                                _local_7.x = (Math.max((_SafeStr_1267.width - _local_7.width), 0) / 2);
                                break;
                            case 2:
                                _local_7.x = Math.max(((_SafeStr_1267.width - _local_7.width) - _sidePadding), 0);
                        };
                        if (_local_8 < 3)
                        {
                            _local_7.y = (topPadding - (_local_7.height / 2));
                        }
                        else
                        {
                            _local_7.y = (_SafeStr_1267.height - (bottomPadding + (_local_7.height / 2)));
                        };
                        _local_7.visible = true;
                        _SafeStr_4429.fillRect(new Rectangle((_local_7.x - _childMargin), _local_7.y, (_local_7.width + (_childMargin * 2)), _local_7.height), 0);
                    };
                }
                else
                {
                    _local_7.visible = false;
                };
            };
            _SafeStr_4429.unlock();
            _SafeStr_1267.invalidate();
        }


    }
}