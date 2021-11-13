package com.sulake.habbo.notifications.feed
{
    import __AS3__.vec.Vector;

    public class FeedSettings 
    {

        public static const _SafeStr_3017:int = 0;
        public static const _SafeStr_3018:int = 1;
        public static const _SafeStr_3019:int = 2;
        public static const _SafeStr_3020:int = 3;
        public static const FEED_CATEGORY_ME:int = 0;
        public static const _SafeStr_3021:int = 1;
        public static const FEED_CATEGORY_HOTEL:int = 2;

        private var _SafeStr_3022:NotificationController;
        private var _SafeStr_3016:Vector.<int>;

        public function FeedSettings(_arg_1:NotificationController)
        {
            _SafeStr_3016 = new Vector.<int>();
            _SafeStr_3016.push(1);
            _SafeStr_3016.push(0);
            _SafeStr_3016.push(2);
        }

        public function dispose():void
        {
            _SafeStr_3022 = null;
            _SafeStr_3016 = null;
        }

        public function getVisibleFeedCategories():Vector.<int>
        {
            return (_SafeStr_3016);
        }

        public function toggleVisibleFeedCategory(_arg_1:int):void
        {
            _SafeStr_3022.updateFeedCategoryFiltering();
        }


    }
}

