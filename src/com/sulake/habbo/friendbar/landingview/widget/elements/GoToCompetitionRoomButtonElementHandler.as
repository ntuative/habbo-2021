package com.sulake.habbo.friendbar.landingview.widget.elements
{
    import com.sulake.habbo.friendbar.landingview.HabboLandingView;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.friendbar.landingview.widget.GenericWidget;
    import com.sulake.habbo.communication.messages.outgoing.competition.ForwardToRandomCompetitionRoomMessageComposer;

    public class GoToCompetitionRoomButtonElementHandler extends AbstractButtonElementHandler 
    {

        private var _SafeStr_2343:String;


        override public function initialize(_arg_1:HabboLandingView, _arg_2:IWindow, _arg_3:Array, _arg_4:GenericWidget):void
        {
            super.initialize(_arg_1, _arg_2, _arg_3, _arg_4);
            _SafeStr_2343 = _arg_3[2];
        }

        override protected function onClick():void
        {
            landingView.questEngine.reenableRoomCompetitionWindow();
            landingView.send(new ForwardToRandomCompetitionRoomMessageComposer(_SafeStr_2343));
            landingView.tracking.trackGoogle("landingView", "click_gotocompetitionroom");
        }


    }
}

