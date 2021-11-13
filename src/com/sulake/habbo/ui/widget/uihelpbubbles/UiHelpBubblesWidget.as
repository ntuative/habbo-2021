package com.sulake.habbo.ui.widget.uihelpbubbles
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import com.sulake.core.runtime.events.ILinkEventTracker;
    import com.sulake.core.runtime.Component;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.toolbar.IHabboToolbar;
    import com.sulake.habbo.friendbar.view.IHabboFriendBarView;
    import com.sulake.habbo.ui.widget.roomtools.RoomToolsWidget;
    import com.sulake.habbo.ui.widget.chatinput.RoomChatInputWidget;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.ui.IRoomDesktop;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.ITextFieldWindow;
    import flash.geom.Point;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetScriptProceedMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;

    public class UiHelpBubblesWidget extends RoomWidgetBase implements ILinkEventTracker 
    {

        private var _SafeStr_659:Component;
        private var _SafeStr_2193:Map;
        private var _toolBar:IHabboToolbar;
        private var _friendBar:IHabboFriendBarView;
        private var _roomTools:RoomToolsWidget;
        private var _chatInput:RoomChatInputWidget;
        private var _SafeStr_4305:Array;
        private var _SafeStr_4306:int = 0;
        private var _localization:IHabboLocalizationManager;

        public function UiHelpBubblesWidget(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary, _arg_4:IHabboLocalizationManager, _arg_5:IHabboFriendBarView, _arg_6:IHabboToolbar, _arg_7:IRoomDesktop, _arg_8:Component)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
            _SafeStr_659 = _arg_8;
            _friendBar = _arg_5;
            _toolBar = _arg_6;
            _SafeStr_2193 = new Map();
            _localization = _arg_4;
            _SafeStr_4305 = [];
            if (_arg_7)
            {
                _roomTools = (_arg_7.getWidget("RWE_ROOM_TOOLS") as RoomToolsWidget);
                _chatInput = (_arg_7.getWidget("RWE_CHAT_INPUT_WIDGET") as RoomChatInputWidget);
            };
            (_arg_2 as Component).context.addLinkEventTracker(this);
        }

        override public function dispose():void
        {
            if (disposed)
            {
                return;
            };
            if (_SafeStr_2193)
            {
                for each (var _local_1:UiHelpBubble in _SafeStr_2193)
                {
                    _local_1.dispose();
                    _local_1 = null;
                };
                _SafeStr_2193.dispose();
                _SafeStr_2193 = null;
                _SafeStr_4305 = null;
            };
            super.dispose();
        }

        private function checkElementPosition(_arg_1:UiHelpBubble, _arg_2:Boolean=false):Rectangle
        {
            var _local_9:Rectangle;
            var _local_14:IWindowContainer;
            var _local_5:IWindow;
            var _local_8:Array;
            var _local_3:IWindowContainer;
            var _local_10:ITextFieldWindow;
            var _local_13:Rectangle;
            var _local_4:int;
            var _local_6:int;
            var _local_7:int;
            if (((!(_arg_1)) || (!(_arg_1.getWindow()))))
            {
                return (null);
            };
            var _local_11:String = _arg_1.getName();
            if (((_local_11 == "") || (!(_local_11))))
            {
                return (null);
            };
            var _local_15:int = _arg_1.getWindow().height;
            var _local_12:int = _arg_1.getWindow().width;
            var _local_16:String = "down";
            var _local_17:int = -1;
            if (toolBar)
            {
                _local_5 = toolBar.getIcon(_local_11);
                if (_local_5)
                {
                    _local_9 = new Rectangle();
                    _local_5.getGlobalRectangle(_local_9);
                    _arg_1.setCallback(_local_5);
                };
            };
            if (friendBar)
            {
                if (!_local_9)
                {
                    _local_14 = friendBar.getIconLocation(_local_11);
                    if (_local_14)
                    {
                        _local_9 = new Rectangle();
                        _local_14.getGlobalRectangle(_local_9);
                        _arg_1.setCallback((_local_14 as IWindow));
                    };
                };
            };
            if (!_local_9)
            {
                if (roomTools)
                {
                    _local_5 = roomTools.getIconLocation(_local_11);
                    if (_local_5)
                    {
                        _local_9 = new Rectangle();
                        _local_5.getGlobalRectangle(_local_9);
                        _arg_1.setCallback(_local_5);
                    };
                };
            };
            if (!_local_9)
            {
                if (((chatInput) && (_local_11 == "chat_input")))
                {
                    _local_8 = chatInput.getChatInputElements();
                    if (_local_8.length > 1)
                    {
                        _local_3 = (_local_8[0] as IWindowContainer);
                        _local_10 = (_local_8[1] as ITextFieldWindow);
                    };
                    _local_9 = _local_3.rectangle;
                    if (_local_9)
                    {
                        if (((_arg_2) && (_local_9)))
                        {
                            return (_local_9);
                        };
                        _local_9.y = (_local_9.y - (_local_15 - 40));
                        _local_9.x = (_local_9.x + ((_local_9.width / 2) - 10));
                        _arg_1.setChatFieldCallback(_local_10);
                        _arg_1.setArrowPos(_local_16, _local_17);
                        return (_local_9);
                    };
                };
            };
            if (_local_9)
            {
                if (_arg_2)
                {
                    return (_local_9);
                };
                _local_13 = _local_9.clone();
                _local_4 = 15;
                _local_6 = _arg_1.getWindow().desktop.width;
                if ((_local_9.y - (_local_15 + _local_4)) < 50)
                {
                    _local_4 = 0;
                };
                _local_16 = "down";
                _local_17 = 0;
                _local_9.x = (_local_9.x + (_local_9.width / 2));
                _local_9.y = (_local_9.y - (_local_15 + _local_4));
                _local_7 = (_local_9.right - _local_13.right);
                if (_local_7 >= (_local_12 / 2))
                {
                    _local_7 = int(((_local_12 / 2) - 25));
                };
                if (_local_9.y < _local_15)
                {
                    _local_9.y = (_local_9.y + ((_local_9.height + _local_15) + 10));
                    _local_16 = "up";
                    if (_local_7 <= 30)
                    {
                        _local_7 = int((_local_7 / 3));
                    };
                    _local_17 = _local_7;
                    _arg_1.setArrowPos(_local_16, _local_17);
                };
                if (_local_9.x < (_local_12 / 2))
                {
                    _local_9.x = 10;
                    _local_17 = int((_local_17 - ((_local_12 / 2) - 30)));
                    _arg_1.setArrowPos(_local_16, _local_17);
                    return (_local_9);
                };
                if ((_local_9.x + (_local_12 / 2)) > _local_6)
                {
                    _local_9.x = (_local_6 - (_local_12 / 2));
                    _local_17 = int((_local_12 / 4));
                    _arg_1.setArrowPos(_local_16, _local_17);
                    return (_local_9);
                };
                _arg_1.setArrowPos(_local_16, _local_17);
            };
            return (_local_9);
        }

        public function addNextBubble():void
        {
            var _local_5:Point;
            if ((((!(_SafeStr_4305)) || (_SafeStr_4305.length == 0)) || (_SafeStr_4305.length < (_SafeStr_4306 + 1))))
            {
                return;
            };
            var _local_3:HelpBubbleItem = (_SafeStr_4305[_SafeStr_4306] as HelpBubbleItem);
            var _local_2:Boolean = (_SafeStr_4305.length > (_SafeStr_4306 + 1));
            var _local_6:String = _local_3.name;
            var _local_4:UiHelpBubble = new UiHelpBubble(this, _local_3, _local_2);
            if (_SafeStr_2193.hasKey(_local_6))
            {
                removeHelpBubble(_local_6);
            };
            var _local_1:Rectangle = checkElementPosition(_local_4);
            _SafeStr_4306++;
            if (_local_1)
            {
                _local_5 = new Point(_local_1.x, _local_1.y);
            };
            if (_local_5)
            {
                _local_4.setPosition(_local_5);
                _local_4.getWindow().desktop.addEventListener("WE_RESIZED", onDesktopResized);
                _local_4.setModal(checkElementPosition(_local_4, true));
                addHelpBubble(_local_6, _local_4);
            }
            else
            {
                _local_4.dispose();
                addNextBubble();
            };
        }

        private function addHelpBubble(_arg_1:String, _arg_2:UiHelpBubble):void
        {
            if (((!(_SafeStr_2193)) || (!(_arg_2))))
            {
                return;
            };
            _SafeStr_2193.add(_arg_1, _arg_2);
        }

        public function removeHelpBubble(_arg_1:String):void
        {
            if (!_SafeStr_2193)
            {
                return;
            };
            var _local_2:UiHelpBubble = (_SafeStr_2193.getValue(_arg_1) as UiHelpBubble);
            if (!_local_2)
            {
                return;
            };
            _SafeStr_2193.remove(_arg_1);
            _local_2.dispose();
            addNextBubble();
        }

        private function onDesktopResized(_arg_1:WindowEvent=null):void
        {
            var _local_2:Rectangle;
            var _local_4:Point;
            for each (var _local_3:UiHelpBubble in _SafeStr_2193)
            {
                _local_2 = checkElementPosition(_local_3);
                if (_local_2)
                {
                    _local_4 = new Point(_local_2.x, _local_2.y);
                    _local_3.setPosition(_local_4);
                    _local_3.setModal(checkElementPosition(_local_3, true));
                };
            };
        }

        public function sendScriptProceedMessage():void
        {
            var _local_1:RoomWidgetMessage = new RoomWidgetScriptProceedMessage("RWPM_ANSWER");
            if (messageListener)
            {
                messageListener.processWidgetMessage(_local_1);
            };
        }

        public function get linkPattern():String
        {
            return ("helpBubble/");
        }

        public function linkReceived(_arg_1:String):void
        {
            var _local_8:int;
            var _local_3:HelpBubbleItem;
            var _local_7:int;
            var _local_6:String;
            var _local_4:String;
            if (!_SafeStr_2193)
            {
                _SafeStr_2193 = new Map();
            };
            if (!_SafeStr_4305)
            {
                _SafeStr_4305 = [];
            };
            var _local_2:Array = _arg_1.split("/");
            var _local_5:int = _local_2.length;
            if (_local_5 < 3)
            {
                return;
            };
            if (_local_2[1] == "add")
            {
                _local_8 = 0;
                _local_7 = 2;
                while (_local_7 < _local_5)
                {
                    if (++_local_8 == 1)
                    {
                        _local_3 = new HelpBubbleItem();
                        _local_6 = _local_2[_local_7];
                        _local_4 = UiHelpBubbleIconEnum[_local_6];
                        if (!_local_4)
                        {
                            _local_4 = _local_6;
                        };
                        _local_3.name = _local_4;
                        _local_3.modal = true;
                    };
                    if (_local_8 == 2)
                    {
                        _local_3.text = _localization.getLocalization(_local_2[_local_7], _local_2[_local_7]);
                        _local_8 = 0;
                        _SafeStr_4305.push(_local_3);
                    };
                    _local_7++;
                };
                addNextBubble();
            }
            else
            {
                if (_local_2[1] == "remove")
                {
                    removeHelpBubble(_local_2[2]);
                };
            };
        }

        public function get toolBar():IHabboToolbar
        {
            return (_toolBar);
        }

        public function get friendBar():IHabboFriendBarView
        {
            return (_friendBar);
        }

        public function get roomTools():RoomToolsWidget
        {
            return (_roomTools);
        }

        public function get chatInput():RoomChatInputWidget
        {
            return (_chatInput);
        }


    }
}

