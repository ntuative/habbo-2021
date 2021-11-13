package com.sulake.habbo.navigator.mainview
{
    import com.sulake.habbo.navigator.HabboNavigator;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.habbo.navigator.Util;
    import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.communication.messages.outgoing.navigator.RoomAdEventTabAdClickedComposer;
    import com.sulake.core.window.events.WindowEvent;

    public class RoomAdListCtrl extends GuestRoomListCtrl 
    {

        public function RoomAdListCtrl(_arg_1:HabboNavigator, _arg_2:int, _arg_3:Boolean)
        {
            super(_arg_1, _arg_2, _arg_3);
        }

        override protected function getListEntry(_arg_1:int):IWindowContainer
        {
            var _local_2:IWindowContainer = IWindowContainer(_navigator.getXmlWindow("grs_room_ads_details_phase_one"));
            _local_2.background = true;
            _local_2.addEventListener("WME_MOVE", onMouseMove);
            _local_2.addEventListener("WME_OVER", onMouseOver);
            _local_2.addEventListener("WME_OUT", onMouseOut);
            _local_2.addEventListener("WME_CLICK", onMouseClick);
            _local_2.setParamFlag(1, true);
            _local_2.setParamFlag(128, true);
            _local_2.color = getBgColor(_arg_1);
            _local_2.tags.push(_arg_1);
            return (_local_2);
        }

        override protected function refreshEntryDetails(_arg_1:IWindowContainer, _arg_2:GuestRoomData):void
        {
            _arg_1.visible = true;
            var _local_3:ITextWindow = ITextWindow(_arg_1.getChildByName("adname"));
            _local_3.visible = true;
            Util.cutTextToWidth(_local_3, _arg_2.roomAdName, _arg_1.width);
            _navigator.refreshButton(_arg_1, "doormode_doorbell_small", (_arg_2.doorMode == 1), null, 0);
            _navigator.refreshButton(_arg_1, "doormode_password_small", (_arg_2.doorMode == 2), null, 0);
            _navigator.refreshButton(_arg_1, "doormode_invisible_small", (_arg_2.doorMode == 3), null, 0);
            _SafeStr_2912.refreshUserCount(_arg_2.maxUserCount, _arg_1, _arg_2.userCount, "${navigator.usercounttooltip.users}", 308, 2);
        }

        private function getRoomAt(_arg_1:int):GuestRoomData
        {
            return (getRooms()[_arg_1]);
        }

        override protected function onMouseClick(_arg_1:WindowEvent):void
        {
            var _local_4:IWindow = _arg_1.target;
            var _local_3:int = _local_4.tags[0];
            var _local_2:GuestRoomData = getRoomAt(_local_3);
            if (_navigator)
            {
                _navigator.send(new RoomAdEventTabAdClickedComposer(_local_2.flatId, _local_2.roomAdName, _local_2.roomAdExpiresInMin));
            };
            super.onMouseClick(_arg_1);
        }


    }
}

