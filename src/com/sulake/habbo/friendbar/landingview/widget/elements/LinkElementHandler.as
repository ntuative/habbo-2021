package com.sulake.habbo.friendbar.landingview.widget.elements
{
    import com.sulake.habbo.friendbar.landingview.interfaces.elements.IElementHandler;
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.friendbar.landingview.HabboLandingView;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.friendbar.landingview.widget.GenericWidget;
    import com.sulake.habbo.utils.HabboWebTools;
    import com.sulake.core.window.events.WindowEvent;

    public class LinkElementHandler implements IElementHandler, IDisposable 
    {

        private var _landingView:HabboLandingView;
        private var _SafeStr_780:String;


        public function dispose():void
        {
            _landingView = null;
        }

        public function get disposed():Boolean
        {
            return (_landingView == null);
        }

        public function initialize(_arg_1:HabboLandingView, _arg_2:IWindow, _arg_3:Array, _arg_4:GenericWidget):void
        {
            _landingView = _arg_1;
            var _local_5:String = _arg_3[1];
            _SafeStr_780 = _arg_3[2];
            _arg_2.procedure = onLink;
            IWindowContainer(_arg_2).findChildByName("link_txt").caption = (("${" + _local_5) + "}");
        }

        private function onLink(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                _landingView.windowManager.alert("${catalog.alert.external.link.title}", "${catalog.alert.external.link.desc}", 0, null);
                HabboWebTools.openWebPage(_SafeStr_780);
                _landingView.tracking.trackGoogle("landingView", "click_link");
            };
        }

        public function refresh():void
        {
        }


    }
}

