package com.sulake.habbo.friendlist
{
    import com.sulake.core.runtime.IDisposable;
    import flash.utils.Dictionary;
    import com.sulake.core.window.components.IFrameWindow;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class AlertView implements IDisposable 
    {

        private static var _SafeStr_2465:Dictionary = new Dictionary();

        private var _friendList:HabboFriendList;
        private var _SafeStr_2466:IFrameWindow;
        private var _xmlFileName:String;
        private var _SafeStr_906:String;
        private var _disposed:Boolean;

        public function AlertView(_arg_1:HabboFriendList, _arg_2:String, _arg_3:String=null)
        {
            _friendList = _arg_1;
            _xmlFileName = _arg_2;
            _SafeStr_906 = _arg_3;
        }

        public function show():void
        {
            var _local_1:IFrameWindow = IFrameWindow(_SafeStr_2465[_xmlFileName]);
            if (_local_1 != null)
            {
                _local_1.dispose();
            };
            _SafeStr_2466 = getAlert();
            if (_SafeStr_906 != null)
            {
                _SafeStr_2466.caption = _SafeStr_906;
            };
            setupContent(_SafeStr_2466.content);
            var _local_2:Rectangle = Util.getLocationRelativeTo(_friendList.view.mainWindow, _SafeStr_2466.width, _SafeStr_2466.height);
            _SafeStr_2466.x = _local_2.x;
            _SafeStr_2466.y = _local_2.y;
            _SafeStr_2465[_xmlFileName] = _SafeStr_2466;
        }

        public function dispose():void
        {
            if (_disposed)
            {
                return;
            };
            _disposed = true;
            if (_SafeStr_2466 != null)
            {
                _SafeStr_2466.destroy();
                _SafeStr_2466 = null;
            };
            _friendList = null;
        }

        internal function setupContent(_arg_1:IWindowContainer):void
        {
        }

        internal function onClose(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            dispose();
        }

        private function getAlert():IFrameWindow
        {
            var _local_1:IFrameWindow = IFrameWindow(_friendList.getXmlWindow(this._xmlFileName));
            var _local_2:IWindow = _local_1.findChildByTag("close");
            _local_2.procedure = onClose;
            return (_local_1);
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get friendList():HabboFriendList
        {
            return (_friendList);
        }


    }
}

