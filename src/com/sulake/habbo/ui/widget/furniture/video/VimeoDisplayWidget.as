package com.sulake.habbo.ui.widget.furniture.video
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import com.vimeo.api.VimeoPlayer;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.ui.handler.FurnitureVimeoDisplayWidgetHandler;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IDisplayObjectWrapper;
    import flash.display.DisplayObject;
    import flash.events.MouseEvent;
    import com.sulake.core.window.events.WindowKeyboardEvent;
    import com.sulake.core.window.events.WindowEvent;

    public class VimeoDisplayWidget extends RoomWidgetBase
    {

        private static const _SafeStr_4137:String = "9a106b76302cbce891b714afdc6a0c93";

        private var _SafeStr_4138:VimeoPlayer;
        private var _mainWindow:IWindowContainer;
        private var _roomObject:IRoomObject;

        public function VimeoDisplayWidget(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary, _arg_4:IHabboLocalizationManager)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
            ownHandler.widget = this;
        }

        private function get ownHandler():FurnitureVimeoDisplayWidgetHandler
        {
            return (_SafeStr_3915 as FurnitureVimeoDisplayWidgetHandler);
        }

        override public function get mainWindow():IWindow
        {
            return (_mainWindow);
        }

        public function show(_arg_1:IRoomObject, _arg_2:Boolean, _arg_3:int):void
        {
            _roomObject = _arg_1;
            createWindow(_arg_2, _arg_3);
            _mainWindow.visible = true;
        }

        private function createWindow(_arg_1:Boolean, _arg_2:int):void
        {
            if (_mainWindow != null)
            {
                return;
            };
            _mainWindow = (windowManager.buildFromXML(XML(assets.getAssetByName("vimeo_viewer_xml").content)) as IWindowContainer);
            _mainWindow.findChildByName("video_id_editor").visible = _arg_1;
            _mainWindow.findChildByName("video_wrapper").visible = (_arg_2 > 0);
            _mainWindow.procedure = windowProcedure;
            _mainWindow.center();
            var _local_3:IDisplayObjectWrapper = IDisplayObjectWrapper(_mainWindow.findChildByName("video_wrapper"));
            _SafeStr_4138 = new VimeoPlayer("9a106b76302cbce891b714afdc6a0c93", _arg_2, _local_3.width, _local_3.height);
            _local_3.setDisplayObject(_SafeStr_4138);
            _SafeStr_4138.addEventListener("mouseUp", onVideoMouseEvent);
            _SafeStr_4138.addEventListener("mouseMove", onVideoMouseEvent);
        }

        private function onVideoMouseEvent(_arg_1:MouseEvent):void
        {
            if (_mainWindow != null)
            {
                DisplayObject(_arg_1.target).stage.dispatchEvent(_arg_1);
            };
        }

        private function windowProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:int;
            switch (_arg_1.type)
            {
                case "WME_CLICK":
                    switch (_arg_2.name)
                    {
                        case "header_button_close":
                            hide(_roomObject);
                    };
                    return;
                case "WE_RESIZE":
                    switch (_arg_2.name)
                    {
                        case "video_wrapper":
                            if (_SafeStr_4138 != null)
                            {
                                _SafeStr_4138.setSize(_arg_2.width, _arg_2.height);
                            };
                    };
                    return;
                case "WKE_KEY_DOWN":
                    if (WindowKeyboardEvent(_arg_1).charCode == 13)
                    {
                        _local_3 = int(_mainWindow.findChildByName("video_id").caption);
                        ownHandler.setVideo(_roomObject, _local_3);
                        _mainWindow.findChildByName("video_wrapper").visible = (_local_3 > 0);
                        _SafeStr_4138.loadVideo(_local_3);
                    };
                    return;
            };
        }

        public function hide(_arg_1:IRoomObject):void
        {
            if (_roomObject != _arg_1)
            {
                return;
            };
            if (_SafeStr_4138 != null)
            {
                _SafeStr_4138.destroy();
                _SafeStr_4138 = null;
            };
            if (_mainWindow != null)
            {
                _mainWindow.dispose();
                _mainWindow = null;
            };
            _roomObject = null;
        }


    }
}