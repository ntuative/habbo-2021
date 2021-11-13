package com.sulake.habbo.campaign.calendar
{
    import __AS3__.vec.Vector;
    import flash.geom.Point;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
    import com.sulake.habbo.communication.messages.parser.campaign.CampaignCalendarData;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.display.BitmapData;
    import com.sulake.core.window.IWindow;

    public class CalendarItem 
    {

        public static const STATE_UNLOCKED:int = 1;
        public static const STATE_LOCKED_AVAILABLE:int = 2;
        public static const STATE_LOCKED_EXPIRED:int = 3;
        public static const STATE_LOCKED_FUTURE:int = 4;
        private static const IMAGE_CLOSED:String = "campaign_day_generic_button";
        private static const IMAGE_ACTIVATED:String = "campaign_day_generic_activated";
        private static const IMAGE_OPENED_BG:String = "campaign_opened";
        private static const ICON_LOCKED:String = "campaign_generic_lock";
        private static const PACKAGE_IMAGE_OFFSETS:Vector.<Point> = new <Point>[new Point(-2, -5), new Point(3, -4), new Point(-3, -3)];


        public static function populateItem(_arg_1:IWindowContainer, _arg_2:CampaignCalendarData, _arg_3:int):IWindowContainer
        {
            var _local_6:IWindowContainer = (_arg_1.clone() as IWindowContainer);
            var _local_7:IStaticBitmapWrapperWindow = (_local_6.findChildByName("bitmap_bg") as IStaticBitmapWrapperWindow);
            var _local_8:IStaticBitmapWrapperWindow = (_local_6.findChildByName("bitmap_opened_bg") as IStaticBitmapWrapperWindow);
            var _local_4:IStaticBitmapWrapperWindow = (_local_6.findChildByName("bitmap_lock") as IStaticBitmapWrapperWindow);
            var _local_5:int = resolveDayState(_arg_2, _arg_3);
            switch (_local_5)
            {
                case 2:
                    _local_7.assetUri = "campaign_day_generic_button";
                    _local_4.assetUri = null;
                    _local_8.visible = false;
                    break;
                case 3:
                case 4:
                    _local_7.assetUri = "campaign_day_generic_button";
                    _local_4.assetUri = "campaign_generic_lock";
                    _local_8.visible = false;
                    break;
                case 1:
                    _local_7.assetUri = "campaign_day_generic_activated";
                    _local_4.assetUri = "";
                    _local_8.visible = true;
                default:
            };
            return (_local_6);
        }

        public static function updateState(_arg_1:IWindowContainer, _arg_2:CampaignCalendarData, _arg_3:int, _arg_4:int):void
        {
            var _local_5:IStaticBitmapWrapperWindow = (_arg_1.findChildByName("bitmap_bg") as IStaticBitmapWrapperWindow);
            if (!_local_5)
            {
                return;
            };
            if (_arg_3 == _arg_4)
            {
                if (resolveDayState(_arg_2, _arg_3) == 2)
                {
                    showWiggleEffect(_local_5);
                };
            };
        }

        public static function updateThumbnail(_arg_1:IWindowContainer, _arg_2:Object):void
        {
            var _local_5:IStaticBitmapWrapperWindow = (_arg_1.findChildByName("bitmap_bg") as IStaticBitmapWrapperWindow);
            var _local_6:IStaticBitmapWrapperWindow = (_arg_1.findChildByName("bitmap_opened_bg") as IStaticBitmapWrapperWindow);
            var _local_3:IStaticBitmapWrapperWindow = (_arg_1.findChildByName("bitmap_icon") as IStaticBitmapWrapperWindow);
            var _local_4:IBitmapWrapperWindow = (_arg_1.findChildByName("bitmap_icon2") as IBitmapWrapperWindow);
            _local_5.assetUri = "campaign_day_generic_activated";
            var _local_7:int = -6;
            _local_3.y = _local_7;
            _local_4.y = _local_7;
            _local_6.visible = true;
            if ((_arg_2 is String))
            {
                _local_3.assetUri = (_arg_2 as String);
                _local_4.bitmap = null;
                showWiggleEffect(_local_3);
            };
            if ((_arg_2 is BitmapData))
            {
                _local_3.assetUri = "";
                _local_4.bitmap = (_arg_2 as BitmapData);
                showWiggleEffect(_local_3);
                showWiggleEffect(_local_4);
            };
        }

        public static function showWiggleEffect(_arg_1:IWindow):void
        {
            new CalendarItemWiggle(_arg_1); //not popped
        }

        public static function resolveDayState(_arg_1:CampaignCalendarData, _arg_2:int):int
        {
            if (_arg_1.openedDays.indexOf(_arg_2) > -1)
            {
                return (1);
            };
            switch (true)
            {
                case (_arg_2 > _arg_1.currentDay):
                    return (4);
                case (_arg_1.missedDays.indexOf(_arg_2) > -1):
                    return (3);
            };
            return (2);
        }


    }
}