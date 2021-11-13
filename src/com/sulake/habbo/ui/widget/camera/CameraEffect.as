package com.sulake.habbo.ui.widget.camera
{
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.utils.StringUtil;
    import flash.filters.ColorMatrixFilter;
    import flash.filters.BitmapFilter;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.core.window.IWindow;

    public class CameraEffect 
    {

        private static const DEFAULT_EFFECT_STRENGTH:Number = 0.5;
        public static const TYPE_COLORMATRIX:String = "colormatrix";
        public static const _SafeStr_3938:String = "composite";
        public static const TYPE_FRAME:String = "frame";

        private static var _SafeStr_2740:Map;
        private static var _SafeStr_3939:Array = [];
        private static var _SafeStr_1625:int = 1;
        private static var _SafeStr_819:IHabboLocalizationManager;

        public var type:String;
        public var matrixArray:Array;
        public var _SafeStr_630:String;
        public var name:String;
        public var description:String;
        public var value:int;
        public var isOn:Boolean = false;
        public var _SafeStr_629:int = 0;
        public var button:IWindowContainer;

        public function CameraEffect(_arg_1:String, _arg_2:String, _arg_3:Array, _arg_4:String, _arg_5:int)
        {
            this.name = _arg_1;
            this.description = _SafeStr_819.getLocalization(("camera.effect.name." + _arg_1), _arg_1);
            this.type = _arg_2;
            this._SafeStr_630 = _arg_4;
            this.matrixArray = _arg_3;
            this._SafeStr_629 = _arg_5;
        }

        public static function resetAllEffects():void
        {
            for each (var _local_1:CameraEffect in _SafeStr_2740)
            {
                _local_1.value = (0.5 * _SafeStr_1625);
                _local_1.setChosen(false);
            };
        }

        public static function setMaxValue(_arg_1:int):void
        {
            _SafeStr_1625 = _arg_1;
        }

        public static function getEffects(_arg_1:String, _arg_2:IHabboLocalizationManager):Map
        {
            var _local_3:Array;
            if (!_SafeStr_2740)
            {
                if (_arg_1 != null)
                {
                    _local_3 = _arg_1.split(",");
                    for each (var _local_4:String in _local_3)
                    {
                        _SafeStr_3939.push(StringUtil.trim(_local_4));
                    };
                };
                _SafeStr_819 = _arg_2;
                initEffects();
            };
            return (_SafeStr_2740);
        }

        private static function initEffects():void
        {
            _SafeStr_2740 = new Map();
            addEffect("dark_sepia", "colormatrix", [0.4, 0.4, 0.1, 0, 110, 0.3, 0.4, 0.1, 0, 30, 0.3, 0.2, 0.1, 0, 0, 0, 0, 0, 1, 0], null);
            addEffect("increase_saturation", "colormatrix", [2, -0.5, -0.5, 0, 0, -0.5, 2, -0.5, 0, 0, -0.5, -0.5, 2, 0, 0, 0, 0, 0, 1, 0], null);
            addEffect("increase_contrast", "colormatrix", [1.5, 0, 0, 0, -50, 0, 1.5, 0, 0, -50, 0, 0, 1.5, 0, -50, 0, 0, 0, 1.5, 0], null);
            addEffect("shadow_multiply_02", "composite", null, "multiply");
            addEffect("color_1", "colormatrix", [0.393, 0.769, 0.189, 0, 0, 0.349, 0.686, 0.168, 0, 0, 0.272, 0.534, 0.131, 0, 0, 0, 0, 0, 1, 0], null, 1);
            addEffect("hue_bright_sat", "colormatrix", [1, 0.6, 0.2, 0, -50, 0.2, 1, 0.6, 0, -50, 0.6, 0.2, 1, 0, -50, 0, 0, 0, 1, 0], null, 1);
            addEffect("hearts_hardlight_02", "composite", null, "hardlight", 1);
            addEffect("texture_overlay", "composite", null, "overlay", 1);
            addEffect("pinky_nrm", "composite", null, "normal", 1);
            addEffect("color_2", "colormatrix", [0.333, 0.333, 0.333, 0, 0, 0.333, 0.333, 0.333, 0, 0, 0.333, 0.333, 0.333, 0, 0, 0, 0, 0, 1, 0], null, 2);
            addEffect("night_vision", "colormatrix", [0, 0, 0, 0, 0, 0, 1.1, 0, 0, -50, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0], null, 2);
            addEffect("stars_hardlight_02", "composite", null, "hardlight", 2);
            addEffect("coffee_mpl", "composite", null, "multiply", 2);
            addEffect("security_hardlight", "composite", null, "hardlight", 3);
            addEffect("bluemood_mpl", "composite", null, "multiply", 3);
            addEffect("rusty_mpl", "composite", null, "multiply", 3);
            addEffect("decr_conrast", "colormatrix", [0.5, 0, 0, 0, 50, 0, 0.5, 0, 0, 50, 0, 0, 0.5, 0, 50, 0, 0, 0, 1, 0], null, 4);
            addEffect("green_2", "colormatrix", [0.5, 0.5, 0.5, 0, 0, 0.5, 0.5, 0.5, 0, 90, 0.5, 0.5, 0.5, 0, 0, 0, 0, 0, 1, 0], null, 4);
            addEffect("alien_hrd", "composite", null, "hardlight", 4);
            addEffect("color_3", "colormatrix", [0.609, 0.609, 0.082, 0, 0, 0.309, 0.609, 0.082, 0, 0, 0.309, 0.609, 0.082, 0, 0, 0, 0, 0, 1, 0], null, 5);
            addEffect("color_4", "colormatrix", [0.8, -0.8, 1, 0, 70, 0.8, -0.8, 1, 0, 70, 0.8, -0.8, 1, 0, 70, 0, 0, 0, 1, 0], null, 5);
            addEffect("toxic_hrd", "composite", null, "hardlight", 5);
            addEffect("hypersaturated", "colormatrix", [2, -1, 0, 0, 0, -1, 2, 0, 0, 0, 0, -1, 2, 0, 0, 0, 0, 0, 1, 0], null, 6);
            addEffect("Yellow", "colormatrix", [1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0], null, 6);
            addEffect("misty_hrd", "composite", null, "hardlight", 6);
            addEffect("x_ray", "colormatrix", [0, 1.2, 0, 0, -100, 0, 2, 0, 0, -120, 0, 2, 0, 0, -120, 0, 0, 0, 1, 0], null, 7);
            addEffect("decrease_saturation", "colormatrix", [0.7, 0.2, 0.2, 0, 0, 0.2, 0.7, 0.2, 0, 0, 0.2, 0.2, 0.7, 0, 0, 0, 0, 0, 1, 0], null, 7);
            addEffect("drops_mpl", "composite", null, "multiply", 8);
            addEffect("shiny_hrd", "composite", null, "hardlight", 9);
            addEffect("glitter_hrd", "composite", null, "hardlight", 10);
            addEffect("frame_gold", "frame", null, null, 999);
            addEffect("frame_gray_4", "frame", null, null, 999);
            addEffect("frame_black_2", "frame", null, null, 999);
            addEffect("frame_wood_2", "frame", null, null, 999);
            addEffect("finger_nrm", "frame", null, null, 999);
            addEffect("color_5", "colormatrix", [3.309, 0.609, 1.082, 0.2, 0, 0.309, 0.609, 0.082, 0, 0, 1.309, 0.609, 0.082, 0, 0, 0, 0, 0, 1, 0], null, 999);
            addEffect("black_white_negative", "colormatrix", [-0.5, -0.5, -0.5, 0, 0xFF, -0.5, -0.5, -0.5, 0, 0xFF, -0.5, -0.5, -0.5, 0, 0xFF, 0, 0, 0, 1, 0], null, 999);
            addEffect("blue", "colormatrix", [0.5, 0.5, 0.5, 0, -255, 0.5, 0.5, 0.5, 0, -170, 0.5, 0.5, 0.5, 0, 0, 0, 0, 0, 1, 0], null, 999);
            addEffect("red", "colormatrix", [0.5, 0.5, 0.5, 0, 0, 0.5, 0.5, 0.5, 0, -170, 0.5, 0.5, 0.5, 0, -170, 0, 0, 0, 1, 0], null, 999);
            addEffect("green", "colormatrix", [0.5, 0.5, 0.5, 0, -170, 0.5, 0.5, 0.5, 0, 0, 0.5, 0.5, 0.5, 0, -170, 0, 0, 0, 1, 0], null, 999);
        }

        private static function addEffect(_arg_1:String, _arg_2:String, _arg_3:Array, _arg_4:String, _arg_5:int=0):void
        {
            if (_SafeStr_3939.indexOf(_arg_1) >= 0)
            {
                _SafeStr_2740[_arg_1] = new CameraEffect(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
            };
        }


        public function getEffectStrength():Number
        {
            return (value / _SafeStr_1625);
        }

        public function allowsOnlyOneInstance():Boolean
        {
            return (type == "frame");
        }

        public function usesEffectStrength():Boolean
        {
            return (!(type == "frame"));
        }

        public function getColorMatrixFilter(_arg_1:Boolean=false):BitmapFilter
        {
            var _local_5:int;
            if (_arg_1)
            {
                return (new ColorMatrixFilter(matrixArray));
            };
            var _local_4:Array = [];
            var _local_3:Array = [1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0];
            _local_5 = 0;
            while (_local_5 < matrixArray.length)
            {
                _local_4.push(((matrixArray[_local_5] * getEffectStrength()) + (_local_3[_local_5] * (1 - getEffectStrength()))));
                _local_5++;
            };
            return (new ColorMatrixFilter(_local_4));
        }

        public function setChosen(_arg_1:Boolean):void
        {
            var _local_3:IRegionWindow;
            var _local_2:IWindow;
            isOn = _arg_1;
            if (button)
            {
                setSelectionHighlight(isOn);
                _local_3 = (button.findChildByName("remove_effect_button") as IRegionWindow);
                _local_3.visible = isOn;
                if (!allowsOnlyOneInstance())
                {
                    _local_2 = (button.findChildByName("active_indicator") as IWindow);
                    _local_2.visible = isOn;
                };
            };
        }

        private function setSelectionHighlight(_arg_1:Boolean):void
        {
            var _local_2:IWindow;
            if (button)
            {
                _local_2 = (button.findChildByName("selected_indicator") as IWindow);
                _local_2.visible = _arg_1;
            };
        }

        public function turnOffHighlight():void
        {
            setSelectionHighlight(false);
        }


    }
}

