package com.sulake.habbo.navigator.lift
{
    import com.sulake.habbo.navigator.HabboNewNavigator;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.communication.messages.incoming.newnavigator.LiftedRoomData;

    public class LiftDataContainer 
    {

        private static const DEFAULT_IMAGE:String = "${image.library.url}officialrooms_hq/nav_teaser_wl.png";

        private var _navigator:HabboNewNavigator;
        private var _liftedRooms:Vector.<LiftedRoomData> = new Vector.<LiftedRoomData>(0);

        public function LiftDataContainer(_arg_1:HabboNewNavigator)
        {
            _navigator = _arg_1;
        }

        public function setLiftedRooms(_arg_1:Vector.<LiftedRoomData>):void
        {
            _liftedRooms = _arg_1;
        }

        public function get liftedRooms():Vector.<LiftedRoomData>
        {
            return (_liftedRooms);
        }

        public function getUrlForLiftImageAtIndex(_arg_1:int):String
        {
            if (((_arg_1 < 0) || (_arg_1 > (_liftedRooms.length - 1))))
            {
                return ("");
            };
            if (_liftedRooms[_arg_1].image == "")
            {
                return ("${image.library.url}officialrooms_hq/nav_teaser_wl.png");
            };
            return (_navigator.imageLibraryBaseUrl + _liftedRooms[_arg_1].image);
        }


    }
}