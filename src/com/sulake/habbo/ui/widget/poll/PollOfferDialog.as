package com.sulake.habbo.ui.widget.poll
{
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetPollMessage;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class PollOfferDialog implements IPollDialog 
    {

        public static const _SafeStr_3049:String = "POLL_OFFER_STATE_OK";
        public static const CANCEL:String = "POLL_OFFER_STATE_CANCEL";
        public static const UNKNOWN:String = "POLL_OFFER_STATE_UNKNOWN";

        private var _disposed:Boolean = false;
        private var _window:IFrameWindow;
        private var _state:String = "POLL_OFFER_STATE_UNKNOWN";
        private var _SafeStr_1324:PollWidget;
        private var _SafeStr_698:int = -1;

        public function PollOfferDialog(_arg_1:int, _arg_2:String, _arg_3:String, _arg_4:PollWidget)
        {
            super();
            var _local_9:IWindow = null;
            var _local_5:IWindow = null;
            var _local_7:IWindow = null;
            var _local_6:IWindow = null;
            var _local_8:IItemListWindow = null;
            var _local_12:ITextWindow = null;
            var _local_10:ITextWindow = null;
            _SafeStr_698 = _arg_1;
            _SafeStr_1324 = _arg_4;
            var _local_11:XmlAsset = (_SafeStr_1324.assets.getAssetByName("poll_offer") as XmlAsset);
            if (_local_11 != null)
            {
                _window = (_SafeStr_1324.windowManager.buildFromXML((_local_11.content as XML)) as IFrameWindow);
                if (_window)
                {
                    _window.center();
                    _local_9 = _window.findChildByName("poll_offer_button_ok");
                    if (_local_9 != null)
                    {
                        _local_9.addEventListener("WME_CLICK", onOk);
                    };
                    _local_5 = _window.findChildByName("poll_offer_button_cancel");
                    if (_local_5 != null)
                    {
                        _local_5.addEventListener("WME_CLICK", onCancel);
                    };
                    _local_7 = _window.findChildByName("poll_offer_button_later");
                    if (_local_7 != null)
                    {
                        _local_7.addEventListener("WME_CLICK", onLater);
                    };
                    _local_6 = _window.findChildByName("header_button_close");
                    if (_local_6 != null)
                    {
                        _local_6.addEventListener("WME_CLICK", onClose);
                    };
                    _local_12 = (_window.findChildByName("poll_offer_headline") as ITextWindow);
                    if (_local_12)
                    {
                        _local_12.htmlText = _arg_2;
                        _local_8 = (_window.findChildByName("poll_offer_headline_wrapper") as IItemListWindow);
                        if (_local_8)
                        {
                            _window.height = (_window.height + (_local_8.scrollableRegion.height - _local_8.visibleRegion.height));
                        };
                    };
                    _local_10 = (_window.findChildByName("poll_offer_summary") as ITextWindow);
                    if (_local_10)
                    {
                        _local_10.htmlText = _arg_3;
                        _local_8 = (_window.findChildByName("poll_offer_summary_wrapper") as IItemListWindow);
                        if (_local_8)
                        {
                            _window.height = (_window.height + (_local_8.scrollableRegion.height - _local_8.visibleRegion.height));
                        };
                    };
                };
            };
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get state():String
        {
            return (_state);
        }

        public function start():void
        {
        }

        public function dispose():void
        {
            if (_disposed)
            {
                return;
            };
            _disposed = true;
            if (_window)
            {
                _window.dispose();
                _window = null;
            };
            _SafeStr_1324 = null;
        }

        private function onOk(_arg_1:WindowEvent):void
        {
            if (_state != "POLL_OFFER_STATE_UNKNOWN")
            {
                return;
            };
            _state = "POLL_OFFER_STATE_OK";
            _SafeStr_1324.messageListener.processWidgetMessage(new RoomWidgetPollMessage("RWPM_START", _SafeStr_698));
        }

        private function onCancel(_arg_1:WindowEvent):void
        {
            if (_state != "POLL_OFFER_STATE_UNKNOWN")
            {
                return;
            };
            _state = "POLL_OFFER_STATE_CANCEL";
            _SafeStr_1324.messageListener.processWidgetMessage(new RoomWidgetPollMessage("RWPM_REJECT", _SafeStr_698));
            _SafeStr_1324.pollCancelled(_SafeStr_698);
        }

        private function onLater(_arg_1:WindowEvent):void
        {
            if (_state != "POLL_OFFER_STATE_UNKNOWN")
            {
                return;
            };
            _state = "POLL_OFFER_STATE_CANCEL";
            _SafeStr_1324.pollCancelled(_SafeStr_698);
        }

        private function onClose(_arg_1:WindowEvent):void
        {
            if (_state != "POLL_OFFER_STATE_UNKNOWN")
            {
                return;
            };
            _state = "POLL_OFFER_STATE_CANCEL";
            _SafeStr_1324.messageListener.processWidgetMessage(new RoomWidgetPollMessage("RWPM_REJECT", _SafeStr_698));
            _SafeStr_1324.pollCancelled(_SafeStr_698);
        }


    }
}

