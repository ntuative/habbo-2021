package com.sulake.habbo.ui.widget.doorbell
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.core.window.IWindow;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.ui.widget.events.RoomWidgetDoorbellEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetLetUserInMessage;

    public class DoorbellWidget extends RoomWidgetBase 
    {

        private static const MAX_USERS_ON_DOORBELL_LIST:int = 50;

        private var _users:Array;
        private var _SafeStr_570:DoorbellView;

        public function DoorbellWidget(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary, _arg_4:IHabboLocalizationManager)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
            _SafeStr_570 = new DoorbellView(this);
            _users = [];
        }

        override public function get mainWindow():IWindow
        {
            return (_SafeStr_570.mainWindow);
        }

        public function get users():Array
        {
            return (_users);
        }

        override public function dispose():void
        {
            if (disposed)
            {
                return;
            };
            if (_SafeStr_570)
            {
                _SafeStr_570.dispose();
                _SafeStr_570 = null;
            };
            _users = null;
            super.dispose();
        }

        override public function registerUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            _arg_1.addEventListener("RWDE_RINGING", onDoorbellRinging);
            _arg_1.addEventListener("RWDE_REJECTED", onDoorbellHandled);
            _arg_1.addEventListener("RWDE_ACCEPTED", onDoorbellHandled);
            super.registerUpdateEvents(_arg_1);
        }

        override public function unregisterUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            _arg_1.removeEventListener("RWDE_RINGING", onDoorbellRinging);
            _arg_1.removeEventListener("RWDE_REJECTED", onDoorbellHandled);
            _arg_1.removeEventListener("RWDE_ACCEPTED", onDoorbellHandled);
        }

        private function onDoorbellRinging(_arg_1:RoomWidgetDoorbellEvent):void
        {
            addUser(_arg_1.userName);
        }

        private function onDoorbellHandled(_arg_1:RoomWidgetDoorbellEvent):void
        {
            removeUser(_arg_1.userName);
        }

        public function addUser(_arg_1:String):void
        {
            if (_users.indexOf(_arg_1) != -1)
            {
                return;
            };
            if (_users.length >= 50)
            {
                deny(_arg_1);
                return;
            };
            _users.push(_arg_1);
            _SafeStr_570.update();
        }

        public function removeUser(_arg_1:String):void
        {
            var _local_2:int = _users.indexOf(_arg_1);
            if (_local_2 == -1)
            {
                return;
            };
            _users.splice(_local_2, 1);
            _SafeStr_570.update();
        }

        public function accept(_arg_1:String):void
        {
            var _local_2:RoomWidgetLetUserInMessage = new RoomWidgetLetUserInMessage(_arg_1, true);
            messageListener.processWidgetMessage(_local_2);
            removeUser(_arg_1);
        }

        public function deny(_arg_1:String):void
        {
            var _local_2:RoomWidgetLetUserInMessage = new RoomWidgetLetUserInMessage(_arg_1, false);
            messageListener.processWidgetMessage(_local_2);
            removeUser(_arg_1);
        }

        public function denyAll():void
        {
            while (_users.length > 0)
            {
                deny(_users[0]);
            };
        }


    }
}

