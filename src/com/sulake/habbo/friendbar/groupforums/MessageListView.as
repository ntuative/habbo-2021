package com.sulake.habbo.friendbar.groupforums
{
    import com.sulake.core.window.components.IScrollableListWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.communication.messages.parser.groupforums.ExtendedForumData;
    import com.sulake.habbo.communication.messages.parser.groupforums.ThreadData;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.habbo.communication.messages.parser.groupforums.MessageData;
    import com.sulake.habbo.window.widgets.IAvatarImageWidget;
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class MessageListView 
    {

        private static const UNREAD_MESSAGE_STATUS:int = -1;
        private static const _SafeStr_2274:int = 20;
        public static const LINE_PATTERN:RegExp = new RegExp("\\\\?(?:(?:\\*([^*]+)\\*)|(?:_([^_]+)_)|(?:@\\S+))");
        public static const _SafeStr_631:RegExp = new RegExp("^>(?: ?|$)");
        private static const QUOTE_BG_COLOR:uint = 4291611852;

        private var _SafeStr_1284:GroupForumController;
        private var _SafeStr_461:GroupForumView;
        private var _SafeStr_853:IScrollableListWindow;
        private var _SafeStr_2247:IWindowContainer;
        private var _SafeStr_2235:ExtendedForumData;
        private var _SafeStr_2236:ThreadData;
        private var _SafeStr_2255:MessagesListData;
        private var _SafeStr_2275:Boolean = true;

        public function MessageListView(_arg_1:GroupForumView, _arg_2:IScrollableListWindow, _arg_3:ExtendedForumData, _arg_4:ThreadData, _arg_5:MessagesListData)
        {
            _SafeStr_461 = _arg_1;
            _SafeStr_1284 = _SafeStr_461.controller;
            _SafeStr_853 = _arg_2;
            _SafeStr_2247 = (_SafeStr_1284.windowManager.buildFromXML(XML(new HabboFriendBarCom.groupforum_message_list_item_xml())) as IWindowContainer);
            _SafeStr_2235 = _arg_3;
            _SafeStr_2236 = _arg_4;
            _SafeStr_2255 = _arg_5;
        }

        private static function getMessageColor(_arg_1:int):Array
        {
            switch (_arg_1)
            {
                case 10:
                    return ([4293519840, 4292335567]);
                case 20:
                    return ([0xFFFFC6BA, 0xFFFFDFD2]);
                case -1:
                    return ([0xFFFFF4D9, 4291227641]);
                case 0:
                case 1:
                default:
                    return ([0xFFFFFFFF, 4291227641]);
            };
        }

        private static function initMessageText(_arg_1:ITextWindow, _arg_2:String):void
        {
            var _local_8:int;
            var _local_5:*;
            var _local_3:IWindowContainer = IWindowContainer(_arg_1.parent);
            _local_3.removeChild(_arg_1);
            var _local_9:Array = _arg_2.split("\r");
            var _local_4:StringBuffer = new StringBuffer();
            var _local_7:int;
            for each (var _local_6:String in _local_9)
            {
                _local_8 = 0;
                _local_5 = _SafeStr_631.exec(_local_6);
                if (_local_5 != null)
                {
                    _local_8 = 1;
                    _local_6 = _local_6.substr(_local_5[0].length);
                };
                if (_local_8 != _local_7)
                {
                    addTextBlock(_local_3, _arg_1, _local_4, _local_7);
                    _local_7 = _local_8;
                }
                else
                {
                    if (_local_4.length > 0)
                    {
                        _local_4.add("\r");
                    };
                };
                parseMessageChunk(_local_4, _local_6);
            };
            addTextBlock(_local_3, _arg_1, _local_4, _local_7);
        }

        private static function parseMessageChunk(_arg_1:StringBuffer, _arg_2:String):void
        {
            var _local_3:*;
            var _local_5:Number;
            var _local_4:String;
            _loop_1:
            while (true)
            {
                _local_3 = LINE_PATTERN.exec(_arg_2);
                if (!_local_3) break;
                if (_local_3.index > 0)
                {
                    _arg_1.addEscaped(_arg_2.substr(0, _local_3.index));
                };
                _local_5 = _local_3[0].length;
                switch (_arg_2.charAt(_local_3.index))
                {
                    case "*":
                        _arg_1.add(" <b>");
                        parseMessageChunk(_arg_1, _arg_2.substr((_local_3.index + 1), (_local_5 - 2)));
                        _arg_1.add("</b> ");
                        break;
                    case "_":
                        _arg_1.add(" <i>");
                        parseMessageChunk(_arg_1, _arg_2.substr((_local_3.index + 1), (_local_5 - 2)));
                        _arg_1.add("</i> ");
                        break;
                    case "@":
                        if (((_local_3.index == 0) || ((_local_3.index > 0) && (_arg_2.substr((_local_3.index - 1), 1) == " "))))
                        {
                            _local_4 = _arg_2.substr((_local_3.index + 1), (_local_5 - 1));
                            _arg_1.add("<u>").addEscaped(_local_4).add("</u>");
                            break;
                        };
                        _arg_1.add("@");
                    default:
                        _arg_1.add(_arg_2.charAt((_local_3.index + 1)));
                        _arg_2 = _arg_2.substr((_local_3.index + 2));
                        continue _loop_1;
                };
                _arg_2 = _arg_2.substr((_local_3.index + _local_5));
            };
            _arg_1.addEscaped(_arg_2);
        }

        private static function addTextBlock(_arg_1:IWindowContainer, _arg_2:ITextWindow, _arg_3:StringBuffer, _arg_4:int):void
        {
            var _local_6:String = _arg_3.toString();
            var _local_5:ITextWindow = ITextWindow(_arg_2.clone());
            _arg_1.addChild(_local_5);
            _local_5.htmlText = _local_6;
            if (_arg_4 > 0)
            {
                _local_5.x = (_local_5.x + (_arg_4 * 20));
                _local_5.width = (_local_5.width - ((_arg_4 + 1) * 20));
                _local_5.color = 4291611852;
                _local_5.background = true;
            };
            _arg_3.reset();
        }


        public function update():void
        {
            var _local_3:Boolean;
            if (_SafeStr_853.numListItems > 0)
            {
                _SafeStr_853.destroyListItems();
            };
            _SafeStr_853.invalidate();
            var _local_2:int = _SafeStr_1284.getThreadLastReadMessageIndex(_SafeStr_2255.threadId);
            _SafeStr_2275 = true;
            _SafeStr_853.autoArrangeItems = false;
            for each (var _local_1:MessageData in _SafeStr_2255.messages)
            {
                _local_3 = (_local_1.messageIndex > _local_2);
                _SafeStr_853.addListItem(createListItem(_local_1, _local_3));
            };
            _SafeStr_2275 = false;
            updateItemSizes();
        }

        public function updateItemSizes():void
        {
            if (_SafeStr_2275)
            {
                return;
            };
            var _local_1:Number = _SafeStr_853.scrollableWindow.width;
            updateItemSizesInternal();
            if (_SafeStr_853.scrollableWindow.width != _local_1)
            {
                updateItemSizesInternal();
            };
        }

        private function updateItemSizesInternal():void
        {
            var _local_5:int;
            var _local_1:IWindowContainer;
            var _local_3:IWindowContainer;
            var _local_4:IWindowContainer;
            var _local_7:int;
            var _local_6:int;
            var _local_2:ITextWindow;
            _SafeStr_853.autoArrangeItems = false;
            _local_5 = 0;
            while (_local_5 < _SafeStr_853.numListItems)
            {
                _local_1 = IWindowContainer(_SafeStr_853.getListItemAt(_local_5));
                _local_3 = (_local_1.findChildByName("texts_container") as IWindowContainer);
                _local_4 = IWindowContainer(_local_1.findChildByName("message_text_container"));
                _local_1.width = (_SafeStr_853.scrollableWindow.width - 2);
                _local_7 = 2;
                _local_6 = 0;
                while (_local_6 < _local_4.numChildren)
                {
                    _local_2 = ITextWindow(_local_4.getChildAt(_local_6));
                    _local_2.y = _local_7;
                    _local_7 = _local_2.bottom;
                    _local_6++;
                };
                _local_4.height = _local_7;
                _local_1.height = (_local_3.height + _local_4.bottom);
                _local_5++;
            };
            _SafeStr_853.autoArrangeItems = true;
        }

        private function createListItem(_arg_1:MessageData, _arg_2:Boolean=false):IWindowContainer
        {
            var _local_4:IWindowContainer = (_SafeStr_2247.clone() as IWindowContainer);
            _local_4.name = ("message_" + _arg_1.messageId);
            var _local_11:int = _arg_1.state;
            var _local_8:Boolean = _SafeStr_2235.canModerate;
            var _local_6:Boolean = _SafeStr_2235.isStaff;
            var _local_9:IWindowContainer = (_local_4.findChildByName("texts_container") as IWindowContainer);
            _local_9.id = _arg_1.messageId;
            _local_9.findChildByName("date").caption = _SafeStr_461.getAsDaysHoursMinutes(_arg_1.creationTimeAsSecondsAgo);
            _local_9.findChildByName("reply_num").caption = ("#" + (_arg_1.messageIndex + 1));
            var _local_5:ITextWindow = (_local_4.findChildByName("message_text") as ITextWindow);
            if (_arg_2)
            {
                _local_11 = -1;
            };
            if (((_local_11 == 20) && (!(_local_6))))
            {
                _local_5.text = getModerationMessage(_arg_1);
            }
            else
            {
                if (((_local_11 > 1) && (!(_local_8))))
                {
                    _local_5.text = getModerationMessage(_arg_1);
                }
                else
                {
                    initMessageText(_local_5, _arg_1.messageText);
                };
            };
            var _local_3:IWindowContainer = (_local_4.findChildByName("msg_container") as IWindowContainer);
            var _local_12:Array = getMessageColor(_local_11);
            _local_3.color = _local_12[0];
            var _local_10:IWindowContainer = (_local_4.findChildByName("avatar_image") as IWindowContainer);
            var _local_7:Array = getMessageColor(_local_11);
            _local_10.color = _local_7[1];
            _local_10.id = _arg_1.authorId;
            _local_10.removeEventListener("WME_CLICK", onSelectAuthor);
            _local_10.addEventListener("WME_CLICK", onSelectAuthor);
            IAvatarImageWidget(IWidgetWindow(_local_10.findChildByName("avatar_widget")).widget).figure = _arg_1.authorFigure;
            _local_10.findChildByName("author").caption = _arg_1.authorName;
            _local_10.findChildByName("author_post_count").caption = ((_arg_1.authorPostCount + " ") + _SafeStr_1284.localizationManager.getLocalization("messageboard.messages", "posts"));
            handleButtonVisibility(_local_4, _arg_1, _local_11);
            return (_local_4);
        }

        public function updateElement(_arg_1:MessageData):void
        {
            var _local_3:int = _arg_1.messageId;
            var _local_2:IWindowContainer = (_SafeStr_853.getListItemByName(("message_" + _local_3)) as IWindowContainer);
            if (_local_2 == null)
            {
                return;
            };
            var _local_4:int = _SafeStr_853.getListItemIndex(_local_2);
            _SafeStr_2275 = true;
            _SafeStr_853.autoArrangeItems = false;
            _SafeStr_853.removeListItemAt(_local_4);
            _SafeStr_853.addListItemAt(createListItem(_arg_1), _local_4);
            _SafeStr_2275 = false;
            updateItemSizes();
        }

        private function handleButtonVisibility(_arg_1:IWindowContainer, _arg_2:MessageData, _arg_3:int):void
        {
            var _local_9:IRegionWindow;
            var _local_8:IStaticBitmapWrapperWindow;
            var _local_7:Boolean = _SafeStr_2235.canModerate;
            var _local_6:Boolean = _SafeStr_2235.isStaff;
            var _local_4:Boolean = _SafeStr_2235.canReport;
            var _local_5:Boolean = _SafeStr_2235.canPostMessage;
            _local_9 = (_arg_1.findChildByName("delete_message") as IRegionWindow);
            _local_9.removeEventListener("WME_CLICK", onDelete);
            _local_9.removeEventListener("WME_CLICK", onUndelete);
            if (_local_7)
            {
                _local_9.id = _arg_2.messageId;
                _local_8 = (_local_9.getChildByName("icon") as IStaticBitmapWrapperWindow);
                switch (_arg_3)
                {
                    case 10:
                        _local_9.addEventListener("WME_CLICK", onUndelete);
                        _local_8.assetUri = "forum_forum_unhide";
                        break;
                    case 20:
                        if (_local_6)
                        {
                            _local_9.addEventListener("WME_CLICK", onUndelete);
                            _local_8.assetUri = "forum_forum_unhide";
                        }
                        else
                        {
                            _local_9.visible = false;
                        };
                        break;
                    case 0:
                    case 1:
                    default:
                        _local_9.addEventListener("WME_CLICK", onDelete);
                        _local_8.assetUri = "forum_forum_hide";
                };
            }
            else
            {
                _local_9.visible = false;
            };
            _local_9 = (_arg_1.findChildByName("report_message") as IRegionWindow);
            if (_local_4)
            {
                _local_9.id = _arg_2.messageId;
                _local_9.removeEventListener("WME_CLICK", onReport);
                _local_9.addEventListener("WME_CLICK", onReport);
            }
            else
            {
                _local_9.visible = false;
            };
            _local_9 = (_arg_1.findChildByName("reply_message") as IRegionWindow);
            if (_local_5)
            {
                _local_9.id = _arg_2.messageId;
                _local_9.removeEventListener("WME_CLICK", onReply);
                _local_9.addEventListener("WME_CLICK", onReply);
            }
            else
            {
                _local_9.visible = false;
            };
        }

        private function getModerationMessage(_arg_1:MessageData):String
        {
            switch (_arg_1.state)
            {
                case 10:
                    return (_SafeStr_1284.localizationManager.getLocalizationWithParams("groupforum.view.message_hidden_by_admin", "", "admin_name", _arg_1.adminName));
                case 20:
                    return (_SafeStr_1284.localizationManager.getLocalizationWithParams("groupforum.view.message_hidden_by_staff", "", "admin_name", _arg_1.adminName));
                default:
                    return (null);
            };
        }

        public function scrollToSpecificElement(_arg_1:int, _arg_2:Boolean=false):void
        {
            var _local_3:IWindowContainer;
            if (!_arg_2)
            {
                _local_3 = (_SafeStr_853.getListItemByName(("message_" + _arg_1)) as IWindowContainer);
            }
            else
            {
                _local_3 = (_SafeStr_853.getListItemAt((_arg_1 - 1)) as IWindowContainer);
            };
            if (_local_3 != null)
            {
                _SafeStr_853.scrollV = (_local_3.bottom / _SafeStr_853.maxScrollV);
            };
        }

        private function onReport(_arg_1:WindowMouseEvent):void
        {
            _SafeStr_1284.reportMessage(_SafeStr_2235, _SafeStr_2236.threadId, _arg_1.target.id);
        }

        private function onUndelete(_arg_1:WindowMouseEvent):void
        {
            _SafeStr_1284.unDeleteMessage(_SafeStr_2235, _SafeStr_2236.threadId, _arg_1.target.id);
        }

        private function onDelete(_arg_1:WindowMouseEvent):void
        {
            _SafeStr_1284.deleteMessage(_SafeStr_2235, _SafeStr_2236.threadId, _arg_1.target.id);
        }

        private function onSelectAuthor(_arg_1:WindowMouseEvent):void
        {
            _SafeStr_1284.getUserInfo(_arg_1.target.id);
        }

        private function onReply(_arg_1:WindowMouseEvent):void
        {
            var _local_2:int = _arg_1.target.id;
            var _local_3:MessageData = _SafeStr_2255.messagesById[_local_2];
            if (_local_3 == null)
            {
                return;
            };
            _SafeStr_461.openComposeMessageView(_SafeStr_2236, _local_3);
        }


    }
}

