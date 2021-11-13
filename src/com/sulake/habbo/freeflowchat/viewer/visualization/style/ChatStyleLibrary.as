package com.sulake.habbo.freeflowchat.viewer.visualization.style
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.freeflowchat.style.IChatStyleLibrary;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.utils.Map;
    import flash.display.BitmapData;
    import flash.geom.Rectangle;
    import flash.geom.Point;
    import flash.text.TextFormat;
    import flash.text.StyleSheet;
    import com.sulake.habbo.freeflowchat.style.IChatStyle;

    public class ChatStyleLibrary implements IDisposable, IChatStyleLibrary 
    {

        private const DEFAULT_STYLE:int = 0;

        private var _assets:IAssetLibrary;
        private var _styles:Map = new Map();

        public function ChatStyleLibrary(_arg_1:IAssetLibrary)
        {
            super();
            var _local_4:int;
            var _local_5:String = null;
            var _local_2:Boolean;
            var _local_7:Boolean;
            var _local_9:Boolean;
            var _local_3:Boolean;
            var _local_10:Boolean;
            var _local_6:ChatStyle = null;
            _assets = _arg_1;
            var _local_8:XML = XML(_assets.getAssetByName("chatstyles_xml").content);
            for each (var _local_11:XML in _local_8.child("style"))
            {
                _local_4 = _local_11.@id[0];
                _local_5 = _local_11.@assetId[0];
                _local_2 = (_local_11.@systemStyle[0] == "true");
                _local_7 = (_local_11.@hcOnly[0] == "true");
                _local_9 = (_local_11.@staffOverrideable[0] == "true");
                _local_3 = (_local_11.@allowHTML[0] == "true");
                _local_10 = (_local_11.@ambassadorOnly[0] == "true");
                try
                {
                    _local_6 = initializeStyleFromAssets(_local_5, _local_2, _local_7, _local_9, _local_3, _local_10);
                    _styles.add(_local_4, _local_6);
                }
                catch(e:Error)
                {
                    Logger.log(((("Error initializing chat style: " + _local_4) + ", error message: ") + e.message));
                };
            };
        }

        public function dispose():void
        {
            _styles.dispose();
            _styles = null;
            _assets = null;
        }

        public function get disposed():Boolean
        {
            return (_assets == null);
        }

        private function initializeStyleFromAssets(_arg_1:String, _arg_2:Boolean, _arg_3:Boolean, _arg_4:Boolean, _arg_5:Boolean, _arg_6:Boolean):ChatStyle
        {
            var _local_15:BitmapData;
            var _local_29:String = String(_assets.getAssetByName((("style_" + _arg_1) + "_regpoints")).content);
            var _local_30:BitmapData = (_assets.getAssetByName((("style_" + _arg_1) + "_chat_bubble_base")).content as BitmapData);
            var _local_21:Rectangle = new Rectangle(getConfigPoint(_local_29, "9sliceXY").x, getConfigPoint(_local_29, "9sliceXY").y, getConfigPoint(_local_29, "9sliceWH").x, getConfigPoint(_local_29, "9sliceWH").y);
            var _local_16:Point = ((hasConfig(_local_29, "faceXY")) ? getConfigPoint(_local_29, "faceXY") : null);
            var _local_25:int;
            var _local_23:Boolean = ((hasConfig(_local_29, "anonymous")) ? getConfigBoolean(_local_29, "anonymous") : false);
            if (!_local_23)
            {
                _local_15 = (_assets.getAssetByName((("style_" + _arg_1) + "_chat_bubble_pointer")).content as BitmapData);
                _local_25 = getConfigCSV(_local_29, "pointerY")[0];
            };
            var _local_7:BitmapData = ((_assets.hasAsset((("style_" + _arg_1) + "_icon"))) ? (_assets.getAssetByName((("style_" + _arg_1) + "_icon")).content as BitmapData) : null);
            var _local_14:Rectangle = getConfigRect(_local_29, "textFieldMargins");
            var _local_24:BitmapData = (_assets.getAssetByName((("style_" + _arg_1) + "_selector_preview")).content as BitmapData);
            var _local_8:BitmapData;
            if (_assets.hasAsset((("style_" + _arg_1) + "_chat_bubble_color")))
            {
                _local_8 = (_assets.getAssetByName((("style_" + _arg_1) + "_chat_bubble_color")).content as BitmapData);
            };
            var _local_28:Point = ((hasConfig(_local_29, "colorXY")) ? getConfigPoint(_local_29, "colorXY") : null);
            var _local_12:Rectangle = ((hasConfig(_local_29, "overlapRect")) ? getConfigRect(_local_29, "overlapRect") : null);
            var _local_20:uint = ((hasConfig(_local_29, "textColorRGB")) ? getConfigCSV(_local_29, "textColorRGB")[0] : 0);
            var _local_10:String = ((hasConfig(_local_29, "fontFace")) ? getConfigCSV(_local_29, "fontFace")[0] : "Volter");
            var _local_26:int = ((hasConfig(_local_29, "fontSize")) ? getConfigCSV(_local_29, "fontSize")[0] : 9);
            var _local_22:TextFormat = new TextFormat(_local_10, _local_26, _local_20);
            var _local_18:uint = ((hasConfig(_local_29, "linkColorRGB")) ? getConfigCSV(_local_29, "linkColorRGB")[0] : _local_20);
            var _local_27:uint = ((hasConfig(_local_29, "linkHoverColorRGB")) ? getConfigCSV(_local_29, "linkHoverColorRGB")[0] : _local_20);
            var _local_19:uint = ((hasConfig(_local_29, "linkActiveColorRGB")) ? getConfigCSV(_local_29, "linkActiveColorRGB")[0] : _local_20);
            var _local_9:StyleSheet = new StyleSheet();
            var _local_11:Object = {};
            _local_11.textDecoration = "underline";
            _local_11.color = toHexString(_local_18);
            _local_9.setStyle("a:link", _local_11);
            var _local_17:Object = {};
            _local_17.color = toHexString(_local_19);
            _local_9.setStyle("a:active", _local_17);
            var _local_13:Object = {};
            _local_13.color = toHexString(_local_27);
            _local_9.setStyle("a:hover", _local_13);
            return (new ChatStyle(_local_30, _local_21, _local_15, _local_25, _local_14, _local_22, _local_23, _local_16, _local_7, _local_24, _arg_2, _arg_3, _arg_4, _arg_6, _local_8, _local_28, _local_12, _arg_5, _local_9));
        }

        private function toHexString(_arg_1:uint):String
        {
            var _local_2:String = _arg_1.toString(16);
            while (_local_2.length < 6)
            {
                _local_2 = ("0" + _local_2);
            };
            return ("#" + _local_2);
        }

        private function hasConfig(_arg_1:String, _arg_2:String):Boolean
        {
            return (!(_arg_1.indexOf(_arg_2) == -1));
        }

        private function getConfigCSV(_arg_1:String, _arg_2:String):Array
        {
            var _local_5:int;
            var _local_6:int;
            var _local_3:Boolean;
            var _local_7:String;
            var _local_4:int = _arg_1.indexOf(_arg_2);
            if (_local_4 != -1)
            {
                _local_5 = _arg_1.indexOf("=", _local_4);
                _local_6 = _arg_1.indexOf("\n", _local_5);
                if (_local_6 == -1)
                {
                    _local_6 = _arg_1.length;
                };
                _local_3 = (_arg_1.charAt((_local_5 + 1)) == " ");
                _local_7 = _arg_1.substr((_local_5 + ((_local_3) ? 2 : 1)), ((_local_6 - _local_5) - ((_local_3) ? 2 : 1)));
                return (_local_7.split(","));
            };
            return (null);
        }

        private function getConfigPoint(_arg_1:String, _arg_2:String):Point
        {
            return (new Point(getConfigCSV(_arg_1, _arg_2)[0], getConfigCSV(_arg_1, _arg_2)[1]));
        }

        private function getConfigRect(_arg_1:String, _arg_2:String):Rectangle
        {
            return (new Rectangle(getConfigCSV(_arg_1, _arg_2)[0], getConfigCSV(_arg_1, _arg_2)[1], getConfigCSV(_arg_1, _arg_2)[2], getConfigCSV(_arg_1, _arg_2)[3]));
        }

        private function getConfigBoolean(_arg_1:String, _arg_2:String):Boolean
        {
            return (getConfigCSV(_arg_1, _arg_2)[0] == "true");
        }

        public function getStyleIds():Array
        {
            return (_styles.getKeys());
        }

        public function getStyle(_arg_1:int):IChatStyle
        {
            if (_styles.hasKey(_arg_1))
            {
                return (_styles.getValue(_arg_1));
            };
            return (_styles.getValue(0));
        }


    }
}

