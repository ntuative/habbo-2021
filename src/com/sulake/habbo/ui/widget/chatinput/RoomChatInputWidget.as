package com.sulake.habbo.ui.widget.chatinput
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import flash.utils.Timer;
    import com.sulake.habbo.ui.RoomUI;
    import com.sulake.habbo.ui.IRoomDesktop;
    import com.sulake.habbo.ui.handler.ChatInputWidgetHandler;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import flash.utils.getTimer;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetChatMessage;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.ui.widget.events.RoomWidgetRoomObjectUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUserInfoUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetChatInputContentUpdateEvent;
    import flash.events.TimerEvent;
    import com.sulake.habbo.ui.widget.roomtools.RoomToolsWidget;
    import com.sulake.habbo.ui.widget.events.RoomWidgetFloodControlEvent;
    import com.sulake.core.window.IWindow;

    public class RoomChatInputWidget extends RoomWidgetBase 
    {

        private static const MIN_PASTE_INTERVAL_MS:int = 5000;

        private var _visualization:RoomChatInputView;
        private var _selectedUserName:String = "";
        private var _floodBlocked:Boolean = false;
        private var _SafeStr_3988:Timer = null;
        private var _lastPasteTime:int;
        private var _roomUi:RoomUI;
        private var _SafeStr_3989:IRoomDesktop;

        public function RoomChatInputWidget(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary, _arg_4:IHabboLocalizationManager, _arg_5:RoomUI, _arg_6:IRoomDesktop)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
            _roomUi = _arg_5;
            _SafeStr_3989 = _arg_6;
            _visualization = new RoomChatInputView(this);
            (_arg_1 as ChatInputWidgetHandler).widget = this;
        }

        public function get floodBlocked():Boolean
        {
            return (_floodBlocked);
        }

        public function get roomUi():RoomUI
        {
            return (_roomUi);
        }

        public function get handler():ChatInputWidgetHandler
        {
            return (_SafeStr_3915 as ChatInputWidgetHandler);
        }

        override public function dispose():void
        {
            if (_visualization != null)
            {
                _visualization.dispose();
                _visualization = null;
            };
            if (_SafeStr_3988 != null)
            {
                _SafeStr_3988.stop();
                _SafeStr_3988 = null;
            };
            _roomUi = null;
            super.dispose();
        }

        public function get allowPaste():Boolean
        {
            return ((getTimer() - _lastPasteTime) > 5000);
        }

        public function setLastPasteTime():void
        {
            _lastPasteTime = getTimer();
        }

        public function sendChat(_arg_1:String, _arg_2:int, _arg_3:String="", _arg_4:int=0):void
        {
            if (_floodBlocked)
            {
                return;
            };
            var _local_5:RoomWidgetChatMessage = new RoomWidgetChatMessage("RWCM_MESSAGE_CHAT", _arg_1, _arg_2, _arg_3, _arg_4);
            if (messageListener != null)
            {
                messageListener.processWidgetMessage(_local_5);
            };
        }

        override public function registerUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            _arg_1.addEventListener("RWROUE_OBJECT_DESELECTED", onRoomObjectDeselected);
            _arg_1.addEventListener("RWWCIDE_CHAT_INPUT_CONTENT", onChatInputUpdate);
            _arg_1.addEventListener("RWUIUE_PEER", onUserInfo);
            _arg_1.addEventListener("RWFCE_FLOOD_CONTROL", onFloodControl);
            super.registerUpdateEvents(_arg_1);
        }

        override public function unregisterUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            _arg_1.removeEventListener("RWROUE_OBJECT_DESELECTED", onRoomObjectDeselected);
            _arg_1.removeEventListener("RWWCIDE_CHAT_INPUT_CONTENT", onChatInputUpdate);
            _arg_1.removeEventListener("RWUIUE_PEER", onUserInfo);
            _arg_1.removeEventListener("RWFCE_FLOOD_CONTROL", onFloodControl);
        }

        private function onRoomObjectDeselected(_arg_1:RoomWidgetRoomObjectUpdateEvent):void
        {
            _selectedUserName = "";
        }

        private function onUserInfo(_arg_1:RoomWidgetUserInfoUpdateEvent):void
        {
            _selectedUserName = _arg_1.name;
        }

        private function onChatInputUpdate(_arg_1:RoomWidgetChatInputContentUpdateEvent):void
        {
            var _local_2:String = "";
            switch (_arg_1.messageType)
            {
                case "whisper":
                    _local_2 = localizations.getLocalization("widgets.chatinput.mode.whisper", ":tell");
                    _visualization.displaySpecialChatMessage(_local_2, _arg_1.userName);
                    return;
                case "shout":
                    return;
                default:
                    return;
            };
        }

        private function onReleaseTimerComplete(_arg_1:TimerEvent):void
        {
            Logger.log("Releasing flood blocking");
            _floodBlocked = false;
            if (_visualization != null)
            {
                _visualization.hideFloodBlocking();
            };
            _SafeStr_3988 = null;
        }

        private function onReleaseTimerTick(_arg_1:TimerEvent):void
        {
            if (_visualization != null)
            {
                _visualization.updateBlockText((_SafeStr_3988.repeatCount - _SafeStr_3988.currentCount));
            };
        }

        public function checkChatInputPosition():void
        {
            _visualization.updatePosition(null);
        }

        public function getFriendBarWidth():int
        {
            if (!_roomUi.friendBarView)
            {
                return (1000);
            };
            return (_roomUi.friendBarView.friendBarWidth);
        }

        public function getToolBarWidth():int
        {
            if (!_roomUi.toolbar)
            {
                return (1000);
            };
            return (_roomUi.toolbar.toolBarAreaWidth);
        }

        public function getRoomToolsWidth():int
        {
            var _local_1:RoomToolsWidget = (_SafeStr_3989.getWidget("RWE_ROOM_TOOLS") as RoomToolsWidget);
            if (!_local_1)
            {
                return (0);
            };
            return (_local_1.getWidgetAreaWidth());
        }

        public function get selectedUserName():String
        {
            return (_selectedUserName);
        }

        public function onFloodControl(_arg_1:RoomWidgetFloodControlEvent):void
        {
            _floodBlocked = true;
            Logger.log((("Enabling flood blocking for " + _arg_1.seconds) + " seconds"));
            if (_SafeStr_3988)
            {
                _SafeStr_3988.reset();
            }
            else
            {
                _SafeStr_3988 = new Timer(1000, _arg_1.seconds);
                _SafeStr_3988.addEventListener("timer", onReleaseTimerTick);
                _SafeStr_3988.addEventListener("timerComplete", onReleaseTimerComplete);
            };
            _SafeStr_3988.start();
            if (_visualization != null)
            {
                _visualization.updateBlockText(_arg_1.seconds);
                _visualization.showFloodBlocking();
            };
        }

        override public function get mainWindow():IWindow
        {
            return (_visualization.window);
        }

        public function hide():void
        {
            if (mainWindow)
            {
                mainWindow.visible = false;
            };
        }

        public function getChatInputY():int
        {
            return ((_visualization) ? _visualization.getChatInputY() : 0);
        }

        public function getChatInputElements():Array
        {
            var _local_1:Array;
            if (_visualization)
            {
                _local_1 = _visualization.getChatWindowElements();
            };
            return (_local_1);
        }


    }
}

