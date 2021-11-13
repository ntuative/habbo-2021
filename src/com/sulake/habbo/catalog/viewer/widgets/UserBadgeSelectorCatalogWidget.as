package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.core.window.components.IItemGridWindow;
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.habbo.communication.messages.parser.inventory.badges.BadgesEvent;
    import com.sulake.habbo.catalog.IPurchasableOffer;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetEvent;
    import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
    import com.sulake.habbo.window.widgets.IBadgeImageWidget;
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.core.window.components._SafeStr_124;
    import com.sulake.habbo.catalog.viewer.widgets.events.SetExtraPurchaseParameterEvent;
    import com.sulake.habbo.catalog.viewer.widgets.events.SetRoomPreviewerStuffDataEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.room.object.data.StringArrayStuffData;
    import com.sulake.habbo.room.IStuffData;

    public class UserBadgeSelectorCatalogWidget extends CatalogWidget implements ICatalogWidget 
    {

        private static const BADGE_GRID_ITEM_NAME:String = "badgeGridItem";

        private var _itemGrid:IItemGridWindow;
        private var _gridItemLayout:XML;
        private var _catalog:HabboCatalog;
        private var _SafeStr_1644:int = -1;
        private var _SafeStr_1645:IMessageEvent;
        private var _SafeStr_1646:Array;

        public function UserBadgeSelectorCatalogWidget(_arg_1:IWindowContainer, _arg_2:HabboCatalog)
        {
            super(_arg_1);
            _catalog = _arg_2;
            _SafeStr_1646 = _catalog.getProperty("badge.display.excluded.badgeCodes").split(",");
        }

        override public function dispose():void
        {
            if (_SafeStr_1645)
            {
                _catalog.connection.removeMessageEvent(_SafeStr_1645);
            };
            _catalog = null;
            _SafeStr_1646 = null;
            super.dispose();
        }

        override public function init():Boolean
        {
            _itemGrid = (_window.findChildByName("badgeGrid") as IItemGridWindow);
            var _local_1:XmlAsset = (page.viewer.catalog.assets.getAssetByName("badgeGridItem") as XmlAsset);
            _gridItemLayout = (_local_1.content as XML);
            resetBadgeSelectorGrid();
            events.addEventListener("WIDGETS_INITIALIZED", onWidgetsInitialized);
            _SafeStr_1645 = new BadgesEvent(onUserBadgesUpdated);
            _catalog.connection.addMessageEvent(_SafeStr_1645);
            return (true);
        }

        private function resetBadgeSelectorGrid():void
        {
            _itemGrid.destroyGridItems();
            var _local_2:int;
            for each (var _local_1:String in _catalog.inventory.getAllMyBadgeIds(_SafeStr_1646))
            {
                _itemGrid.addGridItem(createGridItem(_local_1, _local_2++));
            };
        }

        private function onWidgetsInitialized(_arg_1:CatalogWidgetEvent):void
        {
            if (page.offers.length == 0)
            {
                return;
            };
            var _local_2:IPurchasableOffer = page.offers[0];
            events.dispatchEvent(new CatalogWidgetEvent("CWE_EXTRA_PARAM_REQUIRED_FOR_BUY"));
            events.dispatchEvent(new SelectProductEvent(_local_2));
        }

        protected function createGridItem(_arg_1:String, _arg_2:int):IWindowContainer
        {
            var _local_4:IWindowContainer = (page.viewer.catalog.windowManager.buildFromXML(_gridItemLayout) as IWindowContainer);
            var _local_3:IBadgeImageWidget = IBadgeImageWidget(IWidgetWindow(_local_4.findChildByName("badgeWidget")).widget);
            _local_3.type = "normal";
            _local_3.badgeId = _arg_1;
            _local_4.id = _arg_2;
            _local_4.name = "badgeGridItem";
            _local_4.procedure = badgeGridItemWindowProc;
            return (_local_4);
        }

        private function setBadgeGridItemSelectionBg(_arg_1:int, _arg_2:Boolean):void
        {
            var _local_3:IWindowContainer = IWindowContainer(_itemGrid.getGridItemAt(_arg_1));
            if (_local_3 != null)
            {
                _SafeStr_124(_local_3.findChildByName("bg")).style = ((_arg_2) ? 0 : 2);
            };
        }

        private function getBadgeIdOfGridItem(_arg_1:int):String
        {
            var _local_3:IWindowContainer = IWindowContainer(_itemGrid.getGridItemAt(_arg_1));
            var _local_2:IBadgeImageWidget = IBadgeImageWidget(IWidgetWindow(_local_3.findChildByName("badgeWidget")).widget);
            return (_local_2.badgeId);
        }

        private function badgeGridItemWindowProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            if (_arg_2.name == "badgeGridItem")
            {
                if (_SafeStr_1644 != -1)
                {
                    setBadgeGridItemSelectionBg(_SafeStr_1644, false);
                };
                _SafeStr_1644 = _arg_2.id;
                if (_SafeStr_1644 < _catalog.inventory.getAllMyBadgeIds(_SafeStr_1646).length)
                {
                    setBadgeGridItemSelectionBg(_SafeStr_1644, true);
                    events.dispatchEvent(new SetExtraPurchaseParameterEvent(getBadgeIdOfGridItem(_SafeStr_1644)));
                    page.dispatchWidgetEvent(new SetRoomPreviewerStuffDataEvent(getPreviewerStuffData()));
                };
            };
        }

        private function getPreviewerStuffData():IStuffData
        {
            var _local_1:Array = [];
            _local_1.push("0");
            _local_1.push(_catalog.inventory.getAllMyBadgeIds(_SafeStr_1646)[_SafeStr_1644]);
            _local_1.push("");
            _local_1.push("");
            var _local_2:StringArrayStuffData = new StringArrayStuffData();
            _local_2.setArray(_local_1);
            return (_local_2);
        }

        private function onUserBadgesUpdated(_arg_1:IMessageEvent):void
        {
            resetBadgeSelectorGrid();
        }


    }
}

