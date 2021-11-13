package com.sulake.core.window.graphics
{
    import com.sulake.core.utils.Map;
    import com.sulake.core.utils.XMLVariableParser;
    import flash.utils.Dictionary;
    import com.sulake.core.window.graphics.renderer.ISkinRenderer;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.graphics.renderer.SkinLayout;
    import com.sulake.core.window.graphics.renderer.SkinLayoutEntity;
    import flash.geom.Rectangle;
    import com.sulake.core.window.graphics.renderer.BitmapSkinTemplate;
    import com.sulake.core.window.graphics.renderer.BitmapSkinTemplateEntity;
    import com.sulake.core.window.graphics.renderer.ISkinLayout;
    import com.sulake.core.window.graphics.renderer.*;

    public class BitmapSkinParser
    {

        public static const WINDOW_STATE_DEFAULT:String = "default";
        public static const WINDOW_STATE_ACTIVE:String = "active";
        public static const _SafeStr_1024:String = "focused";
        public static const WINDOW_STATE_HOVERING:String = "hovering";
        public static const _SafeStr_1025:String = "selected";
        public static const _SafeStr_1026:String = "pressed";
        public static const _SafeStr_1027:String = "disabled";
        public static const _SafeStr_1028:String = "locked";


        public static function parseSkinDescription(_arg_1:XML, _arg_2:XMLList, _arg_3:ISkinRenderer, _arg_4:String, _arg_5:IAssetLibrary):void
        {
            var _local_8:XML;
            var _local_10:XMLList;
            var _local_21:XMLList;
            var _local_19:uint;
            var _local_13:uint;
            var _local_22:XML;
            var _local_11:XMLList;
            var _local_7:uint;
            var _local_20:uint;
            var _local_14:uint;
            var _local_18:XML;
            var _local_6:Map = new Map();
            var _local_12:XMLList = _arg_1.child("variables");
            if (_local_12.length() > 0)
            {
                _local_8 = _local_12[0];
                _local_10 = _local_8.child("variable");
                if (_local_10.length())
                {
                    XMLVariableParser.parseVariableList(_local_10, _local_6);
                };
            };
            var _local_9:Dictionary = new Dictionary();
            var _local_17:XMLList = _arg_1.child("templates");
            if (_local_17[0])
            {
                parseTemplateList(_arg_3, _local_17[0], _local_9, _local_6, _arg_5);
            };
            var _local_15:Dictionary = new Dictionary();
            var _local_16:XMLList = _arg_1.child("layouts");
            if (_local_16[0])
            {
                if (_arg_4 == null)
                {
                    parseLayoutList(_arg_3, _local_16[0], _local_15, _local_6);
                }
                else
                {
                    _local_21 = _local_16[0].child("layout");
                    _local_19 = _local_21.length();
                    _local_13 = 0;
                    while (_local_13 < _local_19)
                    {
                        _local_22 = _local_21[_local_13];
                        if (_local_22.attribute("name") == _arg_4)
                        {
                            parseLayout(_arg_3, _local_22, _local_15, _local_6);
                            break;
                        };
                        _local_13++;
                    };
                };
            };
            if (_arg_2.length() == 0)
            {
                _arg_2 = _arg_1.child("states");
            };
            if (_arg_2.length() > 0)
            {
                if (_arg_4 == null)
                {
                    parseRenderStateList(_arg_3, _arg_2[0], _local_15, _local_6);
                }
                else
                {
                    _local_11 = _arg_2[0].child("state");
                    _local_7 = _local_11.length();
                    _local_20 = 0;
                    _local_14 = 0;
                    while (_local_14 < _local_7)
                    {
                        _local_18 = _local_11[_local_14];
                        if (_local_18.attribute("layout") == _arg_4)
                        {
                            parseState(_arg_3, _local_18, _local_15, _local_6);
                            _local_20++;
                        };
                        _local_14++;
                    };
                };
            };
        }

        protected static function parseLayout(_arg_1:ISkinRenderer, _arg_2:XML, _arg_3:Dictionary, _arg_4:Map):void
        {
            var _local_7:String;
            var _local_8:XML;
            var _local_9:XMLList;
            _local_7 = _arg_2.attribute("name");
            var _local_10:Boolean = (_arg_2.attribute("transparent") == "true");
            var _local_5:String = _arg_2.attribute("blendMode");
            var _local_6:SkinLayout = new SkinLayout(_local_7, _local_10, _local_5);
            var _local_11:XMLList = _arg_2.child("entities");
            if (_local_11.length() > 0)
            {
                _local_8 = _local_11[0];
                _local_9 = _local_8.child("entity");
                if (_local_9.length())
                {
                    parseLayoutEntityList(_arg_1, _local_6, _local_9, _arg_4);
                };
            };
            _arg_3[_local_7] = _local_6;
            _arg_1.addLayout(_local_6);
        }

        protected static function parseLayoutList(_arg_1:ISkinRenderer, _arg_2:XML, _arg_3:Dictionary, _arg_4:Map):void
        {
            var _local_6:uint;
            var _local_8:XML;
            var _local_7:XMLList = _arg_2.child("layout");
            var _local_5:uint = _local_7.length();
            _local_6 = 0;
            while (_local_6 < _local_5)
            {
                _local_8 = _local_7[_local_6];
                parseLayout(_arg_1, _local_8, _arg_3, _arg_4);
                _local_6++;
            };
        }

        protected static function parseLayoutEntity(_arg_1:XML, _arg_2:Map):SkinLayoutEntity
        {
            var _local_4:String;
            var _local_6:SkinLayoutEntity;
            var _local_5:uint;
            var _local_3:String;
            var _local_7:XML;
            var _local_8:XMLList;
            _local_3 = _arg_1.attribute("id");
            _local_5 = ((_local_3 == null) ? 0 : uint(_local_3));
            _local_3 = _arg_1.attribute("name");
            _local_4 = ((_local_3 == null) ? "" : _local_3);
            _local_6 = new SkinLayoutEntity(_local_5, _local_4);
            _local_3 = _arg_1.attribute("colorize");
            _local_6.colorize = ((_local_3 == "") ? true : (_local_3 == "true"));
            _local_3 = null;
            _local_8 = _arg_1.child("color");
            if (_local_8.length() > 0)
            {
                _local_7 = _local_8[0];
                _local_3 = String(_local_7);
                if (_local_3 != null)
                {
                    if (_local_3.charAt(0) == "$")
                    {
                        _local_3 = _arg_2[_local_3.slice(1, _local_3.length)];
                    };
                };
            };
            _local_6.color = ((_local_3 == null) ? 0 : uint(_local_3));
            _local_3 = null;
            _local_8 = _arg_1.child("blend");
            if (_local_8.length() > 0)
            {
                _local_7 = _local_8[0];
                _local_3 = String(_local_7);
                if (_local_3 != null)
                {
                    if (_local_3.charAt(0) == "$")
                    {
                        _local_3 = _arg_2[_local_3.slice(1, _local_3.length)];
                    };
                };
            };
            _local_6.blend = ((_local_3 == null) ? 0xFFFFFFFF : uint(_local_3));
            _local_8 = _arg_1.child("scale");
            if (_local_8.length() > 0)
            {
                _local_7 = _local_8[0];
                _local_3 = _local_7.attribute("horizontal");
                if (_local_3 != null)
                {
                    if (_local_3.charAt(0) == "$")
                    {
                        _local_3 = _arg_2[_local_3.slice(1, _local_3.length)];
                    };
                };
                switch (_local_3.toLowerCase())
                {
                    case "fixed":
                        _local_6.scaleH = 0;
                        break;
                    case "move":
                        _local_6.scaleH = 1;
                        break;
                    case "strech":
                        _local_6.scaleH = 2;
                        break;
                    case "tiled":
                        _local_6.scaleH = 4;
                        break;
                    case "center":
                        _local_6.scaleH = 8;
                };
                _local_3 = _local_7.attribute("vertical");
                if (_local_3 != null)
                {
                    if (_local_3.charAt(0) == "$")
                    {
                        _local_3 = _arg_2[_local_3.slice(1, _local_3.length)];
                    };
                };
                switch (_local_3.toLowerCase())
                {
                    case "fixed":
                        _local_6.scaleV = 0;
                        break;
                    case "move":
                        _local_6.scaleV = 1;
                        break;
                    case "strech":
                        _local_6.scaleV = 2;
                        break;
                    case "tiled":
                        _local_6.scaleV = 4;
                        break;
                    case "center":
                        _local_6.scaleV = 8;
                };
            };
            _local_8 = _arg_1.child("region");
            if (_local_8.length() > 0)
            {
                _local_7 = _local_8[0];
                _local_8 = _local_7.child("Rectangle");
                _local_7 = _local_8[0];
                _local_6.region = new Rectangle();
                _local_3 = _local_7.attribute("x");
                _local_6.region.x = ((_local_3.charAt(0) == "$") ? _arg_2[_local_3.slice(1, _local_3.length)] : Number(_local_3));
                _local_3 = _local_7.attribute("y");
                _local_6.region.y = ((_local_3.charAt(0) == "$") ? _arg_2[_local_3.slice(1, _local_3.length)] : Number(_local_3));
                _local_3 = _local_7.attribute("width");
                _local_6.region.width = ((_local_3.charAt(0) == "$") ? _arg_2[_local_3.slice(1, _local_3.length)] : Number(_local_3));
                _local_3 = _local_7.attribute("height");
                _local_6.region.height = ((_local_3.charAt(0) == "$") ? _arg_2[_local_3.slice(1, _local_3.length)] : Number(_local_3));
            };
            return (_local_6);
        }

        protected static function parseLayoutEntityList(_arg_1:ISkinRenderer, _arg_2:SkinLayout, _arg_3:XMLList, _arg_4:Map):void
        {
            var _local_7:SkinLayoutEntity;
            var _local_6:uint;
            var _local_5:uint = _arg_3.length();
            _local_6 = 0;
            while (_local_6 < _local_5)
            {
                _local_7 = parseLayoutEntity(_arg_3[_local_6], _arg_4);
                if (_local_7 != null)
                {
                    _arg_2.addChild(_local_7);
                };
                _local_6++;
            };
        }

        protected static function parseTemplateList(_arg_1:ISkinRenderer, _arg_2:XML, _arg_3:Dictionary, _arg_4:Map, _arg_5:IAssetLibrary):void
        {
            var _local_9:uint;
            var _local_11:XML;
            var _local_12:String;
            var _local_13:String;
            var _local_7:BitmapSkinTemplate;
            var _local_15:XMLList;
            var _local_10:XML;
            var _local_14:XMLList;
            var _local_6:XMLList = _arg_2.child("template");
            var _local_8:uint = _local_6.length();
            _local_9 = 0;
            while (_local_9 < _local_8)
            {
                _local_11 = _local_6[_local_9];
                _local_12 = _local_11.attribute("name");
                if (_local_12 != null)
                {
                    if (_local_12.charAt(0) == "$")
                    {
                        _local_12 = _arg_4[_local_12.slice(1, _local_12.length)];
                    };
                };
                _local_13 = _local_11.attribute("asset");
                if (_local_13 != null)
                {
                    if (_local_13.charAt(0) == "$")
                    {
                        _local_13 = _arg_4[_local_13.slice(1, _local_13.length)];
                    };
                };
                _local_7 = new BitmapSkinTemplate(_local_12, _arg_5.getAssetByName(_local_13));
                _local_15 = _local_11.child("entities");
                if (_local_15.length() > 0)
                {
                    _local_10 = _local_15[0];
                    _local_14 = _local_10.child("entity");
                    if (_local_14.length())
                    {
                        parseTemplateEntityList(_arg_1, _local_7, _local_14, _arg_4);
                    };
                };
                _arg_3[_local_12] = _local_7;
                _arg_1.addTemplate(_local_7);
                _local_9++;
            };
        }

        protected static function parseTemplateEntityList(_arg_1:ISkinRenderer, _arg_2:BitmapSkinTemplate, _arg_3:XMLList, _arg_4:Map):void
        {
            var _local_10:XML;
            var _local_15:XMLList;
            var _local_16:XML;
            var _local_6:String;
            var _local_12:String;
            var _local_9:String;
            var _local_13:uint;
            var _local_14:Rectangle;
            var _local_8:int;
            var _local_5:int = _arg_3.length();
            _local_8 = 0;
            while (_local_8 < _local_5)
            {
                _local_10 = _arg_3[_local_8];
                _local_6 = _local_10.attribute("name");
                _local_12 = ((_local_6.charAt(0) == "$") ? _arg_4[_local_6.slice(1, _local_6.length)] : _local_6);
                _local_6 = _local_10.attribute("type");
                _local_9 = ((_local_6.charAt(0) == "$") ? _arg_4[_local_6.slice(1, _local_6.length)] : _local_6);
                _local_6 = _local_10.attribute("id");
                _local_13 = ((_local_6.charAt(0) == "$") ? _arg_4[_local_6.slice(1, _local_6.length)] : uint(_local_6));
                _local_15 = _local_10.child("region");
                if (_local_15.length() > 0)
                {
                    _local_16 = _local_15[0];
                    _local_15 = _local_16.child("Rectangle");
                    _local_16 = _local_15[0];
                    _local_14 = new Rectangle();
                    _local_6 = _local_16.attribute("x");
                    _local_14.x = ((_local_6.charAt(0) == "$") ? _arg_4[_local_6.slice(1, _local_6.length)] : Number(_local_6));
                    _local_6 = _local_16.attribute("y");
                    _local_14.y = ((_local_6.charAt(0) == "$") ? _arg_4[_local_6.slice(1, _local_6.length)] : Number(_local_6));
                    _local_6 = _local_16.attribute("width");
                    _local_14.width = ((_local_6.charAt(0) == "$") ? _arg_4[_local_6.slice(1, _local_6.length)] : Number(_local_6));
                    _local_6 = _local_16.attribute("height");
                    _local_14.height = ((_local_6.charAt(0) == "$") ? _arg_4[_local_6.slice(1, _local_6.length)] : Number(_local_6));
                };
                _arg_2.addChild(new BitmapSkinTemplateEntity(_local_12, _local_9, _local_13, _local_14));
                _local_8++;
            };
        }

        protected static function parseState(_arg_1:ISkinRenderer, _arg_2:XML, _arg_3:Dictionary, _arg_4:Map):void
        {
            var _local_6:XML;
            var _local_7:XMLList;
            var _local_10:Map;
            var _local_15:String;
            var _local_14:Object;
            var _local_12:String = _arg_2.attribute("name");
            if (_local_12.charAt(0) == "$")
            {
                _local_12 = _arg_4[_local_12.slice(1, _local_12.length)];
            };
            var _local_11:String = _arg_2.attribute("layout");
            if (_local_11.charAt(0) == "$")
            {
                _local_11 = _arg_4[_local_11.slice(1, _local_11.length)];
            };
            var _local_5:String = _arg_2.attribute("template");
            if (_local_5.charAt(0) == "$")
            {
                _local_5 = _arg_4[_local_5.slice(1, _local_5.length)];
            };
            var _local_8:ISkinLayout = _arg_3[_local_11];
            if (_local_8 == null)
            {
                throw (new Error((((("State " + _local_12) + " has invalid layout reference ") + _local_11) + "!")));
            };
            var _local_9:XMLList = _arg_2.child("variables");
            if (_local_9.length() > 0)
            {
                _local_6 = _local_9[0];
                _local_7 = _local_6.child("variable");
                if (_local_7.length())
                {
                    _local_10 = new Map();
                    XMLVariableParser.parseVariableList(_local_7, _local_10);
                    for (_local_15 in _local_10)
                    {
                        _local_14 = _local_10[_local_15];
                        if ((_local_14 is String))
                        {
                            if (_local_14.charAt(0) == "$")
                            {
                                _local_14 = _arg_4[_local_14.slice(1, _local_14.length)];
                                _local_10[_local_15] = _local_14;
                            };
                        };
                    };
                };
            };
            var _local_13:uint;
            switch (_local_12)
            {
                case "active":
                    _local_13 = 1;
                    break;
                case "default":
                    _local_13 = 0;
                    break;
                case "focused":
                    _local_13 = 2;
                    break;
                case "disabled":
                    _local_13 = 32;
                    break;
                case "hovering":
                    _local_13 = 4;
                    break;
                case "pressed":
                    _local_13 = 16;
                    break;
                case "selected":
                    _local_13 = 8;
                    break;
                case "locked":
                    _local_13 = 64;
                    break;
                default:
                    throw (new Error((('Unknown window state: "' + _local_12) + '"!')));
            };
            _arg_1.registerLayoutForRenderState(_local_13, _local_11);
            _arg_1.registerTemplateForRenderState(_local_13, _local_5);
        }

        protected static function parseRenderStateList(_arg_1:ISkinRenderer, _arg_2:XML, _arg_3:Dictionary, _arg_4:Map):void
        {
            var _local_7:uint;
            var _local_6:XMLList = _arg_2.child("state");
            var _local_5:uint = _local_6.length();
            _local_7 = 0;
            while (_local_7 < _local_5)
            {
                parseState(_arg_1, _local_6[_local_7], _arg_3, _arg_4);
                _local_7++;
            };
        }


    }
}