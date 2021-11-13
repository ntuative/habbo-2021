package com.sulake.habbo.ui.widget.roomtools
{
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.IWindowContainer;
    import flash.geom.Point;
    import com.sulake.core.window.motion.Motion;
    import com.sulake.core.window.motion.Queue;
    import com.sulake.core.window.motion.EaseOut;
    import com.sulake.core.window.motion.MoveTo;
    import com.sulake.core.window.motion.Callback;
    import com.sulake.core.window.motion.Motions;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class RoomToolsInfoCtrl extends RoomToolsCtrlBase 
    {

        private static const MARGIN:int = 12;
        private static const TAG_COLOR:uint = 1800619;
        private static const TAG_COLOR_HOVER:uint = 4696294;

        private var _SafeStr_4288:Array;

        public function RoomToolsInfoCtrl(_arg_1:RoomToolsWidget, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary)
        {
            super(_arg_1, _arg_2, _arg_3);
            _SafeStr_4288 = [];
        }

        public function showRoomInfo(_arg_1:Boolean, _arg_2:String, _arg_3:String, _arg_4:Array):void
        {
            if (!_window)
            {
                _window = (_SafeStr_1324.windowManager.buildFromXML((_assets.getAssetByName("room_tools_info_xml").content as XML)) as IWindowContainer);
                _window.procedure = onWindowEvent;
                _window.addEventListener("WME_OVER", onWindowEvent);
                _window.addEventListener("WME_OUT", onWindowEvent);
            };
            updatePosition();
            _window.findChildByName("room_name").caption = _arg_2;
            _window.findChildByName("room_owner").caption = _arg_3;
            if (_arg_4 == null)
            {
                return;
            };
            _SafeStr_4288 = _arg_4;
            _window.findChildByName("tag1_border").visible = (_arg_4.length >= 1);
            _window.findChildByName("tag2_border").visible = (_arg_4.length >= 2);
            if (_arg_4.length >= 1)
            {
                _window.findChildByName("tag1").caption = ("#" + trimTag(_arg_4[0]));
            };
            if (_arg_4.length >= 2)
            {
                _window.findChildByName("tag2").caption = ("#" + trimTag(_arg_4[1]));
            };
            setCollapsed(false);
        }

        public function updatePosition():void
        {
            if (!_window)
            {
                return;
            };
            var _local_2:int = ((((_SafeStr_4284) ? -(_window.width) : 0) + _SafeStr_1324.getRoomToolbarRight()) + 12);
            var _local_1:int = ((_window.desktop.height - 55) - _window.height);
            var _local_3:int = _SafeStr_1324.getChatInputY();
            if (_local_3 < (_local_1 + _window.height))
            {
                _local_1 = ((_local_3 - _window.height) - 12);
            };
            _window.position = new Point(_local_2, _local_1);
        }

        override public function setCollapsed(_arg_1:Boolean):void
        {
            var _local_2:Motion;
            if (_SafeStr_4284 == _arg_1)
            {
                return;
            };
            _SafeStr_4284 = _arg_1;
            if (!_SafeStr_4284)
            {
                collapseAfterDelay();
            };
            if (!_window)
            {
                return;
            };
            _window.visible = true;
            var _local_3:int = ((((_SafeStr_4284) ? -(_window.width) : 0) + _SafeStr_1324.getRoomToolbarRight()) + 12);
            if (_SafeStr_4284)
            {
                _local_2 = new Queue(new EaseOut(new MoveTo(_window, 100, _local_3, _window.y), 1), new Callback(motionComplete));
            }
            else
            {
                _local_2 = new Queue(new EaseOut(new MoveTo(_window, 100, _local_3, _window.y), 1), new Callback(motionComplete));
            };
            Motions.runMotion(_local_2);
        }

        public function setToolbarCollapsed(_arg_1:Boolean):void
        {
            if (!_window)
            {
                return;
            };
            setCollapsed(_arg_1);
            var _local_2:Motion = new EaseOut(new MoveTo(_window, 100, (_SafeStr_1324.getRoomToolbarRight() + 12), _window.y), 1);
            Motions.runMotion(_local_2);
        }

        private function motionComplete(_arg_1:Motion):void
        {
            if (((_SafeStr_4284) && (_window)))
            {
                _window.visible = false;
            };
        }

        private function trimTag(_arg_1:String):String
        {
            var _local_2:String = _arg_1;
            if (_local_2.length > 16)
            {
                _local_2 = (_local_2.substr(0, 16) + "...");
            };
            return (_local_2);
        }

        private function onWindowEvent(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_4:ITextWindow;
            var _local_3:String;
            if (_arg_1.type == "WE_PARENT_RESIZED")
            {
                return (updatePosition());
            };
            switch (_arg_1.type)
            {
                case "WME_CLICK":
                    setCollapsed(true);
                    break;
                case "WME_OVER":
                    cancelWindowCollapse();
                    break;
                case "WME_OUT":
                    collapseIfPending();
            };
            if ((_arg_1 as WindowMouseEvent) == null)
            {
                return;
            };
            if (_arg_2.name == "tag1_region")
            {
                _local_4 = (_window.findChildByName("tag1") as ITextWindow);
                _local_3 = ((_SafeStr_4288[0] == null) ? "" : _SafeStr_4288[0]);
            };
            if (_arg_2.name == "tag2_region")
            {
                _local_4 = (_window.findChildByName("tag2") as ITextWindow);
                _local_3 = ((_SafeStr_4288[1] == null) ? "" : _SafeStr_4288[1]);
            };
            if (_local_4 != null)
            {
                switch (_arg_1.type)
                {
                    case "WME_HOVERING":
                    case "WME_OVER":
                        _local_4.textColor = 4696294;
                        return;
                    case "WME_OUT":
                        _local_4.textColor = 1800619;
                        return;
                    case "WME_CLICK":
                        handler.navigator.performTagSearch(_local_3);
                        return;
                };
            };
        }

        public function get right():int
        {
            return ((_window) ? (_window.width + _window.x) : 0);
        }


    }
}

