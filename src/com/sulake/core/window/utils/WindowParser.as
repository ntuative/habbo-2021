package com.sulake.core.window.utils
{
    import flash.utils.Dictionary;
    import com.sulake.core.utils.Map;
    import com.sulake.core.window.IWindowContext;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.utils.XMLVariableParser;
    import com.sulake.core.window.WindowController;
    import flash.geom.Rectangle;
    import flash.filters.BitmapFilter;
    import com.sulake.core.window.components.IBoxSizerWindow;
    import flash.filters.DropShadowFilter;
    import flash.utils.*;

    public class WindowParser implements IWindowParser
    {

        public static const ELEMENT_TAG_EXCLUDE:String = "_EXCLUDE";
        public static const ELEMENT_TAG_INCLUDE:String = "_INCLUDE";
        public static const _SafeStr_1210:String = "_TEMP";
        private static const LAYOUT:String = "layout";
        private static const _SafeStr_647:String = "window";
        private static const VARIABLES:String = "variables";
        private static const FILTERS:String = "filters";
        private static const NAME:String = "name";
        private static const STYLE:String = "style";
        private static const _SafeStr_1211:String = "dynamic_style";
        private static const PARAMS:String = "params";
        private static const TAGS:String = "tags";
        private static const X:String = "x";
        private static const _SafeStr_882:String = "y";
        private static const WIDTH:String = "width";
        private static const HEIGHT:String = "height";
        private static const VISIBLE:String = "visible";
        private static const CAPTION:String = "caption";
        private static const ID:String = "id";
        private static const BACKGROUND:String = "background";
        private static const BLEND:String = "blend";
        private static const CLIPPING:String = "clipping";
        private static const COLOR:String = "color";
        private static const THRESHOLD:String = "treshold";
        private static const CHILDREN:String = "children";
        private static const WIDTH_MIN:String = "width_min";
        private static const _SafeStr_1212:String = "width_max";
        private static const HEIGHT_MIN:String = "height_min";
        private static const _SafeStr_1213:String = "height_max";
        private static const TRUE:String = "true";
        private static const ZERO:String = "0";
        private static const VAR:String = "$";
        private static const COMMA:String = ",";
        private static const EMPTY:String = "";
        private static const _SafeStr_1214:RegExp = /^(\s|\n|\r|\t|\v)*/m;
        private static const _SafeStr_1215:RegExp = /(\s|\n|\r|\t|\v)*$/;

        protected var _SafeStr_1206:Dictionary;
        protected var _SafeStr_1207:Dictionary;
        protected var _SafeStr_1208:Dictionary;
        protected var _SafeStr_1209:Dictionary;
        protected var _parsedLayoutCache:Map;
        protected var _context:IWindowContext;
        private var _disposed:Boolean = false;

        public function WindowParser(_arg_1:IWindowContext)
        {
            _context = _arg_1;
            _SafeStr_1206 = new Dictionary();
            _SafeStr_1207 = new Dictionary();
            _SafeStr_184.fillTables(_SafeStr_1206, _SafeStr_1207);
            _SafeStr_1208 = new Dictionary();
            _SafeStr_1209 = new Dictionary();
            _SafeStr_196.fillTables(_SafeStr_1208, _SafeStr_1209);
            _parsedLayoutCache = new Map();
        }

        private static function trimWhiteSpace(_arg_1:String):String
        {
            _arg_1 = _arg_1.replace(_SafeStr_1215, "");
            return (_arg_1.replace(_SafeStr_1214, ""));
        }


        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function dispose():void
        {
            var _local_1:Object;
            if (!_disposed)
            {
                for (_local_1 in _SafeStr_1206)
                {
                    delete _SafeStr_1206[_local_1];
                };
                for (_local_1 in _SafeStr_1207)
                {
                    delete _SafeStr_1207[_local_1];
                };
                for (_local_1 in _SafeStr_1208)
                {
                    delete _SafeStr_1208[_local_1];
                };
                for (_local_1 in _SafeStr_1209)
                {
                    delete _SafeStr_1209[_local_1];
                };
                _parsedLayoutCache.dispose();
                _parsedLayoutCache = null;
                _context = null;
                _disposed = true;
            };
        }

        public function parseAndConstruct(_arg_1:XML, _arg_2:IWindow, _arg_3:Map):IWindow
        {
            var _local_6:uint;
            var _local_13:IWindow;
            var _local_8:uint;
            var _local_12:XMLList;
            var _local_9:XMLList;
            var _local_5:XML;
            var _local_4:XMLList;
            var _local_11:Array;
            var _local_10:uint;
            if (_arg_1.localName() == "layout")
            {
                _local_9 = _arg_1.child("variables");
                if (_local_9.length() > 0)
                {
                    _local_5 = _local_9[0];
                    var _local_7:XMLList = XML(_local_5[0]).children();
                    if (_local_7.length() > 0)
                    {
                        if (_arg_3 == null)
                        {
                            _arg_3 = new Map();
                        };
                        XMLVariableParser.parseVariableList(_local_7, _arg_3);
                    };
                };
                _local_4 = _arg_1.child("filters").children();
                if (_local_4.length() > 0)
                {
                    _local_11 = [];
                    _local_10 = 0;
                    while (_local_10 < _local_4.length())
                    {
                        _local_11.push(buildBitmapFilter(_local_4[_local_10]));
                        _local_10++;
                    };
                    _arg_2.filters = _local_11;
                };
                _local_12 = _arg_1.child("window");
                _local_6 = _local_12.length();
                switch (_local_6)
                {
                    case 0:
                        return (null);
                    case 1:
                        _arg_1 = _local_12[0];
                        break;
                    default:
                        _local_8 = 0;
                        while (_local_8 < _local_6)
                        {
                            _local_13 = parseSingleWindowEntity(_local_12[_local_8], WindowController(_arg_2), _arg_3);
                            _local_8++;
                        };
                        return (_local_13);
                };
            };
            if (_arg_1.localName() == "window")
            {
                _local_12 = _arg_1.children();
                _local_6 = _local_12.length();
                if (_local_6 > 1)
                {
                    _local_8 = 0;
                    while (_local_8 < _local_6)
                    {
                        _local_13 = parseSingleWindowEntity(_local_12[_local_8], WindowController(_arg_2), _arg_3);
                        _local_8++;
                    };
                    return (_local_13);
                };
                _arg_1 = _arg_1.children()[0];
            };
            return ((_arg_1 != null) ? parseSingleWindowEntity(_arg_1, WindowController(_arg_2), _arg_3) : null);
        }

        private function parseSingleWindowEntity(_arg_1:XML, _arg_2:WindowController, _arg_3:Map):IWindow
        {
            var _local_9:uint;
            var _local_27:String;
            var _local_10:Rectangle;
            var _local_24:XML;
            var _local_21:XMLList;
            var _local_17:uint;
            var _local_18:uint;
            var _local_29:WindowController;
            var _local_12:String;
            var _local_22:Array;
            var _local_19:Array;
            var _local_23:BitmapFilter;
            var _local_11:IIterator;
            var _local_7:String = "";
            var _local_16:Boolean = true;
            var _local_4:Boolean = true;
            var _local_5:String = "0x00ffffff";
            var _local_6:Number = 1;
            var _local_26:Boolean;
            var _local_8:uint = 10;
            var _local_28:uint = ((_arg_2 != null) ? _arg_2.style : 0);
            var _local_25:String = "";
            var _local_20:uint;
            var _local_13:String = "";
            var _local_14:int;
            _local_9 = _SafeStr_1206[_arg_1.localName()];
            _local_27 = unescape(String(parseAttribute(_arg_1, "name", _arg_3, "")));
            _local_28 = uint(parseAttribute(_arg_1, "style", _arg_3, _local_28));
            _local_25 = String(parseAttribute(_arg_1, "dynamic_style", _arg_3, ""));
            _local_20 = uint(parseAttribute(_arg_1, "params", _arg_3, _local_20));
            _local_13 = unescape(String(parseAttribute(_arg_1, "tags", _arg_3, _local_13)));
            _local_10 = new Rectangle();
            _local_10.x = Number(parseAttribute(_arg_1, "x", _arg_3, "0"));
            _local_10.y = Number(parseAttribute(_arg_1, "y", _arg_3, "0"));
            _local_10.width = Number(parseAttribute(_arg_1, "width", _arg_3, "0"));
            _local_10.height = Number(parseAttribute(_arg_1, "height", _arg_3, "0"));
            _local_16 = (parseAttribute(_arg_1, "visible", _arg_3, _local_16.toString()) == "true");
            _local_14 = int(parseAttribute(_arg_1, "id", _arg_3, _local_14.toString()));
            if (_arg_1.child("params").length() > 0)
            {
                _local_21 = _arg_1.child("params").children();
                _local_17 = _local_21.length();
                _local_18 = 0;
                while (_local_18 < _local_17)
                {
                    _local_24 = _local_21[_local_18];
                    _local_12 = (parseAttribute(_local_24, "name", _arg_3, "") as String);
                    if (_SafeStr_1208[_local_12] != null)
                    {
                        _local_20 = (_local_20 | _SafeStr_1208[_local_12]);
                    }
                    else
                    {
                        throw (new Error((('Unknown window parameter "' + _local_24.attribute("name")) + '"!')));
                    };
                    _local_18++;
                };
            };
            _local_7 = ((_local_20 & 0x80000000) ? ((_arg_2) ? _arg_2.caption : "") : "");
            _local_7 = unescape(String(parseAttribute(_arg_1, "caption", _arg_3, _local_7)));
            if (_local_13 != "")
            {
                _local_22 = _local_13.split(",");
                _local_17 = _local_22.length;
                _local_18 = 0;
                while (_local_18 < _local_17)
                {
                    _local_22[_local_18] = WindowParser.trimWhiteSpace(_local_22[_local_18]);
                    _local_18++;
                };
            };
            _local_29 = (_context.create(_local_27, null, _local_9, _local_28, _local_20, _local_10, null, ((_arg_2 is IIterable) ? null : _arg_2), _local_14, parseProperties(_arg_1.child("variables")[0]), _local_25, _local_22) as WindowController);
            if (hasAttribute(_arg_1, "width_min"))
            {
                _local_29.limits.minWidth = int(parseAttribute(_arg_1, "width_min", _arg_3, _local_29.limits.minWidth));
            };
            if (hasAttribute(_arg_1, "width_max"))
            {
                _local_29.limits.maxWidth = int(parseAttribute(_arg_1, "width_max", _arg_3, _local_29.limits.maxWidth));
            };
            if (hasAttribute(_arg_1, "height_min"))
            {
                _local_29.limits.minHeight = int(parseAttribute(_arg_1, "height_min", _arg_3, _local_29.limits.minHeight));
            };
            if (hasAttribute(_arg_1, "height_max"))
            {
                _local_29.limits.maxHeight = int(parseAttribute(_arg_1, "height_max", _arg_3, _local_29.limits.maxHeight));
            };
            _local_29.limits.limit();
            _local_26 = (parseAttribute(_arg_1, "background", _arg_3, _local_29.background.toString()) == "true");
            _local_6 = Number(parseAttribute(_arg_1, "blend", _arg_3, _local_29.blend.toString()));
            _local_4 = (parseAttribute(_arg_1, "clipping", _arg_3, _local_29.clipping.toString()) == "true");
            _local_5 = String(parseAttribute(_arg_1, "color", _arg_3, _local_29.color.toString()));
            _local_8 = uint(parseAttribute(_arg_1, "treshold", _arg_3, _local_29.mouseThreshold.toString()));
            if (_local_29.caption != _local_7)
            {
                _local_29.caption = _local_7;
            };
            if (_local_29.blend != _local_6)
            {
                _local_29.blend = _local_6;
            };
            if (_local_29.visible != _local_16)
            {
                _local_29.visible = _local_16;
            };
            if (_local_29.clipping != _local_4)
            {
                _local_29.clipping = _local_4;
            };
            if (_local_29.background != _local_26)
            {
                _local_29.background = _local_26;
            };
            if (_local_29.mouseThreshold != _local_8)
            {
                _local_29.mouseThreshold = _local_8;
            };
            var _local_15:uint = ((_local_5.charAt(1) == "x") ? parseInt(_local_5, 16) : uint(_local_5));
            if (_local_29.color != _local_15)
            {
                _local_29.color = _local_15;
            };
            _local_21 = _arg_1.child("filters").children();
            _local_17 = _local_21.length();
            if (_local_17 > 0)
            {
                _local_19 = [];
                _local_18 = 0;
                while (_local_18 < _local_17)
                {
                    _local_23 = (buildBitmapFilter(_local_21[_local_18]) as BitmapFilter);
                    if (_local_23 != null)
                    {
                        _local_19.push(_local_23);
                    };
                    _local_18++;
                };
                _local_29.filters = _local_19;
            };
            if (_local_29 != null)
            {
                if (_arg_2 != null)
                {
                    if ((_arg_2 is IIterable))
                    {
                        if (((((!(_local_29.x == _local_10.x)) || (!(_local_29.y == _local_10.y))) || (!(_local_29.width == _local_10.width))) || (!(_local_29.height == _local_10.height))))
                        {
                            if ((_local_20 & 0xC0) == 192)
                            {
                                _local_29.x = _local_10.x;
                            };
                            if ((_local_20 & 0x0C00) == 0x0C00)
                            {
                                _local_29.y = _local_10.y;
                            };
                        };
                        try
                        {
                            _local_11 = IIterable(_arg_2).iterator;
                        }
                        catch(e:Error)
                        {
                        };
                        if (_local_11 != null)
                        {
                            _local_11[_local_11.length] = _local_29;
                        }
                        else
                        {
                            _arg_2.addChild(_local_29);
                        };
                    };
                };
            };
            _local_21 = _arg_1.child("children");
            if (_local_21.length() > 0)
            {
                _local_24 = _local_21[0];
                _local_21 = _local_24.children();
                _local_17 = _local_21.length();
                if ((_local_29 is IBoxSizerWindow))
                {
                    IBoxSizerWindow(_local_29).setAutoRearrange(false);
                };
                _local_18 = 0;
                while (_local_18 < _local_17)
                {
                    parseAndConstruct(_local_21[_local_18], _local_29, _arg_3);
                    _local_18++;
                };
            };
            if ((_local_29 is IBoxSizerWindow))
            {
                IBoxSizerWindow(_local_29).setAutoRearrange(true);
            };
            return (_local_29);
        }

        private function hasAttribute(_arg_1:XML, _arg_2:String):Boolean
        {
            return (_arg_1.attribute(_arg_2).length() > 0);
        }

        private function parseAttribute(_arg_1:XML, _arg_2:String, _arg_3:Map, _arg_4:Object):Object
        {
            var _local_5:XMLList = _arg_1.attribute(_arg_2);
            if (_local_5.length() == 0)
            {
                return (_arg_4);
            };
            var _local_6:String = String(_local_5);
            if (_arg_3 != null)
            {
                if (_local_6.charAt(0) == "$")
                {
                    _local_6 = _arg_3[_local_6.slice(1, _local_6.length)];
                    if (_local_6 == null)
                    {
                        throw (new Error((('Shared variable not defined: "' + _arg_1.attribute(_arg_2)) + '"!')));
                    };
                };
            };
            return (_local_6);
        }

        private function parseProperties(_arg_1:XML):Array
        {
            return ((_arg_1 != null) ? XMLPropertyArrayParser.parse(_arg_1.children()) : []);
        }

        public function windowToXMLString(_arg_1:IWindow):String
        {
            var _local_17:IWindow;
            var _local_6:uint;
            var _local_10:IIterator;
            var _local_12:PropertyStruct;
            var _local_4:String;
            if (_arg_1.dynamicStyle.length < 3)
            {
                _arg_1.dynamicStyle = "";
            };
            if (_arg_1.dynamicStyle != "")
            {
                _arg_1.setParamFlag(16, false);
            };
            var _local_11:String = "";
            var _local_7:String = _SafeStr_1207[_arg_1.type];
            var _local_8:uint = _arg_1.param;
            var _local_13:uint = _arg_1.style;
            var _local_14:IRectLimiter = _arg_1.limits;
            var _local_16:WindowController = (_arg_1 as WindowController);
            _local_11 = (_local_11 + ((((((((((((((((((((((((((((((((((("<" + _local_7) + ' x="') + _arg_1.x) + '"') + ' y="') + _arg_1.y) + '"') + ' width="') + _arg_1.width) + '"') + ' height="') + _arg_1.height) + '"') + ' params="') + _arg_1.param) + '"') + ' style="') + _arg_1.style) + '"') + ((_arg_1.dynamicStyle != "") ? ((' dynamic_style="' + _arg_1.dynamicStyle) + '"') : "")) + ((_arg_1.name != "") ? ((' name="' + escape(_arg_1.name)) + '"') : "")) + ((_arg_1.caption != "") ? ((' caption="' + escape(_arg_1.caption)) + '"') : "")) + ((_arg_1.id != 0) ? ((' id="' + _arg_1.id.toString()) + '"') : "")) + ((_arg_1.color != 0xFFFFFF) ? (((' color="0x' + _arg_1.alpha.toString(16)) + _arg_1.color.toString(16)) + '"') : "")) + ((_arg_1.blend != 1) ? ((' blend="' + _arg_1.blend.toString()) + '"') : "")) + ((_arg_1.visible != true) ? ((' visible="' + _arg_1.visible.toString()) + '"') : "")) + ((_arg_1.clipping != true) ? ((' clipping="' + _arg_1.clipping.toString()) + '"') : "")) + ((_arg_1.background != false) ? ((' background="' + _arg_1.background.toString()) + '"') : "")) + ((_arg_1.mouseThreshold != 10) ? ((' treshold="' + _arg_1.mouseThreshold.toString()) + '"') : "")) + ((_arg_1.tags.length > 0) ? ((' tags="' + escape(_arg_1.tags.toString())) + '"') : "")) + ((_local_14.minWidth > -2147483648) ? ((' width_min="' + _local_14.minWidth) + '"') : "")) + ((_local_14.maxWidth < 2147483647) ? ((' width_max="' + _local_14.maxWidth) + '"') : "")) + ((_local_14.minHeight > -2147483648) ? ((' height_min="' + _local_14.minHeight) + '"') : "")) + ((_local_14.maxHeight < 2147483647) ? ((' height_max="' + _local_14.maxHeight) + '"') : "")) + ">\r"));
            if (((_arg_1.filters) && (_arg_1.filters.length > 0)))
            {
                _local_11 = (_local_11 + "\t<filters>\r");
                for each (var _local_9:BitmapFilter in _arg_1.filters)
                {
                    _local_11 = (_local_11 + (("\t\t" + filterToXmlString(_local_9)) + "\r"));
                };
                _local_11 = (_local_11 + "\t</filters>\r");
            };
            var _local_5:uint = _local_16.numChildren;
            var _local_2:String = "";
            if ((_local_16 is IIterable))
            {
                _local_10 = IIterable(_local_16).iterator;
                _local_5 = _local_10.length;
                if (_local_5 > 0)
                {
                    _local_6 = 0;
                    while (_local_6 < _local_5)
                    {
                        _local_17 = (_local_10[_local_6] as IWindow);
                        if (_local_17.tags.indexOf("_EXCLUDE") == -1)
                        {
                            _local_2 = (_local_2 + windowToXMLString(_local_17));
                        };
                        _local_6++;
                    };
                };
            }
            else
            {
                _local_5 = _local_16.numChildren;
                if (_local_5 > 0)
                {
                    _local_6 = 0;
                    while (_local_6 < _local_5)
                    {
                        _local_17 = _local_16.getChildAt(_local_6);
                        if (_local_17.tags.indexOf("_EXCLUDE") == -1)
                        {
                            _local_2 = (_local_2 + windowToXMLString(_local_17));
                        };
                        _local_6++;
                    };
                };
            };
            if (_local_2.length > 0)
            {
                _local_11 = (_local_11 + (("\t<children>\r" + _local_2) + "\t</children>\r"));
            };
            var _local_15:Array = _arg_1.properties;
            if (((!(_local_15 == null)) && (_local_15.length > 0)))
            {
                _local_4 = "\t<variables>\r";
                var _local_3:Boolean = false;
                _local_6 = 0;
                while (_local_6 < _local_15.length)
                {
                    _local_12 = (_local_15[_local_6] as PropertyStruct);
                    if (_local_12.valid)
                    {
                        _local_4 = (_local_4 + (("\t\t" + _local_12.toXMLString()) + "\r"));
                        _local_3 = true;
                    };
                    _local_6++;
                };
                _local_4 = (_local_4 + "\t</variables>\r");
                if (_local_3)
                {
                    _local_11 = (_local_11 + _local_4);
                };
            };
            _local_11 = (_local_11 + (("</" + _local_7) + ">\r"));
            return (_local_11);
        }

        private function buildBitmapFilter(_arg_1:XML):BitmapFilter
        {
            var _local_2:BitmapFilter;
            var _local_3:String = (_arg_1.localName() as String);
            switch (_local_3)
            {
                case "DropShadowFilter":
                    _local_2 = new DropShadowFilter(Number(parseAttribute(_arg_1, "distance", null, "0")), Number(parseAttribute(_arg_1, "angle", null, "45")), uint(parseAttribute(_arg_1, "color", null, "0")), Number(parseAttribute(_arg_1, "alpha", null, "1")), Number(parseAttribute(_arg_1, "blurX", null, "0")), Number(parseAttribute(_arg_1, "blurY", null, "0")), Number(parseAttribute(_arg_1, "strength", null, "1")), int(parseAttribute(_arg_1, "quality", null, "1")), (parseAttribute(_arg_1, "inner", null, "false") == "true"), (parseAttribute(_arg_1, "knockout", null, "false") == "true"), (parseAttribute(_arg_1, "hideObject", null, "false") == "true"));
            };
            return (_local_2);
        }

        private function filterToXmlString(_arg_1:BitmapFilter):String
        {
            var _local_2:String;
            if ((_arg_1 is DropShadowFilter))
            {
                _local_2 = "<DropShadowFilter";
                _local_2 = (_local_2 + ((DropShadowFilter(_arg_1).distance != 0) ? ((' distance="' + DropShadowFilter(_arg_1).distance) + '"') : ""));
                _local_2 = (_local_2 + ((DropShadowFilter(_arg_1).angle != 45) ? ((' angle="' + DropShadowFilter(_arg_1).angle) + '"') : ""));
                _local_2 = (_local_2 + ((DropShadowFilter(_arg_1).color != 0) ? ((' color="' + DropShadowFilter(_arg_1).color) + '"') : ""));
                _local_2 = (_local_2 + ((DropShadowFilter(_arg_1).alpha != 1) ? ((' alpha="' + DropShadowFilter(_arg_1).alpha) + '"') : ""));
                _local_2 = (_local_2 + ((DropShadowFilter(_arg_1).blurX != 0) ? ((' blurX="' + DropShadowFilter(_arg_1).blurX) + '"') : ""));
                _local_2 = (_local_2 + ((DropShadowFilter(_arg_1).blurY != 0) ? ((' blurY="' + DropShadowFilter(_arg_1).blurY) + '"') : ""));
                _local_2 = (_local_2 + ((DropShadowFilter(_arg_1).strength != 1) ? ((' strength="' + DropShadowFilter(_arg_1).strength) + '"') : ""));
                _local_2 = (_local_2 + ((DropShadowFilter(_arg_1).quality != 1) ? ((' quality="' + DropShadowFilter(_arg_1).quality) + '"') : ""));
                _local_2 = (_local_2 + ((DropShadowFilter(_arg_1).inner != false) ? ((' inner="' + DropShadowFilter(_arg_1).inner) + '"') : ""));
                _local_2 = (_local_2 + ((DropShadowFilter(_arg_1).knockout != false) ? ((' knockout="' + DropShadowFilter(_arg_1).knockout) + '"') : ""));
                _local_2 = (_local_2 + ((DropShadowFilter(_arg_1).hideObject != false) ? ((' hideObject="' + DropShadowFilter(_arg_1).hideObject) + '"') : ""));
                _local_2 = (_local_2 + " />");
            };
            return (_local_2);
        }


    }
}