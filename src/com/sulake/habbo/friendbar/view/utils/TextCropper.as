package com.sulake.habbo.friendbar.view.utils
{
    import com.sulake.core.runtime.IDisposable;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import com.sulake.core.window.components.ITextWindow;

    public class TextCropper implements IDisposable 
    {

        private var _disposed:Boolean = false;
        private var _SafeStr_2199:TextField;
        private var _SafeStr_2433:TextFormat;
        private var _SafeStr_2434:String = "...";
        private var _SafeStr_2435:int = 20;

        public function TextCropper()
        {
            _SafeStr_2199 = new TextField();
            _SafeStr_2199.autoSize = "left";
            _SafeStr_2199.antiAliasType = "advanced";
            _SafeStr_2199.gridFitType = "pixel";
            _SafeStr_2433 = _SafeStr_2199.defaultTextFormat;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function dispose():void
        {
            if (!_disposed)
            {
                _SafeStr_2199 = null;
                _disposed = true;
            };
        }

        public function crop(_arg_1:ITextWindow):void
        {
            var _local_2:int;
            _SafeStr_2433.font = _arg_1.fontFace;
            _SafeStr_2433.size = _arg_1.fontSize;
            _SafeStr_2433.bold = _arg_1.bold;
            _SafeStr_2433.italic = _arg_1.italic;
            _SafeStr_2199.setTextFormat(_SafeStr_2433);
            _SafeStr_2199.text = _arg_1.getLineText(0);
            var _local_3:int = _SafeStr_2199.textWidth;
            if (_local_3 > _arg_1.width)
            {
                _local_2 = int(_SafeStr_2199.getCharIndexAtPoint((_arg_1.width - _SafeStr_2435), (_SafeStr_2199.textHeight / 2)));
                _arg_1.text = (_arg_1.text.slice(0, _local_2) + _SafeStr_2434);
            };
        }


    }
}

