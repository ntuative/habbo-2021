package com.sulake.habbo.window.utils
{
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.window.graphics.renderer.ISkinRenderer;
    import com.sulake.core.window.utils.DefaultAttStruct;
    import flash.utils.Dictionary;
    import com.sulake.core.window.utils._SafeStr_184;
    import com.sulake.core.window.utils._SafeStr_168;
    import com.sulake.core.window.graphics.renderer.BitmapSkinRenderer;
    import com.sulake.core.window.graphics.renderer.BitmapDataRenderer;
    import com.sulake.core.window.graphics.renderer.FillSkinRenderer;
    import com.sulake.core.window.graphics.renderer.TextSkinRenderer;
    import com.sulake.core.window.graphics.renderer.LabelRenderer;
    import com.sulake.core.window.graphics.renderer.ShapeSkinRenderer;
    import com.sulake.core.window.graphics.renderer.SkinRenderer;
    import com.sulake.core.window.graphics.renderer.NullSkinRenderer;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.graphics.SkinContainer;

    public class SkinParserUtil
    {

        private static const RENDERER_TYPE_SKIN:String = "skin";
        private static const RENDERER_TYPE_BITMAP:String = "bitmap";
        private static const RENDERER_TYPE_FILL:String = "fill";
        private static const RENDERER_TYPE_TEXT:String = "text";
        private static const RENDERER_TYPE_LABEL:String = "label";
        private static const RENDERER_TYPE_SHAPE:String = "shape";
        private static const RENDERER_TYPE_UNKNOWN:String = "unknown";
        private static const RENDERER_TYPE_NULL:String = "null";


        public static function parse(_arg_1:XML, _arg_2:IAssetLibrary, _arg_3:SkinContainer):void
        {
            var _local_9:XML;
            var _local_19:XMLList;
            var _local_8:String;
            var _local_15:String;
            var _local_5:uint;
            var _local_6:uint;
            var _local_27:String;
            var _local_10:String;
            var _local_28:IAsset;
            var _local_4:ISkinRenderer;
            var _local_14:String;
            var _local_16:Class;
            var _local_26:DefaultAttStruct;
            var _local_30:XMLList;
            var _local_25:String;
            var _local_13:IAsset;
            var _local_23:XML;
            var _local_21:String;
            var _local_24:uint;
            var _local_18:Dictionary = new Dictionary();
            var _local_20:Dictionary = new Dictionary();
            _SafeStr_184.fillTables(_local_18, _local_20);
            var _local_17:Dictionary = new Dictionary();
            var _local_11:Dictionary = new Dictionary();
            _SafeStr_168.fillTables(_local_17, _local_11);
            var _local_12:Dictionary = new Dictionary();
            _local_12["skin"] = BitmapSkinRenderer;
            _local_12["bitmap"] = BitmapDataRenderer;
            _local_12["fill"] = FillSkinRenderer;
            _local_12["text"] = TextSkinRenderer;
            _local_12["label"] = LabelRenderer;
            _local_12["shape"] = ShapeSkinRenderer;
            _local_12["unknown"] = SkinRenderer;
            _local_12["null"] = NullSkinRenderer;
            if (_arg_1 != null)
            {
                _local_30 = _arg_1.child("window");
                var _local_7:uint = _local_30.length();
                var _local_22:Array = [];
                if (_local_7 > 0)
                {
                    _local_24 = 0;
                    while (_local_24 < _local_7)
                    {
                        _local_9 = _local_30[_local_24];
                        _local_8 = _local_9.attribute("type");
                        _local_21 = _local_9.attribute("intent");
                        _local_15 = _local_9.attribute("style");
                        _local_5 = (_local_9.attribute("blend") as uint);
                        _local_6 = (_local_9.attribute("color") as uint);
                        _local_27 = _local_9.attribute("asset");
                        _local_10 = _local_9.attribute("layout");
                        _local_25 = _local_9.attribute("window_layout");
                        _local_14 = _local_9.attribute("renderer");
                        _local_19 = _local_9.child("states");
                        _local_16 = _local_12[_local_14];
                        if (_local_16)
                        {
                            _local_4 = new _local_16(_local_10);
                            if (_local_4)
                            {
                                _local_28 = _arg_2.getAssetByName(_local_27);
                                _local_4.parse(_local_28, _local_19, _arg_2);
                                if (((_local_28) && (_local_22.indexOf(_local_28) == -1)))
                                {
                                    _local_22.push(_local_28);
                                };
                            };
                        };
                        _local_26 = new DefaultAttStruct();
                        _local_26.threshold = ((_local_9.@treshold[0]) ? _local_9.@treshold[0] : 10);
                        _local_26.background = ((_local_9.@background[0]) ? (_local_9.@background[0] == "true") : false);
                        _local_26.blend = ((_local_9.@blend[0]) ? _local_9.@blend[0] : 1);
                        _local_26.color = ((_local_9.@color[0]) ? _local_9.@color[0] : 0xFFFFFF);
                        _local_26.width_min = ((_local_9.@width_min[0]) ? _local_9.@width_min[0] : -2147483648);
                        _local_26.width_max = ((_local_9.@width_max[0]) ? _local_9.@width_max[0] : 2147483647);
                        _local_26.height_min = ((_local_9.@height_min[0]) ? _local_9.@height_min[0] : -2147483648);
                        _local_26.height_max = ((_local_9.@height_max[0]) ? _local_9.@height_max[0] : 2147483647);
                        _local_23 = null;
                        if (_local_25 != null)
                        {
                            _local_13 = _arg_2.getAssetByName(_local_25);
                            if (_local_13 != null)
                            {
                                _local_23 = (_local_13.content as XML);
                            };
                        };
                        _arg_3.addSkinRenderer(_local_18[_local_8], uint(_local_15), _local_21, _local_4, _local_23, _local_26);
                        _local_24++;
                    };
                    for each (var _local_29:IAsset in _local_22)
                    {
                        _local_29.dispose();
                    };
                };
            };
        }


    }
}