package com.sulake.habbo.ui.widget.furniture.effectbox
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.ui.widget.furniture.contextmenu.FurnitureContextMenuWidget;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.UseFurnitureMessageComposer;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;

    public class EffectBoxOpenDialogView implements IDisposable 
    {

        private static const _SafeStr_3113:String = "header_button_close";
        private static const _SafeStr_3937:String = "cancel";
        private static const _SafeStr_3119:String = "ok";

        private var _window:IWindowContainer;
        private var _disposed:Boolean = false;
        private var _SafeStr_1324:FurnitureContextMenuWidget;
        private var _windowManager:IHabboWindowManager;
        private var _assets:IAssetLibrary;
        private var _SafeStr_4089:int;

        public function EffectBoxOpenDialogView(_arg_1:FurnitureContextMenuWidget)
        {
            _SafeStr_1324 = _arg_1;
            _windowManager = _arg_1.windowManager;
            _assets = _SafeStr_1324.assets;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function dispose():void
        {
            if (disposed)
            {
                return;
            };
            _disposed = true;
            if (_window)
            {
                _window.dispose();
                _window = null;
            };
        }

        public function open(_arg_1:int):void
        {
            _SafeStr_4089 = _arg_1;
            setWindowContent();
            _window.visible = true;
        }

        private function setWindowContent():void
        {
            var _local_1:String;
            if (!_window)
            {
                _local_1 = "effectbox_xml";
                _window = (_windowManager.buildFromXML((_assets.getAssetByName(_local_1).content as XML)) as IWindowContainer);
                addClickListener("ok");
                addClickListener("cancel");
                addClickListener("header_button_close");
                _window.center();
            };
        }

        public function close():void
        {
            if (_window != null)
            {
                _window.visible = false;
            };
        }

        private function addClickListener(_arg_1:String):void
        {
            _window.findChildByName(_arg_1).addEventListener("WME_CLICK", onMouseClick);
        }

        private function onMouseClick(_arg_1:WindowMouseEvent):void
        {
            var _local_2:RoomWidgetMessage = null;
            switch (_arg_1.target.name)
            {
                case "header_button_close":
                case "cancel":
                    close();
                    break;
                case "ok":
                    connection.send(new UseFurnitureMessageComposer(_SafeStr_4089));
                    close();
            };
            if (_local_2)
            {
                _SafeStr_1324.messageListener.processWidgetMessage(_local_2);
            };
        }

        private function get connection():IConnection
        {
            return (_SafeStr_1324.handler.container.connection);
        }


    }
}

