package com.sulake.habbo.window.theme
{
    import com.sulake.core.window.theme.IThemeManager;
    import flash.utils.Dictionary;
    import com.sulake.core.window.graphics.SkinContainer;
    import com.sulake.core.window.theme.PropertyMap;
    import com.sulake.core.window.enum.PivotPoint;
    import com.sulake.core.window.theme._SafeStr_173;
    import com.sulake.core.window.utils.TextStyleManager;
    import com.sulake.habbo.window.widgets.WidgetClasses;
    import com.sulake.habbo.window.widgets.IlluminaBorderWidget;
    import com.sulake.core.window.theme.IPropertyMap;

    public class ThemeManager implements IThemeManager 
    {

        private static const THEMES:Array = ["None", "Volter", "Ubuntu", "Illumina Light", "Illumina Dark", "Icon", "Legacy border"];
        private static const _SafeStr_4394:int = 100;

        private var _SafeStr_4393:Dictionary;
        private var _SafeStr_437:SkinContainer;

        public function ThemeManager(_arg_1:SkinContainer):void
        {
            super();
            var _local_5:PropertyMap = null;
            var _local_3:PropertyMap = null;
            _SafeStr_437 = _arg_1;
            _local_5 = new PropertyMap();
            _local_5.addBoolean("always_show_selection", false);
            _local_5.addEnumeration("antialias_type", "advanced", ["normal", "advanced"]);
            _local_5.addString("asset_uri", null);
            _local_5.addBoolean("auto_arrange_items", true);
            _local_5.addEnumeration("auto_size", "none", ["none", "left", "center", "right"]);
            _local_5.addString("bitmap_asset_name", null);
            _local_5.addBoolean("border", false);
            _local_5.addHex("border_color", 0);
            _local_5.addBoolean("condense_white", false);
            _local_5.addBoolean("container_resize_to_columns", false);
            _local_5.addEnumeration("direction", "down", ["up", "down", "left", "right"]);
            _local_5.addBoolean("display_as_password", false);
            _local_5.addBoolean("display_raw", false);
            _local_5.addBoolean("editable", true);
            _local_5.addHex("etching_color", 0);
            _local_5.addBoolean("fit_size_to_contents", false);
            _local_5.addBoolean("focus_capturer", false);
            _local_5.addBoolean("greyscale", false);
            _local_5.addEnumeration("grid_fit_type", "pixel", ["pixel", "none", "subpixel"]);
            _local_5.addBoolean("handle_bitmap_disposing", true);
            _local_5.addString("help_page", "");
            _local_5.addEnumeration("link_target", "default", ["default", "_blank", "_parent", "_self", "_top", "internal"]);
            _local_5.addInt("spacing", 0);
            _local_5.addInt("margin_left", 0);
            _local_5.addInt("margin_top", 0);
            _local_5.addInt("margin_right", 0);
            _local_5.addInt("margin_bottom", 0);
            _local_5.addInt("max_chars", 0);
            _local_5.addInt("max_lines", 0);
            _local_5.addArray("item_array", []);
            _local_5.addBoolean("mouse_wheel_enabled", true);
            _local_5.addBoolean("multiline", false);
            _local_5.addEnumeration("pivot_point", PivotPoint.PIVOT_NAMES[0], _SafeStr_173.PIVOT_POINT_RANGE);
            _local_5.addInt("pointer_offset", 0);
            _local_5.addBoolean("resize_on_item_update", false);
            _local_5.addString("restrict", null);
            _local_5.addBoolean("scale_to_fit_items", false);
            _local_5.addString("scrollable", "");
            _local_5.addNumber("scroll_step_h", -1);
            _local_5.addNumber("scroll_step_v", -1);
            _local_5.addBoolean("selectable", true);
            _local_5.addBoolean("stretched_x", true);
            _local_5.addBoolean("stretched_y", true);
            _local_5.addHex("text_color", 0);
            _local_5.addEnumeration("text_style", "regular", TextStyleManager.getStyleNameArrayRef());
            _local_5.addString("tool_tip_caption", "");
            _local_5.addUint("tool_tip_delay", 500);
            _local_5.addBoolean("tool_tip_is_dynamic", false);
            _local_5.addBoolean("vertical", false);
            _local_5.addEnumeration("widget_type", "", WidgetClasses.WIDGET_TYPES);
            _local_5.addBoolean("word_wrap", false);
            _local_5.addNumber("zoom_x", 1);
            _local_5.addNumber("zoom_y", 1);
            _local_5.addBoolean("open_upward", false);
            _local_5.addBoolean("keep_open_on_deactivate", false);
            _local_5.addInt("padding_horizontal", 6);
            _local_5.addInt("padding_vertical", 6);
            _local_5.addString("overflow_replace", "");
            _local_5.addBoolean("wrap_x", false);
            _local_5.addBoolean("wrap_y", false);
            _local_5.addEnumeration("illumina_border:border_style", "illumina_light", IlluminaBorderWidget.BORDER_STYLES);
            _SafeStr_4393 = new Dictionary();
            _SafeStr_4393["None"] = new Theme("None", false, 0, 0xFFFFFFFF, _local_5);
            var _local_4:int;
            while (_SafeStr_437.skinRendererExists(1, _local_4))
            {
                _local_4++;
            };
            _SafeStr_4393["Icon"] = new Theme("Icon", false, 0, _local_4, _local_5);
            var _local_2:int;
            while (((_SafeStr_437.skinRendererExists(30, _local_2)) && (_local_2 < 100)))
            {
                _local_2++;
            };
            _SafeStr_4393["Legacy border"] = new Theme("Legacy border", false, 0, _local_2, _local_5);
            _SafeStr_4393["Volter"] = new Theme("Volter", true, 0, 3, _local_5.clone());
            _local_3 = _local_5.clone();
            _local_3.addEnumeration("antialias_type", "advanced", ["normal", "advanced"]);
            _local_3.addEnumeration("text_style", "u_regular", TextStyleManager.getStyleNameArrayRef());
            _SafeStr_4393["Ubuntu"] = new Theme("Ubuntu", true, 3, 5, _local_3);
            _local_3 = _local_5.clone();
            _local_3.addEnumeration("antialias_type", "advanced", ["normal", "advanced"]);
            _local_5.addHex("etching_color", 3003121663);
            _local_3.addEnumeration("text_style", "il_regular", TextStyleManager.getStyleNameArrayRef());
            _SafeStr_4393["Illumina Light"] = new Theme("Illumina Light", true, 100, 100, _local_3);
            _local_3 = _local_3.clone();
            _local_5.addEnumeration("illumina_border:border_style", "illumina_dark", IlluminaBorderWidget.BORDER_STYLES);
            _SafeStr_4393["Illumina Dark"] = new Theme("Illumina Dark", true, 200, 100, _local_3);
        }

        public function getStyle(_arg_1:String, _arg_2:uint, _arg_3:String):uint
        {
            var _local_4:int;
            var _local_6:uint;
            if (_arg_1 == "None")
            {
                return (int(_arg_3));
            };
            var _local_5:Theme = _SafeStr_4393[_arg_1];
            if (_local_5 == null)
            {
                return (0);
            };
            _local_4 = 0;
            while (_local_4 < _local_5.styleCount)
            {
                _local_6 = (_local_5.baseStyle + _local_4);
                if (_arg_3 == _SafeStr_437.getIntentByTypeAndStyle(_arg_2, _local_6))
                {
                    return (_local_6);
                };
                _local_4++;
            };
            return (_local_5.baseStyle);
        }

        public function getThemeAndIntent(_arg_1:uint, _arg_2:uint):Object
        {
            var _local_4:String = _SafeStr_437.getIntentByTypeAndStyle(_arg_1, _arg_2);
            if (_arg_1 == 1)
            {
                return ({
                    "theme":"Icon",
                    "intent":_local_4
                });
            };
            if (((_arg_1 == 30) && (_arg_2 < 100)))
            {
                return ({
                    "theme":"Legacy border",
                    "intent":_local_4
                });
            };
            for each (var _local_3:Theme in _SafeStr_4393)
            {
                if (((_local_3.isReal) && (_local_3.coversStyle(_arg_2))))
                {
                    return ({
                        "theme":_local_3.name,
                        "intent":_local_4
                    });
                };
            };
            return ({
                "theme":"None",
                "intent":_local_4
            });
        }

        public function getIntents(_arg_1:uint, _arg_2:String, _arg_3:uint):Array
        {
            var _local_6:Theme;
            var _local_5:int;
            var _local_7:String;
            var _local_4:Array = [];
            if (_arg_2 != "None")
            {
                _local_6 = _SafeStr_4393[_arg_2];
                _local_5 = 0;
                while (_local_5 < _local_6.styleCount)
                {
                    _local_7 = _SafeStr_437.getIntentByTypeAndStyle(_arg_1, (_local_6.baseStyle + _local_5));
                    if (_local_7 != null)
                    {
                        _local_4.push(_local_7);
                    };
                    _local_5++;
                };
            };
            if (_local_4.length == 0)
            {
                _local_4.push(_arg_3.toString());
            };
            return (_local_4);
        }

        public function getPropertyDefaults(_arg_1:uint):IPropertyMap
        {
            var _local_2:PropertyMap;
            for each (var _local_3:Theme in _SafeStr_4393)
            {
                if (((_local_3.isReal) && (_local_3.coversStyle(_arg_1))))
                {
                    _local_2 = _local_3.propertyDefaults;
                    break;
                };
            };
            if (_local_2 == null)
            {
                _local_2 = new PropertyMap();
            };
            return (_local_2);
        }

        public function getThemes():Array
        {
            return (THEMES);
        }


    }
}

