package com.sulake.habbo.catalog.clubcenter.util
{
    import flash.display.BitmapData;
    import com.sulake.habbo.session.ISessionDataManager;

    public class BadgeResolver 
    {

        public static const DEFAULT_BADGE:String = "HC1";
        public static const CLUB_BADGES:Array = ["ACH_VipHC1", "ACH_VipHC2", "ACH_VipHC3", "ACH_VipHC4", "ACH_VipHC5", "HC1", "HC2", "HC3", "HC4", "HC5"];


        public static function resolveClubBadgeId(_arg_1:Array):String
        {
            var _local_3:String = null;
            for each (var _local_2:String in CLUB_BADGES)
            {
                if (_arg_1.indexOf(_local_2) > -1)
                {
                    _local_3 = _local_2;
                };
            };
            return (_local_3);
        }

        public static function resolveBadgeBitmap(_arg_1:String, _arg_2:Function, _arg_3:ISessionDataManager):BitmapData
        {
            if (_arg_1 == null)
            {
                return (null);
            };
            var _local_4:BitmapData = _arg_3.requestBadgeImage(_arg_1);
            if (_local_4 == null)
            {
                _arg_3.events.addEventListener("BIRE_BADGE_IMAGE_READY", _arg_2);
            };
            return (_local_4);
        }


    }
}