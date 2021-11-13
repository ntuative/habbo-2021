package com.sulake.habbo.ui.widget.chatinput.styleselector
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.components._SafeStr_124;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.core.window.components.IItemGridWindow;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindowContainer;
    import flash.geom.Point;

    public class ChatStyleGridView implements IDisposable 
    {

        private static const SCREEN_LEFT_BORDER:int = 92;

        private var _window:_SafeStr_124;
        private var _SafeStr_3967:ChatStyleSelector;

        public function ChatStyleGridView(_arg_1:ChatStyleSelector, _arg_2:ISessionDataManager)
        {
            _SafeStr_3967 = _arg_1;
            var _local_3:IAssetLibrary = _arg_1.chatInputView.widget.assets;
            _window = _SafeStr_124(_arg_1.chatInputView.widget.windowManager.buildFromXML(XML(_local_3.getAssetByName("styleselector_menu_new_xml").content)));
            _window.visible = false;
        }

        public function dispose():void
        {
            _window.dispose();
            _window = null;
            _SafeStr_3967 = null;
        }

        public function get disposed():Boolean
        {
            return (_window == null);
        }

        public function get grid():IItemGridWindow
        {
            return (IItemGridWindow(_window.findChildByName("itemgrid")));
        }

        public function get window():_SafeStr_124
        {
            return (_window);
        }

        public function alignToSelector(_arg_1:IWindowContainer):void
        {
            var _local_2:int;
            var _local_4:Rectangle = new Rectangle();
            _arg_1.getGlobalRectangle(_local_4);
            var _local_3:IWindowContainer = IWindowContainer(_window.parent);
            _local_3.x = (_local_4.right - _window.width);
            _local_3.y = (_local_4.bottom - _window.height);
            var _local_5:Point = new Point();
            _local_3.getGlobalPosition(_local_5);
            if (_local_5.x < 92)
            {
                _local_2 = (92 - _local_5.x);
                _local_3.x = (_local_3.x + _local_2);
            };
            _local_3.x = _local_4.x;
            _local_3.y = ((_local_4.bottom - 35) - _window.height);
        }


    }
}

