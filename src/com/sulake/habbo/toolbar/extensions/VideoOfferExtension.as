package com.sulake.habbo.toolbar.extensions
{
    import com.sulake.habbo.catalog.IVideoOfferLauncher;
    import com.sulake.habbo.toolbar.HabboToolbar;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.core.window.components.IIconWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.inventory.events.HabboInventoryHabboClubEvent;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.display.BitmapData;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.assets.XmlAsset;
    import flash.geom.Point;
    import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.catalog.enum.VideoOfferTypeEnum;

    public class VideoOfferExtension implements IVideoOfferLauncher 
    {

        private static const _SafeStr_3789:String = "video_offer";
        private static const LINK_COLOR_NORMAL:uint = 0xFFFFFF;
        private static const LINK_COLOR_HIGHLIGHT:uint = 12247545;
        private static const CLOSE_COLOR_NORMAL:uint = 0x666666;
        private static const CLOSE_COLOR_OVER:uint = 0xCCCCCC;

        private var _toolbar:HabboToolbar;
        private var _window:IWindowContainer;
        private var _textRegion:IRegionWindow;
        private var _closeButton:IIconWindow;
        private var _SafeStr_3794:Boolean = false;

        public function VideoOfferExtension(_arg_1:HabboToolbar)
        {
            _toolbar = _arg_1;
        }

        public function get window():IWindow
        {
            return (_window);
        }

        public function onClubChanged(_arg_1:HabboInventoryHabboClubEvent):void
        {
            if ((((_toolbar.inventory.clubIsExpiring) && (!(_window))) && (isClubExtensionEnabled())))
            {
                _toolbar.extensionView.detachExtension("video_offer");
                destroyWindow();
                return;
            };
            if (((!(_SafeStr_3794)) && (!(_window))))
            {
                _toolbar.catalog.videoOffers.load(this);
            };
        }

        private function isClubExtensionEnabled():Boolean
        {
            return ((_toolbar.inventory.clubLevel == 2) && (_toolbar.getBoolean("club.membership.extend.vip.promotion.enabled")));
        }

        public function offersAvailable(_arg_1:int):void
        {
            if (_toolbar == null)
            {
                return;
            };
            if ((((_arg_1 <= 0) || (_SafeStr_3794)) || ((_toolbar.inventory.clubIsExpiring) && (isClubExtensionEnabled()))))
            {
                if (_window)
                {
                    destroyWindow();
                };
                return;
            };
            if (!_window)
            {
                _window = createWindow();
            };
        }

        private function createWindow():IWindowContainer
        {
            var _local_2:String;
            var _local_6:ITextWindow;
            var _local_7:ITextWindow;
            var _local_4:BitmapDataAsset;
            var _local_5:BitmapData;
            var _local_8:IBitmapWrapperWindow;
            var _local_1:IWindowContainer;
            var _local_3:XmlAsset = (_toolbar.assets.getAssetByName("video_offer_promotion_xml") as XmlAsset);
            if (_local_3)
            {
                _local_1 = (_toolbar.windowManager.buildFromXML((_local_3.content as XML), 1) as IWindowContainer);
                if (_local_1)
                {
                    _local_2 = _toolbar.localization.getLocalization("supersaverads.video.promo.offer", "Watch a video and earn a credit!");
                    _local_6 = (_local_1.findChildByName("promo_text") as ITextWindow);
                    _local_7 = (_local_1.findChildByName("promo_text_shadow") as ITextWindow);
                    if (_local_6)
                    {
                        _local_6.text = _local_2;
                    };
                    if (_local_7)
                    {
                        _local_7.text = _local_2;
                    };
                    _local_4 = (_toolbar.assets.getAssetByName("offer_icon_png") as BitmapDataAsset);
                    if (_local_4 != null)
                    {
                        _local_5 = (_local_4.content as BitmapData);
                        _local_8 = (_local_1.findChildByName("promo_icon") as IBitmapWrapperWindow);
                        if (((!(_local_5 == null)) && (!(_local_8 == null))))
                        {
                            _local_8.bitmap = new BitmapData(_local_8.width, _local_8.height, true, 0);
                            _local_8.bitmap.copyPixels(_local_5, _local_5.rect, new Point(0, 0));
                        };
                    };
                    _textRegion = (_local_1.findChildByName("text_region") as IRegionWindow);
                    if (_textRegion)
                    {
                        _textRegion.addEventListener("WME_CLICK", onTextRegionClicked);
                        _textRegion.addEventListener("WME_OVER", onTextRegionMouseOver);
                        _textRegion.addEventListener("WME_OUT", onTextRegionMouseOut);
                    };
                    _closeButton = (_local_1.findChildByName("promo_close_icon") as IIconWindow);
                    if (_closeButton)
                    {
                        _closeButton.addEventListener("WME_CLICK", onCloseClicked);
                        _closeButton.addEventListener("WME_OVER", onCloseMouseOver);
                        _closeButton.addEventListener("WME_OUT", onCloseMouseOut);
                    };
                    _toolbar.extensionView.attachExtension("video_offer", _local_1, 10);
                };
            };
            return (_local_1);
        }

        private function destroyWindow():void
        {
            if (_window)
            {
                if (_textRegion)
                {
                    _textRegion.removeEventListener("WME_CLICK", onTextRegionClicked);
                    _textRegion.removeEventListener("WME_OVER", onTextRegionMouseOver);
                    _textRegion.removeEventListener("WME_OUT", onTextRegionMouseOut);
                    _textRegion = null;
                };
                if (_closeButton)
                {
                    _closeButton.removeEventListener("WME_CLICK", onCloseClicked);
                    _closeButton.removeEventListener("WME_OVER", onCloseMouseOver);
                    _closeButton.removeEventListener("WME_OUT", onCloseMouseOut);
                    _closeButton = null;
                };
                _window.dispose();
                _window = null;
            };
        }

        public function dispose():void
        {
            if (_toolbar == null)
            {
                return;
            };
            _toolbar.extensionView.detachExtension("video_offer");
            destroyWindow();
            _toolbar = null;
        }

        private function onCloseClicked(_arg_1:WindowMouseEvent):void
        {
            _SafeStr_3794 = true;
            destroyWindow();
            _toolbar.connection.send(new EventLogMessageComposer("SuperSaverAds", "client_action", "supersaverads.video.promo.close_clicked"));
        }

        private function onCloseMouseOver(_arg_1:WindowMouseEvent):void
        {
            if (_closeButton)
            {
                _closeButton.color = 0xCCCCCC;
            };
        }

        private function onCloseMouseOut(_arg_1:WindowMouseEvent):void
        {
            if (_closeButton)
            {
                _closeButton.color = 0x666666;
            };
        }

        private function onTextRegionClicked(_arg_1:WindowMouseEvent):void
        {
            if (!_toolbar.catalog.videoOffers.launch(VideoOfferTypeEnum.CREDIT))
            {
                destroyWindow();
            };
        }

        private function onTextRegionMouseOver(_arg_1:WindowMouseEvent):void
        {
            var _local_2:ITextWindow;
            if (_window)
            {
                _local_2 = (_window.findChildByName("promo_text") as ITextWindow);
                _local_2.textColor = 12247545;
            };
        }

        private function onTextRegionMouseOut(_arg_1:WindowMouseEvent):void
        {
            var _local_2:ITextWindow;
            if (_window)
            {
                _local_2 = (_window.findChildByName("promo_text") as ITextWindow);
                _local_2.textColor = 0xFFFFFF;
            };
        }


    }
}

