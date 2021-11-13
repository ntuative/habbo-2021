package com.sulake.habbo.navigator.roomsettings
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.navigator.IHabboTransitionalNavigator;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.habbo.communication.messages.outgoing.roomsettings.GetCustomRoomFilterMessageComposer;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.communication.messages.outgoing.roomsettings.UpdateRoomFilterMessageComposer;
    import com.sulake.core.window.components.IRegionWindow;

    public class RoomFilterCtrl implements IDisposable 
    {

        private var _flatId:int;
        private var _navigator:IHabboTransitionalNavigator;
        private var _SafeStr_2944:int = -1;
        private var _window:IWindowContainer;
        private var _SafeStr_2945:Array;
        private var _SafeStr_2946:IItemListWindow;
        private var _SafeStr_2947:ITextFieldWindow;

        public function RoomFilterCtrl(_arg_1:IHabboTransitionalNavigator)
        {
            _navigator = _arg_1;
            _SafeStr_2945 = [];
        }

        public function startRoomFilterEdit(_arg_1:int):void
        {
            _flatId = _arg_1;
            _navigator.send(new GetCustomRoomFilterMessageComposer(_flatId));
            refreshWindow();
        }

        private function refreshWindow():void
        {
            if (_navigator.data.enteredGuestRoom == null)
            {
                return;
            };
            prepareWindow();
            _window.visible = true;
            _window.invalidate();
            _window.activate();
            _navigator.tracking.trackEventLogOncePerSession("InterfaceExplorer", "open", "room.filter.seen");
        }

        private function prepareWindow():void
        {
            if (_window != null)
            {
                return;
            };
            _window = IFrameWindow(_navigator.getXmlWindow("iro_room_filter_framed"));
            _window.findChildByName("badword_remove_btn").addEventListener("WME_CLICK", onRemoveWordClick);
            _window.findChildByName("badword_add_btn").addEventListener("WME_CLICK", onAddWordClick);
            _window.findChildByTag("close").addEventListener("WME_CLICK", onCloseButtonClick);
            _SafeStr_2947 = (_window.findChildByName("roomfilter_addword_txt") as ITextFieldWindow);
            _SafeStr_2946 = IItemListWindow(_window.findChildByName("badwords_itemlist"));
            refreshBadWords();
            _window.center();
        }

        public function onRoomFilterSettings(_arg_1:Array):void
        {
            var _local_2:int;
            _local_2 = 0;
            while (_local_2 < _arg_1.length)
            {
                if (_SafeStr_2945.indexOf(_arg_1[_local_2]) == -1)
                {
                    _SafeStr_2945.push(_arg_1[_local_2]);
                };
                _local_2++;
            };
            if (_SafeStr_2946)
            {
                _SafeStr_2946.removeListItems();
                refreshBadWords();
            };
        }

        private function refreshBadWords():void
        {
            var _local_2:int;
            var _local_1:IWindowContainer;
            _SafeStr_2946.autoArrangeItems = false;
            _local_2 = 0;
            while (true)
            {
                _local_1 = IWindowContainer(_SafeStr_2946.getListItemAt(_local_2));
                if (_local_1 == null)
                {
                    if (_SafeStr_2945[_local_2] == null) break;
                    _local_1 = getListEntry(_local_2);
                    _SafeStr_2946.addListItem(_local_1);
                };
                if (_SafeStr_2945[_local_2] != null)
                {
                    _local_1.color = this.getBgColor(_local_2, false);
                    refreshEntryDetails(_local_1, _SafeStr_2945[_local_2]);
                    _local_1.visible = true;
                    _local_1.height = 20;
                }
                else
                {
                    _local_1.height = 0;
                    _local_1.visible = false;
                };
                _local_2++;
            };
            _SafeStr_2946.autoArrangeItems = true;
            _SafeStr_2946.invalidate();
        }

        private function refreshEntryDetails(_arg_1:IWindowContainer, _arg_2:String):void
        {
            _arg_1.findChildByName("badword_txt").caption = _arg_2;
        }

        private function onCloseButtonClick(_arg_1:WindowEvent):void
        {
            disposeWindow();
        }

        private function onAddWordClick(_arg_1:WindowMouseEvent):void
        {
            addBadWord(_SafeStr_2947.text);
        }

        private function addBadWord(_arg_1:String):void
        {
            if (((!(_SafeStr_2947 == null)) && (_SafeStr_2947.text.length > 0)))
            {
                _navigator.send(new UpdateRoomFilterMessageComposer(_flatId, UpdateRoomFilterMessageComposer._SafeStr_626, _arg_1));
                _navigator.send(new GetCustomRoomFilterMessageComposer(_flatId));
                _SafeStr_2947.text = "bobba";
            };
        }

        private function onRemoveWordClick(_arg_1:WindowMouseEvent):void
        {
            if (_SafeStr_2944 < 0)
            {
                return;
            };
            var _local_2:IWindowContainer = IWindowContainer(_SafeStr_2946.getListItemAt(_SafeStr_2944));
            if (!_local_2)
            {
                return;
            };
            var _local_3:String = _local_2.findChildByName("badword_txt").caption;
            _local_2.height = 0;
            _local_2.visible = false;
            _local_2 = null;
            if (_SafeStr_2945.indexOf(_local_3) >= 0)
            {
                _SafeStr_2945.splice(_SafeStr_2945.indexOf(_local_3), 1);
            };
            _navigator.send(new UpdateRoomFilterMessageComposer(_flatId, UpdateRoomFilterMessageComposer._SafeStr_627, _local_3));
        }

        private function refreshColorsAfterClick(_arg_1:IItemListWindow):void
        {
            var _local_3:int;
            var _local_2:IWindowContainer;
            _local_3 = 0;
            while (_local_3 < _SafeStr_2945.length)
            {
                _local_2 = IWindowContainer(_arg_1.getListItemAt(_local_3));
                _local_2.color = this.getBgColor(_local_3, false);
                _local_3++;
            };
        }

        private function getListEntry(_arg_1:int):IWindowContainer
        {
            if (!_navigator)
            {
                return (null);
            };
            var _local_2:IWindowContainer = IWindowContainer(_navigator.getXmlWindow("ros_badword"));
            if (!_local_2)
            {
                return (null);
            };
            var _local_3:IRegionWindow = IRegionWindow(_local_2.findChildByName("bg_region"));
            _local_3.addEventListener("WME_CLICK", onBgMouseClick);
            _local_3.addEventListener("WME_OVER", onBgMouseOver);
            _local_3.addEventListener("WME_OUT", onBgMouseOut);
            _local_2.id = _arg_1;
            return (_local_2);
        }

        protected function getBgColor(_arg_1:int, _arg_2:Boolean):uint
        {
            if (_arg_1 == _SafeStr_2944)
            {
                return (4288329945);
            };
            return ((_arg_2) ? 4290173439 : (((_arg_1 % 2) != 0) ? 0xFFFFFFFF : 4293519841));
        }

        private function onBgMouseClick(_arg_1:WindowEvent):void
        {
            _SafeStr_2944 = _arg_1.target.parent.id;
            refreshColorsAfterClick((_arg_1.target.findParentByName("badwords_itemlist") as IItemListWindow));
        }

        private function onBgMouseOver(_arg_1:WindowEvent):void
        {
            var _local_2:IWindowContainer = IWindowContainer(_arg_1.target.parent);
            _local_2.color = getBgColor(-1, true);
        }

        private function onBgMouseOut(_arg_1:WindowEvent):void
        {
            var _local_2:IWindowContainer = IWindowContainer(_arg_1.target.parent);
            _local_2.color = getBgColor(_local_2.id, false);
        }

        public function close():void
        {
            this._flatId = 0;
            if (_window != null)
            {
                _window.visible = false;
            };
        }

        public function disposeWindow():void
        {
            if (_window)
            {
                _window.visible = false;
                _window.dispose();
                _window = null;
            };
            if (_SafeStr_2946)
            {
                _SafeStr_2946.removeListItems();
                _SafeStr_2946.dispose();
                _SafeStr_2946 = null;
            };
            if (_SafeStr_2947)
            {
                _SafeStr_2947.dispose();
                _SafeStr_2947 = null;
            };
            if (_SafeStr_2945)
            {
                _SafeStr_2945.length = 0;
            };
        }

        public function dispose():void
        {
            if (disposed)
            {
                return;
            };
            disposeWindow();
            _navigator = null;
        }

        public function get disposed():Boolean
        {
            return (_navigator == null);
        }


    }
}

