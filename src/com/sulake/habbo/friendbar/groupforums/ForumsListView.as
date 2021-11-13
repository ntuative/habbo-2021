package com.sulake.habbo.friendbar.groupforums
{
    import com.sulake.core.window.components.IScrollableListWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.communication.messages.parser.groupforums.ForumData;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.habbo.window.widgets.IBadgeImageWidget;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class ForumsListView 
    {

        private var _SafeStr_1284:GroupForumController;
        private var _SafeStr_461:GroupForumView;
        private var _SafeStr_853:IScrollableListWindow;
        private var _SafeStr_2247:IWindowContainer;
        private var _forums:Array;

        public function ForumsListView(_arg_1:GroupForumView, _arg_2:IScrollableListWindow, _arg_3:Array)
        {
            _SafeStr_461 = _arg_1;
            _SafeStr_1284 = _SafeStr_461.controller;
            _SafeStr_853 = _arg_2;
            _SafeStr_2247 = (_SafeStr_1284.windowManager.buildFromXML(XML(new HabboFriendBarCom.groupforum_forum_list_item_xml())) as IWindowContainer);
            _forums = _arg_3;
        }

        public function update():void
        {
            var _local_3:int;
            var _local_2:IWindowContainer;
            var _local_1:ForumData;
            _SafeStr_853.invalidate();
            _local_3 = 0;
            while (_local_3 < _forums.length)
            {
                _local_1 = _forums[_local_3];
                _local_2 = (_SafeStr_2247.clone() as IWindowContainer);
                _local_2.name = ("forum_" + _local_1.groupId);
                updateListItem(_local_2, _local_1, _local_3);
                _SafeStr_853.addListItem(_local_2);
                _local_3++;
            };
            updateItemWidths();
        }

        private function updateListItem(_arg_1:IWindowContainer, _arg_2:ForumData, _arg_3:int):void
        {
            var _local_5:IWindowContainer = (_arg_1 as IWindowContainer);
            _local_5.color = (((_arg_3 + 1) % 2) ? 4293852927 : 4289914618);
            var _local_6:int = _arg_2.unreadMessages;
            var _local_9:IWindow = _local_5.findChildByName("texts_container");
            _local_9.id = _arg_2.groupId;
            var _local_8:ITextWindow = (_local_5.findChildByName("header") as ITextWindow);
            _local_8.bold = (_local_6 > 0);
            _local_8.text = _arg_2.name;
            _local_9 = _local_5.findChildByName("header_region");
            _local_9.id = _arg_2.groupId;
            _local_9.removeEventListener("WME_CLICK", onOpenForum);
            _local_9.addEventListener("WME_CLICK", onOpenForum);
            _local_9 = _local_5.findChildByName("details");
            _local_9.caption = _SafeStr_1284.localizationManager.getLocalizationWithParams("groupforum.view.forum_details", "", "rating", _arg_2.leaderboardScore, "last_author_id", _arg_2.lastMessageAuthorId, "last_author_name", _arg_2.lastMessageAuthorName, "update_time", _SafeStr_461.getAsDaysHoursMinutes(_arg_2.lastMessageTimeAsSecondsAgo));
            _local_9 = _local_5.findChildByName("unread_texts_container");
            _local_9.id = _arg_2.groupId;
            _local_9 = _local_5.findChildByName("unread_region");
            _local_9.id = _arg_2.groupId;
            _local_9.removeEventListener("WME_CLICK", onOpenForum);
            _local_9.addEventListener("WME_CLICK", onOpenForum);
            _local_8 = (_local_5.findChildByName("messages1") as ITextWindow);
            _local_8.bold = (_local_6 > 0);
            _local_8.text = _SafeStr_1284.localizationManager.getLocalizationWithParams("groupforum.view.thread_details1", "", "total_messages", _arg_2.totalMessages, "new_messages", _local_6);
            _local_8 = (_local_5.findChildByName("messages2") as ITextWindow);
            _local_8.bold = (_local_6 > 0);
            _local_8.text = _SafeStr_1284.localizationManager.getLocalizationWithParams("groupforum.view.thread_details2", "", "total_messages", _arg_2.totalMessages, "new_messages", _local_6);
            var _local_7:IWidgetWindow = IWidgetWindow(_local_5.findChildByName("group_icon"));
            var _local_4:IBadgeImageWidget = (_local_7.widget as IBadgeImageWidget);
            _local_4.badgeId = _arg_2.icon;
            _local_4.groupId = _arg_2.groupId;
            _local_4.type = "group";
        }

        public function updateItemWidths():void
        {
            var _local_1:int;
            _local_1 = 0;
            while (_local_1 < _SafeStr_853.numListItems)
            {
                _SafeStr_853.getListItemAt(_local_1).width = (_SafeStr_853.scrollableWindow.width - 2);
                _local_1++;
            };
        }

        private function onOpenForum(_arg_1:WindowMouseEvent):void
        {
            _SafeStr_1284.openGroupForum(_arg_1.target.id);
        }


    }
}

