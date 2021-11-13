package com.sulake.core.window.components
{
    import com.sulake.core.window.WindowController;
    import com.sulake.core.localization.ILocalizable;
    import com.sulake.core.window.utils.TextMargins;
    import com.sulake.core.window.utils.TextStyleManager;
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import flash.text.TextFormat;
    import com.sulake.core.window.utils.IMargins;
    import com.sulake.core.window.utils._SafeStr_177;
    import com.sulake.core.window.utils.TextFieldCache;
    import flash.text.TextField;
    import com.sulake.core.window.events.WindowEvent;
    import flash.events.Event;
    import com.sulake.core.utils.Map;
    import com.sulake.core.window.utils.PropertyStruct;

    public class TextLabelController extends WindowController implements ILabelWindow, ILocalizable
    {

        private static const MARGINS_KEY:String = "margins";

        private var _textColor:Object = null;
        private var _textStyleName:String;
        private var _text:String = "";
        private var _localized:Boolean = false;
        private var _SafeStr_907:TextMargins;
        private var _textHeight:Number = 0;
        private var _textWidth:Number = 0;
        private var _SafeStr_958:Boolean = false;
        private var _vertical:Boolean = false;

        public function TextLabelController(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:WindowContext, _arg_6:Rectangle, _arg_7:IWindow, _arg_8:Function, _arg_9:Array=null, _arg_10:Array=null, _arg_11:uint=0)
        {
            _textStyleName = String(_arg_5.getWindowFactory().getThemeManager().getPropertyDefaults(_arg_3)
                                            .get("text_style"));
            TextStyleManager.events.addEventListener("change", onTextStyleChanged);
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11);
        }

        public function get antiAliasType():String
        {
            return (textField.antiAliasType);
        }

        public function get autoSize():String
        {
            return (textField.autoSize);
        }

        public function get bold():Boolean
        {
            return (textField.defaultTextFormat.bold);
        }

        public function get border():Boolean
        {
            return (textField.border);
        }

        public function get borderColor():uint
        {
            return (textField.borderColor);
        }

        public function get defaultTextFormat():TextFormat
        {
            return (textField.defaultTextFormat);
        }

        public function get embedFonts():Boolean
        {
            return (textField.embedFonts);
        }

        public function get fontFace():String
        {
            return (textField.defaultTextFormat.font);
        }

        public function get fontSize():uint
        {
            return ((textField.defaultTextFormat.size == null) ? 12 : uint(textField.defaultTextFormat.size));
        }

        public function get gridFitType():String
        {
            return (textField.gridFitType);
        }

        public function get italic():Boolean
        {
            return (textField.defaultTextFormat.italic);
        }

        public function get kerning():Boolean
        {
            return (textField.defaultTextFormat.kerning);
        }

        public function get length():int
        {
            return (_text.length);
        }

        public function get margins():IMargins
        {
            if (!_SafeStr_907)
            {
                _SafeStr_907 = new TextMargins(0, 0, 0, 0, setTextMargins);
            };
            return (_SafeStr_907);
        }

        public function get maxChars():int
        {
            return (textField.maxChars);
        }

        public function get sharpness():Number
        {
            return (textField.sharpness);
        }

        public function get spacing():Number
        {
            return Number((textField.defaultTextFormat.letterSpacing));
        }

        public function get text():String
        {
            return (_text);
        }

        public function get textColor():uint
        {
            return uint((_textColor));
        }

        public function get textBackground():Boolean
        {
            return (background);
        }

        public function get textBackgroundColor():uint
        {
            return (color);
        }

        public function get textHeight():Number
        {
            return (_textHeight);
        }

        public function get textWidth():Number
        {
            return (_textWidth);
        }

        public function get textStyle():_SafeStr_177
        {
            return (TextStyleManager.getStyle(_textStyleName));
        }

        public function get thickness():Number
        {
            return (textField.thickness);
        }

        public function get underline():Boolean
        {
            return (textField.defaultTextFormat.underline);
        }

        public function get drawOffsetX():int
        {
            return ((_SafeStr_907) ? _SafeStr_907.left : 0);
        }

        public function get drawOffsetY():int
        {
            return ((_SafeStr_907) ? _SafeStr_907.top : 0);
        }

        public function get hasTextColor():Boolean
        {
            return (!(_textColor == null));
        }

        protected function get textField():TextField
        {
            var _local_1:TextField = TextFieldCache.getTextFieldByStyleName(_textStyleName);
            if (_local_1)
            {
                _local_1.text = _text;
                if (_textColor != null)
                {
                    _local_1.textColor = uint(_textColor);
                };
            };
            return (_local_1);
        }

        public function set text(_arg_1:String):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            if (_localized)
            {
                context.removeLocalizationListener(_caption.slice(2, _caption.indexOf("}")), this);
                _localized = false;
            };
            _caption = _arg_1;
            if (((_caption.charAt(0) == "$") && (_caption.charAt(1) == "{")))
            {
                context.registerLocalizationListener(_caption.slice(2, _caption.indexOf("}")), this);
                _localized = true;
            }
            else
            {
                _text = _arg_1;
                refresh();
            };
        }

        override public function set caption(_arg_1:String):void
        {
            text = _arg_1;
        }

        public function set localization(_arg_1:String):void
        {
            if (_arg_1 != null)
            {
                _text = _arg_1;
                refresh();
            };
        }

        public function set textStyle(_arg_1:_SafeStr_177):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            if (_textStyleName != _arg_1.name)
            {
                _textStyleName = _arg_1.name;
                refresh();
            };
        }

        public function set textColor(_arg_1:uint):void
        {
            if (_arg_1 != _textColor)
            {
                _textColor = _arg_1;
                refresh();
            };
        }

        override public function dispose():void
        {
            if (!_disposed)
            {
                TextStyleManager.events.removeEventListener("change", onTextStyleChanged);
                if (_localized)
                {
                    _localized = false;
                    context.removeLocalizationListener(_caption.slice(2, _caption.indexOf("}")), this);
                };
                if (_SafeStr_907)
                {
                    _SafeStr_907.dispose();
                    _SafeStr_907 = null;
                };
                super.dispose();
            };
        }

        private function refresh(_arg_1:Boolean=false):void
        {
            var _local_11:int;
            var _local_7:WindowEvent;
            if (_SafeStr_958)
            {
                return;
            };
            _SafeStr_958 = true;
            var _local_3:TextField = textField;
            if (!_local_3)
            {
                _SafeStr_958 = false;
                return;
            };
            _textWidth = _local_3.textWidth;
            _textHeight = _local_3.textHeight;
            var _local_9:int = ((_local_3.border) ? 1 : 0);
            _local_11 = ((_SafeStr_907) ? (_SafeStr_907.left + _SafeStr_907.right) : 0);
            var _local_10:int = ((_SafeStr_907) ? (_SafeStr_907.top + _SafeStr_907.bottom) : 0);
            var _local_4:int = (_SafeStr_908 - _local_11);
            var _local_8:int = (_SafeStr_909 - _local_10);
            var _local_2:int = (Math.floor(_local_3.width) + _local_9);
            var _local_6:int = (Math.floor(_local_3.height) + _local_9);
            var _local_5:Boolean;
            if (_vertical)
            {
                if (_local_2 != _local_8)
                {
                    setRectangle(_SafeStr_954, _SafeStr_955, (_local_6 + _local_11), (Math.floor(_local_3.width) + _local_10));
                    _local_5 = true;
                };
                if (_local_6 < _local_4)
                {
                    _local_3.height = (_local_4 - _local_9);
                }
                else
                {
                    if (_local_6 > _local_4)
                    {
                        setRectangle(_SafeStr_954, _SafeStr_955, (_local_6 + _local_11), (Math.floor(_local_3.width) + _local_10));
                        _local_5 = true;
                    };
                };
            }
            else
            {
                if (_local_2 != _local_4)
                {
                    setRectangle(_SafeStr_954, _SafeStr_955, (_local_2 + _local_11), (Math.floor(_local_3.height) + _local_10));
                    _local_5 = true;
                };
                if (_local_6 < _local_8)
                {
                    _local_3.height = (_local_8 - _local_9);
                }
                else
                {
                    if (_local_6 > _local_8)
                    {
                        setRectangle(_SafeStr_954, _SafeStr_955, (_local_2 + _local_11), (Math.floor(_local_3.height) + _local_10));
                        _local_5 = true;
                    };
                };
            };
            _SafeStr_958 = false;
            _context.invalidate(this, null, 1);
            if ((((!(_local_5)) && (!(_arg_1))) && (_SafeStr_913)))
            {
                _local_7 = WindowEvent.allocate("WE_RESIZED", this, null);
                _SafeStr_913.dispatchEvent(_local_7);
                _local_7.recycle();
            };
        }

        private function setTextMargins(_arg_1:IMargins):void
        {
            if (((_arg_1) && (!(_arg_1 == _SafeStr_907))))
            {
                if (_SafeStr_907)
                {
                    _SafeStr_907.assign(_arg_1.left, _arg_1.top, _arg_1.right, _arg_1.bottom, setTextMargins);
                }
                else
                {
                    _SafeStr_907 = new TextMargins(_arg_1.left, _arg_1.top, _arg_1.right, _arg_1.bottom, setTextMargins);
                };
            };
            refresh();
        }

        private function onTextStyleChanged(_arg_1:Event):void
        {
            refresh();
        }

        private function setTextMarginMap(_arg_1:Map):void
        {
            if (_SafeStr_907)
            {
                _SafeStr_907.assign(_arg_1["left"], _arg_1["top"], _arg_1["right"], _arg_1["bottom"], setTextMargins);
            }
            else
            {
                _SafeStr_907 = new TextMargins(_arg_1["left"], _arg_1["top"], _arg_1["right"], _arg_1["bottom"], setTextMargins);
            };
            refresh();
        }

        override public function get properties():Array
        {
            var _local_3:Array = super.properties;
            var _local_2:_SafeStr_177 = TextStyleManager.getStyle(_textStyleName);
            _local_3.push(createProperty("text_style", _textStyleName));
            var _local_1:uint = uint(((_local_2.color != null)
                    ? _local_2.color
                    : getDefaultProperty("text_color").value));
            _local_3.push(new PropertyStruct("text_color", ((_textColor == null) ? _local_1 : _textColor), "hex", ((!(_textColor == null)) && (!(_textColor == _local_1)))));
            _local_3.push(createProperty("vertical", _vertical));
            if (_SafeStr_907 != null)
            {
                _local_3.push(createProperty("margin_left", _SafeStr_907.left));
                _local_3.push(createProperty("margin_top", _SafeStr_907.top));
                _local_3.push(createProperty("margin_right", _SafeStr_907.right));
                _local_3.push(createProperty("margin_bottom", _SafeStr_907.bottom));
            }
            else
            {
                _local_3.push(getDefaultProperty("margin_left"));
                _local_3.push(getDefaultProperty("margin_top"));
                _local_3.push(getDefaultProperty("margin_right"));
                _local_3.push(getDefaultProperty("margin_bottom"));
            };
            return (_local_3);
        }

        override public function set properties(_arg_1:Array):void
        {
            for each (var _local_2:PropertyStruct in _arg_1)
            {
                switch (_local_2.key)
                {
                    case "text_style":
                        textStyle = TextStyleManager.getStyle((_local_2.value as String));
                        break;
                    case "text_color":
                        _textColor = (_local_2.value as uint);
                        break;
                    case "margin_left":
                        if (((!(_SafeStr_907 == null)) || (_local_2.valid)))
                        {
                            margins.left = (_local_2.value as int);
                        };
                        break;
                    case "margin_top":
                        if (((!(_SafeStr_907 == null)) || (_local_2.valid)))
                        {
                            margins.top = (_local_2.value as int);
                        };
                        break;
                    case "margin_right":
                        if (((!(_SafeStr_907 == null)) || (_local_2.valid)))
                        {
                            margins.right = (_local_2.value as int);
                        };
                        break;
                    case "margin_bottom":
                        if (((!(_SafeStr_907 == null)) || (_local_2.valid)))
                        {
                            margins.bottom = (_local_2.value as int);
                        };
                        break;
                    case "margins":
                        setTextMarginMap((_local_2.value as Map));
                        break;
                    case "vertical":
                        vertical = (_local_2.value as Boolean);
                };
            };
            super.properties = _arg_1;
        }

        public function get vertical():Boolean
        {
            return (_vertical);
        }

        public function set vertical(_arg_1:Boolean):void
        {
            _vertical = _arg_1;
            refresh();
        }


    }
}