package com.sulake.habbo.friendbar.landingview.widget.elements
{
    import com.sulake.habbo.friendbar.landingview.interfaces.elements.IElementHandler;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
    import com.sulake.habbo.friendbar.landingview.HabboLandingView;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.friendbar.landingview.widget.GenericWidget;

    public class _SafeStr_230 implements IElementHandler 
    {


        public function initialize(_arg_1:HabboLandingView, _arg_2:IWindow, _arg_3:Array, _arg_4:GenericWidget):void
        {
            var _local_8:String = _arg_3[2];
            var _local_5:IWindowContainer = IWindowContainer(_arg_2);
            _local_5.findChildByName("badge_desc").caption = "";
            var _local_6:IStaticBitmapWrapperWindow = IStaticBitmapWrapperWindow(_local_5.findChildByName("badge_image"));
            var _local_7:String = (("${image.library.url}album1584/" + _arg_3[1]) + ".png");
            Logger.log(("IMAGE: " + _local_7));
            _local_6.assetUri = _local_7;
        }

        public function refresh():void
        {
        }


    }
}

