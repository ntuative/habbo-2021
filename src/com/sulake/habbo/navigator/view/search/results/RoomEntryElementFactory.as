package com.sulake.habbo.navigator.view.search.results
{
    import com.sulake.habbo.navigator.HabboNewNavigator;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.navigator.view.search.ViewMode;
    import com.sulake.core.window.components._SafeStr_124;
    import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
    import com.sulake.habbo.window.widgets.IBadgeImageWidget;
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
    import com.sulake.habbo.window.utils._SafeStr_221;
    import com.sulake.core.window.events.WindowEvent;
    import flash.geom.Rectangle;
    import com.sulake.habbo.communication.messages.outgoing.navigator.DeleteFavouriteRoomMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.AddFavouriteRoomMessageComposer;
    import com.sulake.core.window.components.IRegionWindow;

    public class RoomEntryElementFactory 
    {

        public static const TILES_PER_CONTAINER:int = 3;

        private var _navigator:HabboNewNavigator;
        private var _SafeStr_2959:IWindowContainer;
        private var _SafeStr_2960:IWindowContainer;
        private var _SafeStr_2961:IItemListWindow;
        private var _SafeStr_2962:int;

        public function RoomEntryElementFactory(_arg_1:HabboNewNavigator)
        {
            _navigator = _arg_1;
            _SafeStr_2962 = ViewMode.getViewMode("hotel_view");
        }

        public function set viewMode(_arg_1:int):void
        {
            _SafeStr_2962 = _arg_1;
        }

        public function set rowEntryTemplate(_arg_1:IWindowContainer):void
        {
            _SafeStr_2959 = _arg_1;
        }

        public function set tileEntryTemplate(_arg_1:IWindowContainer):void
        {
            _SafeStr_2960 = _arg_1;
        }

        public function set tileContainerTemplate(_arg_1:IItemListWindow):void
        {
            _SafeStr_2961 = _arg_1;
        }

        public function get rowEntryTemplateHeight():int
        {
            return (_SafeStr_2959.height);
        }

        public function getNewRowElement(_arg_1:GuestRoomData, _arg_2:int, _arg_3:int=-1):IWindowContainer
        {
            var _local_4:IWindowContainer = IWindowContainer(_SafeStr_2959.clone());
            if (_arg_3 != -1)
            {
                _local_4.width = _arg_3;
            };
            _SafeStr_124(_local_4).color = RoomEntryUtils.getModulatedBackgroundColor(_arg_2, _SafeStr_124(_local_4).color);
            updateCommonEntryElements(_local_4, _arg_1, false);
            _local_4.findChildByName("grouphome_icon").visible = (!(_arg_1.groupBadgeCode == ""));
            return (_local_4);
        }

        public function getNewTileElement(_arg_1:GuestRoomData, _arg_2:int):IWindowContainer
        {
            var _local_3:IWindowContainer = IWindowContainer(_SafeStr_2960.clone());
            updateCommonEntryElements(_local_3, _arg_1, true);
            if (_arg_1.groupBadgeCode != "")
            {
                _local_3.findChildByName("room_group_badge").visible = true;
                IBadgeImageWidget(IWidgetWindow(_local_3.findChildByName("room_group_badge")).widget).badgeId = _arg_1.groupBadgeCode;
            };
            if (_arg_1.officialRoomPicRef != null)
            {
                if (_navigator.getBoolean("new.navigator.official.room.thumbnails.in.amazon"))
                {
                    IStaticBitmapWrapperWindow(_local_3.findChildByName("room_pic_placeholder")).assetUri = (_navigator.getProperty("navigator.thumbnail.url_base") + _arg_1.officialRoomPicRef);
                }
                else
                {
                    IStaticBitmapWrapperWindow(_local_3.findChildByName("room_pic_placeholder")).assetUri = (_navigator.getProperty("image.library.url") + _arg_1.officialRoomPicRef);
                };
            }
            else
            {
                IStaticBitmapWrapperWindow(_local_3.findChildByName("room_pic_placeholder")).assetUri = ((_navigator.getProperty("navigator.thumbnail.url_base") + _arg_1.flatId) + ".png");
            };
            return (_local_3);
        }

        private function updateCommonEntryElements(_arg_1:IWindowContainer, _arg_2:GuestRoomData, _arg_3:Boolean):void
        {
            _arg_1.findChildByName("room_usercount").caption = _arg_2.userCount.toString();
            _arg_1.findChildByName("room_name").caption = ((ViewMode.isEventViewMode(_SafeStr_2962)) ? _arg_2.roomAdName : _arg_2.roomName);
            _arg_1.findChildByName("go_to_room_region").id = _arg_2.flatId;
            _arg_1.findChildByName("go_to_room_region").addEventListener("WME_CLICK", onGoButtonClicked);
            _arg_1.findChildByName("go_to_room_region").addEventListener("WME_OVER", ((_arg_3) ? onTileGoToRoomMouseOver : onGoToRoomMouseOver));
            _arg_1.findChildByName("info_popup_click_region").id = _arg_2.flatId;
            _arg_1.findChildByName("info_popup_click_region").addEventListener("WME_CLICK", onMouseClicked);
            _arg_1.findChildByName("info_popup_click_region").addEventListener("WME_OVER", onRoomRoomInfoMouseOver);
            _SafeStr_124(_arg_1.findChildByName("room_info_usercount_border")).color = _SafeStr_221.getUserCountColor(_arg_2.userCount, _arg_2.maxUserCount);
            IStaticBitmapWrapperWindow(_arg_1.findChildByName("doormode_icon")).assetUri = RoomEntryUtils.getDoorModeIconAsset(_arg_2.doorMode);
        }

        public function getNewTileContainerElement():IItemListWindow
        {
            return (_SafeStr_2961.clone() as IItemListWindow);
        }

        private function onGoButtonClicked(_arg_1:WindowEvent):void
        {
            _navigator.goToRoom(_arg_1.window.id);
        }

        private function onMouseClicked(_arg_1:WindowEvent):void
        {
            var _local_2:Rectangle = new Rectangle();
            _arg_1.window.getGlobalRectangle(_local_2);
            _navigator.view.showRoomInfoBubbleAt(_navigator.currentResults.findGuestRoom(_arg_1.window.id), _local_2.right, (((_local_2.bottom - _local_2.top) / 2) + _local_2.top));
        }

        private function onRoomRoomInfoMouseOver(_arg_1:WindowEvent):void
        {
            var _local_2:Rectangle;
            if (_navigator.view.isRoomInfoBubbleVisible)
            {
                _local_2 = new Rectangle();
                _arg_1.window.getGlobalRectangle(_local_2);
                _navigator.view.showRoomInfoBubbleAt(_navigator.currentResults.findGuestRoom(_arg_1.window.id), _local_2.right, (((_local_2.bottom - _local_2.top) / 2) + _local_2.top), true);
            };
        }

        private function onTileGoToRoomMouseOver(_arg_1:WindowEvent):void
        {
            var _local_2:Rectangle;
            if (_navigator.view.isRoomInfoBubbleVisible)
            {
                _local_2 = new Rectangle();
                _arg_1.window.getGlobalRectangle(_local_2);
                _navigator.view.showRoomInfoBubbleAt(_navigator.currentResults.findGuestRoom(_arg_1.window.id), (_local_2.right - 6), ((((_local_2.bottom - _local_2.top) / 2) + _local_2.top) + 56), true);
            };
        }

        private function onGoToRoomMouseOver(_arg_1:WindowEvent):void
        {
            var _local_2:Rectangle;
            if (_navigator.view.isRoomInfoBubbleVisible)
            {
                _local_2 = new Rectangle();
                _arg_1.window.getGlobalRectangle(_local_2);
                _navigator.view.showRoomInfoBubbleAt(_navigator.currentResults.findGuestRoom(_arg_1.window.id), (_local_2.right + 20), (((_local_2.bottom - _local_2.top) / 2) + _local_2.top), true);
            };
        }

        private function onOwnerLinkClicked(_arg_1:WindowEvent):void
        {
            _navigator.getExtendedProfile(_arg_1.window.id);
        }

        private function onGroupLinkClicked(_arg_1:WindowEvent):void
        {
            _navigator.getGuildInfo(_arg_1.window.id);
        }

        private function onFavoriteRegionClicked(_arg_1:WindowEvent):void
        {
            var _local_2:Boolean = _navigator.legacyNavigator.isRoomFavorite(_arg_1.window.id);
            if (_local_2)
            {
                _navigator.communication.connection.send(new DeleteFavouriteRoomMessageComposer(_arg_1.window.id));
            }
            else
            {
                _navigator.communication.connection.send(new AddFavouriteRoomMessageComposer(_arg_1.window.id));
            };
            IStaticBitmapWrapperWindow(IRegionWindow(_arg_1.window).findChildByName("favourite_icon")).assetUri = RoomEntryUtils.getFavoriteIcon((!(_local_2)));
        }


    }
}

