package com.sulake.core.window.components
{
    import com.sulake.core.window.WindowController;
    import com.sulake.core.window.utils.ITextFieldContainer;
    import com.sulake.core.localization.ILocalizable;
    import flash.utils.Dictionary;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import com.sulake.core.window.utils._SafeStr_177;
    import com.sulake.core.window.utils.TextMargins;
    import com.sulake.core.window.utils.TextStyleManager;
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.utils.FontEnum;
    import com.sulake.core.utils.Map;
    import com.sulake.core.window.utils.IMargins;
    import flash.text.Font;
    import com.sulake.core.window.events.WindowEvent;
    import flash.display.DisplayObject;
    import flash.text.TextLineMetrics;
    import flash.events.Event;
    import com.sulake.core.utils.XMLVariableParser;
    import com.sulake.core.window.utils.PropertyStruct;
    import com.sulake.core.window.theme._SafeStr_173;
    import flash.text.StyleSheet;

    public class TextController extends WindowController implements ITextWindow, ITextFieldContainer, ILocalizable
    {

        private static const REPLACE_RANDOM_CHARS:Array = ["a", "B", "c", "D", "e"];
        protected static const _SafeStr_947:Dictionary = createPropertySetterTable();

        private var _overflowReplace:String = "";
        protected var _field:TextField;
        protected var _SafeStr_948:String = "none";
        protected var _localized:Boolean = false;
        protected var _SafeStr_949:int = 0;
        protected var _SafeStr_905:Boolean = false;
        protected var _etchingColor:uint;
        protected var _etchingPosition:String;
        protected var _SafeStr_952:TextFormat;
        private var _textStyleName:String;
        protected var _settingRectangle:Boolean;

        private var _SafeStr_953:_SafeStr_177 = new _SafeStr_177();
        protected var _SafeStr_907:TextMargins = new TextMargins(0, 0, 0, 0, setTextMargins);
        protected var _drawing:Boolean = false;
        protected var _SafeStr_950:Number = 0;
        protected var _SafeStr_951:Number = 0;

        public function TextController(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:WindowContext, _arg_6:Rectangle, _arg_7:IWindow, _arg_8:Function, _arg_9:Array=null, _arg_10:Array=null, _arg_11:uint=0)
        {
            if (_field == null)
            {
                _field = new TextField();
                if (_arg_6)
                {
                    _field.width = _arg_6.width;
                    _field.height = _arg_6.height;
                };
                _field.antiAliasType = "advanced";
                _field.gridFitType = "pixel";
                _field.mouseWheelEnabled = false;
            };
            _textStyleName = String(_arg_5.getWindowFactory().getThemeManager().getPropertyDefaults(_arg_3)
                                            .get("text_style"));
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11);
            setTextFormatting(this);
            TextStyleManager.events.addEventListener("change", onTextStyleChanged);
            antiAliasType = "advanced";
            gridFitType = "pixel";
            if (_field.autoSize == "none")
            {
                _field.width = _SafeStr_908;
                _field.height = _SafeStr_909;
            };
        }

        private static function setAntiAliasType(_arg_1:TextController, _arg_2:String):void
        {
            _arg_2 = ((_arg_2 == "normal") ? "normal" : "advanced");
            _arg_1._SafeStr_953.antiAliasType = _arg_2;
            _arg_1._field.antiAliasType = _arg_2;
            _arg_1.refreshTextImage();
        }

        private static function setAlwaysShowSelection(_arg_1:TextController, _arg_2:Boolean):void
        {
            _arg_1._field.alwaysShowSelection = _arg_2;
        }

        private static function setAutoSize(_arg_1:TextController, _arg_2:String):void
        {
            var _local_3:TextFormat;
            if (_arg_2 != _arg_1._SafeStr_948)
            {
                _arg_1._SafeStr_948 = _arg_2;
                _arg_1._field.autoSize = ((_arg_2 != "none") ? "left" : "none");
                _local_3 = _arg_1.defaultTextFormat;
                switch (_arg_2)
                {
                    case "center":
                        _local_3.align = "center";
                        break;
                    case "right":
                        _local_3.align = "right";
                        break;
                    default:
                        _local_3.align = "left";
                };
                _arg_1.setTextFormat(new TextFormat(_local_3.font, _local_3.size, _local_3.color, _local_3.bold, _local_3.italic, _local_3.underline, _local_3.url, _local_3.target, _local_3.align, _local_3.leftMargin, _local_3.rightMargin, _local_3.indent, _local_3.leading));
                _arg_1.defaultTextFormat = _local_3;
                _arg_1.refreshTextImage();
            };
        }

        private static function setTextBackground(_arg_1:TextController, _arg_2:Boolean):void
        {
            _arg_1.background = _arg_2;
        }

        private static function setTextBackgroundColor(_arg_1:TextController, _arg_2:uint):void
        {
            _arg_1.color = _arg_2;
        }

        private static function setBold(_arg_1:TextController, _arg_2:Boolean):void
        {
            var _local_3:TextFormat = _arg_1.defaultTextFormat;
            _local_3.bold = _arg_2;
            _arg_1.setTextFormat(new TextFormat(_local_3.font, _local_3.size, _local_3.color, _local_3.bold, _local_3.italic, _local_3.underline, _local_3.url, _local_3.target, _local_3.align, _local_3.leftMargin, _local_3.rightMargin, _local_3.indent, _local_3.leading));
            _arg_1.defaultTextFormat = _local_3;
            _arg_1._SafeStr_953.fontWeight = "bold";
        }

        private static function setBorder(_arg_1:TextController, _arg_2:Boolean):void
        {
            _arg_1._field.border = _arg_2;
            _arg_1.refreshTextImage();
        }

        private static function setBorderColor(_arg_1:TextController, _arg_2:uint):void
        {
            _arg_1._field.borderColor = _arg_2;
            _arg_1.refreshTextImage();
        }

        private static function setCondenseWhite(_arg_1:TextController, _arg_2:Boolean):void
        {
            _arg_1._field.condenseWhite = _arg_2;
            _arg_1.refreshTextImage();
        }

        private static function setDefaultTextFormat(_arg_1:TextController, _arg_2:TextFormat):void
        {
            _arg_1._field.defaultTextFormat = _arg_2;
            _arg_1.refreshTextImage();
        }

        private static function setEmbedFonts(_arg_1:TextController, _arg_2:Boolean):void
        {
            _arg_1._field.embedFonts = _arg_2;
        }

        private static function setFontFace(_arg_1:TextController, _arg_2:String):void
        {
            var _local_3:TextFormat = _arg_1.defaultTextFormat;
            _local_3.font = _arg_2;
            _arg_1.setTextFormat(new TextFormat(_local_3.font, _local_3.size, _local_3.color, _local_3.bold, _local_3.italic, _local_3.underline, _local_3.url, _local_3.target, _local_3.align, _local_3.leftMargin, _local_3.rightMargin, _local_3.indent, _local_3.leading));
            _arg_1._field.embedFonts = FontEnum.isEmbeddedFont(_arg_2);
            _arg_1.defaultTextFormat = _local_3;
            _arg_1._SafeStr_953.fontFamily = _arg_2;
        }

        private static function setFontSize(_arg_1:TextController, _arg_2:uint):void
        {
            var _local_3:TextFormat = _arg_1.defaultTextFormat;
            _local_3.size = _arg_2;
            _arg_1.setTextFormat(new TextFormat(_local_3.font, _local_3.size, _local_3.color, _local_3.bold, _local_3.italic, _local_3.underline, _local_3.url, _local_3.target, _local_3.align, _local_3.leftMargin, _local_3.rightMargin, _local_3.indent, _local_3.leading));
            _arg_1.defaultTextFormat = _local_3;
            _arg_1._SafeStr_953.fontSize = _arg_2;
        }

        private static function setGridFitType(_arg_1:TextController, _arg_2:String):void
        {
            _arg_1._field.gridFitType = _arg_2;
            _arg_1.refreshTextImage();
        }

        private static function setHtmlText(_arg_1:TextController, _arg_2:String):void
        {
            if (_arg_2 == null)
            {
                return;
            };
            if (_arg_1._localized)
            {
                _arg_1.context.removeLocalizationListener(_arg_1._caption.slice(2, _arg_1._caption.indexOf("}")), _arg_1);
                _arg_1._localized = false;
            };
            _arg_1._caption = _arg_2;
            if (((_arg_1._caption.charAt(0) == "$") && (_arg_1._caption.charAt(1) == "{")))
            {
                _arg_1.context.registerLocalizationListener(_arg_1._caption.slice(2, _arg_1._caption.indexOf("}")), _arg_1);
                _arg_1._localized = true;
            }
            else
            {
                if (_arg_1._field != null)
                {
                    _arg_1._field.htmlText = _arg_1._caption;
                    _arg_1.refreshTextImage();
                };
            };
        }

        private static function setItalic(_arg_1:TextController, _arg_2:Boolean):void
        {
            var _local_3:TextFormat = _arg_1.defaultTextFormat;
            _local_3.italic = _arg_2;
            _arg_1.setTextFormat(new TextFormat(_local_3.font, _local_3.size, _local_3.color, _local_3.bold, _local_3.italic, _local_3.underline, _local_3.url, _local_3.target, _local_3.align, _local_3.leftMargin, _local_3.rightMargin, _local_3.indent, _local_3.leading));
            _arg_1.defaultTextFormat = _local_3;
            _arg_1._SafeStr_953.fontStyle = ((_arg_2) ? "italic" : "normal");
        }

        private static function setKerning(_arg_1:TextController, _arg_2:Boolean):void
        {
            var _local_4:TextFormat = _arg_1.defaultTextFormat;
            _local_4.kerning = _arg_2;
            var _local_3:TextFormat = new TextFormat(_local_4.font, _local_4.size, _local_4.color, _local_4.bold, _local_4.italic, _local_4.underline, _local_4.url, _local_4.target, _local_4.align, _local_4.leftMargin, _local_4.rightMargin, _local_4.indent, _local_4.leading);
            _local_3.kerning = _arg_2;
            _arg_1.setTextFormat(_local_3);
            _arg_1.defaultTextFormat = _local_4;
            _arg_1._SafeStr_953.kerning = _arg_2;
        }

        private static function setTextMarginMap(_arg_1:TextController, _arg_2:Map):void
        {
            if (_arg_1._SafeStr_907)
            {
                _arg_1._SafeStr_907.assign(_arg_2["left"], _arg_2["top"], _arg_2["right"], _arg_2["bottom"], _arg_1.setTextMargins);
            }
            else
            {
                _arg_1._SafeStr_907 = new TextMargins(_arg_2["left"], _arg_2["top"], _arg_2["right"], _arg_2["bottom"], _arg_1.setTextMargins);
            };
            _arg_1.refreshTextImage();
        }

        private static function setMarginLeft(_arg_1:TextController, _arg_2:int):void
        {
            if (((_arg_1._SafeStr_907) && (!(_arg_1._SafeStr_907.left == _arg_2))))
            {
                _arg_1.margins.left = _arg_2;
            };
        }

        private static function setMarginTop(_arg_1:TextController, _arg_2:int):void
        {
            if (((_arg_1._SafeStr_907) && (!(_arg_1._SafeStr_907.top == _arg_2))))
            {
                _arg_1.margins.top = _arg_2;
            };
        }

        private static function setMarginRight(_arg_1:TextController, _arg_2:int):void
        {
            if (((_arg_1._SafeStr_907) && (!(_arg_1._SafeStr_907.right == _arg_2))))
            {
                _arg_1.margins.right = _arg_2;
            };
        }

        private static function setMarginBottom(_arg_1:TextController, _arg_2:int):void
        {
            if (((_arg_1._SafeStr_907) && (!(_arg_1._SafeStr_907.bottom == _arg_2))))
            {
                _arg_1.margins.bottom = _arg_2;
            };
        }

        private static function setMaxChars(_arg_1:TextController, _arg_2:int):void
        {
            _arg_1._field.maxChars = _arg_2;
            _arg_1.refreshTextImage();
        }

        private static function setMouseWheelEnabled(_arg_1:TextController, _arg_2:Boolean):void
        {
            _arg_1._field.mouseWheelEnabled = _arg_2;
        }

        private static function setMultiline(_arg_1:TextController, _arg_2:Boolean):void
        {
            _arg_1._field.multiline = _arg_2;
            _arg_1.refreshTextImage();
        }

        private static function setRestrict(_arg_1:TextController, _arg_2:String):void
        {
            _arg_1._field.restrict = _arg_2;
        }

        private static function setSharpness(_arg_1:TextController, _arg_2:Number):void
        {
            _arg_1._field.sharpness = _arg_2;
            _arg_1.refreshTextImage();
            _arg_1._SafeStr_953.sharpness = _arg_2;
        }

        private static function setSpacing(_arg_1:TextController, _arg_2:Number):void
        {
            var _local_4:TextFormat = _arg_1.defaultTextFormat;
            _local_4.letterSpacing = _arg_2;
            var _local_3:TextFormat = new TextFormat(_local_4.font, _local_4.size, _local_4.color, _local_4.bold, _local_4.italic, _local_4.underline, _local_4.url, _local_4.target, _local_4.align, _local_4.leftMargin, _local_4.rightMargin, _local_4.indent, _local_4.leading);
            _local_3.letterSpacing = _arg_2;
            _arg_1.setTextFormat(_local_3);
            _arg_1.defaultTextFormat = _local_4;
            _arg_1._SafeStr_953.letterSpacing = _arg_2;
        }

        private static function setMaxLines(_arg_1:TextController, _arg_2:int):void
        {
            _arg_1._SafeStr_949 = _arg_2;
            _arg_1.refreshTextImage();
        }

        private static function setLeading(_arg_1:TextController, _arg_2:Number):void
        {
            var _local_4:TextFormat = _arg_1.defaultTextFormat;
            _local_4.leading = _arg_2;
            var _local_3:TextFormat = new TextFormat(_local_4.font, _local_4.size, _local_4.color, _local_4.bold, _local_4.italic, _local_4.underline, _local_4.url, _local_4.target, _local_4.align, _local_4.leftMargin, _local_4.rightMargin, _local_4.indent, _local_4.leading);
            _local_3.leading = _arg_2;
            _arg_1.setTextFormat(_local_3);
            _arg_1.defaultTextFormat = _local_4;
            _arg_1._SafeStr_953.leading = _arg_2;
        }

        private static function setTextColor(_arg_1:TextController, _arg_2:uint):void
        {
            _arg_1._field.textColor = _arg_2;
            _arg_1.refreshTextImage();
            _arg_1._SafeStr_953.color = _arg_2;
        }

        private static function setTextStyle(_arg_1:TextController, _arg_2:_SafeStr_177):void
        {
            if (((!(_arg_1)) || (!(_arg_2))))
            {
                return;
            };
            var _local_3:_SafeStr_177 = TextStyleManager.getStyle(_arg_2.name);
            if (((_local_3) && (!(_local_3.equals(_arg_2)))))
            {
                _local_3 = TextStyleManager.findMatchingTextStyle(_arg_2.toString());
            };
            if (_local_3)
            {
                _arg_1._textStyleName = _local_3.name;
                setTextFormatting(_arg_1);
                _arg_1.refreshTextImage();
            };
        }

        private static function setTextStyleString(_arg_1:TextController, _arg_2:String):void
        {
            var _local_4:TextFormat;
            var _local_3:_SafeStr_177 = TextStyleManager.getStyle(_arg_2);
            if (!_local_3)
            {
                _local_3 = TextStyleManager.findMatchingTextStyle(_arg_2);
            };
            if (_local_3)
            {
                _arg_1._textStyleName = _local_3.name;
                setTextFormatting(_arg_1);
                _arg_1.refreshTextImage();
            }
            else
            {
                _local_3 = TextStyleManager.parseCSS(_arg_2)[0];
                if (_local_3)
                {
                    if (!TextStyleManager.getStyle(_local_3.name))
                    {
                        TextStyleManager.setStyle(_local_3.name, _local_3);
                    };
                    setTextStyle(_arg_1, _local_3);
                };
            };
            if (_arg_1._SafeStr_948 == "center")
            {
                _local_4 = new TextFormat();
                _local_4.align = "center";
                _arg_1._field.setTextFormat(_local_4);
            };
        }

        private static function setThickness(_arg_1:TextController, _arg_2:Number):void
        {
            _arg_1._field.thickness = _arg_2;
            _arg_1.refreshTextImage();
            _arg_1._SafeStr_953.thickness = _arg_2;
        }

        private static function setUnderline(_arg_1:TextController, _arg_2:Boolean):void
        {
            var _local_3:TextFormat = _arg_1.defaultTextFormat;
            _local_3.underline = _arg_2;
            _arg_1.setTextFormat(new TextFormat(_local_3.font, _local_3.size, _local_3.color, _local_3.bold, _local_3.italic, _local_3.underline, _local_3.url, _local_3.target, _local_3.align, _local_3.leftMargin, _local_3.rightMargin, _local_3.indent, _local_3.leading));
            _arg_1.defaultTextFormat = _local_3;
            _arg_1._SafeStr_953.textDecoration = ((_arg_2) ? "underline" : "none");
        }

        private static function setWordWrap(_arg_1:TextController, _arg_2:Boolean):void
        {
            _arg_1._field.wordWrap = _arg_2;
            _arg_1.refreshTextImage();
        }

        private static function setOverflowReplace(_arg_1:TextController, _arg_2:String):void
        {
            _arg_1._overflowReplace = _arg_2;
            _arg_1.refreshTextImage();
        }

        protected static function setTextFormatting(_arg_1:TextController):void
        {
            var _local_3:TextField = _arg_1._field;
            var _local_4:String = _arg_1._textStyleName;
            var _local_2:_SafeStr_177 = _arg_1._SafeStr_953;
            var _local_5:_SafeStr_177 = TextStyleManager.getStyle(_local_4);
            var _local_6:TextFormat = _local_3.defaultTextFormat;
            if (!_local_5)
            {
                _local_5 = TextStyleManager.getStyle("regular");
            };
            if (!_local_5.color)
            {
                _local_5.color = 0;
            };
            if (!_local_2.fontFamily)
            {
                _local_6.font = _local_5.fontFamily;
            };
            if (!_local_2.fontSize)
            {
                _local_6.size = _local_5.fontSize;
            };
            if (!_local_2.color)
            {
                _local_6.color = _local_5.color;
            };
            if (!_local_2.fontWeight)
            {
                _local_6.bold = ((_local_5.fontWeight == "bold") ? true : null);
            };
            if (!_local_2.fontStyle)
            {
                _local_6.italic = ((_local_5.fontStyle == "italic") ? true : null);
            };
            if (!_local_2.textDecoration)
            {
                _local_6.underline = ((_local_5.textDecoration == "underline") ? true : null);
            };
            if (!_local_2.textIndent)
            {
                _local_6.indent = _local_5.textIndent;
            };
            if (!_local_2.leading)
            {
                _local_6.leading = _local_5.leading;
            };
            if (!_local_2.kerning)
            {
                _local_6.kerning = _local_5.kerning;
            };
            if (!_local_2.letterSpacing)
            {
                _local_6.letterSpacing = _local_5.letterSpacing;
            };
            if (!_local_2.antiAliasType)
            {
                if (_local_5.antiAliasType == "normal")
                {
                    _local_3.antiAliasType = "normal";
                }
                else
                {
                    _local_3.antiAliasType = "advanced";
                    _local_3.gridFitType = "pixel";
                };
            };
            if (!_local_2.sharpness)
            {
                _local_3.sharpness = Number(_local_5.sharpness);
            };
            if (!_local_2.thickness)
            {
                _local_3.thickness = Number(_local_5.thickness);
            };
            if (_local_2.etchingColor == null)
            {
                _arg_1.etchingColor = uint(_local_5.etchingColor);
            };
            if (_local_2.etchingPosition == null)
            {
                _arg_1.etchingPosition = String(_local_5.etchingPosition);
            };
            if (((!(_local_5.fontWeight)) && (!(_local_2.fontWeight))))
            {
                _local_6.bold = false;
            };
            if (((!(_local_5.fontStyle)) && (!(_local_2.fontStyle))))
            {
                _local_6.italic = false;
            };
            if (((!(_local_5.textDecoration)) && (!(_local_2.textDecoration))))
            {
                _local_6.underline = false;
            };
            if (((!(_local_5.textIndent)) && (!(_local_2.textIndent))))
            {
                _local_6.indent = 0;
            };
            if (((!(_local_5.leading)) && (!(_local_2.leading))))
            {
                _local_6.leading = 0;
            };
            if (((!(_local_5.kerning)) && (!(_local_2.kerning))))
            {
                _local_6.kerning = false;
            };
            if (((!(_local_5.letterSpacing)) && (!(_local_2.letterSpacing))))
            {
                _local_6.letterSpacing = 0;
            };
            if (((!(_local_5.antiAliasType)) && (!(_local_2.antiAliasType))))
            {
                _local_3.antiAliasType = "advanced";
                _local_3.gridFitType = "pixel";
            };
            if (((!(_local_5.sharpness)) && (!(_local_2.sharpness))))
            {
                _local_3.sharpness = 0;
            };
            if (((!(_local_5.thickness)) && (!(_local_2.thickness))))
            {
                _local_3.thickness = 0;
            };
            if (((_local_5.etchingColor == null) && (_local_2.etchingColor == null)))
            {
                _arg_1.etchingColor = 0;
            };
            if (((_local_5.etchingPosition == null) && (_local_2.etchingPosition == null)))
            {
                _arg_1.etchingPosition = "bottom";
            };
            _local_3.setTextFormat(_local_6);
            _local_3.embedFonts = FontEnum.isEmbeddedFont(_local_6.font);
            _local_3.defaultTextFormat = _local_6;
            _arg_1._SafeStr_952 = _local_6;
        }

        protected static function createPropertySetterTable():Dictionary
        {
            var _local_1:Dictionary = new Dictionary();
            _local_1["always_show_selection"] = setAlwaysShowSelection;
            _local_1["background"] = setTextBackground;
            _local_1["background_color"] = setTextBackgroundColor;
            _local_1["bold"] = setBold;
            _local_1["border"] = setBorder;
            _local_1["border_color"] = setBorderColor;
            _local_1["condense_white"] = setCondenseWhite;
            _local_1["default_text_format"] = setDefaultTextFormat;
            _local_1["etching_color"] = setEtchingColor;
            _local_1["etching_position"] = setEtchingPosition;
            _local_1["font_face"] = setFontFace;
            _local_1["font_size"] = setFontSize;
            _local_1["grid_fit_type"] = setGridFitType;
            _local_1["italic"] = setItalic;
            _local_1["kerning"] = setKerning;
            _local_1["max_chars"] = setMaxChars;
            _local_1["multiline"] = setMultiline;
            _local_1["restrict"] = setRestrict;
            _local_1["spacing"] = setSpacing;
            _local_1["sharpness"] = setSharpness;
            _local_1["thickness"] = setThickness;
            _local_1["underline"] = setUnderline;
            _local_1["word_wrap"] = setWordWrap;
            _local_1["margins"] = setTextMarginMap;
            _local_1["max_lines"] = setMaxLines;
            _local_1["leading"] = setLeading;
            _local_1["antialias_type"] = setAntiAliasType;
            _local_1["auto_size"] = setAutoSize;
            _local_1["mouse_wheel_enabled"] = setMouseWheelEnabled;
            _local_1["text_color"] = setTextColor;
            _local_1["text_style"] = setTextStyleString;
            _local_1["margin_left"] = setMarginLeft;
            _local_1["margin_top"] = setMarginTop;
            _local_1["margin_right"] = setMarginRight;
            _local_1["margin_bottom"] = setMarginBottom;
            _local_1["overflow_replace"] = setOverflowReplace;
            return (_local_1);
        }

        private static function setEtchingColor(_arg_1:TextController, _arg_2:uint):void
        {
            _arg_1._etchingColor = _arg_2;
            _arg_1.refreshTextImage();
            _arg_1._SafeStr_953.etchingColor = _arg_1._etchingColor;
        }

        private static function setEtchingPosition(_arg_1:TextController, _arg_2:String):void
        {
            _arg_1._etchingPosition = _arg_2;
            _arg_1.refreshTextImage();
            _arg_1._SafeStr_953.etchingPosition = _arg_1._etchingPosition;
        }


        public function get antiAliasType():String
        {
            return (_field.antiAliasType);
        }

        public function get autoSize():String
        {
            return (_SafeStr_948);
        }

        public function get bold():Boolean
        {
            return (_field.defaultTextFormat.bold);
        }

        public function get border():Boolean
        {
            return (_field.border);
        }

        public function get borderColor():uint
        {
            return (_field.borderColor);
        }

        public function get bottomScrollV():int
        {
            return (_field.bottomScrollV);
        }

        public function get defaultTextFormat():TextFormat
        {
            return (_field.defaultTextFormat);
        }

        public function get embedFonts():Boolean
        {
            return (_field.embedFonts);
        }

        public function get fontFace():String
        {
            return (_field.defaultTextFormat.font);
        }

        public function get fontSize():uint
        {
            return ((_field.defaultTextFormat.size == null) ? 12 : uint(_field.defaultTextFormat.size));
        }

        public function get gridFitType():String
        {
            return (_field.gridFitType);
        }

        public function get htmlText():String
        {
            return (_field.htmlText);
        }

        public function get italic():Boolean
        {
            return (_field.defaultTextFormat.italic);
        }

        public function get kerning():Boolean
        {
            return (_field.defaultTextFormat.kerning);
        }

        public function get length():int
        {
            return (_field.length);
        }

        public function get margins():IMargins
        {
            return (_SafeStr_907);
        }

        public function get maxChars():int
        {
            return (_field.maxChars);
        }

        public function get multiline():Boolean
        {
            return (_field.multiline);
        }

        public function get numLines():int
        {
            return (_field.numLines);
        }

        public function get restrict():String
        {
            return (_field.restrict);
        }

        public function get sharpness():Number
        {
            return (_field.sharpness);
        }

        public function get spacing():Number
        {
            return Number((_field.defaultTextFormat.letterSpacing));
        }

        public function get text():String
        {
            return ((_field != null) ? _field.text : "");
        }

        public function get textColor():uint
        {
            return (_field.textColor);
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
            return (_field.textHeight);
        }

        public function get textWidth():Number
        {
            return (_field.textWidth);
        }

        public function get textStyle():_SafeStr_177
        {
            return (TextStyleManager.getStyle(_textStyleName));
        }

        public function get thickness():Number
        {
            return (_field.thickness);
        }

        public function get underline():Boolean
        {
            return (_field.defaultTextFormat.underline);
        }

        public function get wordWrap():Boolean
        {
            return (_field.wordWrap);
        }

        public function get textField():TextField
        {
            return (_field);
        }

        public function get maxLines():int
        {
            return (_SafeStr_949);
        }

        public function get leading():Number
        {
            return Number((_field.defaultTextFormat.leading));
        }

        public function get isOverflowReplaceOn():Boolean
        {
            return (!(_overflowReplace == ""));
        }

        public function get overflowReplace():String
        {
            return (_overflowReplace);
        }

        public function get scrollH():Number
        {
            return (_SafeStr_950);
        }

        public function get scrollV():Number
        {
            return (_SafeStr_951);
        }

        public function get maxScrollH():int
        {
            return (_field.maxScrollH);
        }

        public function get maxScrollV():int
        {
            return (Math.max((_field.textHeight - height), 0));
        }

        public function set antiAliasType(_arg_1:String):void
        {
            setAntiAliasType(this, _arg_1);
        }

        public function set autoSize(_arg_1:String):void
        {
            setAutoSize(this, _arg_1);
        }

        public function set bold(_arg_1:Boolean):void
        {
            setBold(this, _arg_1);
        }

        public function set border(_arg_1:Boolean):void
        {
            setBorder(this, _arg_1);
        }

        public function set borderColor(_arg_1:uint):void
        {
            setBorderColor(this, _arg_1);
        }

        public function set defaultTextFormat(_arg_1:TextFormat):void
        {
            setDefaultTextFormat(this, _arg_1);
        }

        public function set embedFonts(_arg_1:Boolean):void
        {
            setEmbedFonts(this, _arg_1);
        }

        public function set fontFace(_arg_1:String):void
        {
            setFontFace(this, _arg_1);
        }

        public function set fontSize(_arg_1:uint):void
        {
            setFontSize(this, _arg_1);
        }

        public function set gridFitType(_arg_1:String):void
        {
            setGridFitType(this, _arg_1);
        }

        public function set htmlText(_arg_1:String):void
        {
            setHtmlText(this, _arg_1);
        }

        public function set italic(_arg_1:Boolean):void
        {
            setItalic(this, _arg_1);
        }

        public function set kerning(_arg_1:Boolean):void
        {
            setKerning(this, _arg_1);
        }

        public function set maxChars(_arg_1:int):void
        {
            setMaxChars(this, _arg_1);
        }

        public function set multiline(_arg_1:Boolean):void
        {
            setMultiline(this, _arg_1);
        }

        public function set restrict(_arg_1:String):void
        {
            setRestrict(this, _arg_1);
        }

        public function set sharpness(_arg_1:Number):void
        {
            setSharpness(this, _arg_1);
        }

        public function set spacing(_arg_1:Number):void
        {
            setSpacing(this, _arg_1);
        }

        public function set textColor(_arg_1:uint):void
        {
            setTextColor(this, _arg_1);
        }

        public function set textBackground(_arg_1:Boolean):void
        {
            setTextBackground(this, _arg_1);
        }

        public function set textBackgroundColor(_arg_1:uint):void
        {
            setTextBackgroundColor(this, _arg_1);
        }

        public function set textStyle(_arg_1:_SafeStr_177):void
        {
            setTextStyle(this, _arg_1);
        }

        public function set thickness(_arg_1:Number):void
        {
            setThickness(this, _arg_1);
        }

        public function set underline(_arg_1:Boolean):void
        {
            setUnderline(this, _arg_1);
        }

        public function set wordWrap(_arg_1:Boolean):void
        {
            setWordWrap(this, _arg_1);
        }

        public function set maxLines(_arg_1:int):void
        {
            setMaxLines(this, _arg_1);
        }

        public function set leading(_arg_1:Number):void
        {
            setLeading(this, _arg_1);
        }

        public function set overflowReplace(_arg_1:String):void
        {
            setOverflowReplace(this, _arg_1);
        }

        protected function limitStringLength(_arg_1:String):String
        {
            return ((maxChars > 0) ? _arg_1.substr(0, maxChars) : _arg_1);
        }

        override public function setRectangle(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):void
        {
            if ((((_settingRectangle) || (!(multiline))) || (!(wordWrap))))
            {
                super.setRectangle(_arg_1, _arg_2, _arg_3, _arg_4);
                return;
            };
            _settingRectangle = true;
            var _local_5:String = autoSize;
            autoSize = "none";
            super.setRectangle(_arg_1, _arg_2, _arg_3, _arg_4);
            autoSize = _local_5;
            _settingRectangle = false;
        }

        public function set scrollH(_arg_1:Number):void
        {
            _SafeStr_950 = _arg_1;
            _field.scrollH = (_SafeStr_950 * _field.maxScrollH);
            refreshTextImage();
        }

        public function set scrollV(_arg_1:Number):void
        {
            if (_arg_1 > _SafeStr_951)
            {
                _SafeStr_951 = _arg_1;
                _field.scrollV = Math.max(_field.scrollV, ((_arg_1 * _field.maxScrollV) + 1));
                refreshTextImage();
            }
            else
            {
                if (_arg_1 < _SafeStr_951)
                {
                    _SafeStr_951 = _arg_1;
                    _field.scrollV = Math.min(_field.scrollV, ((_arg_1 * _field.maxScrollV) - 1));
                    refreshTextImage();
                };
            };
        }

        public function get visibleRegion():Rectangle
        {
            return (new Rectangle((_SafeStr_950 * maxScrollH), (_SafeStr_951 * maxScrollV), width, height));
        }

        public function get scrollableRegion():Rectangle
        {
            return (new Rectangle(0, 0, (maxScrollH + width), (maxScrollV + height)));
        }

        public function get scrollStepH():Number
        {
            return (10);
        }

        public function get scrollStepV():Number
        {
            return (_field.textHeight / _field.numLines);
        }

        public function set scrollStepH(_arg_1:Number):void
        {
        }

        public function set scrollStepV(_arg_1:Number):void
        {
        }

        private function replaceNonRenderableCharacters(_arg_1:String):String
        {
            var _local_5:Font = null;
            var _local_6:String;
            var _local_4:int;
            var _local_2:String;
            var _local_3:TextFormat = _field.getTextFormat();
            if (((!(_local_3)) || (!(_local_3.font))))
            {
                return (_arg_1);
            };
            var _local_7:Array = Font.enumerateFonts();
            for each (var _local_8:Font in _local_7)
            {
                if (_local_8.fontName.toLowerCase() == _local_3.font.toLowerCase())
                {
                    _local_5 = _local_8;
                };
            };
            if (_local_5 == null)
            {
                return (_arg_1);
            };
            if (_local_5.hasGlyphs(_arg_1))
            {
                return (_arg_1);
            };
            _local_6 = "";
            _local_4 = 0;
            while (_local_4 < _arg_1.length)
            {
                _local_2 = _arg_1.charAt(_local_4);
                if ((((!(_local_5.hasGlyphs(_local_2))) && (!(_local_2 == "\r"))) && (!(_local_2 == "\n"))))
                {
                    _local_6 = (_local_6 + REPLACE_RANDOM_CHARS[Math.floor((Math.random() * REPLACE_RANDOM_CHARS.length))]);
                }
                else
                {
                    _local_6 = (_local_6 + _local_2);
                };
                _local_4++;
            };
            return (_local_6);
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
            if ((((!(_SafeStr_905)) && (_caption.charAt(0) == "$")) && (_caption.charAt(1) == "{")))
            {
                _localized = true;
                context.registerLocalizationListener(_caption.slice(2, _caption.indexOf("}")), this);
            }
            else
            {
                if (_field != null)
                {
                    _field.text = replaceNonRenderableCharacters(_caption);
                    refreshTextImage();
                };
            };
        }

        override public function set caption(_arg_1:String):void
        {
            text = _arg_1;
        }

        override public function set color(_arg_1:uint):void
        {
            super.color = _arg_1;
            _field.backgroundColor = _arg_1;
        }

        override public function set background(_arg_1:Boolean):void
        {
            super.background = _arg_1;
            _field.background = _arg_1;
        }

        public function set localization(_arg_1:String):void
        {
            if (((!(_arg_1 == null)) && (!(_field == null))))
            {
                _field.text = limitStringLength(_arg_1);
                refreshTextImage();
            };
        }

        override public function clone():IWindow
        {
            var _local_1:TextController = (super.clone() as TextController);
            _local_1._field.backgroundColor = color;
            _local_1._field.background = background;
            _local_1._field.antiAliasType = "advanced";
            _local_1._field.gridFitType = "pixel";
            _local_1._SafeStr_950 = _SafeStr_950;
            _local_1._SafeStr_951 = _SafeStr_951;
            _local_1._SafeStr_907 = _SafeStr_907.clone(_local_1.setTextMargins);
            _local_1._SafeStr_948 = _SafeStr_948;
            _local_1._localized = _localized;
            return (_local_1);
        }

        override public function dispose():void
        {
            immediateClickMode = false;
            TextStyleManager.events.removeEventListener("change", onTextStyleChanged);
            if (_localized)
            {
                context.removeLocalizationListener(_caption.slice(2, _caption.indexOf("}")), this);
            };
            if (_SafeStr_907 != null)
            {
                _SafeStr_907.dispose();
                _SafeStr_907 = null;
            };
            _field = null;
            super.dispose();
        }

        override public function update(_arg_1:WindowController, _arg_2:WindowEvent):Boolean
        {
            if (!_drawing)
            {
                if (_arg_2.type == "WE_RESIZED")
                {
                    refreshTextImage(true);
                };
            };
            return (super.update(_arg_1, _arg_2));
        }

        protected function refreshTextImage(_arg_1:Boolean=false):void
        {
            var _local_16:int;
            var _local_17:int;
            var _local_10:String;
            var _local_5:int;
            var _local_4:int;
            var _local_7:int;
            var _local_11:String;
            var _local_12:int;
            var _local_9:TextFormat;
            var _local_8:int;
            var _local_14:WindowEvent;
            if (_drawing)
            {
                return;
            };
            _drawing = true;
            _local_16 = (_SafeStr_907.left + _SafeStr_907.right);
            var _local_15:int = (_SafeStr_907.top + _SafeStr_907.bottom);
            var _local_3:int = (_SafeStr_908 - _local_16);
            var _local_6:int = (_SafeStr_909 - _local_15);
            var _local_2:int = (Math.floor(_field.width) + ((_field.border) ? 1 : 0));
            var _local_13:Boolean;
            if (((_SafeStr_948 == "none") && (isOverflowReplaceOn)))
            {
                _local_10 = _field.text;
                if ((_field.textHeight + _local_15) > _local_6)
                {
                    _local_5 = (_field.numLines - 1);
                    while (((_field.getCharBoundaries(_field.getLineOffset(_local_5)) == null) || (_field.getCharBoundaries(_field.getLineOffset(_local_5)).bottom > _local_6)))
                    {
                        _local_5--;
                    };
                    _local_4 = _field.getLineOffset(_local_5);
                    _local_7 = (_local_4 + _field.getLineLength(_local_5));
                    _local_17 = _local_7;
                    while ((((_field.textHeight + _local_15) > _local_6) && (_local_17 > 0)))
                    {
                        _field.text = (_local_10.slice(0, --_local_17) + overflowReplace);
                    };
                };
                _local_11 = _field.text;
                if ((_field.textWidth + _local_16) > _local_3)
                {
                    _local_12 = (_field.text.length - 1);
                    while (((_field.getCharBoundaries(_local_12) == null) || (_field.getCharBoundaries(_local_12).right > _local_3)))
                    {
                        _local_12--;
                    };
                    _local_9 = getTextFormat(0, _local_12);
                    _local_17 = _local_12;
                    _local_8 = (((_local_16 + _local_9.indent) + _local_9.leftMargin) + _local_9.rightMargin);
                    while (((((_field.textWidth + _local_8) + 2) > _local_3) && (_local_17 > 0)))
                    {
                        _field.text = (_local_11.slice(0, --_local_17) + overflowReplace);
                    };
                };
                _local_2 = (Math.floor(_field.width) + ((_field.border) ? 1 : 0));
            };
            if (_local_2 != _local_3)
            {
                if (_SafeStr_948 == "left")
                {
                    setRectangle(_SafeStr_954, _SafeStr_955, (_local_2 + _local_16), (Math.floor(_field.height) + _local_15));
                    _local_13 = true;
                }
                else
                {
                    if (_SafeStr_948 != "right")
                    {
                        if (_SafeStr_948 != "center")
                        {
                            _field.width = (_local_3 - ((_field.border) ? 1 : 0));
                            _field.height = (_local_6 - ((_field.border) ? 1 : 0));
                        };
                    };
                };
            };
            if ((_field.height + ((_field.border) ? 1 : 0)) < _local_6)
            {
                if (_SafeStr_948 == "none")
                {
                    _field.height = (_local_6 - ((_field.border) ? 1 : 0));
                }
                else
                {
                    height = (Math.floor(_field.height) + _local_15);
                    _local_13 = true;
                };
            }
            else
            {
                if ((_field.height + ((_field.border) ? 1 : 0)) > _local_6)
                {
                    if (_SafeStr_948 != "none")
                    {
                        height = (Math.floor(_field.height) + _local_15);
                        _local_13 = true;
                    };
                };
            };
            _drawing = false;
            _context.invalidate(this, null, 1);
            if ((((!(_local_13)) && (!(_arg_1))) && (_SafeStr_913)))
            {
                _local_14 = WindowEvent.allocate("WE_RESIZED", this, null);
                _SafeStr_913.dispatchEvent(_local_14);
                _local_14.recycle();
            };
        }

        public function appendText(_arg_1:String):void
        {
            _field.appendText(_arg_1);
            refreshTextImage();
        }

        public function getCharBoundaries(_arg_1:int):Rectangle
        {
            return (_field.getCharBoundaries(_arg_1));
        }

        public function getCharIndexAtPoint(_arg_1:Number, _arg_2:Number):int
        {
            return (_field.getCharIndexAtPoint(_arg_1, _arg_2));
        }

        public function getFirstCharInParagraph(_arg_1:int):int
        {
            return (_field.getFirstCharInParagraph(_arg_1));
        }

        public function getImageReference(_arg_1:String):DisplayObject
        {
            return (_field.getImageReference(_arg_1));
        }

        public function getLineIndexAtPoint(_arg_1:Number, _arg_2:Number):int
        {
            return (_field.getLineIndexAtPoint(_arg_1, _arg_2));
        }

        public function getLineIndexOfChar(_arg_1:int):int
        {
            return (_field.getLineIndexOfChar(_arg_1));
        }

        public function getLineLength(_arg_1:int):int
        {
            return (_field.getLineLength(_arg_1));
        }

        public function getLineMetrics(_arg_1:int):TextLineMetrics
        {
            return (_field.getLineMetrics(_arg_1));
        }

        public function getLineOffset(_arg_1:int):int
        {
            return (_field.getLineOffset(_arg_1));
        }

        public function getLineText(_arg_1:int):String
        {
            return (_field.getLineText(_arg_1));
        }

        public function getParagraphLength(_arg_1:int):int
        {
            return (_field.getParagraphLength(_arg_1));
        }

        public function getTextFormat(_arg_1:int=-1, _arg_2:int=-1):TextFormat
        {
            return (_field.getTextFormat(_arg_1, _arg_2));
        }

        public function replaceText(_arg_1:int, _arg_2:int, _arg_3:String):void
        {
            _field.replaceText(_arg_1, _arg_2, _arg_3);
            refreshTextImage();
        }

        public function setTextFormat(_arg_1:TextFormat, _arg_2:int=-1, _arg_3:int=-1):void
        {
            if ((((_arg_2 >= 0) && (_arg_3 > _arg_2)) && (_arg_3 < _field.length)))
            {
                _field.setTextFormat(_arg_1, _arg_2, _arg_3);
                refreshTextImage();
            };
        }

        public function setTextMargins(_arg_1:IMargins):void
        {
            if (_arg_1 != _SafeStr_907)
            {
                _SafeStr_907.dispose();
                _SafeStr_907 = new TextMargins(_arg_1.left, _arg_1.top, _arg_1.right, _arg_1.bottom, setTextMargins);
            };
            if (_SafeStr_948 == "left")
            {
                _field.width = ((_SafeStr_908 - _SafeStr_907.left) - _SafeStr_907.right);
            };
            refreshTextImage();
        }

        private function onTextStyleChanged(_arg_1:Event):void
        {
            setTextFormatting(this);
            refreshTextImage();
        }

        protected function parseVariableSet(_arg_1:XML):void
        {
            var _local_3:Function;
            var _local_4:String;
            if (_arg_1 != null)
            {
                var _local_2:Map = new Map();
                XMLVariableParser.parseVariableList(_arg_1.children(), _local_2);
                _drawing = true;
                for (_local_4 in _local_2)
                {
                    _local_3 = _SafeStr_947[_local_4];
                    if (_local_3 != null)
                    {
                        (_local_3(this, _local_2[_local_4]));
                    };
                };
                _drawing = false;
            };
        }

        override public function set properties(_arg_1:Array):void
        {
            var _local_3:Function;
            _drawing = true;
            for each (var _local_2:PropertyStruct in _arg_1)
            {
                _local_3 = _SafeStr_947[_local_2.key];
                if (_local_3 != null)
                {
                    (_local_3(this, _local_2.value));
                };
            };
            _drawing = false;
            super.properties = _arg_1;
            refreshTextImage();
        }

        override public function get properties():Array
        {
            var _local_3:Array = super.properties;
            var _local_2:_SafeStr_177 = TextStyleManager.getStyle(_textStyleName);
            _local_3.push(createProperty("always_show_selection", _field.alwaysShowSelection));
            _local_3.push(new PropertyStruct("antialias_type", _field.antiAliasType, "String", (!(_field.antiAliasType == _local_2.antiAliasType)), _SafeStr_173.ANTIALIAS_TYPE_RANGE));
            _local_3.push(createProperty("auto_size", _SafeStr_948));
            _local_3.push(createProperty("border", _field.border));
            _local_3.push(createProperty("border_color", _field.borderColor));
            _local_3.push(new PropertyStruct("etching_color", _etchingColor, "hex", (!(_etchingColor == _local_2.etchingColor))));
            _local_3.push(new PropertyStruct("etching_position", _etchingPosition, "String", (!(_etchingPosition == _local_2.etchingPosition)), _SafeStr_173.ETCHING_POSITION_RANGE));
            _local_3.push(createProperty("condense_white", _field.condenseWhite));
            _local_3.push(new PropertyStruct("font_face", defaultTextFormat.font, "String", (!(defaultTextFormat.font == _local_2.fontFamily))));
            _local_3.push(new PropertyStruct("font_size", defaultTextFormat.size, "uint", (!(defaultTextFormat.size == _local_2.fontSize))));
            _local_3.push(createProperty("grid_fit_type", _field.gridFitType));
            var _local_1:uint = uint(((_local_2.color != null)
                    ? _local_2.color
                    : getDefaultProperty("text_color").value));
            _local_3.push(new PropertyStruct("text_color", _field.textColor, "hex", (!(_field.textColor == _local_1))));
            _local_3.push(createProperty("text_style", _textStyleName));
            _local_3.push(createProperty("margin_left", _SafeStr_907.left));
            _local_3.push(createProperty("margin_top", _SafeStr_907.top));
            _local_3.push(createProperty("margin_right", _SafeStr_907.right));
            _local_3.push(createProperty("margin_bottom", _SafeStr_907.bottom));
            _local_3.push(createProperty("mouse_wheel_enabled", _field.mouseWheelEnabled));
            _local_3.push(createProperty("max_chars", _field.maxChars));
            _local_3.push(createProperty("multiline", _field.multiline));
            _local_3.push(createProperty("restrict", _field.restrict));
            _local_3.push(new PropertyStruct("sharpness", _field.sharpness, "Number", (!(_field.sharpness == _local_2.sharpness))));
            _local_3.push(new PropertyStruct("thickness", _field.thickness, "Number", (!(_field.thickness == _local_2.thickness))));
            _local_3.push(createProperty("word_wrap", _field.wordWrap));
            _local_3.push(createProperty("max_lines", maxLines));
            _local_3.push(createProperty("overflow_replace", overflowReplace));
            _local_3.push(new PropertyStruct("bold", (!(_field.defaultTextFormat.bold == false)), "Boolean", (!(_field.defaultTextFormat.bold == (_local_2.fontWeight == "bold")))));
            _local_3.push(new PropertyStruct("italic", (!(_field.defaultTextFormat.italic == false)), "Boolean", (!(_field.defaultTextFormat.italic == (_local_2.fontStyle == "italic")))));
            _local_3.push(new PropertyStruct("underline", (!(_field.defaultTextFormat.underline == false)), "Boolean", (!(_field.defaultTextFormat.underline == (_local_2.textDecoration == "underline")))));
            _local_3.push(new PropertyStruct("kerning", (!(_field.defaultTextFormat.kerning == false)), "Boolean", (!(_field.defaultTextFormat.kerning == _local_2.kerning))));
            _local_3.push(new PropertyStruct("spacing", _field.defaultTextFormat.letterSpacing, "Number", (!(_field.defaultTextFormat.letterSpacing == _local_2.letterSpacing))));
            _local_3.push(new PropertyStruct("leading", _field.defaultTextFormat.leading, "Number", (!(_field.defaultTextFormat.leading == _local_2.leading))));
            return (_local_3);
        }

        public function get etchingColor():uint
        {
            return (_etchingColor);
        }

        public function set etchingColor(_arg_1:uint):void
        {
            setEtchingColor(this, _arg_1);
        }

        public function set styleSheet(_arg_1:StyleSheet):void
        {
            setStyleSheet(this, _arg_1);
        }

        private function setStyleSheet(_arg_1:TextController, _arg_2:StyleSheet):void
        {
            _arg_1._field.styleSheet = _arg_2;
            refreshTextImage();
        }

        public function get etchingPosition():String
        {
            return (_etchingPosition);
        }

        public function set etchingPosition(_arg_1:String):void
        {
            setEtchingPosition(this, _arg_1);
        }

        public function resetExplicitStyle():void
        {
            _SafeStr_953 = new _SafeStr_177();
        }


    }
}