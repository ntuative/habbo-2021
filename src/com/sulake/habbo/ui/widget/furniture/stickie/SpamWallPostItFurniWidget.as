package com.sulake.habbo.ui.widget.furniture.stickie
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.ui.widget.events.RoomWidgetStickieDataUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetSpamWallPostItEditEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetSpamWallPostItFinishEditingMessage;

    public class SpamWallPostItFurniWidget extends StickieFurniWidget 
    {

        private var _location:String = "";

        public function SpamWallPostItFurniWidget(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary=null)
        {
            _windowName = "spamwall_postit_container";
            super(_arg_1, _arg_2, _arg_3);
        }

        override public function dispose():void
        {
            _SafeStr_1922 = -1;
            _location = "";
            super.dispose();
        }

        override public function registerUpdateEvents(_arg_1:IEventDispatcher):void
        {
            _arg_1.addEventListener("RWSWPUE_OPEN_EDITOR", onEditPostItRequest);
            super.registerUpdateEvents(_arg_1);
        }

        override public function unregisterUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            _arg_1.removeEventListener("RWSWPUE_OPEN_EDITOR", onEditPostItRequest);
        }

        override protected function onObjectUpdate(_arg_1:RoomWidgetStickieDataUpdateEvent):void
        {
        }

        private function onEditPostItRequest(_arg_1:RoomWidgetSpamWallPostItEditEvent):void
        {
            hideInterface(false);
            _SafeStr_1922 = _arg_1.objectId;
            _location = _arg_1.location;
            _SafeStr_4132 = _arg_1.objectType;
            _text = "";
            _SafeStr_1928 = "FFFF33";
            _SafeStr_1284 = true;
            showInterface();
        }

        override protected function sendUpdate():void
        {
            var _local_1:RoomWidgetSpamWallPostItFinishEditingMessage;
            if (_SafeStr_1922 != -1)
            {
                storeTextFromField();
                Logger.log("Spamwall Post-It Widget Send Update");
                if (messageListener != null)
                {
                    _local_1 = new RoomWidgetSpamWallPostItFinishEditingMessage("RWSWPFEE_SEND_POSTIT_DATA", _SafeStr_1922, _location, _text, _SafeStr_1928);
                    messageListener.processWidgetMessage(_local_1);
                };
                hideInterface(false);
            };
        }

        override protected function sendSetColor(_arg_1:uint):void
        {
            storeTextFromField();
            var _local_2:String = _arg_1.toString(16).toUpperCase();
            if (_local_2.length > 6)
            {
                _local_2 = _local_2.slice((_local_2.length - 6), _local_2.length);
            };
            if (_local_2 == _SafeStr_1928)
            {
                return;
            };
            _SafeStr_1928 = _local_2;
            showInterface();
        }

        override protected function sendDelete():void
        {
            hideInterface(false);
        }


    }
}

