package com.sulake.habbo.friendbar.landingview.widget.elements
{
    import com.sulake.habbo.communication.messages.incoming.quest.CommunityGoalProgressMessageEvent;
    import com.sulake.habbo.friendbar.landingview.HabboLandingView;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.friendbar.landingview.widget.GenericWidget;
    import com.sulake.habbo.communication.messages.outgoing.quest._SafeStr_42;
    import com.sulake.habbo.communication.messages.incoming.quest.CommunityGoalData;

    public class CommunityGoalTimerElementHandler extends AbstractTimerElementHandler 
    {


        override public function initialize(_arg_1:HabboLandingView, _arg_2:IWindow, _arg_3:Array, _arg_4:GenericWidget):void
        {
            super.initialize(_arg_1, _arg_2, _arg_3, _arg_4);
            _arg_1.communicationManager.addHabboConnectionMessageEvent(new CommunityGoalProgressMessageEvent(onCommunityGoalProgress));
        }

        override public function refresh():void
        {
            landingView.send(new _SafeStr_42());
        }

        private function onCommunityGoalProgress(_arg_1:CommunityGoalProgressMessageEvent):void
        {
            var _local_2:CommunityGoalData = _arg_1.getParser().data;
            setTimer(((_local_2.hasGoalExpired) ? 0 : _local_2.timeRemainingInSeconds));
        }


    }
}

