package com.sulake.habbo.ui
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.runtime.ICoreConfiguration;
    import com.sulake.core.window.events.WindowEvent;
    import flash.geom.Rectangle;
    import com.sulake.core.window.components.IDisplayObjectWrapper;

    public class DesktopLayoutManager 
    {

        private static const ROOM_VIEW:String = "room_view";
        private static const ROOM_NEW_CHAT:String = "room_new_chat";
        private static const ROOM_WIDGET:String = "room_widget";
        private static const BOTTOM_MARGIN:int = 47;

        private var _layoutContainer:IWindowContainer;


        public function dispose():void
        {
            if (_layoutContainer != null)
            {
                _layoutContainer.dispose();
            };
        }

        public function setLayout(_arg_1:XML, _arg_2:IHabboWindowManager, _arg_3:ICoreConfiguration):void
        {
            var _local_7:IWindow;
            var _local_6:int;
            var _local_5:int;
            if (((_arg_1 == null) || (_arg_2 == null)))
            {
                throw (new Error("Unable to set room desktop layout."));
            };
            _layoutContainer = (_arg_2.buildFromXML(_arg_1, 0) as IWindowContainer);
            if (_layoutContainer == null)
            {
                throw (new Error("Failed to build layout from XML."));
            };
            _layoutContainer.width = _layoutContainer.desktop.width;
            _layoutContainer.height = _layoutContainer.desktop.height;
            var _local_4:IWindowContainer = (_layoutContainer.desktop as IWindowContainer);
            _local_4.addChild(_layoutContainer);
            _layoutContainer.findChildByTag("room_widget_infostand").y = (_layoutContainer.findChildByTag("room_widget_infostand").y - 47);
            _local_6 = 0;
            while (_local_6 < _layoutContainer.numChildren)
            {
                _local_7 = _layoutContainer.getChildAt(_local_6);
                _local_5 = 0x100000;
                if (_local_7.testParamFlag(_local_5))
                {
                    _local_7.addEventListener("WE_CHILD_RESIZED", trimContainer);
                };
                _local_6++;
            };
        }

        private function trimContainer(_arg_1:WindowEvent):void
        {
            var _local_2:IWindowContainer = (_arg_1.window as IWindowContainer);
            if (_local_2 == null)
            {
                return;
            };
            if (_local_2.numChildren != 1)
            {
                return;
            };
            var _local_3:IWindow = _local_2.getChildAt(0);
            if (_local_3 == null)
            {
                return;
            };
            _local_2.width = _local_3.width;
            _local_2.height = _local_3.height;
        }

        private function getWidgetContainer(_arg_1:String, _arg_2:IWindow):IWindowContainer
        {
            var _local_7:IWindowContainer;
            var _local_3:IWindowContainer;
            var _local_5:String;
            var _local_6:int;
            if (_arg_2 == null)
            {
                return (null);
            };
            if (((_arg_1 == "RWE_HIGH_SCORE_DISPLAY") || (_arg_1 == "RWE_WORD_QUIZZ")))
            {
                _local_7 = (_layoutContainer.getChildByName("background_widgets") as IWindowContainer);
                return (_local_7);
            };
            if (_arg_1 == "RWE_CHAT_INPUT_WIDGET")
            {
                return (_arg_2.desktop as IWindowContainer);
            };
            var _local_8:Array = _arg_2.tags;
            _local_6 = 0;
            while (_local_6 < _local_8.length)
            {
                if (_local_8[_local_6].indexOf("room_widget") == 0)
                {
                    _local_5 = (_local_8[_local_6] as String);
                    break;
                };
                _local_6++;
            };
            if (_local_5 == null)
            {
                return (null);
            };
            var _local_4:IWindowContainer = (_layoutContainer.getChildByTag(_local_5) as IWindowContainer);
            return (_local_4);
        }

        public function addWidgetWindow(_arg_1:String, _arg_2:IWindow):Boolean
        {
            if (_arg_2 == null)
            {
                return (false);
            };
            var _local_3:IWindowContainer = getWidgetContainer(_arg_1, _arg_2);
            if (_local_3 == null)
            {
                return (false);
            };
            if (_arg_1 == "RWE_CHAT_INPUT_WIDGET")
            {
                _local_3.addChild(_arg_2);
                return (true);
            };
            _arg_2.x = 0;
            _arg_2.y = 0;
            _local_3.addChild(_arg_2);
            _local_3.width = _arg_2.width;
            _local_3.height = _arg_2.height;
            return (true);
        }

        public function removeWidgetWindow(_arg_1:String, _arg_2:IWindow):void
        {
            var _local_3:IWindowContainer = getWidgetContainer(_arg_1, _arg_2);
            if (_local_3 != null)
            {
                _local_3.removeChild(_arg_2);
            };
        }

        public function addRoomView(_arg_1:IWindow):Boolean
        {
            if (_arg_1 == null)
            {
                return (false);
            };
            var _local_2:IWindowContainer = (_layoutContainer.getChildByTag("room_view") as IWindowContainer);
            if (_local_2 == null)
            {
                return (false);
            };
            _local_2.addChild(_arg_1);
            return (true);
        }

        public function get roomViewRect():Rectangle
        {
            if (_layoutContainer == null)
            {
                return (null);
            };
            var _local_1:IWindowContainer = (_layoutContainer.findChildByTag("room_view") as IWindowContainer);
            if (!_local_1)
            {
                return (null);
            };
            var _local_2:Rectangle = _local_1.rectangle;
            if (!_local_2)
            {
                return (null);
            };
            _local_2.offset(_layoutContainer.x, _layoutContainer.y);
            return (_local_2);
        }

        public function getRoomView():IWindow
        {
            if (_layoutContainer == null)
            {
                return (null);
            };
            var _local_1:IWindowContainer = (_layoutContainer.findChildByTag("room_view") as IWindowContainer);
            if (((!(_local_1 == null)) && (_local_1.numChildren > 0)))
            {
                return (_local_1.getChildAt(0));
            };
            return (null);
        }

        public function getChatContainer():IDisplayObjectWrapper
        {
            if (_layoutContainer == null)
            {
                return (null);
            };
            return (_layoutContainer.findChildByTag("room_new_chat") as IDisplayObjectWrapper);
        }


    }
}