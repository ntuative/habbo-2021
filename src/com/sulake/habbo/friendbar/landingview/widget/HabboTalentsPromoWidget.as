package com.sulake.habbo.friendbar.landingview.widget
{
    import com.sulake.habbo.friendbar.landingview.interfaces.ILandingViewWidget;
    import com.sulake.habbo.friendbar.landingview.HabboLandingView;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.communication.messages.outgoing.talent.GetTalentTrackMessageComposer;
    import com.sulake.core.window.events.WindowEvent;

    public class HabboTalentsPromoWidget implements ILandingViewWidget 
    {

        private var _landingView:HabboLandingView;
        private var _container:IWindowContainer;

        public function HabboTalentsPromoWidget(_arg_1:HabboLandingView)
        {
            _landingView = _arg_1;
        }

        public function get container():IWindow
        {
            return (_container);
        }

        public function dispose():void
        {
            _landingView = null;
            _container = null;
        }

        public function initialize():void
        {
            _container = IWindowContainer(_landingView.getXmlWindow("habbo_talents_promo"));
            _container.findChildByName("go_button").procedure = onGoButton;
            HabboLandingView.positionAfterAndStretch(_container, "title_txt", "hdr_line");
        }

        public function refresh():void
        {
        }

        public function get disposed():Boolean
        {
            return (_landingView == null);
        }

        private function onGoButton(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                _landingView.tracking.trackTalentTrackOpen(_landingView.sessionDataManager.currentTalentTrack, "landingpagepromo");
                _landingView.send(new GetTalentTrackMessageComposer(_landingView.sessionDataManager.currentTalentTrack));
            };
        }


    }
}