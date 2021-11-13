package com.sulake.habbo.friendbar.talent
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.communication.messages.parser.talent.TalentLevelUpMessageEvent;
    import com.sulake.habbo.communication.messages.parser.talent.TalentLevelUpMessageParser;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.communication.messages.parser.talent.TalentTrackRewardPerk;
    import com.sulake.habbo.communication.messages.parser.talent.TalentTrackRewardProduct;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.window.widgets.IBadgeImageWidget;
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.habbo.communication.messages.outgoing.talent.GetTalentTrackMessageComposer;
    import com.sulake.core.window.events.WindowEvent;

    public class TalentLevelUpController implements IDisposable 
    {

        private var _habboTalent:HabboTalent;
        private var _disposed:Boolean;
        private var _window:IWindowContainer;
        private var _SafeStr_2383:String;
        private var _SafeStr_2384:IWindow;
        private var _SafeStr_2385:IWindow;
        private var _SafeStr_2386:IWindow;

        public function TalentLevelUpController(_arg_1:HabboTalent)
        {
            _habboTalent = _arg_1;
        }

        public function dispose():void
        {
            if (!_disposed)
            {
                if (_SafeStr_2386 != null)
                {
                    _SafeStr_2386.dispose();
                    _SafeStr_2386 = null;
                };
                if (_SafeStr_2384 != null)
                {
                    _SafeStr_2384.dispose();
                    _SafeStr_2384 = null;
                };
                if (_SafeStr_2385 != null)
                {
                    _SafeStr_2385.dispose();
                    _SafeStr_2385 = null;
                };
                closeWindow();
                _habboTalent = null;
                _disposed = true;
            };
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function initialize():void
        {
            _habboTalent.communicationManager.addHabboConnectionMessageEvent(new TalentLevelUpMessageEvent(onTalentLevelUp));
        }

        private function onTalentLevelUp(_arg_1:TalentLevelUpMessageEvent):void
        {
            var _local_2:TalentLevelUpMessageParser = _arg_1.getParser();
            if ((((_local_2.level == 1) && (_local_2.talentTrackName == "helper")) && (_habboTalent.citizenshipEnabled)))
            {
                return;
            };
            showWindow(_local_2.talentTrackName, _local_2.level, _local_2.rewardPerks, _local_2.rewardProducts);
        }

        public function showWindow(_arg_1:String, _arg_2:int, _arg_3:Vector.<TalentTrackRewardPerk>, _arg_4:Vector.<TalentTrackRewardProduct>):void
        {
            closeWindow();
            _SafeStr_2383 = _arg_1;
            _window = (_habboTalent.getXmlWindow("level_up") as IWindowContainer);
            _window.center();
            _window.procedure = onWindowEvent;
            IStaticBitmapWrapperWindow(_window.findChildByName("level_decoration")).assetUri = (((("${image.library.url}talent/" + _arg_1) + "_levelup_") + _arg_2) + ".png");
            _window.findChildByName("level_up_message").caption = (("${talent.track." + _arg_1) + ".levelup.message}");
            _window.findChildByName("level_title").caption = (((("${talent.track." + _arg_1) + ".level.") + _arg_2) + ".title}");
            _window.findChildByName("level_description").caption = (((("${talent.track." + _arg_1) + ".level.") + _arg_2) + ".description}");
            var _local_8:IItemListWindow = IItemListWindow(_window.findChildByName("reward_list"));
            var _local_6:IWindow = _local_8.removeListItem(_local_8.getListItemByName("plus_template"));
            _SafeStr_2384 = _local_8.removeListItem(_local_8.getListItemByName("reward_product_template"));
            _SafeStr_2385 = _local_8.removeListItem(_local_8.getListItemByName("reward_vip_template"));
            _SafeStr_2386 = _local_8.removeListItem(_local_8.getListItemByName("reward_perk_template"));
            var _local_7:Boolean;
            for each (var _local_5:TalentTrackRewardPerk in _arg_3)
            {
                if (_local_7)
                {
                    _local_8.addListItem(_local_6.clone());
                };
                _local_8.addListItem(createRewardPerk(_local_5));
                _local_7 = true;
            };
            for each (var _local_9:TalentTrackRewardProduct in _arg_4)
            {
                if (_local_7)
                {
                    _local_8.addListItem(_local_6.clone());
                };
                _local_8.addListItem(createRewardProduct(_local_9));
                _local_7 = true;
            };
            if (_local_8.numListItems < 1)
            {
                _window.findChildByName("level_rewards").visible = false;
                IItemListWindow(_window.findChildByName("level_up_layout")).arrangeListItems();
            };
        }

        private function createRewardPerk(_arg_1:TalentTrackRewardPerk):IWindow
        {
            var _local_2:IWindowContainer = (_SafeStr_2386.clone() as IWindowContainer);
            IBadgeImageWidget(IWidgetWindow(_local_2.findChildByName("perk_image")).widget).badgeId = _arg_1.perkId;
            _local_2.findChildByName("perk_name").caption = (("${perk." + _arg_1.perkId) + ".name}");
            return (_local_2);
        }

        private function createRewardProduct(_arg_1:TalentTrackRewardProduct):IWindow
        {
            var _local_2:IWindow;
            if (_arg_1.vipDays == 0)
            {
                _local_2 = _SafeStr_2384.clone();
                IStaticBitmapWrapperWindow(_local_2).assetUri = (("${image.library.url}talent/reward_product_" + _arg_1.productCode.toLowerCase().replace(" ", "_")) + ".png");
            }
            else
            {
                _local_2 = _SafeStr_2385.clone();
                IWindowContainer(_local_2).findChildByName("vip_length").caption = _habboTalent.localizationManager.getLocalizationWithParams("catalog.vip.item.header.days", "", "num_days", _arg_1.vipDays);
            };
            return (_local_2);
        }

        private function closeWindow():void
        {
            if (_window != null)
            {
                _window.dispose();
                _window = null;
            };
        }

        private function onWindowEvent(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if ((((_window == null) || (_window.disposed)) || (!(_arg_1.type == "WME_CLICK"))))
            {
                return;
            };
            switch (_arg_2.name)
            {
                case "header_button_close":
                case "close_button":
                    closeWindow();
                    return;
                case "talent_button":
                    closeWindow();
                    _habboTalent.tracking.trackTalentTrackOpen(_SafeStr_2383, "levelup");
                    _habboTalent.send(new GetTalentTrackMessageComposer(_SafeStr_2383));
                    return;
            };
        }


    }
}

