package com.sulake.habbo.friendbar.landingview.widget.elements
{
    import com.sulake.habbo.friendbar.landingview.HabboLandingView;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.friendbar.landingview.widget.GenericWidget;

    public class CatalogButtonElementHandler extends AbstractButtonElementHandler 
    {

        private var _pageName:String;


        override public function initialize(_arg_1:HabboLandingView, _arg_2:IWindow, _arg_3:Array, _arg_4:GenericWidget):void
        {
            super.initialize(_arg_1, _arg_2, _arg_3, _arg_4);
            _pageName = _arg_3[2];
        }

        override protected function onClick():void
        {
            if (_pageName)
            {
                landingView.catalog.openCatalogPage(_pageName);
            }
            else
            {
                landingView.catalog.openCatalog();
            };
            landingView.tracking.trackGoogle("landingView", "click_genericcatalog");
        }


    }
}