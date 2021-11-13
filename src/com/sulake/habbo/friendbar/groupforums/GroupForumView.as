package com.sulake.habbo.friendbar.groupforums
{
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.components.IScrollableListWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components._SafeStr_143;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.habbo.communication.messages.parser.groupforums.ExtendedForumData;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.habbo.window.widgets.IBadgeImageWidget;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.habbo.communication.messages.parser.groupforums.ForumData;
    import com.sulake.core.window.components.ILabelWindow;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.communication.messages.parser.groupforums.ThreadData;
    import com.sulake.habbo.communication.messages.parser.groupforums.MessageData;
    import com.sulake.habbo.utils.FriendlyTime;
    import com.sulake.core.window.events.WindowEvent;

    public class GroupForumView 
    {

        private static const _SafeStr_2259:int = 100;

        private var _controller:GroupForumController;
        private var _SafeStr_2260:ForumsListView;
        private var _SafeStr_2261:ThreadListView;
        private var _SafeStr_2262:MessageListView;
        private var _window:IFrameWindow;
        private var _SafeStr_2263:IScrollableListWindow;
        private var _SafeStr_2264:IWindow;
        private var _SafeStr_2265:IWindow;
        private var _SafeStr_2266:IWindow;
        private var _SafeStr_2267:IWindow;
        private var _txtElement:IWindow;
        private var _backButton:_SafeStr_143;
        private var _postButton:_SafeStr_143;
        private var _SafeStr_2268:IWindow;
        private var _SafeStr_2269:IWindow;
        private var _SafeStr_2270:ITextWindow;
        private var _SafeStr_2253:ForumsListData;
        private var _SafeStr_2235:ExtendedForumData;
        private var _SafeStr_2254:ThreadsListData;
        private var _SafeStr_2255:MessagesListData;
        private var _SafeStr_2271:int = 1;
        private var _SafeStr_2272:int = 1;
        private var _SafeStr_2273:int;

        public function GroupForumView(_arg_1:GroupForumController)
        {
            _controller = _arg_1;
            _SafeStr_2273 = 20;
        }

        private static function enable(_arg_1:IWindow, _arg_2:Boolean):void
        {
            if (_arg_2)
            {
                _arg_1.enable();
            }
            else
            {
                _arg_1.disable();
            };
        }

        internal static function initTopAreaForForum(_arg_1:IFrameWindow, _arg_2:ForumData):IRegionWindow
        {
            var _local_4:IWindowContainer = (_arg_1.findChildByName("top_part") as IWindowContainer);
            var _local_6:IWidgetWindow = IWidgetWindow(_local_4.findChildByName("group_icon"));
            _local_6.visible = true;
            var _local_3:IBadgeImageWidget = (_local_6.widget as IBadgeImageWidget);
            _local_3.badgeId = _arg_2.icon;
            _local_3.groupId = _arg_2.groupId;
            _local_3.type = "group";
            var _local_8:IStaticBitmapWrapperWindow = (_local_4.findChildByName("header_icon") as IStaticBitmapWrapperWindow);
            if (_local_8 != null)
            {
                _local_8.visible = false;
            };
            var _local_7:ITextWindow = (_local_4.findChildByName("top_header_text") as ITextWindow);
            _local_7.text = _arg_2.name;
            var _local_5:ITextWindow = (_local_4.findChildByName("top_text") as ITextWindow);
            _local_5.text = _arg_2.description;
            return (_local_4.findChildByName("top_click_area") as IRegionWindow);
        }


        public function dispose():void
        {
            if (_controller)
            {
                _controller.closeMainView();
            };
            if (_window != null)
            {
                _window.removeEventListener("click", onClickButton);
                _window.dispose();
                _window = null;
                _controller = null;
            };
        }

        private function initCommonControls():void
        {
            var _local_2:IWindow = _window.findChildByName("settings_button");
            if (((!(_SafeStr_2235 == null)) && (_SafeStr_2235.canChangeSettings)))
            {
                _local_2.removeEventListener("WME_CLICK", onSettingsButtonClick);
                _local_2.addEventListener("WME_CLICK", onSettingsButtonClick);
                _local_2.visible = true;
            }
            else
            {
                _local_2.visible = false;
            };
            var _local_1:ILabelWindow = (_backButton.findChildByName("back_button_label") as ILabelWindow);
            if (_SafeStr_2261 != null)
            {
                _backButton.visible = true;
                _local_1.text = _controller.localizationManager.getLocalization("groupforum.view.mark_read");
            }
            else
            {
                if (_SafeStr_2262 != null)
                {
                    _backButton.visible = true;
                    _local_1.text = _controller.localizationManager.getLocalization("groupforum.view.back");
                }
                else
                {
                    if (_SafeStr_2260 != null)
                    {
                        _backButton.visible = true;
                        _local_1.text = _controller.localizationManager.getLocalization("groupforum.view.mark_read");
                    }
                    else
                    {
                        _backButton.visible = false;
                    };
                };
            };
            var _local_3:ILabelWindow = (_postButton.findChildByName("post_button_label") as ILabelWindow);
            if (_SafeStr_2261 != null)
            {
                _postButton.visible = true;
                _local_3.text = _controller.localizationManager.getLocalization("groupforum.view.start_thread");
            }
            else
            {
                if (_SafeStr_2262 != null)
                {
                    _postButton.visible = true;
                    _local_3.text = _controller.localizationManager.getLocalization("groupforum.view.reply");
                }
                else
                {
                    _postButton.visible = false;
                };
            };
            var _local_4:int = (_SafeStr_2271 + 1);
            _txtElement.caption = ((_local_4 + " / ") + _SafeStr_2272);
            _window.scaler.enable();
            _window.scaler.visible = true;
            enable(_SafeStr_2266, (_SafeStr_2271 > 0));
            enable(_SafeStr_2264, (_SafeStr_2271 > 0));
            enable(_SafeStr_2265, (_SafeStr_2271 < (_SafeStr_2272 - 1)));
            enable(_SafeStr_2267, (_SafeStr_2271 < (_SafeStr_2272 - 1)));
            updateUnreadForumsCount(_controller.unreadForumsCount);
        }

        private function resetWindow():void
        {
            if (_window != null)
            {
                _SafeStr_2263.destroyListItems();
                _SafeStr_2260 = null;
                _SafeStr_2261 = null;
                _SafeStr_2262 = null;
            }
            else
            {
                _window = (_controller.windowManager.buildFromXML(XML(new HabboFriendBarCom.groupforum_main_view_xml())) as IFrameWindow);
                _SafeStr_2263 = (_window.findChildByName("scrollable_message_list") as IScrollableListWindow);
                _SafeStr_2263.scrollableWindow.addEventListener("WE_RESIZED", onResized, 100);
                _window.center();
                _window.y = 100;
                _txtElement = _window.findChildByName("page_info");
                _SafeStr_2264 = _window.findChildByName("show_previous");
                _SafeStr_2264.addEventListener("WME_CLICK", onClickButton);
                _SafeStr_2265 = _window.findChildByName("show_next");
                _SafeStr_2265.addEventListener("WME_CLICK", onClickButton);
                _SafeStr_2267 = _window.findChildByName("show_last");
                _SafeStr_2267.addEventListener("WME_CLICK", onClickButton);
                _SafeStr_2266 = _window.findChildByName("show_first");
                _SafeStr_2266.addEventListener("WME_CLICK", onClickButton);
                _backButton = _SafeStr_143(_window.findChildByName("back_button"));
                _backButton.addEventListener("WME_CLICK", onClickButton);
                _postButton = _SafeStr_143(_window.findChildByName("post_button"));
                _postButton.addEventListener("WME_CLICK", onClickButton);
                _SafeStr_2268 = _window.findChildByTag("close");
                _SafeStr_2268.addEventListener("WME_CLICK", onClickButton);
                _SafeStr_2269 = _window.findChildByName("list_header");
                _SafeStr_2270 = ITextWindow(IItemListWindow(_window.findChildByName("shortcuts")).getListItemByName("my"));
            };
        }

        private function setStatusTextError(_arg_1:String, _arg_2:String):void
        {
            var _local_3:ITextWindow = ITextWindow(_window.findChildByName("status"));
            if (((_arg_2 == null) || (_arg_2.length == 0)))
            {
                _local_3.caption = "";
            }
            else
            {
                _arg_1 = _controller.localizationManager.getLocalization(("groupforum.view.error.operation_" + _arg_1));
                _local_3.text = _controller.localizationManager.getLocalizationWithParams(("groupforum.view.error." + _arg_2), "", "operation", _arg_1);
            };
        }

        private function onSettingsButtonClick(_arg_1:WindowMouseEvent):void
        {
            openForumSettingsView();
        }

        private function onTopAreaClick(_arg_1:WindowMouseEvent):void
        {
            if (_SafeStr_2235 != null)
            {
                _controller.context.createLinkEvent(("group/" + _SafeStr_2235.groupId));
            };
        }

        public function openForumsList(_arg_1:ForumsListData):void
        {
            resetWindow();
            _SafeStr_2253 = _arg_1;
            _SafeStr_2235 = null;
            _SafeStr_2254 = null;
            _SafeStr_2255 = null;
            _SafeStr_2272 = calculateNumOfPagesAvailable(_SafeStr_2253.totalAmount);
            _SafeStr_2271 = Math.ceil((_SafeStr_2253.startIndex / 20));
            _SafeStr_2260 = new ForumsListView(this, _SafeStr_2263, _SafeStr_2253.forums);
            _SafeStr_2260.update();
            _SafeStr_2269.caption = _controller.localizationManager.getLocalization(("groupforum.view.forums_list." + _SafeStr_2253.listCode));
            var _local_3:IWindowContainer = (_window.findChildByName("top_part") as IWindowContainer);
            var _local_6:IWidgetWindow = IWidgetWindow(_local_3.findChildByName("group_icon"));
            _local_6.visible = false;
            var _local_8:IStaticBitmapWrapperWindow = (_local_3.findChildByName("header_icon") as IStaticBitmapWrapperWindow);
            _local_8.visible = true;
            _local_8.assetUri = ("forum_forum_list" + _SafeStr_2253.listCode);
            var _local_7:ITextWindow = (_local_3.findChildByName("top_header_text") as ITextWindow);
            _local_7.text = _controller.localizationManager.getLocalization(("groupforum.view.forums_header." + _SafeStr_2253.listCode));
            var _local_4:ITextWindow = (_local_3.findChildByName("top_text") as ITextWindow);
            _local_4.text = _controller.localizationManager.getLocalization(("groupforum.view.forums_description." + _SafeStr_2253.listCode));
            var _local_2:IRegionWindow = (_local_3.findChildByName("top_click_area") as IRegionWindow);
            _local_2.removeEventListener("WME_CLICK", onTopAreaClick);
            _local_2.disable();
            initCommonControls();
            var _local_5:ITextWindow = ITextWindow(_window.findChildByName("status"));
            _local_5.text = _controller.localizationManager.getLocalization("groupforum.view.forums_list.status");
        }

        public function get isForumsListOpened():Boolean
        {
            return (!(_SafeStr_2260 == null));
        }

        public function openThreadList(_arg_1:ForumsListData, _arg_2:ExtendedForumData, _arg_3:ThreadsListData):void
        {
            resetWindow();
            _SafeStr_2253 = _arg_1;
            _SafeStr_2235 = _arg_2;
            _SafeStr_2254 = _arg_3;
            _SafeStr_2255 = null;
            _SafeStr_2272 = calculateNumOfPagesAvailable(_SafeStr_2254.totalThreads);
            _SafeStr_2271 = Math.ceil((_SafeStr_2254.startIndex / 20));
            _SafeStr_2261 = new ThreadListView(this, _SafeStr_2263, _SafeStr_2235, _SafeStr_2254);
            _SafeStr_2261.update();
            _SafeStr_2269.caption = _controller.localizationManager.getLocalization("groupforum.view.all_threads");
            if (_SafeStr_2235.canPostThread)
            {
                _postButton.enable();
                setStatusTextError("post_thread", null);
            }
            else
            {
                _postButton.disable();
                setStatusTextError("post_thread", _SafeStr_2235.postThreadPermissionError);
            };
            var _local_4:IRegionWindow = GroupForumView.initTopAreaForForum(_window, _SafeStr_2235);
            _local_4.removeEventListener("WME_CLICK", onTopAreaClick);
            _local_4.addEventListener("WME_CLICK", onTopAreaClick);
            _local_4.enable();
            initCommonControls();
        }

        public function updateThread(_arg_1:ThreadData):void
        {
            if (_SafeStr_2261 != null)
            {
                _SafeStr_2261.updateElement(_arg_1);
            };
        }

        public function updateMessage(_arg_1:MessageData):void
        {
            if (_SafeStr_2262 != null)
            {
                _SafeStr_2262.updateElement(_arg_1);
            };
        }

        public function openMessagesList(_arg_1:ForumsListData, _arg_2:ExtendedForumData, _arg_3:ThreadsListData, _arg_4:MessagesListData):void
        {
            resetWindow();
            _SafeStr_2253 = _arg_1;
            _SafeStr_2235 = _arg_2;
            _SafeStr_2254 = _arg_3;
            _SafeStr_2255 = _arg_4;
            var _local_7:int = _arg_4.threadId;
            var _local_5:ThreadData = _SafeStr_2254.threadsById[_local_7];
            _SafeStr_2272 = calculateNumOfPagesAvailable(_arg_4.totalMessages);
            var _local_8:int = _arg_4.startIndex;
            _SafeStr_2271 = Math.ceil((_local_8 / 20));
            _SafeStr_2269.caption = _local_5.header;
            _SafeStr_2262 = new MessageListView(this, _SafeStr_2263, _SafeStr_2235, _local_5, _arg_4);
            _SafeStr_2262.update();
            if (((_controller.getGoToMessageIndex() > 0) && (_controller.getGoToThreadId() == _local_7)))
            {
                _SafeStr_2262.scrollToSpecificElement(_controller.getGoToMessageIndex(), true);
                _controller.resetGoTo();
            };
            if (_SafeStr_2235.canPostMessage)
            {
                if (((_SafeStr_2235.canModerate) || (!(_local_5.isLocked))))
                {
                    _postButton.enable();
                    setStatusTextError("post_message", null);
                }
                else
                {
                    _postButton.disable();
                    setStatusTextError("post_in_locked", _SafeStr_2235.moderatePermissionError);
                };
            }
            else
            {
                _postButton.disable();
                setStatusTextError("post_message", _SafeStr_2235.postMessagePermissionError);
            };
            var _local_6:IRegionWindow = GroupForumView.initTopAreaForForum(_window, _SafeStr_2235);
            _local_6.removeEventListener("WME_CLICK", onTopAreaClick);
            _local_6.addEventListener("WME_CLICK", onTopAreaClick);
            _local_6.enable();
            initCommonControls();
        }

        public function get controller():GroupForumController
        {
            return (_controller);
        }

        private function calculateNumOfPagesAvailable(_arg_1:int):int
        {
            return (Math.ceil((_arg_1 / _SafeStr_2273)));
        }

        private function getPreviousPageData():void
        {
            var _local_1:int = (_SafeStr_2271 - 1);
            if (_local_1 >= 0)
            {
                requestNewPageData(_local_1);
            };
        }

        private function getNextPageData():void
        {
            var _local_1:int = (_SafeStr_2271 + 1);
            if (_local_1 <= _SafeStr_2272)
            {
                requestNewPageData(_local_1);
            };
        }

        private function getFirstPageData():void
        {
            if (_SafeStr_2271 == 0)
            {
                return;
            };
            requestNewPageData(0);
        }

        private function getLastPageData():void
        {
            if (_SafeStr_2271 >= _SafeStr_2272)
            {
                return;
            };
            requestNewPageData((_SafeStr_2272 - 1));
        }

        private function requestNewPageData(_arg_1:int):void
        {
            var _local_2:int = (_arg_1 * _SafeStr_2273);
            if (_SafeStr_2260 != null)
            {
                _controller.openForumsList(_SafeStr_2253.listCode, _local_2);
            }
            else
            {
                if (_SafeStr_2261 != null)
                {
                    _controller.requestThreadList(_SafeStr_2235.groupId, _local_2);
                }
                else
                {
                    if (_SafeStr_2262 != null)
                    {
                        _controller.requestThreadMessageList(_SafeStr_2235.groupId, _SafeStr_2255.threadId, _local_2);
                    };
                };
            };
            _SafeStr_2271 = _arg_1;
        }

        public function getAsDaysHoursMinutes(_arg_1:int):String
        {
            return (FriendlyTime.getFriendlyTime(_controller.localizationManager, _arg_1, ".ago", 1));
        }

        private function onResized(_arg_1:WindowEvent=null):void
        {
            if (_SafeStr_2260 != null)
            {
                _SafeStr_2260.updateItemWidths();
            };
            if (_SafeStr_2261 != null)
            {
                _SafeStr_2261.updateItemWidths();
            };
            if (_SafeStr_2262 != null)
            {
                _SafeStr_2262.updateItemSizes();
            };
        }

        private function onClickButton(_arg_1:WindowMouseEvent):void
        {
            switch (_arg_1.target.name)
            {
                case "back_button":
                    if (_SafeStr_2262 != null)
                    {
                        _controller.requestThreadList(_SafeStr_2235.groupId, _SafeStr_2254.startIndex);
                    }
                    else
                    {
                        if (_SafeStr_2261 != null)
                        {
                            _controller.markForumAsRead(true);
                            if (_SafeStr_2253 != null)
                            {
                                _controller.openForumsList(_SafeStr_2253.listCode, _SafeStr_2253.startIndex);
                            }
                            else
                            {
                                dispose();
                            };
                        }
                        else
                        {
                            if (_SafeStr_2260 != null)
                            {
                                _controller.markForumsAsRead();
                                dispose();
                            };
                        };
                    };
                    return;
                case "show_previous":
                    getPreviousPageData();
                    return;
                case "show_next":
                    getNextPageData();
                    return;
                case "show_last":
                    getLastPageData();
                    return;
                case "show_first":
                    getFirstPageData();
                    return;
                case "header_button_close":
                    _window.visible = false;
                    dispose();
                    return;
                case "post_button":
                    openComposeMessageView(((_SafeStr_2255 != null) ? _SafeStr_2254.threadsById[_SafeStr_2255.threadId] : null));
                    return;
            };
        }

        public function openComposeMessageView(_arg_1:ThreadData, _arg_2:MessageData=null):void
        {
            if (_controller.composeMessageView != null)
            {
                _controller.composeMessageView.focus(_SafeStr_2235, _arg_1, _arg_2);
            }
            else
            {
                _controller.composeMessageView = new ComposeMessageView(this, (_window.x + _window.width), _window.y, _SafeStr_2235, _arg_1, _arg_2);
            };
        }

        public function openForumSettingsView():void
        {
            if (_controller.forumSettingsView != null)
            {
                _controller.forumSettingsView.focus(_SafeStr_2235);
            }
            else
            {
                _controller.forumSettingsView = new ForumSettingsView(this, (_window.x + _window.width), _window.y, _SafeStr_2235);
            };
        }

        public function updateUnreadForumsCount(_arg_1:int):void
        {
            if (_arg_1 > 0)
            {
                _SafeStr_2270.htmlText = _controller.localizationManager.getLocalizationWithParams("groupforum.view.shortcuts.my.unread", "", "unread_count", _arg_1);
            }
            else
            {
                _SafeStr_2270.htmlText = _controller.localizationManager.getLocalization("groupforum.view.shortcuts.my", "");
            };
        }


    }
}

