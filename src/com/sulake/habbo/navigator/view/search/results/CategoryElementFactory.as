package com.sulake.habbo.navigator.view.search.results
{
    import com.sulake.habbo.navigator.HabboNewNavigator;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
    import com.sulake.core.window.events.WindowMouseEvent;
    import __AS3__.vec.Vector;

    public class CategoryElementFactory
    {

        private static const MARGIN_LAYOUT_CATEGORY_CONTAINER:int = 13;

        private var _navigator:HabboNewNavigator;
        private var _SafeStr_2954:BlockResultsView;
        private var _SafeStr_2955:RoomEntryElementFactory;
        private var _SafeStr_2956:IWindowContainer;
        private var _SafeStr_2957:IWindowContainer;
        private var _SafeStr_2958:IWindowContainer;

        public function CategoryElementFactory(_arg_1:HabboNewNavigator, _arg_2:RoomEntryElementFactory)
        {
            _navigator = _arg_1;
            _SafeStr_2955 = _arg_2;
        }

        public function set blockResultsView(_arg_1:BlockResultsView):void
        {
            _SafeStr_2954 = _arg_1;
        }

        public function set categoryTemplate(_arg_1:IWindowContainer):void
        {
            _SafeStr_2956 = _arg_1;
        }

        public function set collapsedCategoryTemplate(_arg_1:IWindowContainer):void
        {
            _SafeStr_2957 = _arg_1;
        }

        public function set noResultsTemplate(_arg_1:IWindowContainer):void
        {
            _SafeStr_2958 = _arg_1;
        }

        public function getOpenCategoryElement(_arg_1:Vector.<GuestRoomData>, _arg_2:String, _arg_3:int=-1, _arg_4:int=0, _arg_5:int=-1):IWindowContainer
        {
            var guestRooms:Vector.<GuestRoomData> = _arg_1;
            var title:String = _arg_2;
            var showMoreId:int = _arg_3;
            var actionAllowed:int = _arg_4;
            var resultMode:int = _arg_5;
            var container:IWindowContainer = IWindowContainer(_SafeStr_2956.clone());
            container.width = (_SafeStr_2954.itemListWidth - 13);
            container.height = (16 + (_SafeStr_2955.rowEntryTemplateHeight * (guestRooms.length + 1)));
            container.findChildByName("category_name").caption = title;
            container.findChildByName("category_back").addEventListener("WME_CLICK", _SafeStr_2954.onCategoryBackClicked);
            container.findChildByName("category_back").visible = (actionAllowed == 2);
            container.findChildByName("category_collapse").visible = (!(actionAllowed == 2));
            container.findChildByName("category_collapse").id = showMoreId;
            container.findChildByName("category_collapse").addEventListener("WME_CLICK", _SafeStr_2954.onCategoryCollapseClicked);
            container.findChildByName("category_name_region").id = showMoreId;
            container.findChildByName("category_name_region").addEventListener("WME_CLICK", _SafeStr_2954.onCategoryCollapseClicked);
            container.findChildByName("category_show_more").id = showMoreId;
            container.findChildByName("category_show_more").addEventListener("WME_CLICK", _SafeStr_2954.onCategoryShowMoreClicked);
            container.findChildByName("category_show_more").visible = (actionAllowed == 1);
            container.findChildByName("category_add_quick_link").id = showMoreId;
            container.findChildByName("category_add_quick_link").addEventListener("WME_CLICK", _SafeStr_2954.onCategoryAddQuickLinkClicked);
            container.findChildByName("category_content_background").background = true;
            container.findChildByName("category_content_background").height = (12 + (_SafeStr_2955.rowEntryTemplateHeight * (guestRooms.length + 1)));
            container.findChildByName("category_add_quick_link").visible = (_navigator.currentResults.searchCodeOriginal.indexOf("official_view") == -1);
            var headerControls:IItemListWindow = IItemListWindow(container.findChildByName("category_controls_itemlist"));
            if (_navigator.sessionData.isPerkAllowed("NAVIGATOR_ROOM_THUMBNAIL_CAMERA"))
            {
                headerControls.getListItemByName("category_toggle_tiles").addEventListener("WME_CLICK", _SafeStr_2954.onCategoryToggleModeClicked);
                headerControls.getListItemByName("category_toggle_tiles").id = showMoreId;
                headerControls.getListItemByName("category_toggle_tiles").visible = (resultMode == 0);
                headerControls.getListItemByName("category_toggle_rows").addEventListener("WME_CLICK", _SafeStr_2954.onCategoryToggleModeClicked);
                headerControls.getListItemByName("category_toggle_rows").id = showMoreId;
                headerControls.getListItemByName("category_toggle_rows").visible = (resultMode == 1);
            }
            else
            {
                headerControls.removeListItem(headerControls.getListItemByName("category_toggle_tiles"));
                headerControls.removeListItem(headerControls.getListItemByName("category_toggle_rows"));
            };
            headerControls.arrangeListItems();
            var roomList:IItemListWindow = IItemListWindow(container.findChildByName("category_content"));
            if (resultMode == 0)
            {
                roomList.spacing = 0;
            };
            var colorMod:uint = 9412607;
            var color:int = -1;
            var colorModAccumulator:int = 1;
            var currentTileContainer:IItemListWindow;
            for each (var guestRoom:GuestRoomData in guestRooms)
            {
                var alternatingColor:int = (((colorModAccumulator % 2) == 0) ? color : colorMod);
                if (resultMode == 0)
                {
                    roomList.addListItem(_SafeStr_2955.getNewRowElement(guestRoom, alternatingColor));
                    colorModAccumulator++;
                }
                else
                {
                    if (!currentTileContainer)
                    {
                        currentTileContainer = _SafeStr_2955.getNewTileContainerElement();
                        roomList.addListItem(currentTileContainer);
                    };
                    currentTileContainer.addEventListener("WME_WHEEL", function (_arg_1:WindowMouseEvent):void
                    {
                        _SafeStr_2954.itemList.scrollV = (_SafeStr_2954.itemList.scrollV - (_arg_1.delta * 0.01));
                    });
                    currentTileContainer.addListItem(_SafeStr_2955.getNewTileElement(guestRoom, alternatingColor));
                    if (currentTileContainer.numListItems >= 3)
                    {
                        currentTileContainer = null;
                        colorModAccumulator++;
                    };
                };
            };
            roomList.arrangeListItems();
            return (container);
        }

        public function getCollapsedCategoryElement(_arg_1:String, _arg_2:int=-1, _arg_3:int=0):IWindowContainer
        {
            var _local_4:IWindowContainer = IWindowContainer(_SafeStr_2957.clone());
            _local_4.findChildByName("category_name").caption = _arg_1;
            _local_4.findChildByName("category_show_more").id = _arg_2;
            _local_4.findChildByName("category_show_more").addEventListener("WME_CLICK", _SafeStr_2954.onCategoryShowMoreClicked);
            _local_4.findChildByName("category_show_more").visible = (_arg_3 == 1);
            _local_4.findChildByName("category_expand").addEventListener("WME_CLICK", _SafeStr_2954.onCategoryExpandClicked);
            _local_4.findChildByName("category_expand").id = _arg_2;
            _local_4.findChildByName("category_name_region").addEventListener("WME_CLICK", _SafeStr_2954.onCategoryExpandClicked);
            _local_4.findChildByName("category_name_region").id = _arg_2;
            _local_4.findChildByName("category_add_quick_link").addEventListener("WME_CLICK", _SafeStr_2954.onCategoryAddQuickLinkClicked);
            _local_4.findChildByName("category_add_quick_link").id = _arg_2;
            _local_4.findChildByName("category_add_quick_link").visible = (_navigator.currentResults.searchCodeOriginal.indexOf("official_view") == -1);
            _local_4.width = (_SafeStr_2954.itemListWidth - 13);
            IItemListWindow(_local_4.findChildByName("category_controls_itemlist")).arrangeListItems();
            return (_local_4);
        }

        public function getNoResultsELement():IWindowContainer
        {
            return (IWindowContainer(_SafeStr_2958.clone()));
        }


    }
}