package com.sulake.habbo.ui.widget.chooser
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetRequestWidgetMessage;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.ui.widget.events.RoomWidgetChooserContentEvent;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetRoomObjectUpdateEvent;

    public class UserChooserWidget extends ChooserWidgetBase
    {

        private const STATE_USER_CHOOSER_CLOSED:int = 0;
        private const STATE_USER_CHOOSER_OPEN:int = 1;

        private var _SafeStr_3992:ChooserView;

        public function UserChooserWidget(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary=null, _arg_4:IHabboLocalizationManager=null)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
        }

        override public function get state():int
        {
            if (((!(_SafeStr_3992 == null)) && (_SafeStr_3992.isOpen())))
            {
                return (1);
            };
            return (0);
        }

        override public function initialize(_arg_1:int=0):void
        {
            var _local_2:RoomWidgetRequestWidgetMessage;
            super.initialize(_arg_1);
            if (_arg_1 == 1)
            {
                _local_2 = new RoomWidgetRequestWidgetMessage("RWRWM_USER_CHOOSER");
                messageListener.processWidgetMessage(_local_2);
            };
        }

        override public function dispose():void
        {
            if (_SafeStr_3992 != null)
            {
                _SafeStr_3992.dispose();
                _SafeStr_3992 = null;
            };
            super.dispose();
        }

        override public function registerUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            _arg_1.addEventListener("RWCCE_USER_CHOOSER_CONTENT", onChooserContent);
            _arg_1.addEventListener("RWROUE_USER_REMOVED", onUpdateUserChooser);
            _arg_1.addEventListener("RWROUE_USER_ADDED", onUpdateUserChooser);
            super.registerUpdateEvents(_arg_1);
        }

        override public function unregisterUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            _arg_1.removeEventListener("RWCCE_USER_CHOOSER_CONTENT", onChooserContent);
            _arg_1.removeEventListener("RWROUE_USER_REMOVED", onUpdateUserChooser);
            _arg_1.removeEventListener("RWROUE_USER_ADDED", onUpdateUserChooser);
        }

        private function onChooserContent(_arg_1:RoomWidgetChooserContentEvent):void
        {
            if (((_arg_1 == null) || (_arg_1.items == null)))
            {
                return;
            };
            if (_SafeStr_3992 == null)
            {
                _SafeStr_3992 = new ChooserView(this, "${widget.chooser.user.title}");
            };
            _SafeStr_3992.populate(_arg_1.items, false);
        }

        private function onUpdateUserChooser(_arg_1:RoomWidgetRoomObjectUpdateEvent):void
        {
            var event:RoomWidgetRoomObjectUpdateEvent = _arg_1;
            if (((_SafeStr_3992 == null) || (!(_SafeStr_3992.isOpen()))))
            {
                return;
            };
            var delayedAction:Timer = new Timer(100, 1);
            delayedAction.addEventListener("timer", function (_arg_1:TimerEvent):void
            {
                if (disposed)
                {
                    return;
                };
                messageListener.processWidgetMessage(new RoomWidgetRequestWidgetMessage("RWRWM_USER_CHOOSER"));
            });
            delayedAction.start();
        }


    }
}