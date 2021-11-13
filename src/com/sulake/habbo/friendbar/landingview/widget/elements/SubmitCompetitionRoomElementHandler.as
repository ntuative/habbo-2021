package com.sulake.habbo.friendbar.landingview.widget.elements
{
    import com.sulake.habbo.communication.messages.parser.competition.IsUserPartOfCompetitionMessageEvent;
    import com.sulake.habbo.friendbar.landingview.HabboLandingView;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.friendbar.landingview.widget.GenericWidget;
    import com.sulake.habbo.communication.messages.outgoing.competition.GetIsUserPartOfCompetitionMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.competition.ForwardToASubmittableRoomMessageComposer;

    public class SubmitCompetitionRoomElementHandler extends AbstractButtonElementHandler 
    {

        private var _submittedKey:String;
        private var _SafeStr_2343:String;
        private var _SafeStr_2348:Boolean;
        private var _SafeStr_2349:int;


        override public function initialize(_arg_1:HabboLandingView, _arg_2:IWindow, _arg_3:Array, _arg_4:GenericWidget):void
        {
            super.initialize(_arg_1, _arg_2, _arg_3, _arg_4);
            _submittedKey = _arg_3[2];
            _SafeStr_2343 = _arg_3[3];
            _arg_1.communicationManager.addHabboConnectionMessageEvent(new IsUserPartOfCompetitionMessageEvent(onInfo));
        }

        override public function refresh():void
        {
            super.refresh();
            landingView.send(new GetIsUserPartOfCompetitionMessageComposer(_SafeStr_2343));
        }

        override protected function onClick():void
        {
            landingView.questEngine.reenableRoomCompetitionWindow();
            if (_SafeStr_2348)
            {
                landingView.navigator.goToPrivateRoom(_SafeStr_2349);
                landingView.tracking.trackGoogle("landingView", "click_submittedroom");
            }
            else
            {
                landingView.send(new ForwardToASubmittableRoomMessageComposer());
                landingView.tracking.trackGoogle("landingView", "click_startsubmit");
            };
        }

        private function onInfo(_arg_1:IsUserPartOfCompetitionMessageEvent):void
        {
            _SafeStr_2348 = _arg_1.getParser().isPartOf;
            _SafeStr_2349 = _arg_1.getParser().targetId;
            if (_SafeStr_2348)
            {
                window.caption = (("${" + _submittedKey) + "}");
            };
        }


    }
}

