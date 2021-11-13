package com.sulake.habbo.ui.widget.chatinput
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components._SafeStr_159;
    import com.sulake.core.window.components.IRegionWindow;
    import flash.text.TextFormat;
    import flash.utils.Timer;
    import com.sulake.habbo.ui.widget.chatinput.styleselector.ChatStyleSelector;
    import com.sulake.habbo.freeflowchat.style.IChatStyle;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.room.utils.RoomEnterEffect;
    import flash.geom.Rectangle;
    import flash.events.TimerEvent;
    import flash.geom.Point;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowKeyboardEvent;
    import flash.events.KeyboardEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetChatTypingMessage;
    import flash.display.Stage;
    import flash.display.InteractiveObject;
    import flash.display.DisplayObject;
    import flash.text.TextField;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.core.runtime.ICoreConfiguration;

    public class RoomChatInputView 
    {

        private static const MARGIN_H:int = 12;
        private static const CHAT_HELP_INTERNAL_CLIENT_LINK:String = "habbopages/chat/commands";

        private var _widget:RoomChatInputWidget;
        private var _window:IWindowContainer;
        private var _SafeStr_1584:ITextFieldWindow;
        private var _SafeStr_3974:IWindow;
        private var _SafeStr_3975:IWindow;
        private var _helpButton:_SafeStr_159;
        private var _helpButtonShowRegion:IRegionWindow;
        private var _mouseOverHelpButton:Boolean = false;
        private var _SafeStr_3976:IWindowContainer;
        private var _chatStyleMenuContainer:IWindowContainer;
        private var _chatModeIdShout:String;
        private var _SafeStr_3977:String;
        private var _SafeStr_3978:String;
        private var _SafeStr_3979:Boolean = false;
        private var _SafeStr_3980:TextFormat;
        private var _SafeStr_3981:Boolean = false;
        private var _SafeStr_3982:Boolean = false;
        private var _SafeStr_2670:Timer;
        private var _SafeStr_3971:Timer;
        private var _SafeStr_3973:Timer;
        private var _SafeStr_3983:String = "";
        private var _SafeStr_574:Timer;
        private var _SafeStr_3972:Boolean = false;
        private var _SafeStr_3984:Timer;
        private var _SafeStr_3985:int = 0;
        private var _SafeStr_3986:Timer;
        private var _SafeStr_3987:ChatStyleSelector;

        public function RoomChatInputView(_arg_1:RoomChatInputWidget)
        {
            super();
            var _local_3:ICoreConfiguration = null;
            var _local_2:int;
            _widget = _arg_1;
            _SafeStr_3977 = _arg_1.localizations.getLocalization("widgets.chatinput.mode.whisper", ":tell");
            _chatModeIdShout = _arg_1.localizations.getLocalization("widgets.chatinput.mode.shout", ":shout");
            _SafeStr_3978 = _arg_1.localizations.getLocalization("widgets.chatinput.mode.speak", ":speak");
            _SafeStr_2670 = new Timer(1000, 1);
            _SafeStr_2670.addEventListener("timerComplete", onTypingTimerComplete);
            _SafeStr_3971 = new Timer(10000, 1);
            _SafeStr_3971.addEventListener("timerComplete", onIdleTimerComplete);
            _SafeStr_3972 = ((sessionDataManager.isNoob) || (sessionDataManager.isRealNoob));
            if (_SafeStr_3972)
            {
                _local_3 = _arg_1.handler.container.config;
                if (_local_3.getProperty("nux.chat.reminder.shown") != "1")
                {
                    _local_2 = _local_3.getInteger("nux.noob.chat.reminder.delay", 240);
                    _SafeStr_3973 = new Timer((_local_2 * 1000), 1);
                    _SafeStr_3973.addEventListener("timerComplete", onNuxIdleTimerComplete);
                    _SafeStr_3973.start();
                };
            };
            _SafeStr_3980 = new TextFormat(null, null, 0x999999, null, true, false);
            createWindow();
        }

        public function get window():IWindowContainer
        {
            return (_window);
        }

        public function dispose():void
        {
            if (_SafeStr_3972)
            {
                widget.windowManager.hideHint();
                widget.windowManager.unregisterHintWindow("nux_chat_reminder");
            };
            _widget = null;
            if (_SafeStr_1584)
            {
                _SafeStr_1584.removeEventListener("WME_DOWN", windowMouseEventProcessor);
                _SafeStr_1584.removeEventListener("WKE_KEY_DOWN", windowKeyEventProcessor);
                _SafeStr_1584.removeEventListener("WKE_KEY_UP", keyUpHandler);
                _SafeStr_1584.removeEventListener("WE_CHANGE", onInputChanged);
                _SafeStr_1584.removeEventListener("WME_OVER", onInputHoverRegionMouseEvent);
                _SafeStr_1584.removeEventListener("WME_OUT", onInputHoverRegionMouseEvent);
                _SafeStr_1584 = null;
            };
            _SafeStr_3974 = null;
            _SafeStr_3975 = null;
            if (_helpButton)
            {
                _helpButton.removeEventListener("WME_CLICK", onHelpButtonMouseEvent);
                _helpButton.removeEventListener("WME_OVER", onHelpButtonMouseEvent);
                _helpButton.removeEventListener("WME_OUT", onHelpButtonMouseEvent);
                _helpButton = null;
            };
            if (_helpButtonShowRegion)
            {
                _helpButtonShowRegion.removeEventListener("WME_OVER", onInputHoverRegionMouseEvent);
                _helpButtonShowRegion.removeEventListener("WME_OUT", onInputHoverRegionMouseEvent);
                _helpButtonShowRegion = null;
            };
            if (_SafeStr_3976 != null)
            {
                _SafeStr_3976.dispose();
                _SafeStr_3976 = null;
            };
            if (_SafeStr_2670 != null)
            {
                _SafeStr_2670.reset();
                _SafeStr_2670.removeEventListener("timerComplete", onTypingTimerComplete);
                _SafeStr_2670 = null;
            };
            if (_SafeStr_3971 != null)
            {
                _SafeStr_3971.reset();
                _SafeStr_3971.removeEventListener("timerComplete", onIdleTimerComplete);
                _SafeStr_3971 = null;
            };
            if (_SafeStr_3973 != null)
            {
                _SafeStr_3973.reset();
                _SafeStr_3973.removeEventListener("timerComplete", onNuxIdleTimerComplete);
                _SafeStr_3973 = null;
            };
            if (_SafeStr_3984 != null)
            {
                _SafeStr_3984.reset();
                _SafeStr_3984.removeEventListener("timerComplete", onChatReminderTimer);
                _SafeStr_3984 = null;
            };
            if (_SafeStr_574)
            {
                _SafeStr_574.reset();
                _SafeStr_574.removeEventListener("timerComplete", onRemoveDimmer);
                _SafeStr_574 = null;
            };
            if (((_window) && (_window.desktop)))
            {
                _window.desktop.removeChild(_window);
            };
        }

        private function createWindow():void
        {
            var _local_1:Array;
            var _local_2:Array;
            var _local_3:Boolean;
            var _local_7:IChatStyle;
            if (_SafeStr_3976 != null)
            {
                return;
            };
            var _local_6:String = "chatinput_window_new";
            var _local_5:XmlAsset = (_widget.assets.getAssetByName(_local_6) as XmlAsset);
            if (((_local_5 == null) || (_local_5.content == null)))
            {
                return;
            };
            _window = (_widget.windowManager.buildFromXML((_local_5.content as XML)) as IWindowContainer);
            _window.width = _window.desktop.width;
            _window.height = _window.desktop.height;
            _window.invalidate();
            _chatStyleMenuContainer = IWindowContainer(_window.findChildByName("chatstyles_menu"));
            _SafeStr_3976 = (_window.findChildByName("bubblecont") as IWindowContainer);
            _SafeStr_3976.tags.push("room_widget_chatinput");
            _SafeStr_1584 = (_SafeStr_3976.findChildByName("chat_input") as ITextFieldWindow);
            _SafeStr_3974 = _SafeStr_3976.findChildByName("input_border");
            _SafeStr_3975 = _SafeStr_3976.findChildByName("block_text");
            _helpButtonShowRegion = IRegionWindow(_SafeStr_3976.findChildByName("helpbutton_show_hover_region"));
            _helpButtonShowRegion.addEventListener("WME_OVER", onInputHoverRegionMouseEvent);
            _helpButtonShowRegion.addEventListener("WME_OUT", onInputHoverRegionMouseEvent);
            updatePosition();
            _SafeStr_1584.setParamFlag(1, true);
            _SafeStr_1584.addEventListener("WME_DOWN", windowMouseEventProcessor);
            _SafeStr_1584.addEventListener("WKE_KEY_DOWN", windowKeyEventProcessor);
            _SafeStr_1584.addEventListener("WKE_KEY_UP", keyUpHandler);
            _SafeStr_1584.addEventListener("WE_CHANGE", onInputChanged);
            _SafeStr_1584.addEventListener("WME_OVER", onInputHoverRegionMouseEvent);
            _SafeStr_1584.addEventListener("WME_OUT", onInputHoverRegionMouseEvent);
            _SafeStr_1584.toolTipDelay = 0;
            _SafeStr_1584.toolTipIsDynamic = true;
            _SafeStr_3979 = true;
            _SafeStr_1584.setTextFormat(_SafeStr_3980);
            _SafeStr_3983 = "";
            _window.addEventListener("WE_PARENT_RESIZED", updatePosition);
            _window.addEventListener("WE_PARENT_ADDED", updatePosition);
            if (((((customChatStylesEnabled()) && (!(_widget.handler.container.roomSession.isGameSession))) && (!(_widget.handler.container.freeFlowChat == null))) && (!(_widget.handler.container.freeFlowChat.chatStyleLibrary == null))))
            {
                _local_1 = [];
                _local_2 = _widget.roomUi.getProperty("disabled.custom.chat.styles").split(",");
                _local_3 = _widget.handler.container.sessionDataManager.hasSecurity(4);
                for each (var _local_4:int in _widget.handler.container.freeFlowChat.chatStyleLibrary.getStyleIds())
                {
                    _local_7 = _widget.handler.container.freeFlowChat.chatStyleLibrary.getStyle(_local_4);
                    if (((!(_local_7.isSystemStyle)) && (_local_2.indexOf(_local_4.toString()) == -1)))
                    {
                        if (((_local_7.isHcOnly) && (_widget.handler.container.sessionDataManager.hasClub)))
                        {
                            _local_1.push(_local_4);
                        }
                        else
                        {
                            if (((!(_local_7.isHcOnly)) && (!(_local_7.isAmbassadorOnly))))
                            {
                                _local_1.push(_local_4);
                            };
                        };
                    };
                    if (((_local_7.isStaffOverrideable) && (_local_3)))
                    {
                        _local_1.push(_local_4);
                    };
                    if (((_local_7.isAmbassadorOnly) && ((_local_3) || (_widget.handler.container.sessionDataManager.isAmbassador))))
                    {
                        _local_1.push(_local_4);
                    };
                };
                removeDuplicateStyles(_local_1);
                createChatStyleSelectorMenuItems(_local_1);
            }
            else
            {
                if ((_SafeStr_3976.findChildByName("chat_input_container") is IItemListWindow))
                {
                    IItemListWindow(_SafeStr_3976.findChildByName("chat_input_container")).removeListItemAt(0);
                };
            };
            createAndAttachDimmerWindow();
            _helpButton = _SafeStr_159(_window.findChildByName("helpbutton"));
            _helpButton.addEventListener("WME_CLICK", onHelpButtonMouseEvent);
            _helpButton.addEventListener("WME_OVER", onHelpButtonMouseEvent);
            _helpButton.addEventListener("WME_OUT", onHelpButtonMouseEvent);
            _helpButton.visible = false;
        }

        private function removeDuplicateStyles(_arg_1:Array):void
        {
            var _local_2:int;
            var _local_3:int;
            _local_2 = 0;
            while (_local_2 < (_arg_1.length - 1))
            {
                _local_3 = (_local_2 + 1);
                while (_local_3 < _arg_1.length)
                {
                    if (_arg_1[_local_2] === _arg_1[_local_3])
                    {
                        _arg_1.splice(_local_3--, 1);
                    };
                    _local_3++;
                };
                _local_2++;
            };
        }

        private function customChatStylesEnabled():Boolean
        {
            return (_widget.roomUi.getBoolean("custom.chat.styles.enabled"));
        }

        private function createAndAttachDimmerWindow():void
        {
            var _local_1:IWindow;
            if (RoomEnterEffect.isRunning())
            {
                _local_1 = _widget.windowManager.createWindow("chat_dimmer", "", 30, 1, ((0x80 | 0x0800) | 0x01), new Rectangle(0, 0, _SafeStr_3976.width, _SafeStr_3976.height), null, 0);
                _local_1.color = 0;
                _local_1.blend = 0.3;
                _SafeStr_3976.addChild(_local_1);
                _SafeStr_3976.invalidate();
                if (_SafeStr_574 == null)
                {
                    _SafeStr_574 = new Timer(RoomEnterEffect.totalRunningTime, 1);
                    _SafeStr_574.addEventListener("timerComplete", onRemoveDimmer);
                    _SafeStr_574.start();
                };
            };
        }

        private function onRemoveDimmer(_arg_1:TimerEvent):void
        {
            _SafeStr_574.removeEventListener("timerComplete", onRemoveDimmer);
            _SafeStr_574 = null;
            var _local_2:IWindow = _SafeStr_3976.findChildByName("chat_dimmer");
            if (_local_2 != null)
            {
                _SafeStr_3976.removeChild(_local_2);
                _widget.windowManager.destroy(_local_2);
            };
        }

        public function updatePosition(_arg_1:WindowEvent=null, _arg_2:int=10000, _arg_3:int=10000):void
        {
            _window.width = _window.desktop.width;
            _window.height = _window.desktop.height;
            var _local_9:Point = new Point();
            if (!_SafeStr_3976)
            {
                return;
            };
            var _local_4:int = widget.getToolBarWidth();
            var _local_6:int = widget.getFriendBarWidth();
            var _local_5:int = int(((_window.desktop.width / 2) - (_SafeStr_3976.width / 2)));
            var _local_7:int;
            var _local_8:int = (_SafeStr_3976.width + 12);
            if (((_window.desktop.width - _local_4) - _local_6) > _local_8)
            {
                _local_7 = (_local_4 + 12);
                _SafeStr_3976.y = (_window.desktop.height - 104);
                if ((_local_5 + _SafeStr_3976.width) > (_window.desktop.width - _local_6))
                {
                    _local_5 = 0;
                };
            }
            else
            {
                _local_7 = (widget.getRoomToolsWidth() + 12);
                _SafeStr_3976.y = (_window.desktop.height - 160);
            };
            _SafeStr_3976.x = Math.max(_local_5, _local_7);
            if (_SafeStr_3987)
            {
                _SafeStr_3987.alignMenuToSelector();
            };
        }

        private function onSend(_arg_1:WindowMouseEvent):void
        {
            if (!_SafeStr_3979)
            {
                sendChatFromInputField();
            };
        }

        public function hideFloodBlocking():void
        {
            _SafeStr_1584.visible = true;
            _SafeStr_3975.visible = false;
        }

        public function showFloodBlocking():void
        {
            _SafeStr_1584.visible = false;
            _SafeStr_3975.visible = true;
        }

        public function updateBlockText(_arg_1:int):void
        {
            _SafeStr_3975.caption = _widget.localizations.registerParameter("chat.input.alert.flood", "time", _arg_1.toString());
        }

        public function displaySpecialChatMessage(_arg_1:String, _arg_2:String=""):void
        {
            if (((_SafeStr_3976 == null) || (_SafeStr_1584 == null)))
            {
                return;
            };
            _SafeStr_1584.enable();
            _SafeStr_1584.selectable = true;
            _SafeStr_1584.text = "";
            setInputFieldFocus();
            _SafeStr_1584.text = (_SafeStr_1584.text + (_arg_1 + " "));
            if (_arg_2.length > 0)
            {
                _SafeStr_1584.text = (_SafeStr_1584.text + (_arg_2 + " "));
            };
            _SafeStr_1584.setSelection(_SafeStr_1584.text.length, _SafeStr_1584.text.length);
            _SafeStr_3983 = _SafeStr_1584.text;
        }

        private function windowMouseEventProcessor(_arg_1:WindowEvent=null, _arg_2:IWindow=null):void
        {
            setInputFieldFocus();
        }

        private function windowKeyEventProcessor(_arg_1:WindowEvent=null, _arg_2:IWindow=null):void
        {
            var _local_7:uint;
            var _local_3:Boolean;
            var _local_6:WindowKeyboardEvent;
            var _local_4:KeyboardEvent;
            var _local_8:String;
            var _local_5:Array;
            if ((((_SafeStr_3976 == null) || (_widget == null)) || (_widget.floodBlocked)))
            {
                return;
            };
            if (anotherFieldHasFocus())
            {
                return;
            };
            setInputFieldFocus();
            if ((_arg_1 is WindowKeyboardEvent))
            {
                _local_6 = (_arg_1 as WindowKeyboardEvent);
                _local_7 = _local_6.charCode;
                _local_3 = _local_6.shiftKey;
            };
            if ((_arg_1 is KeyboardEvent))
            {
                _local_4 = (_arg_1 as KeyboardEvent);
                _local_7 = _local_4.charCode;
                _local_3 = _local_4.shiftKey;
            };
            if (((_local_4 == null) && (_local_6 == null)))
            {
                return;
            };
            if (_local_7 == 32)
            {
                checkSpecialKeywordForInput();
            };
            if (_local_7 == 13)
            {
                sendChatFromInputField(_local_3);
                setButtonPressedState(true);
            };
            if (_local_7 == 8)
            {
                if (_SafeStr_1584 != null)
                {
                    _local_8 = _SafeStr_1584.text;
                    _local_5 = _local_8.split(" ");
                    if ((((_local_5[0] == _SafeStr_3977) && (_local_5.length == 3)) && (_local_5[2] == "")))
                    {
                        _SafeStr_1584.text = "";
                        _SafeStr_3983 = "";
                    };
                };
            };
        }

        private function keyUpHandler(_arg_1:WindowKeyboardEvent):void
        {
            if (_arg_1.keyCode == 13)
            {
                setButtonPressedState(false);
            };
        }

        private function setButtonPressedState(_arg_1:Boolean):void
        {
        }

        private function onInputChanged(_arg_1:WindowEvent):void
        {
            var _local_2:ITextFieldWindow = (_arg_1.window as ITextFieldWindow);
            if (_local_2 == null)
            {
                return;
            };
            _SafeStr_3971.reset();
            var _local_3:Boolean = (_local_2.text.length == 0);
            if (_local_3)
            {
                _SafeStr_3981 = false;
                _SafeStr_2670.start();
            }
            else
            {
                if (_local_2.text.length > (_SafeStr_3983.length + 1))
                {
                    if (_widget.allowPaste)
                    {
                        _widget.setLastPasteTime();
                    }
                    else
                    {
                        _local_2.text = "";
                    };
                };
                _SafeStr_3983 = _local_2.text;
                if (!_SafeStr_3981)
                {
                    _SafeStr_3981 = true;
                    _SafeStr_2670.reset();
                    _SafeStr_2670.start();
                };
                _SafeStr_3971.start();
                if (_SafeStr_3973 != null)
                {
                    _SafeStr_3973.reset();
                    _SafeStr_3973 = null;
                };
            };
        }

        private function checkSpecialKeywordForInput():void
        {
            if (((_SafeStr_1584 == null) || (_SafeStr_1584.text == "")))
            {
                return;
            };
            var _local_2:String = _SafeStr_1584.text;
            var _local_1:String = _widget.selectedUserName;
            if (_local_2 == _SafeStr_3977)
            {
                if (_local_1.length > 0)
                {
                    _SafeStr_1584.text = (_SafeStr_1584.text + (" " + _widget.selectedUserName));
                    _SafeStr_1584.setSelection(_SafeStr_1584.text.length, _SafeStr_1584.text.length);
                    _SafeStr_3983 = _SafeStr_1584.text;
                };
            };
        }

        private function onIdleTimerComplete(_arg_1:TimerEvent):void
        {
            if (_SafeStr_3981)
            {
                _SafeStr_3982 = false;
            };
            _SafeStr_3981 = false;
            sendTypingMessage();
        }

        private function onNuxIdleTimerComplete(_arg_1:TimerEvent):void
        {
            if (_SafeStr_3973 != null)
            {
                _SafeStr_3973.reset();
                _SafeStr_3973.removeEventListener("timerComplete", onNuxIdleTimerComplete);
                _SafeStr_3973 = null;
            };
            highlightChatInput();
        }

        private function onTypingTimerComplete(_arg_1:TimerEvent):void
        {
            if (_SafeStr_3981)
            {
                _SafeStr_3982 = true;
            };
            sendTypingMessage();
        }

        private function sendTypingMessage():void
        {
            if (_widget == null)
            {
                return;
            };
            if (_widget.floodBlocked)
            {
                return;
            };
            var _local_1:RoomWidgetChatTypingMessage = new RoomWidgetChatTypingMessage(_SafeStr_3981);
            _widget.messageListener.processWidgetMessage(_local_1);
        }

        private function highlightChatInput():void
        {
            _SafeStr_1584.text = widget.localizations.getLocalization("widgets.chatinput.mode.remind.noobie");
            _SafeStr_3984 = new Timer(500);
            _SafeStr_3984.addEventListener("timer", onChatReminderTimer);
            _SafeStr_3984.start();
            widget.windowManager.registerHintWindow("nux_chat_reminder", _SafeStr_1584);
            widget.windowManager.showHint("nux_chat_reminder");
        }

        private function onChatReminderTimer(_arg_1:TimerEvent):void
        {
            _SafeStr_3985++;
            if ((_SafeStr_3985 % 2) != 0)
            {
                _widget.mainWindow.y = (_widget.mainWindow.y - 1);
            }
            else
            {
                _widget.mainWindow.y = (_widget.mainWindow.y + 1);
            };
            if (_SafeStr_3985 >= 10)
            {
                _SafeStr_3984.reset();
                _SafeStr_3984 = null;
                _widget.mainWindow.y = 0;
                chatBarReminderShown();
            };
        }

        private function chatBarReminderShown():void
        {
            widget.handler.container.config.setProperty("nux.chat.reminder.shown", "1");
            if (_SafeStr_3984 != null)
            {
                _SafeStr_3984.reset();
            };
            widget.windowManager.hideHint();
            widget.windowManager.unregisterHintWindow("nux_chat_reminder");
        }

        private function setInputFieldFocus():void
        {
            if (_SafeStr_1584 == null)
            {
                return;
            };
            if (_SafeStr_3984 != null)
            {
                chatBarReminderShown();
            };
            if (_SafeStr_3979)
            {
                _SafeStr_1584.text = "";
                _SafeStr_1584.textColor = 0;
                _SafeStr_1584.italic = false;
                _SafeStr_3979 = false;
                _SafeStr_3983 = "";
            };
            _SafeStr_1584.focus();
        }

        public function setInputFieldColor(_arg_1:uint):void
        {
            if (_SafeStr_1584 == null)
            {
                return;
            };
            _SafeStr_1584.textColor = _arg_1;
            _SafeStr_1584.defaultTextFormat.color = _arg_1;
        }

        private function sendChatFromInputField(_arg_1:Boolean=false):void
        {
            if (((_SafeStr_1584 == null) || (_SafeStr_1584.text == "")))
            {
                return;
            };
            var _local_7:int = ((_arg_1) ? 2 : 0);
            var _local_6:String = _SafeStr_1584.text;
            var _local_4:Array = _local_6.split(" ");
            var _local_2:String = "";
            var _local_5:String = "";
            switch (_local_4[0])
            {
                case _SafeStr_3977:
                    _local_7 = 1;
                    _local_2 = _local_4[1];
                    _local_5 = (((_SafeStr_3977 + " ") + _local_2) + " ");
                    _local_4.shift();
                    _local_4.shift();
                    break;
                case _chatModeIdShout:
                    _local_7 = 2;
                    _local_4.shift();
                    break;
                case _SafeStr_3978:
                    _local_7 = 0;
                    _local_4.shift();
            };
            _local_6 = _local_4.join(" ");
            var _local_3:int;
            if (((customChatStylesEnabled()) && (!(_SafeStr_3987 == null))))
            {
                _local_3 = _SafeStr_3987.selectedStyleId;
            };
            if (_widget != null)
            {
                if (_SafeStr_2670.running)
                {
                    _SafeStr_2670.reset();
                };
                if (_SafeStr_3971.running)
                {
                    _SafeStr_3971.reset();
                };
                _widget.sendChat(_local_6, _local_7, _local_2, _local_3);
                _SafeStr_3981 = false;
                if (_SafeStr_3982)
                {
                    sendTypingMessage();
                };
                _SafeStr_3982 = false;
            };
            if (_SafeStr_1584 != null)
            {
                _SafeStr_1584.text = _local_5;
            };
            _SafeStr_3983 = _local_5;
        }

        private function anotherFieldHasFocus():Boolean
        {
            var _local_3:Stage;
            var _local_2:InteractiveObject;
            if (_SafeStr_1584 != null)
            {
                if (_SafeStr_1584.focused)
                {
                    return (false);
                };
            };
            var _local_1:DisplayObject = _SafeStr_3976.context.getDesktopWindow().getDisplayObject();
            if (_local_1 != null)
            {
                _local_3 = _local_1.stage;
                if (_local_3 != null)
                {
                    _local_2 = _local_3.focus;
                    if (_local_2 == null)
                    {
                        return (false);
                    };
                    if ((_local_2 is TextField))
                    {
                        return (true);
                    };
                };
            };
            return (false);
        }

        public function get sessionDataManager():ISessionDataManager
        {
            return (_widget.handler.container.sessionDataManager);
        }

        private function createChatStyleSelectorMenuItems(_arg_1:Array):void
        {
            var _local_3:int;
            var _local_2:int;
            if (!_SafeStr_3987)
            {
                _SafeStr_3987 = new ChatStyleSelector(this, IWindowContainer(_SafeStr_3976.findChildByName("styles")), sessionDataManager);
                _SafeStr_3987.gridColumns = ((_arg_1.length / 6) + 1);
            };
            _local_3 = (_arg_1.length - 1);
            while (_local_3 >= 0)
            {
                _local_2 = _arg_1[_local_3];
                _SafeStr_3987.addItem(_local_2, _widget.handler.container.freeFlowChat.chatStyleLibrary.getStyle(_local_2).selectorPreview);
                _local_3--;
            };
            _SafeStr_3987.initSelection();
        }

        public function get widget():RoomChatInputWidget
        {
            return (_widget);
        }

        public function get chatStyleMenuContainer():IWindowContainer
        {
            return (_chatStyleMenuContainer);
        }

        public function getChatInputY():int
        {
            if (((!(_window)) || (!(_window.findChildByName("chat_input_container")))))
            {
                return (0);
            };
            var _local_1:Point = new Point();
            _window.findChildByName("chat_input_container").getGlobalPosition(_local_1);
            return (_local_1.y);
        }

        public function getChatWindowElements():Array
        {
            return ([_SafeStr_3976, _SafeStr_1584]);
        }

        private function onHelpButtonMouseEvent(_arg_1:WindowMouseEvent):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                _widget.roomUi.context.createLinkEvent("habbopages/chat/commands");
            };
            if (_arg_1.type == "WME_OVER")
            {
                _helpButton.visible = true;
                _mouseOverHelpButton = true;
                stopHelpButtonHideTimer();
            }
            else
            {
                if (_arg_1.type == "WME_OUT")
                {
                    _mouseOverHelpButton = false;
                    startHelpButtonHideTimer();
                };
            };
        }

        private function onInputHoverRegionMouseEvent(_arg_1:WindowMouseEvent):void
        {
            if (_arg_1.type == "WME_OVER")
            {
                _helpButton.visible = true;
                stopHelpButtonHideTimer();
            }
            else
            {
                if (((_arg_1.type == "WME_OUT") && (!(_mouseOverHelpButton))))
                {
                    startHelpButtonHideTimer();
                };
            };
        }

        private function startHelpButtonHideTimer():void
        {
            if (_SafeStr_3986 != null)
            {
                stopHelpButtonHideTimer();
            };
            _SafeStr_3986 = new Timer(400);
            _SafeStr_3986.addEventListener("timer", onHelpButtonHideTimer);
            _SafeStr_3986.start();
        }

        private function onHelpButtonHideTimer(_arg_1:TimerEvent):void
        {
            if (((!(_mouseOverHelpButton)) && (_helpButton)))
            {
                _helpButton.visible = false;
            };
            stopHelpButtonHideTimer();
        }

        private function stopHelpButtonHideTimer():void
        {
            if (!_SafeStr_3986)
            {
                return;
            };
            _SafeStr_3986.stop();
            _SafeStr_3986.removeEventListener("timer", onHelpButtonHideTimer);
            _SafeStr_3986 = null;
        }


    }
}

