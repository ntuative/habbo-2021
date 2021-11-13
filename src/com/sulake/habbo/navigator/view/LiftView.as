package com.sulake.habbo.navigator.view
{
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.habbo.navigator.HabboNewNavigator;
    import com.sulake.core.window.components._SafeStr_124;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.components.IRegionWindow;
    import flash.utils.getTimer;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class LiftView implements IUpdateReceiver 
    {

        private static const AUTO_CYCLE_TIMEOUT_MS:uint = 8000;

        private var _navigator:HabboNewNavigator;
        private var _SafeStr_2967:_SafeStr_124;
        private var _SafeStr_2968:IItemListWindow;
        private var _SafeStr_2969:IRegionWindow;
        private var _SafeStr_2970:int = -1;
        private var _SafeStr_2971:uint = getTimer();

        public function LiftView(_arg_1:HabboNewNavigator)
        {
            _navigator = _arg_1;
            _navigator.registerUpdateReceiver(this, 1000);
        }

        public function dispose():void
        {
            _navigator.removeUpdateReceiver(this);
            _navigator = null;
        }

        public function get disposed():Boolean
        {
            return (_navigator == null);
        }

        public function set pagerIconTemplate(_arg_1:IRegionWindow):void
        {
            _SafeStr_2969 = _arg_1;
        }

        public function set borderWindow(_arg_1:_SafeStr_124):void
        {
            _SafeStr_2967 = _arg_1;
            _SafeStr_2968 = IItemListWindow(_SafeStr_2967.findChildByName("pager_itemlist"));
            IRegionWindow(_SafeStr_2967.findChildByName("room_image_click_region")).procedure = goToRoomRegionProcedure;
        }

        public function refresh(_arg_1:Boolean=true):void
        {
            var _local_2:int;
            _SafeStr_2968.destroyListItems();
            _SafeStr_2970 = ((_arg_1) ? 0 : _SafeStr_2970);
            _local_2 = 0;
            while (_local_2 < _navigator.liftDataContainer.liftedRooms.length)
            {
                _SafeStr_2968.addListItem(_SafeStr_2969.clone());
                _local_2++;
            };
            setPagerToSelectedPage();
            drawSelectedPage();
        }

        private function setPagerToSelectedPage():void
        {
            var _local_1:int;
            var _local_2:IRegionWindow;
            _local_1 = 0;
            while (_local_1 < _SafeStr_2968.numListItems)
            {
                _local_2 = IRegionWindow(_SafeStr_2968.getListItemAt(_local_1));
                IStaticBitmapWrapperWindow(_local_2.findChildByName("icon")).assetUri = ((_local_1 == _SafeStr_2970) ? "progress_disk_flat_on" : "progress_disk_flat_off");
                _local_2.id = _local_1;
                _local_2.procedure = pagerPageProcedure;
                _local_1++;
            };
        }

        private function drawSelectedPage():void
        {
            setPagerToSelectedPage();
            IStaticBitmapWrapperWindow(_SafeStr_2967.findChildByName("room_image")).assetUri = _navigator.liftDataContainer.getUrlForLiftImageAtIndex(_SafeStr_2970);
            if (_SafeStr_2970 < _navigator.liftDataContainer.liftedRooms.length)
            {
                _SafeStr_2967.findChildByName("caption_text").caption = _navigator.liftDataContainer.liftedRooms[_SafeStr_2970].caption;
            };
        }

        private function autoCycleToNextPage():void
        {
            _SafeStr_2970++;
            if (_SafeStr_2970 > (_navigator.liftDataContainer.liftedRooms.length - 1))
            {
                _SafeStr_2970 = 0;
            };
            refresh(false);
        }

        public function update(_arg_1:uint):void
        {
            var _local_2:uint = getTimer();
            if ((_SafeStr_2971 + 8000) < _local_2)
            {
                autoCycleToNextPage();
                _SafeStr_2971 = _local_2;
            };
        }

        private function pagerPageProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                if (_arg_2.id != _SafeStr_2970)
                {
                    _SafeStr_2970 = _arg_2.id;
                    drawSelectedPage();
                    _SafeStr_2971 = getTimer();
                    _navigator.trackEventLog("browse.promotion", "Promotion", "", _SafeStr_2970);
                };
            };
        }

        private function goToRoomRegionProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                if (_navigator.liftDataContainer.liftedRooms.length > _SafeStr_2970)
                {
                    _navigator.goToRoom(_navigator.liftDataContainer.liftedRooms[_SafeStr_2970].flatId, "promotion");
                };
            };
        }


    }
}

