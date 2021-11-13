package com.sulake.habbo.friendbar.landingview.widget.elements
{
    import com.sulake.habbo.friendbar.landingview.interfaces.elements.IElementHandler;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.habbo.friendbar.landingview.HabboLandingView;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.friendbar.landingview.widget.GenericWidget;

    public class TextElementHandler implements IElementHandler 
    {

        private var _window:ITextWindow;


        public function initialize(_arg_1:HabboLandingView, _arg_2:IWindow, _arg_3:Array, _arg_4:GenericWidget):void
        {
            _window = (_arg_2 as ITextWindow);
            var _local_5:String = _arg_3[1];
            _window.caption = (("${" + _local_5) + "}");
            if (_arg_3.length > 2)
            {
                _window.width = parseInt(_arg_3[2]);
            };
            if (((_arg_3.length > 3) && (_arg_3[3] == "true")))
            {
                _window.border = true;
            };
        }

        public function refresh():void
        {
        }

        public function set localizationKey(_arg_1:String):void
        {
            _window.caption = (("${" + _arg_1) + "}");
        }


    }
}