package com.sulake.habbo.moderation
{
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.IWindowContainer;
    import flash.display.BitmapData;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.communication.messages.parser.moderation.IssueMessageData;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.utils.getTimer;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class IssueListView 
    {

        private var _SafeStr_2848:IssueManager;
        private var _SafeStr_2849:IssueBrowser;
        private var _SafeStr_853:IItemListWindow;
        private var _SafeStr_2247:IWindowContainer;
        private var _userIcon:BitmapData;
        private var _roomIcon:BitmapData;
        private var _SafeStr_2850:int = 200;

        public function IssueListView(_arg_1:IssueManager, _arg_2:IssueBrowser, _arg_3:IItemListWindow)
        {
            _SafeStr_2848 = _arg_1;
            _SafeStr_2849 = _arg_2;
            _SafeStr_853 = _arg_3;
            _SafeStr_2247 = (_arg_3.getListItemAt(0) as IWindowContainer);
            _arg_3.removeListItems();
            _SafeStr_2850 = _arg_1.issueListLimit;
        }

        public function update(_arg_1:Array):void
        {
            var _local_9:int;
            var _local_2:IWindowContainer;
            var _local_3:IWindow;
            var _local_14:IWindow;
            var _local_12:IssueBundle;
            var _local_6:IssueMessageData;
            var _local_8:IBitmapWrapperWindow;
            var _local_10:String;
            var _local_11:BitmapDataAsset;
            var _local_4:BitmapData;
            if (_SafeStr_853 == null)
            {
                return;
            };
            if (((_arg_1 == null) || (_arg_1.length == 0)))
            {
                _SafeStr_853.destroyListItems();
                return;
            };
            _arg_1.sortOn(["highestPriority", "issueAgeInMilliseconds"], [16, 16]);
            var _local_13:int = _SafeStr_853.numListItems;
            var _local_5:int = _arg_1.length;
            if (_local_5 > _SafeStr_2850)
            {
                _local_5 = _SafeStr_2850;
            };
            if (_local_13 < _local_5)
            {
                _local_9 = 0;
                while (_local_9 < (_local_5 - _local_13))
                {
                    _local_2 = (_SafeStr_2247.clone() as IWindowContainer);
                    _SafeStr_853.addListItem(_local_2);
                    _local_9++;
                };
            }
            else
            {
                if (_local_13 > _local_5)
                {
                    _local_9 = 0;
                    while (_local_9 < (_local_13 - _local_5))
                    {
                        _local_3 = _SafeStr_853.removeListItemAt(0);
                        _local_3.dispose();
                        _local_9++;
                    };
                };
            };
            _local_9 = 1;
            var _local_7:int = getTimer();
            for each (_local_12 in _arg_1)
            {
                if (_local_9 > _SafeStr_2850) break;
                if (((_local_12 == null) || (_SafeStr_2247 == null)))
                {
                    return;
                };
                _local_2 = (_SafeStr_853.getListItemAt((_local_9 - 1)) as IWindowContainer);
                if (_local_2 == null)
                {
                    return;
                };
                _local_2.width = _SafeStr_853.width;
                _local_2.color = ((_local_9++ % 2) ? 4289914618 : 0xFFFFFFFF);
                _local_14 = _local_2.findChildByName("score");
                if (_local_14 != null)
                {
                    _local_14.caption = _local_12.highestPriority.toString();
                };
                _local_6 = _local_12.getHighestPriorityIssue();
                if (_local_6 == null)
                {
                    return;
                };
                _local_14 = _local_2.findChildByName("source");
                if (_local_14 != null)
                {
                    _local_14.caption = IssueCategoryNames.getSourceName(_local_6.categoryId);
                };
                _local_14 = _local_2.findChildByName("category");
                if (_local_14 != null)
                {
                    _local_14.caption = IssueCategoryNames.getCategoryName(_local_6.reportedCategoryId);
                };
                _local_14 = _local_2.findChildByName("target_name");
                if (_local_14 != null)
                {
                    if (_local_6.reportedUserId != 0)
                    {
                        _local_14.caption = _local_6.reportedUserName;
                    }
                    else
                    {
                        _local_14.caption = "";
                    };
                };
                _local_8 = (_local_2.findChildByName("target_icon") as IBitmapWrapperWindow);
                if (_local_8 != null)
                {
                    _local_10 = ((_local_6.reportedUserId) ? "user_icon_png" : "room_icon_png");
                    _local_11 = (_SafeStr_2849.assets.getAssetByName(_local_10) as BitmapDataAsset);
                    if (((!(_local_11 == null)) && (!((_local_11.content as BitmapData) == null))))
                    {
                        _local_4 = (_local_11.content as BitmapData);
                        if (_local_4 != null)
                        {
                            _local_8.bitmap = _local_4.clone();
                        };
                    };
                };
                _local_14 = _local_2.findChildByName("time");
                if (_local_14 != null)
                {
                    _local_14.caption = _local_12.getOpenTime(_local_7);
                };
                _local_14 = _local_2.findChildByName("msgs");
                if (_local_14 != null)
                {
                    _local_14.caption = _local_12.getMessageCount().toString();
                };
                _local_14 = _local_2.findChildByName("picker");
                if (_local_14 != null)
                {
                    _local_14.caption = _local_12.pickerName;
                };
                _local_14 = _local_2.findChildByName("pick_button");
                if (_local_14 != null)
                {
                    _local_14.id = _local_12.id;
                    _local_14.removeEventListener("WME_CLICK", onPick);
                    _local_14.addEventListener("WME_CLICK", onPick);
                };
                _local_14 = _local_2.findChildByName("handle_button");
                if (_local_14 != null)
                {
                    _local_14.id = _local_12.id;
                    _local_14.removeEventListener("WME_CLICK", onHandle);
                    _local_14.addEventListener("WME_CLICK", onHandle);
                };
                _local_14 = _local_2.findChildByName("release_button");
                if (_local_14 != null)
                {
                    _local_14.id = _local_12.id;
                    _local_14.removeEventListener("WME_CLICK", onRelease);
                    _local_14.addEventListener("WME_CLICK", onRelease);
                };
            };
        }

        private function onPick(_arg_1:WindowMouseEvent):void
        {
            if (_SafeStr_2848 == null)
            {
                return;
            };
            _SafeStr_2848.pickBundle(_arg_1.window.id, "pick button");
        }

        private function onHandle(_arg_1:WindowMouseEvent):void
        {
            if (_SafeStr_2849 == null)
            {
                return;
            };
            _SafeStr_2848.handleBundle(_arg_1.window.id);
        }

        private function onRelease(_arg_1:WindowMouseEvent):void
        {
            if (_SafeStr_2848 == null)
            {
                return;
            };
            _SafeStr_2848.releaseBundle(_arg_1.window.id);
        }


    }
}

