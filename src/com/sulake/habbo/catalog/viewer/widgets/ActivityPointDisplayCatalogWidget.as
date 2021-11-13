package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.habbo.catalog.purse._SafeStr_139;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.catalog.purse.PurseUpdateEvent;
    import com.sulake.habbo.catalog.IPurchasableOffer;

    public class ActivityPointDisplayCatalogWidget extends CatalogWidget implements ICatalogWidget 
    {

        public function ActivityPointDisplayCatalogWidget(_arg_1:IWindowContainer)
        {
            super(_arg_1);
        }

        override public function dispose():void
        {
            var _local_1:HabboCatalog = HabboCatalog(page.viewer.catalog);
            _local_1.events.removeEventListener("catalog_purse_update", onPurseUpdate);
            super.dispose();
        }

        override public function init():Boolean
        {
            if (!super.init())
            {
                return (false);
            };
            attachWidgetView("activityPointDisplayWidget");
            _window.findChildByName("activity_points_txt").caption = "";
            var _local_1:HabboCatalog = HabboCatalog(page.viewer.catalog);
            _local_1.events.addEventListener("catalog_purse_update", onPurseUpdate);
            return (updateAmount());
        }

        private function updateAmount():Boolean
        {
            if (disposed)
            {
                return (false);
            };
            if (_window == null)
            {
                return (false);
            };
            var _local_3:int = getActivityPointType();
            if (((_local_3 < 1) || (!(_SafeStr_139.isVisible(_local_3)))))
            {
                _window.visible = false;
                return (false);
            };
            var _local_1:HabboCatalog = HabboCatalog(page.viewer.catalog);
            var _local_2:String = ("catalog.purchase.youractivitypoints." + _local_3);
            _local_1.localization.registerParameter(_local_2, "activitypoints", ("" + _local_1.getPurse().getActivityPointsForType(_local_3)));
            _window.findChildByName("activity_points_txt").caption = _local_1.localization.getLocalization(_local_2);
            var _local_4:IWindow = _window.findChildByName("activity_point_icon");
            _local_4.style = _SafeStr_139.getIconStyleFor(_local_3, _local_1, true);
            _window.visible = true;
            return (true);
        }

        private function onPurseUpdate(_arg_1:PurseUpdateEvent):void
        {
            updateAmount();
        }

        private function getActivityPointType():int
        {
            if (((page == null) || (page.offers == null)))
            {
                return (0);
            };
            for each (var _local_1:IPurchasableOffer in page.offers)
            {
                if (_local_1.activityPointType > 0)
                {
                    return (_local_1.activityPointType);
                };
            };
            return (0);
        }


    }
}

