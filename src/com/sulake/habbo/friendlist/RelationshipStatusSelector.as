package com.sulake.habbo.friendlist
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.components._SafeStr_124;
    import flash.geom.Point;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowEvent;

    public class RelationshipStatusSelector implements IDisposable 
    {

        private var _friendList:HabboFriendList;
        private var _window:_SafeStr_124;
        private var _SafeStr_1880:int;
        private var _disposed:Boolean = false;

        public function RelationshipStatusSelector(_arg_1:HabboFriendList)
        {
            _friendList = _arg_1;
            createWindow();
        }

        public function dispose():void
        {
            if (!_disposed)
            {
                destroyWindow();
                _disposed = true;
            };
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function appearAt(_arg_1:IWindow, _arg_2:IWindow):void
        {
            var _local_3:Point = new Point();
            _arg_1.getGlobalPosition(_local_3);
            _window.x = _local_3.x;
            _window.y = _local_3.y;
            _window.visible = true;
            _window.activate();
        }

        public function disappear():void
        {
            _window.visible = false;
        }

        public function set friendId(_arg_1:int):void
        {
            _SafeStr_1880 = _arg_1;
        }

        private function createWindow():void
        {
            _window = _SafeStr_124(_friendList.windowManager.buildFromXML(XML(_friendList.assets.getAssetByName("relationship_chooser_xml").content)));
            _window.procedure = onWindowEvent;
            _window.visible = false;
        }

        private function destroyWindow():void
        {
            if (_window)
            {
                _window.dispose();
                _window = null;
            };
        }

        private function onWindowEvent(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                switch (_arg_2.name)
                {
                    case "item_none":
                        _friendList.setRelationshipStatus(_SafeStr_1880, 0);
                        break;
                    case "item_heart":
                        _friendList.setRelationshipStatus(_SafeStr_1880, 1);
                        break;
                    case "item_smile":
                        _friendList.setRelationshipStatus(_SafeStr_1880, 2);
                        break;
                    case "item_bobba":
                        _friendList.setRelationshipStatus(_SafeStr_1880, 3);
                };
                _window.visible = false;
            };
            if (_arg_1.type == "WE_UNFOCUSED")
            {
                _window.visible = false;
            };
        }


    }
}

