package com.sulake.habbo.navigator.view.search
{
    public class ViewMode 
    {

        public static const MYWORLD_VIEW_CODE:String = "myworld_view";
        public static const HOTEL_VIEW_CODE:String = "hotel_view";
        public static const OFFICIAL_VIEW_CODE:String = "official_view";
        public static const ROOM_ADS_VIEW_CODE:String = "roomads_view";
        public static const NEW_ADS_VIEW_CODE:String = "new_ads";
        public static const ADS_VIEW_CODE_PREFIX:String = "eventcategory__";
        public static const _SafeStr_2965:int = 0;
        public static const MY_WORLD_VIEW:int = 1;
        public static const HOTEL_VIEW:int = 2;
        public static const ROOM_AD_VIEW:int = 3;
        public static const _SafeStr_2966:int = 4;


        public static function getViewMode(_arg_1:String):int
        {
            if (_arg_1 == "official_view")
            {
                return (0);
            };
            if (_arg_1 == "myworld_view")
            {
                return (1);
            };
            if (_arg_1 == "roomads_view")
            {
                return (3);
            };
            if (_arg_1 == "new_ads")
            {
                return (4);
            };
            if (_arg_1.indexOf("eventcategory__") == 0)
            {
                return (4);
            };
            return (2);
        }

        public static function isEventViewMode(_arg_1:int):Boolean
        {
            return ((_arg_1 == 3) || (_arg_1 == 4));
        }


    }
}

