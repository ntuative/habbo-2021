package com.sulake.habbo.navigator.mainview
{
    import com.sulake.habbo.communication.messages.incoming.navigator.PromotedRoomCategoryData;
    import com.sulake.habbo.navigator.HabboNavigator;
    import com.sulake.habbo.navigator.domain.RoomSessionTags;

    public class PromotedRoomsGuestRoomListCtrl extends GuestRoomListCtrl 
    {

        private var _SafeStr_826:PromotedRoomCategoryData;

        public function PromotedRoomsGuestRoomListCtrl(_arg_1:HabboNavigator)
        {
            super(_arg_1, -6, false);
        }

        public function set category(_arg_1:PromotedRoomCategoryData):void
        {
            _SafeStr_826 = _arg_1;
        }

        override public function getRooms():Array
        {
            return (_SafeStr_826.rooms);
        }

        override public function beforeEnterRoom(_arg_1:int):void
        {
            navigator.data.roomSessionTags = new RoomSessionTags(_SafeStr_826.code, ("" + (_arg_1 + 2)));
        }


    }
}

