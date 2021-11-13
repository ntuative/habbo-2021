package com.sulake.habbo.toolbar.extensions
{
    import com.sulake.habbo.toolbar.HabboToolbar;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.utils.Timer;
    import flash.display.BitmapData;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.catalog.GetHabboClubExtendOfferMessageComposer;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.inventory.events.HabboInventoryHabboClubEvent;
    import flash.events.TimerEvent;
    import com.sulake.core.window.components.ITextWindow;
    import flash.geom.Rectangle;
    import flash.geom.Point;
    import com.sulake.core.window.components.IIconWindow;

    public class ClubDiscountPromoExtension 
    {

        private static const _SafeStr_3789:String = "club_promo";
        private static const ICON_STYLE_VIP:int = 14;
        private static const LINK_COLOR_NORMAL:uint = 0xFFFFFF;
        private static const LINK_COLOR_HIGHLIGHT:uint = 12247545;

        private var _toolbar:HabboToolbar;
        private var _SafeStr_570:IWindowContainer;
        private var _disposed:Boolean = false;
        private var _SafeStr_3790:IBitmapWrapperWindow;
        private var _SafeStr_3779:Timer;
        private var _SafeStr_3791:int = 0;
        private var _animBlockMoveAmount:int;
        private var _SafeStr_3792:Timer;
        private var _SafeStr_3793:BitmapData;
        private var _SafeStr_3786:Timer;

        public function ClubDiscountPromoExtension(_arg_1:HabboToolbar)
        {
            _toolbar = _arg_1;
        }

        private function createWindow():IWindowContainer
        {
            var _local_4:IAsset;
            var _local_2:IRegionWindow;
            var _local_1:IWindowContainer;
            var _local_3:XmlAsset = (_toolbar.assets.getAssetByName("club_discount_promotion_xml") as XmlAsset);
            if (_local_3)
            {
                _local_1 = (_toolbar.windowManager.buildFromXML((_local_3.content as XML), 1) as IWindowContainer);
                if (_local_1)
                {
                    _SafeStr_3790 = (_local_1.findChildByName("flashing_animation") as IBitmapWrapperWindow);
                    if (_SafeStr_3790)
                    {
                        _local_4 = (_toolbar.assets.getAssetByName("extend_hilite_png") as IAsset);
                        if (_local_4)
                        {
                            _SafeStr_3793 = (_local_4.content as BitmapData);
                            if (_SafeStr_3793)
                            {
                                _SafeStr_3790.bitmap = _SafeStr_3793.clone();
                            };
                        };
                        _SafeStr_3790.visible = false;
                    };
                    _local_2 = (_local_1.findChildByName("text_region") as IRegionWindow);
                    if (_local_2)
                    {
                        _local_2.addEventListener("WME_CLICK", onTextRegionClicked);
                        _local_2.addEventListener("WME_OVER", onTextRegionMouseOver);
                        _local_2.addEventListener("WME_OUT", onTextRegionMouseOut);
                    };
                    assignState();
                };
            };
            return (_local_1);
        }

        private function destroyWindow():void
        {
            if (_SafeStr_570)
            {
                _SafeStr_570.dispose();
                _SafeStr_570 = null;
                _SafeStr_3790 = null;
            };
            animate(false);
            destroyExpirationTimer();
        }

        public function dispose():void
        {
            if (((_disposed) || (!(_toolbar))))
            {
                return;
            };
            if (_toolbar.extensionView)
            {
                _toolbar.extensionView.detachExtension("club_promo");
            };
            clearAnimation();
            destroyWindow();
            _toolbar = null;
            _disposed = true;
        }

        private function onTextRegionClicked(_arg_1:WindowMouseEvent):void
        {
            if (_toolbar.inventory.clubLevel == 2)
            {
                _toolbar.connection.send(new EventLogMessageComposer("DiscountPromo", "discount", "client.club.extend.discount.clicked"));
                _toolbar.connection.send(new GetHabboClubExtendOfferMessageComposer());
            };
        }

        private function assignState():void
        {
            switch (_toolbar.inventory.clubLevel)
            {
                case 0:
                    setText("${discount.bar.no.club.promo}");
                    setClubIcon(14);
                    break;
                case 2:
                    setText("${discount.bar.vip.expiring}");
                    setClubIcon(14);
                default:
            };
            animate(true);
        }

        public function onClubChanged(_arg_1:HabboInventoryHabboClubEvent):void
        {
            if ((((_toolbar.inventory.clubIsExpiring) && (!(_SafeStr_570))) && (isExtensionEnabled())))
            {
                _SafeStr_570 = createWindow();
                if (_SafeStr_3786 != null)
                {
                    destroyExpirationTimer();
                };
                if (((_toolbar.inventory.clubMinutesUntilExpiration < 1440) && (_toolbar.inventory.clubMinutesUntilExpiration > 0)))
                {
                    _SafeStr_3786 = new Timer(((_toolbar.inventory.clubMinutesUntilExpiration * 60) * 1000), 1);
                    _SafeStr_3786.addEventListener("timerComplete", onExtendOfferExpire);
                    _SafeStr_3786.start();
                };
                assignState();
                _toolbar.extensionView.attachExtension("club_promo", _SafeStr_570, 10);
            }
            else
            {
                _toolbar.extensionView.detachExtension("club_promo");
                destroyWindow();
            };
        }

        private function destroyExpirationTimer():void
        {
            if (_SafeStr_3786)
            {
                _SafeStr_3786.stop();
                _SafeStr_3786.removeEventListener("timerComplete", onExtendOfferExpire);
                _SafeStr_3786 = null;
            };
        }

        private function onExtendOfferExpire(_arg_1:TimerEvent):void
        {
            _toolbar.extensionView.detachExtension("club_promo");
            destroyWindow();
        }

        private function isExtensionEnabled():Boolean
        {
            if (((_toolbar.inventory.clubLevel == 2) && (_toolbar.getBoolean("club.membership.extend.vip.promotion.enabled"))))
            {
                return (true);
            };
            return (false);
        }

        private function setText(_arg_1:String):void
        {
            var _local_2:ITextWindow;
            var _local_3:ITextWindow;
            if (_SafeStr_570)
            {
                _local_2 = (_SafeStr_570.findChildByName("promo_text") as ITextWindow);
                _local_3 = (_SafeStr_570.findChildByName("promo_text_shadow") as ITextWindow);
                if (_local_2)
                {
                    _local_2.text = _arg_1;
                };
                if (_local_3)
                {
                    _local_3.text = _arg_1;
                };
            };
        }

        private function animate(_arg_1:Boolean):void
        {
            if (_arg_1)
            {
                Logger.log("Animate window");
                if (_SafeStr_3792)
                {
                    _SafeStr_3792.stop();
                };
                _SafeStr_3792 = new Timer(15000);
                _SafeStr_3792.addEventListener("timer", onTriggerTimer);
                _SafeStr_3792.start();
            }
            else
            {
                if (_SafeStr_3792)
                {
                    _SafeStr_3792.stop();
                    _SafeStr_3792 = null;
                };
                clearAnimation();
            };
        }

        private function clearAnimation():void
        {
            if (_SafeStr_3790)
            {
                _SafeStr_3790.visible = false;
                _SafeStr_3790.bitmap = null;
                _SafeStr_3790 = null;
                _SafeStr_570.invalidate();
                if (_SafeStr_3779)
                {
                    _SafeStr_3779.stop();
                    _SafeStr_3779 = null;
                };
            };
        }

        private function onTriggerTimer(_arg_1:TimerEvent):void
        {
            if (_SafeStr_3790)
            {
                if (_SafeStr_3790.context)
                {
                    _SafeStr_3790.visible = true;
                    resetAnimationVariables();
                    startAnimationTimer();
                };
            };
        }

        private function resetAnimationVariables():void
        {
            _SafeStr_3790.x = 3;
            _SafeStr_3790.y = 3;
            _SafeStr_3790.bitmap = _SafeStr_3793.clone();
            _SafeStr_3790.height = (_SafeStr_570.height - 6);
            _SafeStr_3790.width = _SafeStr_3790.bitmap.width;
            _SafeStr_3790.invalidate();
            _animBlockMoveAmount = ((_SafeStr_570.width - 7) - _SafeStr_3790.bitmap.width);
            _SafeStr_3791 = 0;
        }

        private function startAnimationTimer():void
        {
            _SafeStr_3779 = new Timer(25, 26);
            _SafeStr_3779.addEventListener("timer", onAnimationTimer);
            _SafeStr_3779.addEventListener("timerComplete", onAnimationTimerComplete);
            _SafeStr_3779.start();
        }

        private function onAnimationTimer(_arg_1:TimerEvent):void
        {
            var _local_2:int;
            var _local_3:BitmapData;
            if (_SafeStr_3790)
            {
                _SafeStr_3790.x = (3 + ((_SafeStr_3791 / 20) * _animBlockMoveAmount));
                if (_SafeStr_3790.x > _animBlockMoveAmount)
                {
                    _local_2 = ((_SafeStr_570.width - 4) - _SafeStr_3790.x);
                    _local_3 = new BitmapData(_local_2, _SafeStr_3793.height);
                    _local_3.copyPixels(_SafeStr_3793, new Rectangle(0, 0, _local_2, _SafeStr_3793.height), new Point(0, 0));
                    _SafeStr_3790.bitmap = _local_3;
                    _SafeStr_3790.width = _local_2;
                };
                _SafeStr_3790.invalidate();
                _SafeStr_3791++;
            };
        }

        private function onAnimationTimerComplete(_arg_1:TimerEvent):void
        {
            clearAnimation();
        }

        private function setClubIcon(_arg_1:int):void
        {
            var _local_2:IIconWindow;
            if (_SafeStr_570)
            {
                _local_2 = (_SafeStr_570.findChildByName("club_icon") as IIconWindow);
                if (_local_2)
                {
                    _local_2.style = _arg_1;
                    _local_2.invalidate();
                };
            };
        }

        private function onTextRegionMouseOver(_arg_1:WindowMouseEvent):void
        {
            var _local_2:ITextWindow;
            if (_SafeStr_570)
            {
                _local_2 = (_SafeStr_570.findChildByName("promo_text") as ITextWindow);
                _local_2.textColor = 12247545;
            };
        }

        private function onTextRegionMouseOut(_arg_1:WindowMouseEvent):void
        {
            var _local_2:ITextWindow;
            if (_SafeStr_570)
            {
                _local_2 = (_SafeStr_570.findChildByName("promo_text") as ITextWindow);
                _local_2.textColor = 0xFFFFFF;
            };
        }


    }
}

