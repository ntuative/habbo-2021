package com.sulake.habbo.friendbar.landingview.widget.elements
{
    import com.sulake.habbo.friendbar.landingview.interfaces.elements.IElementHandler;
    import com.sulake.habbo.friendbar.landingview.interfaces.elements.IFloatingElement;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.friendbar.landingview.HabboLandingView;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.friendbar.landingview.widget.GenericWidget;

    public class TitleElementHandler implements IElementHandler, IFloatingElement 
    {

        private var _SafeStr_2350:Boolean = false;


        public function initialize(_arg_1:HabboLandingView, _arg_2:IWindow, _arg_3:Array, _arg_4:GenericWidget):void
        {
            var _local_5:IWindowContainer = IWindowContainer(_arg_2);
            var _local_6:String = _arg_3[1];
            _SafeStr_2350 = ((_arg_3.length > 2) ? (_arg_3[2] == "true") : false);
            _local_5.findChildByName("title_txt").caption = (("${" + _local_6) + "}");
            HabboLandingView.positionAfterAndStretch(_local_5, "title_txt", "hdr_line");
        }

        public function isFloating(_arg_1:Boolean):Boolean
        {
            return ((_arg_1) || (_SafeStr_2350));
        }

        public function refresh():void
        {
        }


    }
}

