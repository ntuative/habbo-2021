package com.sulake.habbo.ui.widget.furniture.mysterybox
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.habbo.ui.widget.furniture.contextmenu.FurnitureContextMenuWidget;
    import com.sulake.habbo.window.utils.IModalDialog;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.habbo.communication.messages.parser.mysterybox.ShowMysteryBoxWaitMessageEvent;
    import com.sulake.habbo.communication.messages.parser.mysterybox.CancelMysteryBoxWaitMessageEvent;
    import com.sulake.habbo.communication.messages.parser.mysterybox.GotMysteryBoxPrizeMessageEvent;
    import com.sulake.habbo.communication.messages.parser.mysterybox.GotMysteryBoxPrizeMessageParser;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.habbo.communication.messages.outgoing.mysterybox.MysteryBoxWaitingCanceledMessageComposer;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.room._SafeStr_147;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.display.BitmapData;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.UseFurnitureMessageComposer;
    import com.sulake.core.communication.connection.IConnection;

    public class MysteryBoxOpenDialogView implements IDisposable, IGetImageListener 
    {

        private var _disposed:Boolean;
        private var _SafeStr_1324:FurnitureContextMenuWidget;
        private var _SafeStr_1665:IModalDialog;
        private var _window:IWindowContainer;
        private var _SafeStr_4065:IRoomObject;
        private var _SafeStr_4116:ShowMysteryBoxWaitMessageEvent;
        private var _SafeStr_4117:CancelMysteryBoxWaitMessageEvent;
        private var _SafeStr_4118:GotMysteryBoxPrizeMessageEvent;
        private var _SafeStr_1484:int = -1;

        public function MysteryBoxOpenDialogView(_arg_1:FurnitureContextMenuWidget)
        {
            _SafeStr_1324 = _arg_1;
            _SafeStr_4116 = new ShowMysteryBoxWaitMessageEvent(onShowMysteryBoxWait);
            _SafeStr_4117 = new CancelMysteryBoxWaitMessageEvent(onCancelMysteryBoxWait);
            _SafeStr_4118 = new GotMysteryBoxPrizeMessageEvent(onGotMysteryBoxPrize);
            connection.addMessageEvent(_SafeStr_4116);
            connection.addMessageEvent(_SafeStr_4117);
            connection.addMessageEvent(_SafeStr_4118);
        }

        private function onShowMysteryBoxWait(_arg_1:ShowMysteryBoxWaitMessageEvent):void
        {
            showWaitWindow();
        }

        private function onCancelMysteryBoxWait(_arg_1:CancelMysteryBoxWaitMessageEvent):void
        {
            closeWindow();
        }

        private function onGotMysteryBoxPrize(_arg_1:GotMysteryBoxPrizeMessageEvent):void
        {
            var _local_2:GotMysteryBoxPrizeMessageParser = _arg_1.getParser();
            showRewardWindow(_local_2.contentType, _local_2.classId);
        }

        private function showWaitWindow():void
        {
            closeWindow();
            var _local_1:XML = (_SafeStr_1324.assets.getAssetByName("mystery_box_open_dialog").content as XML);
            _SafeStr_1665 = _SafeStr_1324.handler.container.windowManager.buildModalDialogFromXML(_local_1);
            _window = (_SafeStr_1665.rootWindow as IWindowContainer);
            _window.procedure = waitWindowProcedure;
            var _local_4:Boolean = _SafeStr_1324.handler.container.isOwnerOfFurniture(_SafeStr_4065);
            var _local_5:String = ((_local_4) ? "mysterybox.dialog.owner." : "mysterybox.dialog.other.");
            _window.caption = (("${" + _local_5) + "title}");
            _window.findChildByName("subtitle_text").caption = (("${" + _local_5) + "subtitle}");
            _window.findChildByName("waiting_text").caption = (("${" + _local_5) + "waiting}");
            _window.findChildByName("cancel_button").caption = (("${" + _local_5) + "cancel}");
            IStaticBitmapWrapperWindow(_window.findChildByName("reward_base")).assetUri = ((_local_4) ? "mysterybox_box_base" : "mysterybox_key_base");
            IStaticBitmapWrapperWindow(_window.findChildByName("reward_overlay")).assetUri = ((_local_4) ? "mysterybox_box_overlay" : "mysterybox_key_overlay");
            IStaticBitmapWrapperWindow(_window.findChildByName("needed_base")).assetUri = ((_local_4) ? "mysterybox_key_base" : "mysterybox_box_base");
            IStaticBitmapWrapperWindow(_window.findChildByName("needed_overlay")).assetUri = ((_local_4) ? "mysterybox_key_overlay" : "mysterybox_box_overlay");
            var _local_6:ISessionDataManager = _SafeStr_1324.handler.container.sessionDataManager;
            var _local_2:String = ((_local_4) ? _local_6.mysteryBoxColor : _local_6.mysteryKeyColor);
            if (((_local_2 == null) || (_local_2 == "")))
            {
                return;
            };
            var _local_3:uint = MysteryBoxToolbarExtension.KEY_COLORS[_local_2.toLowerCase()];
            _window.findChildByName("reward_base").color = _local_3;
            _window.findChildByName("needed_base").color = _local_3;
        }

        private function waitWindowProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            switch (_arg_1.target.name)
            {
                case "header_button_close":
                case "cancel_button":
                    closeWindow();
                    connection.send(new MysteryBoxWaitingCanceledMessageComposer(_SafeStr_1324.handler.container.getFurnitureOwnerId(_SafeStr_4065)));
                    return;
            };
        }

        private function showRewardWindow(_arg_1:String, _arg_2:int):void
        {
            closeWindow();
            var _local_3:XML = (_SafeStr_1324.assets.getAssetByName("mystery_box_reward").content as XML);
            _SafeStr_1665 = _SafeStr_1324.handler.container.windowManager.buildModalDialogFromXML(_local_3);
            _window = (_SafeStr_1665.rootWindow as IWindowContainer);
            _window.procedure = rewardWindowProcedure;
            _SafeStr_1484 = -1;
            var _local_4:_SafeStr_147;
            switch (_arg_1)
            {
                case "s":
                    _local_4 = _SafeStr_1324.handler.container.roomEngine.getFurnitureImage(_arg_2, new Vector3d(90, 0, 0), 64, this, 0);
                    break;
                case "i":
                    _local_4 = _SafeStr_1324.handler.container.roomEngine.getWallItemImage(_arg_2, new Vector3d(90, 0, 0), 64, this, 0);
                    break;
                case "e":
                    rewardBitmap = _SafeStr_1324.handler.container.catalog.getPixelEffectIcon(_arg_2);
                    break;
                case "h":
                    rewardBitmap = _SafeStr_1324.handler.container.catalog.getSubscriptionProductIcon(_arg_2);
                    break;
                default:
                    return;
            };
            if (_local_4 != null)
            {
                if (_local_4.data != null)
                {
                    rewardBitmap = _local_4.data;
                };
                _SafeStr_1484 = _local_4.id;
            };
        }

        private function set rewardBitmap(_arg_1:BitmapData):void
        {
            if (((_window == null) || (_window.disposed)))
            {
                return;
            };
            var _local_3:IBitmapWrapperWindow = (_window.findChildByName("reward_image") as IBitmapWrapperWindow);
            var _local_2:IWindow = _window.findChildByName("bitmap_container");
            _local_3.bitmap = _arg_1;
            _local_2.width = _arg_1.width;
            _local_2.height = _arg_1.height;
            _local_2.width++;
        }

        private function rewardWindowProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            switch (_arg_1.target.name)
            {
                case "header_button_close":
                case "close_button":
                    closeWindow();
                    return;
            };
        }

        private function closeWindow():void
        {
            if (((!(_SafeStr_1665 == null)) && (!(_SafeStr_1665.disposed))))
            {
                _window = null;
                _SafeStr_1665.dispose();
                _SafeStr_1665 = null;
            };
        }

        public function dispose():void
        {
            if (_disposed)
            {
                return;
            };
            closeWindow();
            connection.removeMessageEvent(_SafeStr_4116);
            connection.removeMessageEvent(_SafeStr_4117);
            connection.removeMessageEvent(_SafeStr_4118);
            _SafeStr_4116 = null;
            _SafeStr_4117 = null;
            _SafeStr_4118 = null;
            _SafeStr_4065 = null;
            _SafeStr_1324 = null;
            _disposed = true;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function startOpenFlow(_arg_1:IRoomObject):void
        {
            _SafeStr_4065 = _arg_1;
            connection.send(new UseFurnitureMessageComposer(_arg_1.getId()));
        }

        private function get connection():IConnection
        {
            return (_SafeStr_1324.handler.container.connection);
        }

        public function imageReady(_arg_1:int, _arg_2:BitmapData):void
        {
            if (_arg_1 == _SafeStr_1484)
            {
                _SafeStr_1484 = -1;
                rewardBitmap = _arg_2;
            };
        }

        public function imageFailed(_arg_1:int):void
        {
        }


    }
}

