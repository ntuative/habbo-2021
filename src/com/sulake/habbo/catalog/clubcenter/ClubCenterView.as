package com.sulake.habbo.catalog.clubcenter
{
    import com.sulake.habbo.avatar.IAvatarImageListener;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.window.widgets.IRoomPreviewerWidget;
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.habbo.avatar.IAvatarImage;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.window.components._SafeStr_101;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.habbo.communication.messages.incoming.users.ScrKickbackData;
    import com.sulake.habbo.catalog.purse.IPurse;
    import flash.display.BitmapData;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.habbo.utils.FriendlyTime;

    public class ClubCenterView implements IAvatarImageListener 
    {

        private var _SafeStr_1284:HabboClubCenter;
        private var _container:IWindowContainer;
        private var _SafeStr_1324:IRoomPreviewerWidget;
        private var _SafeStr_1382:String;

        public function ClubCenterView(_arg_1:HabboClubCenter, _arg_2:IHabboWindowManager, _arg_3:String)
        {
            _SafeStr_1284 = _arg_1;
            _container = (_arg_2.buildFromXML(XML(_SafeStr_1284.assets.getAssetByName("club_center_xml").content)) as IWindowContainer);
            if (!container)
            {
                return;
            };
            if (!_SafeStr_1284.isKickbackEnabled())
            {
                removeElement("special_breakdown_link");
                removeElement("special_content");
                removeElement("special_content_postit");
                container.invalidate();
            }
            else
            {
                setElementVisibility("special_amount_icon", false);
                setElementVisibility("special_amount_title", false);
                setElementVisibility("special_amount_content", false);
                setElementVisibility("special_breakdown_link", false);
                setElementVisibility("special_time_content", false);
            };
            setElementVisibility("btn_earn", false);
            _SafeStr_1284.getOffers();
            _container.center();
            _container.addEventListener("WE_RELOCATE", onRelocate);
            _SafeStr_1382 = _arg_3;
            _SafeStr_1324 = (IWidgetWindow(_container.findChildByName("avatar")).widget as IRoomPreviewerWidget);
            var _local_4:IAvatarImage = _SafeStr_1284.avatarRenderManager.createAvatarImage(_arg_3, "h", null, this);
            if (_local_4)
            {
                _local_4.setDirection("full", 4);
                _SafeStr_1324.showPreview(_local_4.getCroppedImage("full"));
            };
            container.procedure = onInput;
        }

        public function dispose():void
        {
            if (_container)
            {
                _container.removeEventListener("WE_RELOCATE", onRelocate);
                _container.dispose();
                _container = null;
            };
            _SafeStr_1284 = null;
        }

        public function dataReceived(_arg_1:ScrKickbackData, _arg_2:IPurse, _arg_3:int, _arg_4:BitmapData):void
        {
            var _local_7:int;
            var _local_6:_SafeStr_101;
            var _local_9:String = _SafeStr_1284.resolveClubStatus();
            setElementText("status_title", (("${hccenter.status." + _local_9) + "}"));
            if (((!(_arg_1)) || (!(_arg_2))))
            {
                setElementVisibility("gift_content", false);
                setElementVisibility("special_container", false);
                return;
            };
            setElementVisibility("gift_content", true);
            var _local_5:String = getLocalization((("hccenter.status." + _local_9) + ".info"));
            _local_5 = _local_5.replace("%timeleft%", formatMinutes(_arg_2.minutesUntilExpiration));
            _local_5 = _local_5.replace("%joindate%", _arg_1.firstSubscriptionDate);
            _local_5 = _local_5.replace("%streakduration%", formatDays(_arg_1.currentHcStreak));
            setElementText("status_info", _local_5);
            var _local_8:IBitmapWrapperWindow = (container.findChildByName("hc_badge") as IBitmapWrapperWindow);
            if (((_local_8) && (_arg_4)))
            {
                _local_8.bitmap = _arg_4;
            };
            if (_SafeStr_1284.isKickbackEnabled())
            {
                if (_arg_1.timeUntilPayday < 60)
                {
                    setElementText("special_time_content", getLocalization("hccenter.special.time.soon"));
                }
                else
                {
                    setElementText("special_time_content", formatMinutes(_arg_1.timeUntilPayday));
                };
                setElementVisibility("special_time_content", true);
                _local_7 = (_arg_1.creditRewardForMonthlySpent + _arg_1.creditRewardForStreakBonus);
                if (_local_7 > 0)
                {
                    setElementVisibility("special_amount_icon", true);
                    setElementVisibility("special_amount_title", true);
                    setElementVisibility("special_amount_content", true);
                    setElementVisibility("special_breakdown_link", true);
                    setElementText("special_amount_content", getLocalization("hccenter.special.sum").replace("%credits%", _local_7));
                };
            };
            _local_6 = (container.findChildByName("btn_gift") as _SafeStr_101);
            if (((_local_9 == "active") && (_arg_3 > 0)))
            {
                if (_local_6)
                {
                    _local_6.caption = "${hccenter.btn.gifts.redeem}";
                };
                setElementText("gift_info", getLocalization("hccenter.unclaimedgifts").replace("%unclaimedgifts%", _arg_3));
            }
            else
            {
                if (_local_6)
                {
                    _local_6.caption = "${hccenter.btn.gifts.view}";
                };
                setElementText("gift_info", getLocalization("hccenter.gift.info"));
            };
            _local_6 = (container.findChildByName("btn_buy") as _SafeStr_101);
            if (_local_9 == "active")
            {
                if (_local_6)
                {
                    _local_6.caption = "${hccenter.btn.extend}";
                };
            }
            else
            {
                if (_local_6)
                {
                    _local_6.caption = "${hccenter.btn.buy}";
                };
            };
        }

        public function avatarImageReady(_arg_1:String):void
        {
            var _local_2:IAvatarImage;
            if (_arg_1 == _SafeStr_1382)
            {
                _local_2 = _SafeStr_1284.avatarRenderManager.createAvatarImage(_SafeStr_1382, "h", null, this);
                _local_2.setDirection("full", 4);
                _SafeStr_1324.showPreview(_local_2.getCroppedImage("full"));
            };
        }

        private function onInput(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (((!(_arg_1.type == "WME_DOWN")) || (!(_SafeStr_1284))))
            {
                return;
            };
            _arg_1.stopImmediatePropagation();
            _arg_1.stopPropagation();
            switch (_arg_2.name)
            {
                case "header_button_close":
                    _SafeStr_1284.removeView();
                    return;
                case "special_infolink":
                    _SafeStr_1284.openPaydayHelpPage();
                    return;
                case "special_breakdown_link":
                    _SafeStr_1284.showPaydayBreakdownView();
                    return;
                case "general_infolink":
                    _SafeStr_1284.openHelpPage();
                    return;
                case "btn_gift":
                    _SafeStr_1284.openClubGiftPage();
                    _SafeStr_1284.removeView();
                    return;
                case "btn_buy":
                    _SafeStr_1284.openPurchasePage();
                    _SafeStr_1284.removeView();
                    return;
                case "btn_earn":
                    if (_SafeStr_1284.offerCenter)
                    {
                        _SafeStr_1284.offerCenter.showVideo();
                    };
                    return;
                default:
                    return;
            };
        }

        private function onRelocate(_arg_1:WindowEvent):void
        {
            _SafeStr_1284.removeBreakdown();
        }

        private function get container():IWindowContainer
        {
            return (_container);
        }

        private function setElementText(_arg_1:String, _arg_2:String):void
        {
            if (!container)
            {
                return;
            };
            var _local_3:ITextWindow = (container.findChildByName(_arg_1) as ITextWindow);
            if (_local_3)
            {
                _local_3.text = _arg_2;
            };
        }

        private function setElementVisibility(_arg_1:String, _arg_2:Boolean):void
        {
            if (!container)
            {
                return;
            };
            var _local_3:IWindow = container.findChildByName(_arg_1);
            if (_local_3)
            {
                _local_3.visible = _arg_2;
            };
        }

        public function getSpecialCalloutAnchor():IWindow
        {
            return ((container) ? container.findChildByName("special_content_postit") : null);
        }

        private function removeElement(_arg_1:String):void
        {
            if (!container)
            {
                return;
            };
            var _local_3:IWindow = container.findChildByName(_arg_1);
            if (!_local_3)
            {
                return;
            };
            var _local_2:IWindowContainer = (_local_3.parent as IWindowContainer);
            _local_2.removeChild(_local_3);
        }

        private function getLocalization(_arg_1:String):String
        {
            if (((!(_SafeStr_1284)) || (!(_SafeStr_1284.localization))))
            {
                return ("");
            };
            return (_SafeStr_1284.localization.getLocalization(_arg_1, _arg_1));
        }

        public function formatMinutes(_arg_1:int):String
        {
            return (FriendlyTime.getShortFriendlyTime(_SafeStr_1284.localization, (_arg_1 * 60)));
        }

        public function formatDays(_arg_1:int):String
        {
            return (FriendlyTime.getShortFriendlyTime(_SafeStr_1284.localization, (_arg_1 * 86400)));
        }

        public function get disposed():Boolean
        {
            return (_SafeStr_1284 == null);
        }

        public function setVideoOfferButtonVisibility(_arg_1:Boolean, _arg_2:Boolean):void
        {
            var _local_3:IWindow = _container.findChildByName("btn_earn");
            if (_local_3)
            {
                _local_3.visible = _arg_1;
                if (_arg_2)
                {
                    _local_3.enable();
                    _local_3.alpha = 0;
                }
                else
                {
                    _local_3.disable();
                    _local_3.alpha = 51;
                };
            };
        }


    }
}

