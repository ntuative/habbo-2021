package com.sulake.habbo.ui.widget.infostand
{
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.components._SafeStr_124;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.ITextWindow;
    import flash.geom.Rectangle;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.habbo.window.widgets.IAvatarImageWidget;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.window.widgets.IBadgeImageWidget;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUserInfoUpdateEvent;

    public class InfoStandBotView
    {

        private const ITEM_SPACER:int = 5;
        private const MOTTO_TEXT_OFFSET:int = 3;
        private const MAX_MOTTO_HEIGHT:int = 50;
        private const MIN_MOTTO_HEIGHT:int = 23;

        private var _SafeStr_1324:InfoStandWidget;
        private var _window:IItemListWindow;
        private var _SafeStr_4145:IItemListWindow;
        private var _SafeStr_1276:_SafeStr_124;
        private var _badgeDetails:_SafeStr_124;

        public function InfoStandBotView(_arg_1:InfoStandWidget, _arg_2:String)
        {
            _SafeStr_1324 = _arg_1;
            createWindow(_arg_2);
        }

        public function dispose():void
        {
            _SafeStr_1324 = null;
            _window.dispose();
            _window = null;
            disposeBadgeDetails();
        }

        public function get window():IItemListWindow
        {
            return (_window);
        }

        private function updateWindow():void
        {
            if (((_SafeStr_4145 == null) || (_SafeStr_1276 == null)))
            {
                return;
            };
            _SafeStr_4145.height = _SafeStr_4145.scrollableRegion.height;
            _SafeStr_1276.height = (_SafeStr_4145.height + 20);
            _window.width = _SafeStr_1276.width;
            _window.height = _window.scrollableRegion.height;
            _SafeStr_1324.refreshContainer();
        }

        private function createWindow(_arg_1:String):void
        {
            var _local_2:IWindow;
            var _local_4:int;
            _window = (_SafeStr_1324.getXmlWindow("bot_view") as IItemListWindow);
            if (_window == null)
            {
                throw (new Error("Failed to construct window from XML!"));
            };
            _SafeStr_1276 = (_window.getListItemByName("info_border") as _SafeStr_124);
            _SafeStr_4145 = (_SafeStr_1276.findChildByName("infostand_element_list") as IItemListWindow);
            if (_SafeStr_1276 != null)
            {
                _SafeStr_4145 = (_SafeStr_1276.findChildByName("infostand_element_list") as IItemListWindow);
            };
            _window.name = _arg_1;
            _SafeStr_1324.mainContainer.addChild(_window);
            var _local_3:IWindow = _SafeStr_1276.findChildByTag("close");
            if (_local_3 != null)
            {
                _local_3.addEventListener("WME_CLICK", onClose);
            };
            _local_4 = 0;
            while (_local_4 < 5)
            {
                _local_2 = _SafeStr_1276.findChildByName(("badge_" + _local_4));
                if (_local_2 != null)
                {
                    _local_2.addEventListener("WME_OVER", showBadgeInfo);
                    _local_2.addEventListener("WME_OUT", hideBadgeInfo);
                };
                _local_4++;
            };
        }

        private function showBadgeInfo(_arg_1:WindowMouseEvent):void
        {
            var _local_5:ITextWindow;
            if (_arg_1.window == null)
            {
                return;
            };
            var _local_6:int = int(_arg_1.window.name.replace("badge_", ""));
            if (_local_6 < 0)
            {
                return;
            };
            var _local_2:Array = _SafeStr_1324.userData.badges;
            if (_local_2 == null)
            {
                return;
            };
            if (_local_6 >= _local_2.length)
            {
                return;
            };
            var _local_3:String = _SafeStr_1324.userData.badges[_local_6];
            if (_local_3 == null)
            {
                return;
            };
            createBadgeDetails();
            _local_5 = (_badgeDetails.getChildByName("name") as ITextWindow);
            if (_local_5 != null)
            {
                _local_5.text = _SafeStr_1324.localizations.getBadgeName(_local_3);
            };
            _local_5 = (_badgeDetails.getChildByName("description") as ITextWindow);
            if (_local_5 != null)
            {
                _local_5.text = _SafeStr_1324.localizations.getBadgeDesc(_local_3);
                _badgeDetails.height = ((_local_5.text == "") ? 40 : 99);
            };
            var _local_4:Rectangle = new Rectangle();
            _arg_1.window.getGlobalRectangle(_local_4);
            _badgeDetails.x = (_local_4.left - _badgeDetails.width);
            _badgeDetails.y = (_local_4.top + ((_local_4.height - _badgeDetails.height) / 2));
        }

        private function hideBadgeInfo(_arg_1:WindowMouseEvent):void
        {
            disposeBadgeDetails();
        }

        private function createBadgeDetails():void
        {
            if (_badgeDetails != null)
            {
                return;
            };
            var _local_1:XmlAsset = (_SafeStr_1324.assets.getAssetByName("badge_details") as XmlAsset);
            if (_local_1 == null)
            {
                return;
            };
            _badgeDetails = (_SafeStr_1324.windowManager.buildFromXML((_local_1.content as XML)) as _SafeStr_124);
            if (_badgeDetails == null)
            {
                throw (new Error("Failed to construct window from XML!"));
            };
        }

        private function disposeBadgeDetails():void
        {
            if (_badgeDetails != null)
            {
                _badgeDetails.dispose();
                _badgeDetails = null;
            };
        }

        private function onClose(_arg_1:WindowMouseEvent):void
        {
            _SafeStr_1324.close();
        }

        public function setFigure(_arg_1:String):void
        {
            var _local_2:IAvatarImageWidget = (IWidgetWindow(_SafeStr_1276.findChildByName("avatar_image")).widget as IAvatarImageWidget);
            _local_2.figure = _arg_1;
        }

        public function set name(_arg_1:String):void
        {
            var _local_2:ITextWindow = (_SafeStr_4145.getListItemByName("name_text") as ITextWindow);
            if (_local_2 == null)
            {
                return;
            };
            _local_2.text = _arg_1;
            _local_2.visible = true;
        }

        public function setMotto(_arg_1:String):void
        {
            var _local_4:IWindowContainer = (_SafeStr_4145.getListItemByName("motto_container") as IWindowContainer);
            if (!_local_4)
            {
                return;
            };
            var _local_3:ITextWindow = (_local_4.findChildByName("motto_text") as ITextWindow);
            var _local_2:IWindowContainer = (_SafeStr_4145.getListItemByName("motto_spacer") as IWindowContainer);
            if (((_local_3 == null) || (_local_2 == null)))
            {
                return;
            };
            if (_arg_1 == null)
            {
                _arg_1 = "";
            };
            _local_3.text = _arg_1;
            _local_3.height = Math.min((_local_3.textHeight + 5), 50);
            _local_3.height = Math.max(_local_3.height, 23);
            _local_4.height = (_local_3.height + 3);
            updateWindow();
        }

        public function set achievementScore(_arg_1:int):void
        {
            if (!_SafeStr_1324.handler.isActivityDisplayEnabled)
            {
                return;
            };
            var _local_2:ITextWindow = (_SafeStr_4145.getListItemByName("score_value") as ITextWindow);
            if (_local_2 == null)
            {
                return;
            };
            _local_2.text = String(_arg_1);
        }

        public function set carryItem(_arg_1:int):void
        {
            var _local_2:String;
            var _local_6:ITextWindow = (_SafeStr_4145.getListItemByName("handitem_txt") as ITextWindow);
            var _local_3:IWindowContainer = (_SafeStr_4145.getListItemByName("handitem_spacer") as IWindowContainer);
            if (((_local_6 == null) || (_local_3 == null)))
            {
                return;
            };
            if (((_arg_1 > 0) && (_arg_1 < 999999)))
            {
                _local_2 = _SafeStr_1324.localizations.getLocalization(("handitem" + _arg_1), ("handitem" + _arg_1));
                _SafeStr_1324.localizations.registerParameter("infostand.text.handitem", "item", _local_2);
            };
            _local_6.height = (_local_6.textHeight + 5);
            var _local_4:Boolean = _local_6.visible;
            var _local_5:Boolean = ((_arg_1 > 0) && (_arg_1 < 999999));
            _local_6.visible = _local_5;
            _local_3.visible = _local_5;
            if (_local_5 != _local_4)
            {
                _SafeStr_4145.arrangeListItems();
            };
            updateWindow();
        }

        public function setBadge(_arg_1:int, _arg_2:String):void
        {
            var _local_3:IBadgeImageWidget = (IWidgetWindow(_SafeStr_1276.findChildByName(("badge_" + _arg_1))).widget as IBadgeImageWidget);
            _local_3.badgeId = _arg_2;
        }

        public function clearBadges():void
        {
            var _local_2:int;
            var _local_1:IBadgeImageWidget;
            _local_2 = 0;
            while (_local_2 < 5)
            {
                _local_1 = (IWidgetWindow(_SafeStr_1276.findChildByName(("badge_" + _local_2))).widget as IBadgeImageWidget);
                _local_1.badgeId = "";
                _local_2++;
            };
        }

        public function update(_arg_1:RoomWidgetUserInfoUpdateEvent):void
        {
            clearBadges();
            updateInfo(_arg_1);
        }

        private function updateInfo(_arg_1:RoomWidgetUserInfoUpdateEvent):void
        {
            name = _arg_1.name;
            setMotto(_arg_1.motto);
            achievementScore = _arg_1.achievementScore;
            carryItem = _arg_1.carryItem;
            setFigure(_arg_1.figure);
            updateBadges(_arg_1.badges);
        }

        private function updateBadges(_arg_1:Array):void
        {
            var _local_2:int;
            if (_arg_1 == null)
            {
                return;
            };
            _local_2 = 0;
            while (_local_2 < _arg_1.length)
            {
                setBadge(_local_2, _arg_1[_local_2]);
                _local_2++;
            };
        }


    }
}