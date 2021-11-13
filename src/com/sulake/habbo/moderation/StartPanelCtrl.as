package com.sulake.habbo.moderation
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.ILabelWindow;
    import com.sulake.habbo.communication.messages.parser.room.engine.RoomEntryInfoMessageParser;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.communication.messages.outgoing.moderator.GetRoomChatlogMessageComposer;

    public class StartPanelCtrl implements IDisposable 
    {

        private var _main:ModerationManager;
        private var _frame:IFrameWindow;
        private var _SafeStr_1887:int;
        private var _isGuestRoom:Boolean;
        private var _SafeStr_1907:int;
        private var _disposed:Boolean = false;

        public function StartPanelCtrl(_arg_1:ModerationManager)
        {
            _main = _arg_1;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function dispose():void
        {
            if (!_disposed)
            {
                _main = null;
                if (_frame)
                {
                    _frame.dispose();
                    _frame = null;
                };
            };
        }

        public function userSelected(_arg_1:int, _arg_2:String):void
        {
            if (_frame == null)
            {
                return;
            };
            _SafeStr_1887 = _arg_1;
            _frame.findChildByName("userinfo_but").enable();
            (IWindowContainer(_frame.findChildByName("userinfo_but")).findChildByName("offence_name") as ILabelWindow).textColor = 0;
            IWindowContainer(_frame.findChildByName("userinfo_but")).findChildByName("offence_name").caption = ("User info: " + _arg_2);
        }

        public function guestRoomEntered(_arg_1:RoomEntryInfoMessageParser):void
        {
            if (((_frame == null) || (_arg_1 == null)))
            {
                return;
            };
            _frame.findChildByName("room_tool_but").enable();
            (IWindowContainer(_frame.findChildByName("room_tool_but")).findChildByName("offence_name") as ILabelWindow).textColor = 0;
            enableChatlogButton();
            _isGuestRoom = true;
            _SafeStr_1907 = _arg_1.guestRoomId;
        }

        public function roomExited():void
        {
            if (_frame == null)
            {
                return;
            };
            _frame.findChildByName("room_tool_but").disable();
            _frame.findChildByName("chatlog_but").disable();
        }

        public function show():void
        {
            if (_frame == null)
            {
                _frame = IFrameWindow(_main.getXmlWindow("start_panel"));
                _frame.findChildByName("room_tool_but").addEventListener("WME_CLICK", onRoomToolButton);
                _frame.findChildByName("chatlog_but").addEventListener("WME_CLICK", onChatlogButton);
                _frame.findChildByName("ticket_queue_but").addEventListener("WME_CLICK", onTicketQueueButton);
                _frame.findChildByName("userinfo_but").addEventListener("WME_CLICK", onUserinfoButton);
                _frame.findChildByName("room_tool_but").addEventListener("WME_OVER", onMouseOver);
                _frame.findChildByName("chatlog_but").addEventListener("WME_OVER", onMouseOver);
                _frame.findChildByName("ticket_queue_but").addEventListener("WME_OVER", onMouseOver);
                _frame.findChildByName("userinfo_but").addEventListener("WME_OVER", onMouseOver);
                _frame.findChildByName("room_tool_but").addEventListener("WME_OUT", onMouseOut);
                _frame.findChildByName("chatlog_but").addEventListener("WME_OUT", onMouseOut);
                _frame.findChildByName("ticket_queue_but").addEventListener("WME_OUT", onMouseOut);
                _frame.findChildByName("userinfo_but").addEventListener("WME_OUT", onMouseOut);
                _frame.findChildByName("userinfo_but").disable();
                _frame.findChildByName("room_tool_but").disable();
                _frame.findChildByName("chatlog_but").disable();
                ((_main.initMsg.cfhPermission) ? null : _frame.findChildByName("ticket_queue_but").disable());
                ((_main.initMsg.chatlogsPermission) ? null : _frame.findChildByName("chatlog_but").disable());
                (IWindowContainer(_frame.findChildByName("userinfo_but")).findChildByName("offence_name") as ILabelWindow).textColor = 0x666666;
                (IWindowContainer(_frame.findChildByName("room_tool_but")).findChildByName("offence_name") as ILabelWindow).textColor = 0x666666;
                (IWindowContainer(_frame.findChildByName("chatlog_but")).findChildByName("offence_name") as ILabelWindow).textColor = 0x666666;
            };
            _frame.visible = true;
        }

        private function enableChatlogButton():void
        {
            if (_main.initMsg.chatlogsPermission)
            {
                _frame.findChildByName("chatlog_but").enable();
                (IWindowContainer(_frame.findChildByName("chatlog_but")).findChildByName("offence_name") as ILabelWindow).textColor = 0;
            };
        }

        private function onMouseOver(_arg_1:WindowEvent):void
        {
            if (!_arg_1.window.isEnabled())
            {
                return;
            };
            (_arg_1.window as IWindowContainer).findChildByName("mouseover").visible = true;
        }

        private function onMouseOut(_arg_1:WindowEvent):void
        {
            (_arg_1.window as IWindowContainer).findChildByName("mouseover").visible = false;
        }

        private function onRoomToolButton(_arg_1:WindowEvent):void
        {
            _main.windowTracker.show(new RoomToolCtrl(_main, _SafeStr_1907), _frame, false, false, true);
        }

        private function onChatlogButton(_arg_1:WindowEvent):void
        {
            _main.windowTracker.show(new ChatlogCtrl(new GetRoomChatlogMessageComposer(((_isGuestRoom) ? 0 : 1), _SafeStr_1907), _main, 4, _SafeStr_1907), _frame, false, false, true);
        }

        private function onUserinfoButton(_arg_1:WindowEvent):void
        {
            _main.windowTracker.show(new UserInfoFrameCtrl(_main, _SafeStr_1887), _frame, false, false, true);
        }

        private function onTicketQueueButton(_arg_1:WindowEvent):void
        {
            _main.issueManager.init();
        }


    }
}

