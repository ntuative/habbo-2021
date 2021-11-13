package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.core.window.components.IDropListWindow;
    import com.sulake.habbo.catalog.guilds.GuildMembershipsController;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetGuildSelectedEvent;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetEvent;
    import com.sulake.habbo.communication.messages.incoming.users.HabboGroupEntryData;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetToggleEvent;
    import com.sulake.habbo.catalog.viewer.Offer;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.catalog.viewer.widgets.events.SetRoomPreviewerStuffDataEvent;
    import com.sulake.habbo.catalog.viewer.widgets.events.SetExtraPurchaseParameterEvent;
    import flash.display.BitmapData;
    import flash.geom.Rectangle;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.components.ILabelWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.room.object.data.StringArrayStuffData;
    import com.sulake.habbo.room.IStuffData;

    public class GuildSelectorCatalogWidget extends CatalogWidget implements ICatalogWidget 
    {

        private static const CATALOG_PAGE_LAYOUT_WIDGET_NAME:String = "guild_selector";
        private static const _SafeStr_1567:String = "guild_selector_widget_item";
        private static const GUILD_COLORS_BMP_BORDER_COLOR:uint = 0;
        private static const GUILD_COLORS_BMP_BORDER_WIDTH:int = 1;
        private static const GUILD_COLORS_BMP_HEIGHT:int = 14;
        private static const GUILD_COLORS_BMP_WIDTH:int = 21;

        private var _SafeStr_1568:IDropListWindow;
        protected var _SafeStr_1566:GuildMembershipsController;
        private var _SafeStr_1569:Array;
        private var _SafeStr_1570:IWindow;
        private var _membersOnlyInfo:IWindow;
        private var _selection:int = -1;

        public function GuildSelectorCatalogWidget(_arg_1:IWindowContainer, _arg_2:GuildMembershipsController)
        {
            super(_arg_1);
            _SafeStr_1566 = _arg_2;
        }

        override public function dispose():void
        {
            if (!disposed)
            {
                events.removeEventListener("WIDGETS_INITIALIZED", onWidgetsInitialized);
                page.dispatchWidgetEvent(new CatalogWidgetGuildSelectedEvent(-1, "", "", ""));
                if (_SafeStr_1568)
                {
                    _SafeStr_1568.procedure = null;
                    _SafeStr_1568 = null;
                };
                _SafeStr_1570 = null;
                _membersOnlyInfo = null;
                if (_SafeStr_1566)
                {
                    _SafeStr_1566.unregisterGuildSelectorWidget(this);
                    _SafeStr_1566 = null;
                };
                super.dispose();
            };
        }

        override public function init():Boolean
        {
            if (!super.init())
            {
                return (false);
            };
            events.addEventListener("WIDGETS_INITIALIZED", onWidgetsInitialized);
            attachWidgetView("guildSelectorWidget");
            _SafeStr_1570 = window.findChildByName("guild_selector");
            _membersOnlyInfo = window.findChildByName("members_only");
            var _local_1:IWindow = window.findChildByName("find_groups_button");
            if (_local_1)
            {
                _local_1.addEventListener("WME_CLICK", onFindGroups);
            };
            _SafeStr_1568 = (_window.findChildByName("guild_selector") as IDropListWindow);
            if (_SafeStr_1568)
            {
                _SafeStr_1568.procedure = dropMenuEventProc;
            }
            else
            {
                Logger.log("ERROR: Missing 'guild_selector' itemlist_dropmenu component from page layout xml");
            };
            _SafeStr_1570.visible = false;
            _membersOnlyInfo.visible = false;
            return (true);
        }

        private function onWidgetsInitialized(_arg_1:CatalogWidgetEvent):void
        {
            _SafeStr_1566.registerGuildSelectorWidget(this);
            events.dispatchEvent(new CatalogWidgetEvent("CWE_EXTRA_PARAM_REQUIRED_FOR_BUY"));
        }

        public function populateAndSelectFavorite(_arg_1:Array):void
        {
            var _local_4:int;
            var _local_5:int;
            var _local_7:HabboGroupEntryData;
            var _local_2:int = -1;
            _SafeStr_1569 = filterGroupMemberships(_arg_1);
            var _local_3:Boolean = (_arg_1.length > 0);
            events.dispatchEvent(new CatalogWidgetToggleEvent("purchaseWidget", _local_3));
            _SafeStr_1570.visible = _local_3;
            _membersOnlyInfo.visible = (!(_local_3));
            var _local_6:int = _SafeStr_1568.numMenuItems;
            _local_4 = 0;
            while (_local_4 < _local_6)
            {
                _SafeStr_1568.removeMenuItemAt(0);
                _local_4++;
            };
            _local_5 = 0;
            while (_local_5 < _SafeStr_1569.length)
            {
                _local_7 = _SafeStr_1569[_local_5];
                _SafeStr_1568.addMenuItem(createDropmenuItemWindow(_local_7));
                if (_local_7.favourite)
                {
                    _local_2 = _local_5;
                };
                _local_5++;
            };
            if (_selection == -1)
            {
                if (_local_2 != -1)
                {
                    _SafeStr_1568.selection = _local_2;
                }
                else
                {
                    if (_SafeStr_1568.numMenuItems > 0)
                    {
                        _SafeStr_1568.selection = 0;
                    };
                };
            }
            else
            {
                _SafeStr_1568.selection = _selection;
            };
        }

        protected function filterGroupMemberships(_arg_1:Array):Array
        {
            return (_arg_1);
        }

        public function selectFirstOffer():void
        {
            if ((((page) && (page.offers)) && (page.offers.length > 0)))
            {
                page.selectOffer(Offer(page.offers[0]).offerId);
            };
        }

        private function dropMenuEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            switch (_arg_1.type)
            {
                case "WE_SELECTED":
                    selectFromDropList(_SafeStr_1568.selection);
                    _selection = _SafeStr_1568.selection;
                    return;
            };
        }

        private function selectFromDropList(_arg_1:int):void
        {
            var _local_2:HabboGroupEntryData;
            if (_arg_1 > -1)
            {
                _local_2 = _SafeStr_1569[_arg_1];
                selectGroup(_local_2);
            };
        }

        protected function selectGroup(_arg_1:HabboGroupEntryData):void
        {
            page.dispatchWidgetEvent(new CatalogWidgetGuildSelectedEvent(_arg_1.groupId, _arg_1.primaryColor, _arg_1.secondaryColor, _arg_1.badgeCode));
            page.dispatchWidgetEvent(new SetRoomPreviewerStuffDataEvent(getPreviewerStuffData(_arg_1.groupId, _arg_1.primaryColor, _arg_1.secondaryColor, _arg_1.badgeCode)));
            events.dispatchEvent(new SetExtraPurchaseParameterEvent(_arg_1.groupId.toString()));
        }

        private function createGuildColorsBitmap(_arg_1:uint, _arg_2:uint):BitmapData
        {
            var _local_3:BitmapData = new BitmapData(21, 14, false, 0);
            var _local_5:int = int(((_local_3.width / 2) + 1));
            var _local_6:Rectangle = new Rectangle();
            _local_6.left = 1;
            _local_6.top = 1;
            _local_6.right = _local_5;
            _local_6.bottom = (_local_3.height - 1);
            var _local_4:Rectangle = new Rectangle();
            _local_4.left = _local_5;
            _local_4.top = 1;
            _local_4.right = (_local_3.width - 1);
            _local_4.bottom = (_local_3.height - 1);
            _local_3.fillRect(_local_6, _arg_1);
            _local_3.fillRect(_local_4, _arg_2);
            return (_local_3);
        }

        private function createDropmenuItemWindow(_arg_1:HabboGroupEntryData):IWindow
        {
            var _local_4:BitmapData = createGuildColorsBitmap(parseInt(_arg_1.primaryColor, 16), parseInt(_arg_1.secondaryColor, 16));
            var _local_2:XML = (page.viewer.catalog.assets.getAssetByName("guild_selector_widget_item").content as XML);
            var _local_6:IWindowContainer = (page.viewer.catalog.windowManager.buildFromXML(_local_2) as IWindowContainer);
            var _local_3:IBitmapWrapperWindow = (_local_6.findChildByName("guild_colors") as IBitmapWrapperWindow);
            var _local_5:ILabelWindow = (_local_6.findChildByName("guild_name") as ILabelWindow);
            _local_3.bitmap = _local_4;
            _local_5.caption = _arg_1.groupName;
            return (_local_6);
        }

        private function onFindGroups(_arg_1:WindowMouseEvent):void
        {
            if (((((page) && (page.viewer)) && (page.viewer.catalog)) && (page.viewer.catalog.navigator)))
            {
                page.viewer.catalog.navigator.performGuildBaseSearch();
            };
        }

        private function getPreviewerStuffData(_arg_1:uint, _arg_2:String, _arg_3:String, _arg_4:String):IStuffData
        {
            var _local_5:Array = [];
            _local_5.push("0");
            _local_5.push(_arg_1.toString());
            _local_5.push(_arg_4);
            _local_5.push(_arg_2);
            _local_5.push(_arg_3);
            var _local_6:StringArrayStuffData = new StringArrayStuffData();
            _local_6.setArray(_local_5);
            return (_local_6);
        }


    }
}

