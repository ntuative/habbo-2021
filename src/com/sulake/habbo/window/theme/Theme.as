package com.sulake.habbo.window.theme
{
    import com.sulake.core.window.theme.PropertyMap;

    public class Theme 
    {

        public static const _SafeStr_617:String = "None";
        public static const ICON:String = "Icon";
        public static const LEGACY_BORDER:String = "Legacy border";
        public static const VOLTER:String = "Volter";
        public static const UBUNTU:String = "Ubuntu";
        public static const ILLUMINA_LIGHT:String = "Illumina Light";
        public static const ILLUMINA_DARK:String = "Illumina Dark";

        private var _name:String;
        private var _isReal:Boolean;
        private var _baseStyle:uint;
        private var _styleCount:uint;
        private var _propertyDefaults:PropertyMap;

        public function Theme(_arg_1:String, _arg_2:Boolean, _arg_3:uint, _arg_4:uint, _arg_5:PropertyMap)
        {
            _name = _arg_1;
            _isReal = _arg_2;
            _baseStyle = _arg_3;
            _styleCount = _arg_4;
            _propertyDefaults = _arg_5;
        }

        public function get name():String
        {
            return (_name);
        }

        public function get isReal():Boolean
        {
            return (_isReal);
        }

        public function get baseStyle():uint
        {
            return (_baseStyle);
        }

        public function get styleCount():uint
        {
            return (_styleCount);
        }

        public function get propertyDefaults():PropertyMap
        {
            return (_propertyDefaults);
        }

        public function coversStyle(_arg_1:uint):Boolean
        {
            return ((_arg_1 >= _baseStyle) && (_arg_1 < (_baseStyle + _styleCount)));
        }


    }
}

