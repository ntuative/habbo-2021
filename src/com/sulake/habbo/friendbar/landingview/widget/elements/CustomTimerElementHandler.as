package com.sulake.habbo.friendbar.landingview.widget.elements
{
    import com.sulake.habbo.communication.messages.parser.competition.SecondsUntilMessageEvent;
    import com.sulake.habbo.friendbar.landingview.HabboLandingView;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.friendbar.landingview.widget.GenericWidget;
    import com.sulake.habbo.communication.messages.outgoing.competition.GetSecondsUntilMessageComposer;

    public class CustomTimerElementHandler extends AbstractTimerElementHandler 
    {

        private var _SafeStr_2337:String;


        override public function initialize(_arg_1:HabboLandingView, _arg_2:IWindow, _arg_3:Array, _arg_4:GenericWidget):void
        {
            super.initialize(_arg_1, _arg_2, _arg_3, _arg_4);
            _SafeStr_2337 = _arg_3[6];
            _arg_1.communicationManager.addHabboConnectionMessageEvent(new SecondsUntilMessageEvent(onTime));
        }

        override public function refresh():void
        {
            landingView.send(new GetSecondsUntilMessageComposer(_SafeStr_2337));
        }

        private function onTime(_arg_1:SecondsUntilMessageEvent):void
        {
            if (_arg_1.getParser().timeStr == _SafeStr_2337)
            {
                setTimer(_arg_1.getParser().secondsUntil);
            };
        }


    }
}

