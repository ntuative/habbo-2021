package com.sulake.core.window.graphics.renderer
{
    import flash.geom.Rectangle;

    public class SkinTemplateEntity implements ISkinTemplateEntity 
    {

        protected var _SafeStr_698:uint;
        protected var _name:String;
        protected var _SafeStr_741:String;
        protected var _SafeStr_1116:Rectangle;

        public function SkinTemplateEntity(_arg_1:String, _arg_2:String, _arg_3:uint, _arg_4:Rectangle)
        {
            _SafeStr_698 = _arg_3;
            _name = _arg_1;
            _SafeStr_741 = _arg_2;
            _SafeStr_1116 = _arg_4;
        }

        public function get id():uint
        {
            return (_SafeStr_698);
        }

        public function get name():String
        {
            return (_name);
        }

        public function get type():String
        {
            return (_SafeStr_741);
        }

        public function get region():Rectangle
        {
            return (_SafeStr_1116);
        }


    }
}

