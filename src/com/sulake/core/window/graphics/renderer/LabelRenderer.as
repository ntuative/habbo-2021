package com.sulake.core.window.graphics.renderer
{
    import flash.geom.ColorTransform;
    import flash.geom.Matrix;
    import com.sulake.core.window.utils._SafeStr_177;
    import flash.text.TextField;
    import com.sulake.core.window.components.TextLabelController;
    import com.sulake.core.window.utils.TextFieldCache;
    import com.sulake.core.window.IWindow;
    import flash.display.BitmapData;
    import flash.geom.Rectangle;

    public class LabelRenderer extends SkinRenderer
    {

        private static const _SafeStr_1110:ColorTransform = new ColorTransform(0, 0, 0, 1, 0xFF, 0xFF, 0xFF, 0);

        protected var _SafeStr_700:Matrix;
        protected var _SafeStr_1111:_SafeStr_177;
        protected var _SafeStr_1112:TextField;

        public function LabelRenderer(_arg_1:String)
        {
            super(_arg_1);
            _SafeStr_700 = new Matrix();
        }

        override public function draw(_arg_1:IWindow, _arg_2:BitmapData, _arg_3:Rectangle, _arg_4:uint, _arg_5:Boolean):void
        {
            var _local_9:TextLabelController;
            var _local_6:uint;
            var _local_7:Object;
            var _local_10:ColorTransform;
            if (_arg_2 != null)
            {
                _local_9 = TextLabelController(_arg_1);
                var _local_8:_SafeStr_177 = _local_9.textStyle;
                if (_local_8 != _SafeStr_1111)
                {
                    _SafeStr_1112 = TextFieldCache.getTextFieldByStyle(_local_8);
                    _SafeStr_1111 = _local_8;
                };
                _SafeStr_700.tx = _local_9.drawOffsetX;
                _SafeStr_700.ty = _local_9.drawOffsetY;
                _SafeStr_1112.text = _local_9.text;
                _local_6 = uint(_local_8.color);
                _SafeStr_1112.textColor = ((_local_9.hasTextColor) ? _local_9.textColor : _local_6);
                _SafeStr_1112.antiAliasType = "advanced";
                _SafeStr_1112.gridFitType = "pixel";
                if (_local_9.vertical)
                {
                    _SafeStr_700.a = 0;
                    _SafeStr_700.b = -1;
                    _SafeStr_700.c = 1;
                    _SafeStr_700.d = 0;
                    _SafeStr_700.ty = (_SafeStr_700.ty + _local_9.height);
                };
                if ((Number(_local_8.etchingColor) & 0xFF000000) != 0)
                {
                    _SafeStr_1110.redOffset = ((Number(_local_8.etchingColor) >> 16) & 0xFF);
                    _SafeStr_1110.greenOffset = ((Number(_local_8.etchingColor) >> 8) & 0xFF);
                    _SafeStr_1110.blueOffset = (Number(_local_8.etchingColor) & 0xFF);
                    _local_7 = ETCHING_POSITION[_local_8.etchingPosition];
                    if (_local_7 != null)
                    {
                        if (_local_9.vertical)
                        {
                            _SafeStr_700.tx = (_SafeStr_700.tx + _local_7.y);
                            _SafeStr_700.ty = (_SafeStr_700.ty - _local_7.x);
                            _arg_2.draw(_SafeStr_1112, _SafeStr_700, _SafeStr_1110, null, null, false);
                            _SafeStr_700.tx = (_SafeStr_700.tx - _local_7.y);
                            _SafeStr_700.ty = (_SafeStr_700.ty + _local_7.x);
                        }
                        else
                        {
                            _SafeStr_700.tx = (_SafeStr_700.tx + _local_7.x);
                            _SafeStr_700.ty = (_SafeStr_700.ty + _local_7.y);
                            _arg_2.draw(_SafeStr_1112, _SafeStr_700, _SafeStr_1110, null, null, false);
                            _SafeStr_700.tx = (_SafeStr_700.tx - _local_7.x);
                            _SafeStr_700.ty = (_SafeStr_700.ty - _local_7.y);
                        };
                    };
                };
                if (_arg_1.dynamicStyleColor)
                {
                    _local_10 = _arg_1.dynamicStyleColor;
                };
                _arg_2.draw(_SafeStr_1112, _SafeStr_700, _local_10, null, null, false);
                if (_local_9.vertical)
                {
                    _SafeStr_700.a = 1;
                    _SafeStr_700.b = 0;
                    _SafeStr_700.c = 0;
                    _SafeStr_700.d = 1;
                    _SafeStr_700.ty = (_SafeStr_700.ty - _local_9.height);
                };
                _SafeStr_1112.textColor = _local_6;
            };
        }

        override public function isStateDrawable(_arg_1:uint):Boolean
        {
            return (_arg_1 == 0);
        }


    }
}