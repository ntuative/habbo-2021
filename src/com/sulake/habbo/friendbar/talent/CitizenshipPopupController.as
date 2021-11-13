package com.sulake.habbo.friendbar.talent
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.window.utils.IModalDialog;
    import com.sulake.habbo.communication.messages.incoming.room.engine.RoomEntryInfoMessageEvent;
    import flash.utils.Timer;
    import com.sulake.core.communication.messages.IMessageEvent;
    import flash.events.TimerEvent;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.communication.messages.outgoing.talent.GetTalentTrackMessageComposer;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class CitizenshipPopupController implements IDisposable 
    {

        private var _habboTalent:HabboTalent;
        private var _SafeStr_1665:IModalDialog;
        private var _disposed:Boolean;
        private var _SafeStr_2382:RoomEntryInfoMessageEvent;
        private var _seenPopupDuringSession:Boolean;

        public function CitizenshipPopupController(_arg_1:HabboTalent)
        {
            _habboTalent = _arg_1;
            _SafeStr_2382 = new RoomEntryInfoMessageEvent(onRoomEnter);
            _habboTalent.communicationManager.addHabboConnectionMessageEvent(_SafeStr_2382);
        }

        private function onRoomEnter(_arg_1:IMessageEvent):void
        {
            var _local_2:Timer;
            if ((((_habboTalent.newIdentity) && (!(_seenPopupDuringSession))) && (_habboTalent.getBoolean("new.user.citizenship.popup.enabled"))))
            {
                _local_2 = new Timer(10000, 1);
                _local_2.addEventListener("timer", onCitizenshipPopup);
                _local_2.start();
            };
        }

        private function onCitizenshipPopup(_arg_1:TimerEvent):void
        {
            removeRoomEnterListener();
            show();
            _seenPopupDuringSession = true;
        }

        private function removeRoomEnterListener():void
        {
            if (((!(_habboTalent == null)) && (!(_habboTalent.disposed))))
            {
                _habboTalent.communicationManager.removeHabboConnectionMessageEvent(_SafeStr_2382);
            };
            _SafeStr_2382 = null;
        }

        public function show():void
        {
            hide();
            _SafeStr_1665 = _habboTalent.getModalXmlWindow("citizenship_welcome");
            _SafeStr_1665.rootWindow.procedure = onWindowEvent;
            IWindowContainer(_SafeStr_1665.rootWindow).findChildByName("header_button_close").visible = false;
        }

        private function hide():void
        {
            if (((!(_SafeStr_1665 == null)) && (!(_SafeStr_1665.disposed))))
            {
                _SafeStr_1665.dispose();
                _SafeStr_1665 = null;
            };
        }

        public function dispose():void
        {
            if (!_disposed)
            {
                hide();
                removeRoomEnterListener();
                _habboTalent = null;
            };
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        private function onWindowEvent(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if ((((_SafeStr_1665 == null) || (_SafeStr_1665.disposed)) || (!(_arg_1.type == "WME_CLICK"))))
            {
                return;
            };
            switch (_arg_2.name)
            {
                case "postpone_citizenship":
                    hide();
                    return;
                case "show_citizenship":
                    hide();
                    _habboTalent.tracking.trackTalentTrackOpen("citizenship", "citizenshippopup");
                    _habboTalent.send(new GetTalentTrackMessageComposer("citizenship"));
                    return;
            };
        }


    }
}

