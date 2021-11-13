package com.sulake.habbo.ui.widget.roomtools
{
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.ui.handler.RoomToolsWidgetHandler;
    import __AS3__.vec.Vector;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
    import com.sulake.core.window.events.WindowEvent;

    public class RoomToolsHistory 
    {

        private static const PADDING:int = 5;
        private static const SPACING:int = 2;

        private var _windowManager:IHabboWindowManager;
        private var _assets:IAssetLibrary;
        private var _window:IWindowContainer;
        private var _SafeStr_3915:RoomToolsWidgetHandler;
        private var _items:Vector.<IWindowContainer> = new Vector.<IWindowContainer>();

        public function RoomToolsHistory(_arg_1:IHabboWindowManager, _arg_2:IAssetLibrary, _arg_3:RoomToolsWidgetHandler)
        {
            _SafeStr_3915 = _arg_3;
            _assets = _arg_2;
            _windowManager = _arg_1;
            _window = (_arg_1.buildFromXML((_arg_2.getAssetByName("room_tools_history_xml").content as XML)) as IWindowContainer);
        }

        public function populate(_arg_1:Vector.<GuestRoomData>):void
        {
            var _local_3:IWindow;
            var _local_2:IWindowContainer;
            for each (var _local_4:GuestRoomData in _arg_1)
            {
                _local_2 = (_windowManager.buildFromXML((_assets.getAssetByName("room_tools_history_item_xml").content as XML)) as IWindowContainer);
                _window.addChild(_local_2);
                _local_2.findChildByName("room_name").caption = _local_4.roomName;
                if (_local_3)
                {
                    _local_2.y = (_local_3.bottom + 2);
                }
                else
                {
                    _local_2.y = 5;
                };
                _local_2.x = 5;
                _local_2.id = _local_4.flatId;
                _local_2.procedure = onClick;
                _local_3 = _local_2;
                _items.push(_local_2);
            };
            if (_local_3)
            {
                _window.height = (_local_3.bottom + (2 * 5));
            };
        }

        public function dispose():void
        {
            for each (var _local_1:IWindowContainer in _items)
            {
                _local_1.procedure = null;
                _local_1.dispose();
            };
            _items = null;
            _windowManager = null;
            _SafeStr_3915 = null;
            _assets = null;
            _window.dispose();
            _window = null;
        }

        private function onClick(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            _SafeStr_3915.goToPrivateRoom(_arg_2.id);
        }

        public function get window():IWindowContainer
        {
            return (_window);
        }


    }
}

