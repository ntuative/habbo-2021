package com.sulake.habbo.moderation
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemListWindow;
    import flash.utils.Dictionary;
    import flash.utils.Timer;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.communication.messages.parser.moderation.IssueMessageData;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.habbo.communication.messages.incoming.moderation.ChatRecordData;
    import com.sulake.habbo.communication.messages.incoming.moderation.ChatlineData;
    import com.sulake.core.window.components._SafeStr_101;
    import com.sulake.habbo.utils.StringUtil;
    import com.sulake.core.window.components.ITextWindow;
    import flash.text.TextFormat;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import flash.events.TimerEvent;

    public class ChatlogCtrl implements IDisposable, ITrackedWindow, IChatLogListener 
    {

        private static const CHAT_REPORTED_USER_COLOUR:uint = 4293973667;
        private static const CHAT_REPORTEE_COLOUR:uint = 4288921072;

        private static var CHAT_LINE_POOL:Array = [];
        private static var CHAT_LINE_POOL_MAX_SIZE:int = 1000;

        private var _SafeStr_741:int;
        private var _SafeStr_698:int;
        private var _msg:IMessageComposer;
        private var _main:ModerationManager;
        private var _frame:IWindowContainer;
        private var _SafeStr_853:IItemListWindow;
        private var _rooms:Array;
        private var _embedded:Boolean;
        private var _disposed:Boolean;
        private var _SafeStr_2819:IWindowContainer;
        private var _SafeStr_2820:IWindowContainer;
        private var _hilitedUserIds:Dictionary;
        private var _SafeStr_2821:Timer;
        private var _SafeStr_2822:Map;
        private var _SafeStr_2823:IssueMessageData;
        private var _SafeStr_2824:Array = [];
        private var _headers:Array = [];

        public function ChatlogCtrl(_arg_1:IMessageComposer, _arg_2:ModerationManager, _arg_3:int, _arg_4:int, _arg_5:IssueMessageData=null, _arg_6:IWindowContainer=null, _arg_7:IItemListWindow=null, _arg_8:Boolean=false)
        {
            _main = _arg_2;
            _SafeStr_741 = _arg_3;
            _SafeStr_698 = _arg_4;
            _msg = _arg_1;
            _SafeStr_2822 = new Map();
            _SafeStr_2823 = _arg_5;
            _frame = _arg_6;
            _SafeStr_853 = _arg_7;
            _embedded = _arg_8;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function show():void
        {
            var _local_2:IWindow;
            var _local_1:IFrameWindow = IFrameWindow(_main.getXmlWindow("evidence_frame"));
            _local_1.visible = false;
            var _local_3:IItemListWindow = IItemListWindow(_local_1.findChildByName("evidence_list"));
            _SafeStr_2820 = (_local_3.getListItemAt(0) as IWindowContainer);
            _SafeStr_2819 = (_local_3.getListItemAt(1) as IWindowContainer);
            _local_3.removeListItems();
            _SafeStr_2821 = new Timer(1000, 1);
            _SafeStr_2821.addEventListener("timer", onResizeTimer);
            if (!_embedded)
            {
                _frame = _local_1;
                _frame.procedure = onWindow;
                _frame.visible = true;
                _local_2 = _frame.findChildByTag("close");
                _local_2.procedure = onClose;
                _SafeStr_853 = _local_3;
            }
            else
            {
                _local_1.dispose();
            };
            _main.connection.send(_msg);
            _main.messageHandler.addChatlogListener(this);
        }

        public function hide():void
        {
            dispose();
        }

        public function onChatlog(_arg_1:String, _arg_2:int, _arg_3:int, _arg_4:Array, _arg_5:Dictionary):void
        {
            var _local_6:IWindowContainer;
            if ((((!(_arg_2 == _SafeStr_741)) || (!(_arg_3 == _SafeStr_698))) || (_disposed)))
            {
                return;
            };
            for each (_local_6 in _SafeStr_2824)
            {
                recycleContentLine(_local_6);
            };
            for each (_local_6 in _headers)
            {
                _local_6.dispose();
            };
            _SafeStr_2824 = [];
            _headers = [];
            _main.messageHandler.removeChatlogListener(this);
            _rooms = _arg_4;
            _hilitedUserIds = _arg_5;
            populate();
            onResizeTimer(null);
            if (!_embedded)
            {
                _frame.caption = _arg_1;
                _frame.visible = true;
            };
        }

        public function getType():int
        {
            return (_SafeStr_741);
        }

        public function getId():String
        {
            return ("" + _SafeStr_698);
        }

        public function setId(_arg_1:int):void
        {
            _SafeStr_698 = _arg_1;
        }

        public function getFrame():IFrameWindow
        {
            return (_frame as IFrameWindow);
        }

        private function populate():void
        {
            var _local_1:ChatRecordData;
            _SafeStr_853.autoArrangeItems = false;
            _SafeStr_853.removeListItems();
            for each (_local_1 in _rooms)
            {
                populateEvidence(_local_1);
            };
            _SafeStr_853.autoArrangeItems = true;
        }

        private function populateEvidence(_arg_1:ChatRecordData):void
        {
            var _local_10:String;
            var _local_7:int;
            var _local_8:ChatlineData;
            var _local_6:IWindowContainer = createHeaderLine();
            var _local_9:IWindow = _local_6.findChildByName("text");
            var _local_2:_SafeStr_101 = _SafeStr_101(_local_6.findChildByName("btnHeaderAction"));
            var _local_3:_SafeStr_101 = _SafeStr_101(_local_6.findChildByName("btnHeaderAction2"));
            if (_local_3)
            {
                _local_3.visible = false;
            };
            switch (_arg_1.recordType)
            {
                case 1:
                    if (_arg_1.roomId > 0)
                    {
                        _local_2.caption = "Room tool";
                        if (_arg_1.roomName == null)
                        {
                            _local_9.caption = ("Room #" + _arg_1.roomId);
                        }
                        else
                        {
                            _local_9.caption = ("Room: " + _arg_1.roomName);
                        };
                        _local_3.visible = true;
                        _local_3.caption = "View room";
                        new OpenRoomInSpectatorMode(_main, _local_3, _arg_1.roomId);
                        if (_embedded)
                        {
                            new OpenRoomTool(null, _main, _local_2, _arg_1.roomId);
                        }
                        else
                        {
                            new OpenRoomTool((_frame as IFrameWindow), _main, _local_2, _arg_1.roomId);
                        };
                    };
                    break;
                case 2:
                    _local_9.caption = "IM session";
                    break;
                case 3:
                    _local_9.caption = "Forum thread";
                    _local_3.visible = true;
                    _local_3.caption = "Open thread";
                    new OpenDiscussionThread(_main, _local_3, _arg_1.groupId, _arg_1.threadId);
                    _local_2.caption = "Delete";
                    new HideDiscussionThread(_main, this, _local_2, _arg_1.groupId, _arg_1.threadId);
                    break;
                case 4:
                    _local_9.caption = "Forum message";
                    _local_3.visible = true;
                    _local_3.caption = "Open Message";
                    new OpenDiscussionMessage(_main, _local_3, _arg_1.groupId, _arg_1.threadId, _arg_1.context.messageIndex);
                    _local_2.caption = "Delete";
                    new HideDiscussionMessage(_main, this, _local_2, _arg_1.groupId, _arg_1.threadId, _arg_1.messageId);
                    break;
                case 5:
                    _local_9.caption = "Selfie report";
                    _local_3.visible = true;
                    _local_3.caption = "View selfie";
                    new OpenExternalLink(_main, _local_3, _arg_1.context.url);
                    _local_2.visible = true;
                    _local_2.caption = "Room tool";
                    if (_embedded)
                    {
                        new OpenRoomTool(null, _main, _local_2, _arg_1.roomId);
                    }
                    else
                    {
                        new OpenRoomTool((_frame as IFrameWindow), _main, _local_2, _arg_1.roomId);
                    };
                    break;
                case 6:
                    _local_9.caption = "Photo report";
                    _local_3.visible = true;
                    _local_3.caption = "Moderate photo";
                    _local_10 = _main.getProperty("stories.admin.tool.base.url");
                    if (StringUtil.isEmpty(_local_10))
                    {
                        _local_10 = "https://theallseeingeye.sulake.com/habbo-stories-admin/#/photos/";
                    };
                    _local_10 = (_local_10 + _arg_1.context.extraDataId);
                    new OpenExternalLink(_main, _local_3, _local_10);
                    _local_2.visible = true;
                    _local_2.caption = "Room tool";
                    if (_embedded)
                    {
                        new OpenRoomTool(null, _main, _local_2, _arg_1.roomId);
                    }
                    else
                    {
                        new OpenRoomTool((_frame as IFrameWindow), _main, _local_2, _arg_1.roomId);
                    };
                default:
            };
            addHeaderLineToList(_local_6);
            var _local_4:Boolean = true;
            var _local_5:int = -1;
            _local_7 = 0;
            while (_local_7 < _arg_1.chatlog.length)
            {
                _local_8 = _arg_1.chatlog[_local_7];
                populateContentLine(_local_8, _local_4);
                _local_4 = (!(_local_4));
                if (((_local_8.hasHighlighting) && (_local_5 == -1)))
                {
                    _local_5 = _local_7;
                };
                _local_7++;
            };
            if (_local_5 > -1)
            {
                _SafeStr_853.autoArrangeItems = true;
                if (_SafeStr_853.maxScrollV > 0)
                {
                    _SafeStr_853.scrollV = (_SafeStr_853.getListItemAt(_local_5).y / _SafeStr_853.maxScrollV);
                };
            };
        }

        private function addContentLineToList(_arg_1:IWindowContainer):void
        {
            _SafeStr_853.addListItem(_arg_1);
            _SafeStr_2824.push(_arg_1);
        }

        private function addHeaderLineToList(_arg_1:IWindowContainer):void
        {
            _SafeStr_853.addListItem(_arg_1);
            _headers.push(_arg_1);
        }

        private function createContentLine():IWindowContainer
        {
            if (CHAT_LINE_POOL.length > 0)
            {
                return (CHAT_LINE_POOL.pop() as IWindowContainer);
            };
            return (IWindowContainer(_SafeStr_2819.clone()));
        }

        private function recycleContentLine(_arg_1:IWindowContainer):void
        {
            var _local_2:ITextWindow;
            if (CHAT_LINE_POOL.length < CHAT_LINE_POOL_MAX_SIZE)
            {
                _local_2 = ITextWindow(_arg_1.findChildByName("chatter_txt"));
                _local_2.removeEventListener("WME_CLICK", onUserClick);
                _arg_1.width = _SafeStr_2819.width;
                _arg_1.height = (_SafeStr_2819.height - 10);
                CHAT_LINE_POOL.push(_arg_1);
            }
            else
            {
                _arg_1.dispose();
            };
        }

        private function createHeaderLine():IWindowContainer
        {
            return (_SafeStr_2820.clone() as IWindowContainer);
        }

        private function populateContentLine(_arg_1:ChatlineData, _arg_2:Boolean):void
        {
            var _local_5:TextFormat;
            var _local_7:IWindowContainer = createContentLine();
            var _local_8:IWindow = _local_7.findChildByName("time_txt");
            var _local_4:ITextWindow = ITextWindow(_local_7.findChildByName("chatter_txt"));
            var _local_6:ITextWindow = (_local_7.findChildByName("msg_txt") as ITextWindow);
            _local_8.caption = _arg_1.timeStamp;
            var _local_9:* = _hilitedUserIds[_arg_1.chatterId];
            if (_local_9 != null)
            {
                _local_7.color = (((_local_9 as int) == 0) ? 4293973667 : 4288921072);
            }
            else
            {
                _local_7.color = ((_arg_2) ? 4291030266 : 0xFFFFFFFF);
            };
            if (_arg_1.hasHighlighting)
            {
                _local_5 = _local_6.getTextFormat();
                _local_5.bold = true;
                _local_6.setTextFormat(_local_5);
                _local_6.bold = true;
            };
            if (_arg_1.chatterId > 0)
            {
                _local_4.text = _arg_1.chatterName;
                _local_4.underline = true;
                _local_4.addEventListener("WME_CLICK", onUserClick);
                if (!_SafeStr_2822.getValue(_arg_1.chatterName))
                {
                    _SafeStr_2822.add(_arg_1.chatterName, _arg_1.chatterId);
                };
            }
            else
            {
                if (_arg_1.chatterId == 0)
                {
                    _local_4.text = "Bot / pet";
                    _local_4.underline = false;
                }
                else
                {
                    _local_4.text = "-";
                    _local_4.underline = false;
                };
            };
            _local_4.color = _local_7.color;
            _local_8.color = _local_7.color;
            _local_6.color = _local_7.color;
            _local_6.text = _arg_1.msg;
            var _local_3:int = Math.max(_local_8.height, (_local_6.textHeight + 5));
            _local_6.height = _local_3;
            if (_local_6.getTextFormat())
            {
                _local_6.getTextFormat().align = "left";
                _local_6.getTextFormat().rightMargin = (_local_6.getTextFormat().rightMargin + 10);
            };
            _local_4.height = _local_3;
            _local_8.height = _local_3;
            _local_7.height = _local_3;
            addContentLineToList(_local_7);
        }

        private function onUserClick(_arg_1:WindowMouseEvent):void
        {
            var _local_2:String = _arg_1.target.caption;
            var _local_3:int = _SafeStr_2822.getValue(_local_2);
            _main.windowTracker.show(new UserInfoFrameCtrl(_main, _local_3, _SafeStr_2823), (_frame as IFrameWindow), false, false, true);
        }

        private function onClose(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            dispose();
        }

        private function onWindow(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (((!(_arg_1.type == "WE_RESIZED")) || (!(_arg_2 == _frame))))
            {
                return;
            };
            _SafeStr_2821.reset();
            _SafeStr_2821.start();
        }

        private function onResizeTimer(_arg_1:TimerEvent):void
        {
            refreshListDims();
            var _local_2:Boolean = refreshScrollBarVisibility();
        }

        private function refreshListDims():void
        {
            var _local_4:IWindowContainer;
            var _local_2:ITextWindow;
            var _local_3:int;
            _SafeStr_853.autoArrangeItems = false;
            var _local_1:int = _SafeStr_853.numListItems;
            _local_3 = 0;
            while (_local_3 < _local_1)
            {
                _local_4 = IWindowContainer(_SafeStr_853.getListItemAt(_local_3));
                if (_local_4.name == "chatline")
                {
                    _local_2 = ITextWindow(_local_4.findChildByName("msg_txt"));
                    _local_2.width = (_local_4.width - _local_2.x);
                    _local_2.height = (_local_2.textHeight + 5);
                    _local_4.height = _local_2.height;
                };
                _local_3++;
            };
            _SafeStr_853.autoArrangeItems = true;
        }

        private function refreshScrollBarVisibility():Boolean
        {
            var _local_2:IWindowContainer = IWindowContainer(_SafeStr_853.parent);
            var _local_4:IWindow = (_local_2.getChildByName("scroller") as IWindow);
            var _local_3:Boolean = (_SafeStr_853.scrollableRegion.height > _SafeStr_853.height);
            var _local_1:int = 22;
            if (_local_4.visible)
            {
                if (_local_3)
                {
                    return (false);
                };
                _local_4.visible = false;
                _SafeStr_853.width = (_SafeStr_853.width + _local_1);
                return (true);
            };
            if (_local_3)
            {
                _local_4.visible = true;
                _SafeStr_853.width = (_SafeStr_853.width - _local_1);
                return (true);
            };
            return (false);
        }

        public function dispose():void
        {
            var _local_1:IWindowContainer;
            if (_disposed)
            {
                return;
            };
            _disposed = true;
            _main = null;
            _msg = null;
            _SafeStr_2823 = null;
            if (_SafeStr_853 != null)
            {
                _SafeStr_853.removeListItems();
                _SafeStr_853.dispose();
                _SafeStr_853 = null;
            };
            if (_frame != null)
            {
                _frame.destroy();
                _frame = null;
            };
            _rooms = null;
            _hilitedUserIds = null;
            if (_SafeStr_2821 != null)
            {
                _SafeStr_2821.stop();
                _SafeStr_2821.removeEventListener("timer", onResizeTimer);
                _SafeStr_2821 = null;
            };
            if (!_embedded)
            {
                for each (_local_1 in _SafeStr_2824)
                {
                    recycleContentLine(_local_1);
                };
                for each (_local_1 in _headers)
                {
                    _local_1.dispose();
                };
            };
            _SafeStr_2824 = [];
            _headers = [];
            if (_SafeStr_2819 != null)
            {
                _SafeStr_2819.dispose();
                _SafeStr_2819 = null;
            };
            if (_SafeStr_2820 != null)
            {
                _SafeStr_2820.dispose();
                _SafeStr_2820 = null;
            };
        }


    }
}

