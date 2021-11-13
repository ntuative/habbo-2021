package com.sulake.core.window.graphics.renderer
{
    import flash.geom.ColorTransform;
    import flash.geom.Matrix;
    import com.sulake.core.window.utils.TextStyleManager;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.utils.ITextFieldContainer;
    import com.sulake.core.window.components.ITextWindow;
    import flash.text.TextField;
    import com.sulake.core.window.IWindow;
    import flash.display.BitmapData;
    import flash.geom.Rectangle;

    public class TextSkinRenderer extends SkinRenderer 
    {

        private static const _SafeStr_1110:ColorTransform = new ColorTransform(0, 0, 0, 1, 0xFF, 0xFF, 0xFF, 0);

        protected var _SafeStr_700:Matrix;

        public function TextSkinRenderer(_arg_1:String)
        {
            super(_arg_1);
            _SafeStr_700 = new Matrix();
        }

        override public function parse(_arg_1:IAsset, _arg_2:XMLList, _arg_3:IAssetLibrary):void
        {
            var _local_4:String = _arg_1.content.toString();
            TextStyleManager.setStyles(TextStyleManager.parseCSS(_local_4));
        }

        override public function draw(_arg_1:IWindow, _arg_2:BitmapData, _arg_3:Rectangle, _arg_4:uint, _arg_5:Boolean):void
        {
            var _local_7:ITextFieldContainer;
            var _local_9:Object;
            var _local_11:ColorTransform;
            if (_arg_2 != null)
            {
                _local_7 = ITextFieldContainer(_arg_1);
                var _local_10:ITextWindow = ITextWindow(_arg_1);
                var _local_6:String = _local_10.autoSize;
                var _local_8:TextField = _local_7.textField;
                _SafeStr_700.tx = _local_7.margins.left;
                _SafeStr_700.ty = _local_7.margins.top;
                if (_local_6 == "right")
                {
                    _SafeStr_700.tx = Math.floor((_arg_1.width - _local_8.width));
                }
                else
                {
                    if (_local_6 == "center")
                    {
                        _SafeStr_700.tx = Math.floor(((_arg_1.width / 2) - (_local_8.width / 2)));
                    };
                };
                if ((_local_10.etchingColor & 0xFF000000) != 0)
                {
                    _SafeStr_1110.redOffset = ((_local_10.etchingColor >> 16) & 0xFF);
                    _SafeStr_1110.greenOffset = ((_local_10.etchingColor >> 8) & 0xFF);
                    _SafeStr_1110.blueOffset = (_local_10.etchingColor & 0xFF);
                    _SafeStr_1110.alphaMultiplier = (((_local_10.etchingColor >> 24) & 0xFF) / 0xFF);
                    _local_9 = ETCHING_POSITION[_local_10.etchingPosition];
                    if (_local_9 != null)
                    {
                        _SafeStr_700.tx = (_SafeStr_700.tx + _local_9.x);
                        _SafeStr_700.ty = (_SafeStr_700.ty + _local_9.y);
                        _arg_2.draw(_local_8, _SafeStr_700, _SafeStr_1110, null, null, false);
                        _SafeStr_700.tx = (_SafeStr_700.tx - _local_9.x);
                        _SafeStr_700.ty = (_SafeStr_700.ty - _local_9.y);
                    };
                };
                if (_arg_1.dynamicStyleColor)
                {
                    _local_11 = _arg_1.dynamicStyleColor;
                };
                _arg_2.draw(_local_8, _SafeStr_700, _local_11, null, null, false);
            };
        }

        override public function isStateDrawable(_arg_1:uint):Boolean
        {
            return (_arg_1 == 0);
        }


    }
}

