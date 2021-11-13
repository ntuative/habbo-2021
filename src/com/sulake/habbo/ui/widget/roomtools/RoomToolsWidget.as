package com.sulake.habbo.ui.widget.roomtools
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
    import com.sulake.habbo.ui.IRoomDesktop;
    import com.sulake.habbo.freeflowchat.IHabboFreeFlowChat;
    import flash.utils.Timer;
    import com.sulake.habbo.utils.StringUtil;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.ui.RoomUI;
    import flash.events.TimerEvent;
    import com.sulake.habbo.ui.handler.RoomToolsWidgetHandler;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.ui.widget.chatinput.RoomChatInputWidget;

    public class RoomToolsWidget extends RoomWidgetBase 
    {

        private static const ROOM_HISTORY_MAX_LENGTH:int = 10;

        private static var _visitedRooms:Vector.<GuestRoomData> = new Vector.<GuestRoomData>();
        private static var _currentRoomIndex:int;

        private var _currentRoomName:String = "";
        private var _SafeStr_3795:RoomToolsToolbarCtrl;
        private var _SafeStr_4290:RoomToolsInfoCtrl;
        private var _SafeStr_3989:IRoomDesktop;
        private var _freeFlowChat:IHabboFreeFlowChat;
        private var _SafeStr_4291:Timer;

        public function RoomToolsWidget(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary, _arg_4:RoomUI)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4.localization);
            handler.widget = this;
            _SafeStr_3989 = _arg_4.getDesktop("hard_coded_room_id");
            _freeFlowChat = _arg_4.freeFlowChat;
            _SafeStr_4290 = new RoomToolsInfoCtrl(this, _arg_2, _arg_3);
            _SafeStr_3795 = new RoomToolsToolbarCtrl(this, _arg_2, _arg_3);
            _SafeStr_3795.updateRoomHistoryButtons();
            _SafeStr_3795.setChatHistoryButton(((!(_freeFlowChat)) || (!(_freeFlowChat.isDisabledInPreferences))));
            var _local_5:String = _arg_4.getProperty("camera.launch.ui.position");
            _SafeStr_3795.setCameraButton(((handler.container.sessionDataManager.isPerkAllowed("CAMERA")) && ((StringUtil.isBlank(_local_5)) || (_local_5 == "room-menu"))));
            _SafeStr_3795.setLikeButton(handler.canRate);
            _SafeStr_3795.setCollapsed(((handler.sessionDataManager.isNoob) || (!(handler.sessionDataManager.uiFlags & 0x02))));
        }

        override public function dispose():void
        {
            if (_SafeStr_4291)
            {
                _SafeStr_4291.stop();
                _SafeStr_4291 = null;
            };
            if (_SafeStr_3795)
            {
                _SafeStr_3795.dispose();
                _SafeStr_3795 = null;
            };
            if (_SafeStr_4290)
            {
                _SafeStr_4290.dispose();
                _SafeStr_4290 = null;
            };
            _freeFlowChat = null;
            _SafeStr_3989 = null;
            super.dispose();
        }

        public function updateRoomData(_arg_1:GuestRoomData):void
        {
            for each (var _local_2:GuestRoomData in _visitedRooms)
            {
                if (_local_2.flatId == _arg_1.flatId)
                {
                    _local_2.roomName = _arg_1.roomName;
                };
            };
        }

        public function storeRoomData(_arg_1:GuestRoomData):void
        {
            for each (var _local_2:GuestRoomData in _visitedRooms)
            {
                if (_local_2.flatId == _arg_1.flatId)
                {
                    return;
                };
            };
            _visitedRooms.push(_arg_1);
            if (_visitedRooms.length > 10)
            {
                _visitedRooms.shift();
            };
            _currentRoomIndex = (_visitedRooms.length - 1);
            if (_SafeStr_3795)
            {
                _SafeStr_3795.setLikeButton(handler.canRate);
            };
        }

        public function showRoomInfo(_arg_1:Boolean, _arg_2:String, _arg_3:String, _arg_4:Array):void
        {
            if (!_SafeStr_4290)
            {
                return;
            };
            _currentRoomName = _arg_2;
            _SafeStr_4290.showRoomInfo(_arg_1, _arg_2, _arg_3, _arg_4);
        }

        public function enterNewRoom(_arg_1:int):void
        {
            if (((!(_SafeStr_3795)) || (!(_SafeStr_4290))))
            {
                return;
            };
            var _local_3:int;
            for each (var _local_2:GuestRoomData in _visitedRooms)
            {
                if (_local_2.flatId == _arg_1)
                {
                    _currentRoomIndex = _local_3;
                };
                _local_3++;
            };
            _SafeStr_3795.disableRoomHistoryButtons();
            if (_SafeStr_4291 != null)
            {
                _SafeStr_4291.stop();
            };
            _SafeStr_4291 = new Timer(2000, 1);
            _SafeStr_4291.addEventListener("timer", roomButtonTimerEventHandler);
            _SafeStr_4291.start();
            _SafeStr_4290.setElementVisible("tags", true);
        }

        private function roomButtonTimerEventHandler(_arg_1:TimerEvent):void
        {
            var _local_2:Timer = (_arg_1.target as Timer);
            if (_local_2)
            {
                _local_2.stop();
                _local_2.removeEventListener("timer", roomButtonTimerEventHandler);
            };
            if (_SafeStr_3795)
            {
                _SafeStr_3795.updateRoomHistoryButtons();
            };
        }

        public function setCollapsed(_arg_1:Boolean):void
        {
            if (_SafeStr_3795)
            {
                _SafeStr_3795.setCollapsed(_arg_1);
            };
            if (_SafeStr_4290)
            {
                _SafeStr_4290.setToolbarCollapsed(_arg_1);
            };
        }

        public function get handler():RoomToolsWidgetHandler
        {
            return (_SafeStr_3915 as RoomToolsWidgetHandler);
        }

        public function getIconLocation(_arg_1:String):IWindow
        {
            return (_SafeStr_3795.window.findChildByName(_arg_1));
        }

        public function getWidgetAreaWidth():int
        {
            return ((_SafeStr_3795) ? _SafeStr_3795.right : 0);
        }

        public function getChatInputY():int
        {
            if (!_SafeStr_3989)
            {
                return (0);
            };
            var _local_1:RoomChatInputWidget = (_SafeStr_3989.getWidget("RWE_CHAT_INPUT_WIDGET") as RoomChatInputWidget);
            if (!_local_1)
            {
                return (0);
            };
            return (_local_1.getChatInputY());
        }

        public function getRoomToolbarRight():int
        {
            return ((_SafeStr_3795) ? _SafeStr_3795.right : 0);
        }

        public function goToNextRoom():void
        {
            var _local_1:int = (_currentRoomIndex + 1);
            var _local_2:int = _visitedRooms.length;
            if (_local_1 > _local_2)
            {
                _local_1 = _local_2;
            };
            handler.goToPrivateRoom(_visitedRooms[_local_1].flatId);
            _SafeStr_3795.disableRoomHistoryButtons();
        }

        public function goToPreviousRoom():void
        {
            var _local_1:int = (_currentRoomIndex - 1);
            if (_local_1 < 0)
            {
                _local_1 = 0;
            };
            handler.goToPrivateRoom(_visitedRooms[_local_1].flatId);
            _SafeStr_3795.disableRoomHistoryButtons();
        }

        public function get freeFlowChat():IHabboFreeFlowChat
        {
            return (_freeFlowChat);
        }

        public function get visitedRooms():Vector.<GuestRoomData>
        {
            return (_visitedRooms);
        }

        public function get currentRoomIndex():int
        {
            return (_currentRoomIndex);
        }

        public function get currentRoomName():String
        {
            return (_currentRoomName);
        }


    }
}

