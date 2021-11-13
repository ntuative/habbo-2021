package com.sulake.habbo.moderation
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.communication.messages.incoming.moderation.RoomModerationData;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.components.IDropMenuWindow;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.core.window.components._SafeStr_108;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.communication.messages.outgoing.moderator.GetModeratorRoomInfoMessageComposer;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.components._SafeStr_101;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.habbo.communication.messages.incoming.moderation.RoomData;
    import com.sulake.habbo.communication.messages.outgoing.moderator.GetRoomChatlogMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.moderator.ModeratorActionMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.moderator.ModerateRoomMessageComposer;
    import com.sulake.habbo.window.utils.IAlertDialog;

    public class RoomToolCtrl implements IDisposable, ITrackedWindow 
    {

        private var _main:ModerationManager;
        private var _flatId:int;
        private var _SafeStr_690:RoomModerationData;
        private var _frame:IFrameWindow;
        private var _SafeStr_853:IItemListWindow;
        private var _disposed:Boolean;
        private var _SafeStr_2872:IDropMenuWindow;
        private var _SafeStr_2868:ITextFieldWindow;
        private var _includeInfo:Boolean = true;
        private var _SafeStr_2873:_SafeStr_108;
        private var _SafeStr_2874:_SafeStr_108;
        private var _SafeStr_2875:_SafeStr_108;
        private var _SafeStr_2876:IWindowContainer;

        public function RoomToolCtrl(_arg_1:ModerationManager, _arg_2:int)
        {
            _main = _arg_1;
            _flatId = _arg_2;
        }

        public static function getLowestPoint(_arg_1:IWindowContainer):int
        {
            var _local_2:int;
            var _local_4:IWindow;
            var _local_3:int;
            _local_2 = 0;
            while (_local_2 < _arg_1.numChildren)
            {
                _local_4 = _arg_1.getChildAt(_local_2);
                if (_local_4.visible)
                {
                    _local_3 = Math.max(_local_3, (_local_4.y + _local_4.height));
                };
                _local_2++;
            };
            return (_local_3);
        }

        public static function moveChildrenToColumn(_arg_1:IWindowContainer, _arg_2:int, _arg_3:int):void
        {
            var _local_4:int;
            var _local_5:IWindow;
            _local_4 = 0;
            while (_local_4 < _arg_1.numChildren)
            {
                _local_5 = _arg_1.getChildAt(_local_4);
                if ((((!(_local_5 == null)) && (_local_5.visible)) && (_local_5.height > 0)))
                {
                    _local_5.y = _arg_2;
                    _arg_2 = (_arg_2 + (_local_5.height + _arg_3));
                };
                _local_4++;
            };
        }


        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function show():void
        {
            _frame = IFrameWindow(_main.getXmlWindow("roomtool_frame"));
            var _local_1:IItemListWindow = (_frame.findChildByName("list_cont") as IItemListWindow);
            var _local_2:IWindowContainer = (_local_1.getListItemByName("room_cont") as IWindowContainer);
            _SafeStr_2876 = (_local_2.findChildByName("room_data") as IWindowContainer);
            _local_2.removeChild(_SafeStr_2876);
            _main.messageHandler.addRoomInfoListener(this);
            _main.connection.send(new GetModeratorRoomInfoMessageComposer(_flatId));
            Logger.log(("BEGINNING TO SHOW: " + _flatId));
        }

        public function getType():int
        {
            return (9);
        }

        public function getId():String
        {
            return ("" + _flatId);
        }

        public function getFrame():IFrameWindow
        {
            return (_frame);
        }

        private function onClose(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            dispose();
        }

        public function dispose():void
        {
            if (_disposed)
            {
                return;
            };
            _disposed = true;
            _main.messageHandler.removeRoomEnterListener(this);
            if (_frame != null)
            {
                _frame.destroy();
                _frame = null;
            };
            if (_SafeStr_690 != null)
            {
                _SafeStr_690.dispose();
                _SafeStr_690 = null;
            };
            _main = null;
            _SafeStr_853 = null;
            _SafeStr_2872 = null;
            _SafeStr_2868 = null;
            _SafeStr_2873 = null;
            _SafeStr_2874 = null;
            _SafeStr_2875 = null;
        }

        public function onRoomChange():void
        {
            setSendButtonState("send_caution_but");
            setSendButtonState("send_message_but");
        }

        private function setSendButtonState(_arg_1:String):void
        {
            var _local_3:Boolean = ((!(_SafeStr_690 == null)) && (_SafeStr_690.flatId == _main.currentFlatId));
            var _local_2:_SafeStr_101 = _SafeStr_101(_frame.findChildByName(_arg_1));
            if (((_local_3) && (_main.initMsg.roomAlertPermission)))
            {
                _local_2.enable();
            }
            else
            {
                _local_2.disable();
            };
        }

        public function onRoomInfo(_arg_1:RoomModerationData):void
        {
            if (_disposed)
            {
                return;
            };
            Logger.log(((("GOT ROOM INFO: " + _arg_1.flatId) + ", ") + _flatId));
            if (_arg_1.flatId != _flatId)
            {
                Logger.log(((("NOT THE SAME FLAT: " + _arg_1.flatId) + ", ") + _flatId));
                return;
            };
            _SafeStr_690 = _arg_1;
            populate();
            _main.messageHandler.removeRoomInfoListener(this);
            _frame.visible = true;
            _main.messageHandler.addRoomEnterListener(this);
        }

        public function populate():void
        {
            _SafeStr_853 = IItemListWindow(_frame.findChildByName("list_cont"));
            var _local_1:IWindow = _frame.findChildByTag("close");
            _local_1.procedure = onClose;
            _SafeStr_2868 = ITextFieldWindow(_frame.findChildByName("message_input"));
            _SafeStr_2868.procedure = onInputClick;
            _SafeStr_2872 = IDropMenuWindow(_frame.findChildByName("msgTemplatesSelect"));
            prepareMsgSelect(_SafeStr_2872);
            _SafeStr_2872.procedure = onSelectTemplate;
            _SafeStr_2873 = _SafeStr_108(_frame.findChildByName("kick_check"));
            _SafeStr_2874 = _SafeStr_108(_frame.findChildByName("lock_check"));
            _SafeStr_2875 = _SafeStr_108(_frame.findChildByName("changename_check"));
            refreshRoomData(_SafeStr_690.room, "room_cont");
            setTxt("owner_name_txt", _SafeStr_690.ownerName);
            setTxt("owner_in_room_txt", ((_SafeStr_690.ownerInRoom) ? "Yes" : "No"));
            setTxt("user_count_txt", ("" + _SafeStr_690.userCount));
            _frame.findChildByName("enter_room_but").procedure = onEnterRoom;
            _frame.findChildByName("chatlog_but").procedure = onChatlog;
            _frame.findChildByName("edit_in_hk_but").procedure = onEditInHk;
            _frame.findChildByName("send_caution_but").procedure = onSendCaution;
            _frame.findChildByName("send_message_but").procedure = onSendMessage;
            ((_main.initMsg.chatlogsPermission) ? null : _frame.findChildByName("chatlog_but").disable());
            if (!_main.initMsg.roomKickPermission)
            {
                _SafeStr_2873.disable();
            };
            _frame.findChildByName("owner_name_txt").procedure = onOwnerName;
            this.onRoomChange();
        }

        private function disposeItemFromList(_arg_1:IItemListWindow, _arg_2:IWindow):void
        {
            var _local_3:IWindow = _arg_1.removeListItem(_arg_2);
            if (_local_3 != null)
            {
                _local_3.dispose();
            };
        }

        private function refreshRoomData(_arg_1:RoomData, _arg_2:String):void
        {
            var _local_6:IWindowContainer = IWindowContainer(_SafeStr_853.getListItemByName(_arg_2));
            var _local_7:IWindowContainer = IWindowContainer(_local_6.findChildByName("room_data"));
            if (_local_7 == null)
            {
                _local_7 = (_local_6.addChild(_SafeStr_2876.clone()) as IWindowContainer);
            };
            if (!_arg_1.exists)
            {
                disposeItemFromList(_SafeStr_853, _local_6);
                disposeItemFromList(_SafeStr_853, _SafeStr_853.getListItemByName("event_spacing"));
                return;
            };
            var _local_4:ITextWindow = ITextWindow(_local_7.findChildByName("name"));
            _local_4.caption = _arg_1.name;
            _local_4.height = (_local_4.textHeight + 5);
            var _local_3:ITextWindow = ITextWindow(_local_7.findChildByName("desc"));
            _local_3.caption = _arg_1.desc;
            _local_3.height = (_local_3.textHeight + 5);
            var _local_5:IWindowContainer = IWindowContainer(_local_7.findChildByName("tags_cont"));
            var _local_8:ITextWindow = ITextWindow(_local_5.findChildByName("tags_txt"));
            _local_8.caption = getTagsAsString(_arg_1.tags);
            _local_8.height = (_local_8.textHeight + 5);
            _local_5.height = _local_8.height;
            if (_arg_1.tags.length < 1)
            {
                _local_7.removeChild(_local_5);
            };
            moveChildrenToColumn(_local_7, _local_4.y, 0);
            _local_7.height = getLowestPoint(_local_7);
            _local_6.height = (_local_7.height + (2 * _local_7.y));
            Logger.log(((((((((((("XXXX: " + _local_6.height) + ", ") + _local_7.height) + ", ") + _local_4.height) + ", ") + _local_3.height) + ", ") + _local_5.height) + ", ") + _local_8.height));
        }

        private function getTagsAsString(_arg_1:Array):String
        {
            var _local_3:String;
            var _local_2:String = "";
            for each (_local_3 in _arg_1)
            {
                if (_local_2 == "")
                {
                    _local_2 = _local_3;
                }
                else
                {
                    _local_2 = ((_local_2 + ", ") + _local_3);
                };
            };
            return (_local_2);
        }

        private function setTxt(_arg_1:String, _arg_2:String):void
        {
            var _local_3:ITextWindow = ITextWindow(_frame.findChildByName(_arg_1));
            _local_3.text = _arg_2;
        }

        private function onOwnerName(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            _main.windowTracker.show(new UserInfoFrameCtrl(_main, _SafeStr_690.ownerId), _frame, false, false, true);
        }

        private function onEnterRoom(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            Logger.log("Enter room clicked");
            _main.goToRoom(_SafeStr_690.flatId);
        }

        private function onChatlog(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            _main.windowTracker.show(new ChatlogCtrl(new GetRoomChatlogMessageComposer(0, _SafeStr_690.flatId), _main, 4, _SafeStr_690.flatId), _frame, false, false, true);
        }

        private function onEditInHk(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            Logger.log("Edit in hk clicked");
            _main.openHkPage("roomadmin.url", ("" + _SafeStr_690.flatId));
        }

        private function onSendCaution(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            Logger.log("Sending caution...");
            act(true);
        }

        private function onSendMessage(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            Logger.log("Sending message...");
            act(false);
        }

        private function act(_arg_1:Boolean):void
        {
            if (((_includeInfo) || (_SafeStr_2868.text == "")))
            {
                _main.windowManager.alert("Alert", "You must input a message to the user", 0, onAlertClose);
                return;
            };
            var _local_2:int = determineAction(_arg_1, _SafeStr_2873.isSelected);
            _main.connection.send(new ModeratorActionMessageComposer(_local_2, _SafeStr_2868.text, ""));
            if ((((_SafeStr_2874.isSelected) || (_SafeStr_2875.isSelected)) || (_SafeStr_2873.isSelected)))
            {
                _main.connection.send(new ModerateRoomMessageComposer(_SafeStr_690.flatId, _SafeStr_2874.isSelected, _SafeStr_2875.isSelected, _SafeStr_2873.isSelected));
            };
            this.dispose();
        }

        private function determineAction(_arg_1:Boolean, _arg_2:Boolean):int
        {
            if (_arg_2)
            {
                return ((_arg_1) ? 1 : 4);
            };
            return ((_arg_1) ? 0 : 3);
        }

        private function onInputClick(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WE_FOCUSED")
            {
                return;
            };
            if (!_includeInfo)
            {
                return;
            };
            _SafeStr_2868.text = "";
            _includeInfo = false;
        }

        private function onAlertClose(_arg_1:IAlertDialog, _arg_2:WindowEvent):void
        {
            _arg_1.dispose();
        }

        private function prepareMsgSelect(_arg_1:IDropMenuWindow):void
        {
            Logger.log(("MSG TEMPLATES: " + _main.initMsg.roomMessageTemplates.length));
            _arg_1.populate(_main.initMsg.roomMessageTemplates);
        }

        private function onSelectTemplate(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WE_SELECTED")
            {
                return;
            };
            var _local_3:String = _main.initMsg.roomMessageTemplates[_SafeStr_2872.selection];
            if (_local_3 != null)
            {
                _includeInfo = false;
                _SafeStr_2868.text = _local_3;
            };
        }


    }
}

