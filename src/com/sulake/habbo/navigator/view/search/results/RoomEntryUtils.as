package com.sulake.habbo.navigator.view.search.results
{
    public class RoomEntryUtils 
    {


        public static function getDoorModeIconAsset(_arg_1:int):String
        {
            switch (_arg_1)
            {
                case 1:
                    return ("newnavigator_doormode_doorbell_small");
                case 2:
                    return ("newnavigator_doormode_password_small");
                case 3:
                    return ("newnavigator_doormode_invisible_small");
                default:
                    return ("");
            };
        }

        public static function getModulatedBackgroundColor(_arg_1:int, _arg_2:uint):uint
        {
            if (_arg_1 == -1)
            {
                return (_arg_2);
            };
            var _local_5:Number = (((0xFF0000 & _arg_2) >> 16) / 0xFF);
            var _local_9:Number = (((0xFF00 & _arg_2) >> 8) / 0xFF);
            var _local_6:Number = ((0xFF & _arg_2) / 0xFF);
            var _local_10:Number = (((0xFF0000 & _arg_1) >> 16) / 0xFF);
            var _local_7:Number = (((0xFF00 & _arg_1) >> 8) / 0xFF);
            var _local_11:Number = ((0xFF & _arg_1) / 0xFF);
            var _local_3:Number = (_local_5 * Math.min(1, (_local_10 * 1.5)));
            var _local_8:Number = (_local_9 * Math.min(1, (_local_7 * 1.5)));
            var _local_4:Number = (_local_6 * Math.min(1, (_local_11 * 1.5)));
            var _local_12:uint = (((((_local_3 * 0xFF) << 16) + ((_local_8 * 0xFF) << 8)) + (_local_4 * 0xFF)) + 0xFF000000);
            return (_local_12);
        }

        public static function getFavoriteIcon(_arg_1:Boolean):String
        {
            return ("newnavigator_icon_fav_" + ((_arg_1) ? "yes" : "no"));
        }


    }
}