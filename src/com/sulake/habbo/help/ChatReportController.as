package com.sulake.habbo.help
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.IWindowContainer;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.help.cfh.registry.instantmessage.InstantMessageRegistryItem;
    import com.sulake.habbo.help.cfh.registry.chat.ChatRegistryItem;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class ChatReportController implements IDisposable 
    {

        private static const COLOR_ITEM_SELECTED:uint = 4282169599;
        private static const COLOR_ITEM_NORMAL:uint = 4293848814;

        private var _habboHelp:HabboHelp;
        private var _window:IWindowContainer;
        private var _submitFunction:Function;
        private var _reportedRoomId:int;
        private var _SafeStr_2685:int;
        private var _disposed:Boolean = false;

        public function ChatReportController(_arg_1:HabboHelp, _arg_2:Function)
        {
            _habboHelp = _arg_1;
            _submitFunction = _arg_2;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get reportedRoomId():int
        {
            return (_reportedRoomId);
        }

        public function dispose():void
        {
            if (!_disposed)
            {
                closeWindow();
                _habboHelp = null;
                _disposed = true;
            };
        }

        public function show(_arg_1:int, _arg_2:int, _arg_3:int):void
        {
            _window = (_habboHelp.getXmlWindow("chat_report") as IWindowContainer);
            _window.procedure = _submitFunction;
            _window.center();
            _SafeStr_2685 = _arg_2;
            _reportedRoomId = -1;
            if (_arg_3 == 3)
            {
                deselectInstantMessageEntries();
                populateInstantMessageList(_arg_1, _arg_2);
            }
            else
            {
                deselectChatEntries();
                populateChatMessageList(_arg_1, _arg_2);
            };
        }

        public function closeWindow():void
        {
            if (((_habboHelp) && (_habboHelp.chatRegistry)))
            {
                _habboHelp.chatRegistry.holdPurges = false;
            };
            if (((_habboHelp) && (_habboHelp.instantMessageRegistry)))
            {
                _habboHelp.instantMessageRegistry.holdPurges = false;
            };
            if (_window)
            {
                _window.dispose();
            };
            _window = null;
        }

        public function collectSelectedEntries(_arg_1:int, _arg_2:int):Array
        {
            var _local_6:int;
            var _local_4:Vector.<InstantMessageRegistryItem> = undefined;
            var _local_3:Array = [];
            if (_arg_1 == 3)
            {
                _local_6 = ((_arg_2 > 0) ? _arg_2 : _SafeStr_2685);
                _local_4 = _habboHelp.instantMessageRegistry.getItemsByUser(_local_6);
                for each (var _local_5:InstantMessageRegistryItem in _local_4)
                {
                    if (_local_5.selected)
                    {
                        if (_local_5.userId < 0)
                        {
                            _local_3.push(_local_5.userName.split(":")[0]);
                            _local_3.push(_local_5.text);
                        }
                        else
                        {
                            _local_3.push(_local_5.userId);
                            _local_3.push(_local_5.text);
                        };
                    };
                };
            }
            else
            {
                for each (var _local_7:ChatRegistryItem in _habboHelp.chatRegistry.getItems())
                {
                    if (_local_7.selected)
                    {
                        _local_3.push(_local_7.userId);
                        _local_3.push(_local_7.text);
                    };
                };
            };
            return (_local_3);
        }

        private function populateInstantMessageList(_arg_1:int, _arg_2:int):void
        {
            var _local_4:IWindowContainer;
            var _local_7:ITextWindow;
            var _local_8:IItemListWindow = (_window.findChildByName("room_items") as IItemListWindow);
            var _local_3:IWindowContainer = (_local_8.getListItemAt(0) as IWindowContainer);
            var _local_5:IWindowContainer = (_habboHelp.getXmlWindow("chat_report_item") as IWindowContainer);
            _local_8.removeListItems();
            var _local_6:IWindowContainer = (_local_3.clone() as IWindowContainer);
            _local_8.addListItemAt(_local_6, 0);
            var _local_10:IItemListWindow = (_local_6.findChildByName("chat_items") as IItemListWindow);
            _local_10.removeListItems();
            _habboHelp.instantMessageRegistry.holdPurges = true;
            var _local_9:Vector.<InstantMessageRegistryItem> = _habboHelp.instantMessageRegistry.getItemsByUser(_arg_2);
            for each (var _local_11:InstantMessageRegistryItem in _local_9)
            {
                _local_4 = (_local_5.clone() as IWindowContainer);
                _local_7 = (_local_4.getChildByName("text") as ITextWindow);
                if (_local_11.userId < 0)
                {
                    _local_7.caption = ((_local_11.userName.split(":")[1] + ": ") + _local_11.text);
                }
                else
                {
                    _local_7.caption = ((_local_11.userName + ": ") + _local_11.text);
                };
                _local_4.id = _local_11.index;
                _local_4.procedure = onInstantMessageEntryEvent;
                _local_4.color = 4293848814;
                _local_10.addListItem(_local_4);
            };
        }

        private function populateChatMessageList(_arg_1:int, _arg_2:int):void
        {
            var _local_9:int;
            var _local_6:IWindowContainer;
            var _local_11:IItemListWindow;
            var _local_4:IWindowContainer;
            var _local_7:ITextWindow;
            var _local_8:IItemListWindow = (_window.findChildByName("room_items") as IItemListWindow);
            var _local_3:IWindowContainer = (_local_8.getListItemAt(0) as IWindowContainer);
            var _local_5:IWindowContainer = (_habboHelp.getXmlWindow("chat_report_item") as IWindowContainer);
            _local_8.removeListItems();
            _habboHelp.chatRegistry.holdPurges = true;
            var _local_10:Vector.<ChatRegistryItem> = ((_arg_2 > 0) ? _habboHelp.chatRegistry.getItemsByUser(_arg_2) : _habboHelp.chatRegistry.getItems());
            for each (var _local_12:ChatRegistryItem in _local_10)
            {
                if (_local_12.userId != _arg_1)
                {
                    if (_local_12.roomId != _local_9)
                    {
                        _local_9 = _local_12.roomId;
                        _local_6 = (_local_3.clone() as IWindowContainer);
                        _local_6.findChildByName("room_name").caption = ("Room: " + _local_12.roomName);
                        _local_8.addListItemAt(_local_6, 0);
                        _local_11 = (_local_6.findChildByName("chat_items") as IItemListWindow);
                        _local_11.removeListItems();
                    };
                    _local_4 = (_local_5.clone() as IWindowContainer);
                    _local_7 = (_local_4.getChildByName("text") as ITextWindow);
                    _local_7.caption = ((_local_12.userName + ": ") + _local_12.text);
                    _local_4.id = _local_12.index;
                    _local_4.procedure = onChatEntryEvent;
                    _local_4.color = 4293848814;
                    _local_11.addListItem(_local_4);
                };
            };
        }

        private function onChatEntryEvent(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:ChatRegistryItem;
            if (_arg_1.type == "WME_CLICK")
            {
                _local_3 = _habboHelp.chatRegistry.getItem(_arg_2.id);
                if (!_local_3)
                {
                    return;
                };
                if (((!(_local_3.selected)) && (!(_local_3.roomId == _reportedRoomId))))
                {
                    _reportedRoomId = _local_3.roomId;
                    deselectChatEntries();
                };
                _local_3.selected = (!(_local_3.selected));
                _arg_2.color = ((_local_3.selected) ? 4282169599 : 4293848814);
            };
        }

        private function onInstantMessageEntryEvent(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:InstantMessageRegistryItem;
            if (_arg_1.type == "WME_CLICK")
            {
                _local_3 = _habboHelp.instantMessageRegistry.getItem(_SafeStr_2685, _arg_2.id);
                if (!_local_3)
                {
                    return;
                };
                _local_3.selected = (!(_local_3.selected));
                _arg_2.color = ((_local_3.selected) ? 4282169599 : 4293848814);
            };
        }

        private function deselectInstantMessageEntries():void
        {
            deselectAllEntries();
            refreshInstantMessageEntries();
        }

        private function deselectChatEntries():void
        {
            deselectAllEntries();
            refreshChatEntries();
        }

        private function deselectAllEntries():void
        {
            for each (var _local_2:Vector.<InstantMessageRegistryItem> in _habboHelp.instantMessageRegistry.getItems())
            {
                for each (var _local_3:InstantMessageRegistryItem in _local_2)
                {
                    _local_3.selected = false;
                };
            };
            for each (var _local_1:ChatRegistryItem in _habboHelp.chatRegistry.getItems())
            {
                _local_1.selected = false;
            };
        }

        private function refreshChatEntries():void
        {
            var _local_3:int;
            var _local_2:IWindowContainer;
            var _local_6:IItemListWindow;
            var _local_4:int;
            var _local_1:IWindow;
            var _local_7:ChatRegistryItem;
            var _local_5:IItemListWindow = (_window.findChildByName("room_items") as IItemListWindow);
            _local_3 = 0;
            while (_local_3 < _local_5.numListItems)
            {
                _local_2 = (_local_5.getListItemAt(_local_3) as IWindowContainer);
                _local_6 = (_local_2.findChildByName("chat_items") as IItemListWindow);
                _local_4 = 0;
                while (_local_4 < _local_6.numListItems)
                {
                    _local_1 = (_local_6.getListItemAt(_local_4) as IWindow);
                    _local_7 = _habboHelp.chatRegistry.getItem(_local_1.id);
                    if (_local_7)
                    {
                        _local_1.color = ((_local_7.selected) ? 4282169599 : 4293848814);
                    };
                    _local_4++;
                };
                _local_3++;
            };
        }

        public function refreshInstantMessageEntries():void
        {
            var _local_3:int;
            var _local_2:IWindowContainer;
            var _local_6:IItemListWindow;
            var _local_4:int;
            var _local_1:IWindow;
            var _local_7:InstantMessageRegistryItem;
            var _local_5:IItemListWindow = (_window.findChildByName("room_items") as IItemListWindow);
            _local_3 = 0;
            while (_local_3 < _local_5.numListItems)
            {
                _local_2 = (_local_5.getListItemAt(_local_3) as IWindowContainer);
                _local_6 = (_local_2.findChildByName("chat_items") as IItemListWindow);
                _local_4 = 0;
                while (_local_4 < _local_6.numListItems)
                {
                    _local_1 = (_local_6.getListItemAt(_local_4) as IWindow);
                    _local_7 = _habboHelp.instantMessageRegistry.getItem(_SafeStr_2685, _local_1.id);
                    if (_local_7)
                    {
                        _local_1.color = ((_local_7.selected) ? 4282169599 : 4293848814);
                    };
                    _local_4++;
                };
                _local_3++;
            };
        }


    }
}

