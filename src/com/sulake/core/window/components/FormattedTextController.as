package com.sulake.core.window.components
{
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;

    public class FormattedTextController extends TextController 
    {

        public function FormattedTextController(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:WindowContext, _arg_6:Rectangle, _arg_7:IWindow, _arg_8:Function=null, _arg_9:Array=null, _arg_10:Array=null, _arg_11:uint=0)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11);
        }

        override public function set text(_arg_1:String):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            if (_localized)
            {
                context.removeLocalizationListener(_caption.slice(2, _caption.indexOf("}")), this);
                _localized = false;
            };
            _caption = _arg_1;
            if ((((!(_SafeStr_905)) && (_caption.charAt(0) == "$")) && (_caption.charAt(1) == "{")))
            {
                _localized = true;
                context.registerLocalizationListener(_caption.slice(2, _caption.indexOf("}")), this);
            }
            else
            {
                if (_field != null)
                {
                    _field.htmlText = _caption;
                    refreshTextImage();
                };
            };
        }

        override public function set localization(_arg_1:String):void
        {
            if (((!(_arg_1 == null)) && (!(_field == null))))
            {
                _field.htmlText = limitStringLength(_arg_1);
                refreshTextImage();
            };
        }


    }
}

