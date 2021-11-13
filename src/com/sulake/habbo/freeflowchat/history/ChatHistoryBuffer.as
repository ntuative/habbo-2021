package com.sulake.habbo.freeflowchat.history
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.freeflowchat.HabboFreeFlowChat;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.freeflowchat.history.visualization.entry.IChatHistoryEntryBitmap;
    import com.sulake.habbo.freeflowchat.data.ChatItem;
    import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;

    public class ChatHistoryBuffer implements IDisposable 
    {

        private const MAX_CHAT_ITEMS:int = 1000;

        private var _SafeStr_659:HabboFreeFlowChat;
        private var _entries:Vector.<IChatHistoryEntryBitmap> = new Vector.<IChatHistoryEntryBitmap>(0);

        public function ChatHistoryBuffer(_arg_1:HabboFreeFlowChat)
        {
            _SafeStr_659 = _arg_1;
        }

        public function dispose():void
        {
            _entries = null;
            _SafeStr_659 = null;
        }

        public function get disposed():Boolean
        {
            return (_SafeStr_659 == null);
        }

        public function insertChat(_arg_1:ChatItem):void
        {
            var _local_2:IChatHistoryEntryBitmap;
            try
            {
                _local_2 = _SafeStr_659.chatBubbleFactory.getHistoryLineEntry(_arg_1);
            }
            catch(e:Error)
            {
                if (e.errorID == 2015)
                {
                    return;
                };
                throw (e);
            };
            _entries.push(_local_2);
            checkBufferOverflowAndSpliceTop(_local_2);
            if (_SafeStr_659.chatHistoryScrollView.isActive)
            {
                _SafeStr_659.chatHistoryScrollView.addHistoryEntry(_entries[(_entries.length - 1)]);
            };
        }

        public function insertRoomChange(_arg_1:GuestRoomData):void
        {
            var _local_2:IChatHistoryEntryBitmap = _SafeStr_659.chatBubbleFactory.getHistoryRoomChangeEntry(_arg_1);
            _entries.push(_local_2);
            checkBufferOverflowAndSpliceTop(_local_2);
        }

        private function checkBufferOverflowAndSpliceTop(_arg_1:IChatHistoryEntryBitmap):void
        {
            if (_entries.length > 1000)
            {
                _SafeStr_659.chatHistoryScrollView.scrollUpAndSpliceTopItem(((_arg_1.bitmap.height - _arg_1.overlap.y) - 8));
                _entries.splice(0, 1);
            };
        }

        public function get entries():Vector.<IChatHistoryEntryBitmap>
        {
            return (_entries);
        }

        public function get totalHeight():int
        {
            var _local_2:int;
            for each (var _local_1:IChatHistoryEntryBitmap in _entries)
            {
                _local_2 = (_local_2 + ((_local_1.bitmap.height - _local_1.overlap.y) - 8));
            };
            return (_local_2);
        }


    }
}

