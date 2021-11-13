package com.sulake.habbo.ui.widget.loadingbar
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import com.sulake.core.window.components._SafeStr_124;
    import com.sulake.core.runtime.ICoreConfiguration;
    import flash.display.BitmapData;
    import flash.display.Sprite;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.ui.widget.events.RoomWidgetLoadingBarUpdateEvent;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.core.window.components.IDisplayObjectWrapper;
    import com.sulake.habbo.utils.HabboWebTools;
    import flash.events.Event;

    public class LoadingBarWidget extends RoomWidgetBase 
    {

        private var _window:_SafeStr_124;
        private var _config:ICoreConfiguration;
        private var _SafeStr_1384:BitmapData;
        private var _SafeStr_3370:String = "";
        private var _SafeStr_4175:Sprite = null;

        public function LoadingBarWidget(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary, _arg_4:IHabboLocalizationManager, _arg_5:ICoreConfiguration)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
            _config = _arg_5;
        }

        override public function dispose():void
        {
            if (_SafeStr_4175 != null)
            {
                _SafeStr_4175.removeEventListener("click", clickHandler);
                _SafeStr_4175 = null;
            };
            if (_SafeStr_1384 != null)
            {
                _SafeStr_1384.dispose();
                _SafeStr_1384 = null;
            };
            if (_window != null)
            {
                _window.dispose();
                _window = null;
            };
            _config = null;
            super.dispose();
        }

        override public function registerUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            _arg_1.addEventListener("RWLBUE_SHOW_LOADING_BAR", onShowLoadingBar);
            _arg_1.addEventListener("RWLBUW_HIDE_LOADING_BAR", onHideLoadingBar);
            super.registerUpdateEvents(_arg_1);
        }

        override public function unregisterUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            _arg_1.removeEventListener("RWLBUE_SHOW_LOADING_BAR", onShowLoadingBar);
            _arg_1.removeEventListener("RWLBUW_HIDE_LOADING_BAR", onShowLoadingBar);
            _arg_1.removeEventListener("RWLBUW_HIDE_LOADING_BAR", onHideLoadingBar);
        }

        private function onShowLoadingBar(_arg_1:RoomWidgetLoadingBarUpdateEvent):void
        {
            if (((_arg_1 == null) || (!(_arg_1.type == "RWLBUE_SHOW_LOADING_BAR"))))
            {
                return;
            };
            if (!createWindow())
            {
                return;
            };
            _window.visible = true;
            _window.center();
        }

        private function onHideLoadingBar(_arg_1:RoomWidgetLoadingBarUpdateEvent):void
        {
            if (((_arg_1 == null) || (!(_arg_1.type == "RWLBUW_HIDE_LOADING_BAR"))))
            {
                return;
            };
            if (_window != null)
            {
                _window.dispose();
                _window = null;
            };
        }

        private function createWindow():Boolean
        {
            var _local_4:int;
            if (_window != null)
            {
                return (true);
            };
            var _local_2:XmlAsset = (assets.getAssetByName("room_loading_bar") as XmlAsset);
            if (_local_2 == null)
            {
                return (false);
            };
            _window = (windowManager.buildFromXML((_local_2.content as XML)) as _SafeStr_124);
            if (_window == null)
            {
                return (false);
            };
            _window.visible = false;
            var _local_3:IRegionWindow = (_window.findChildByName("region") as IRegionWindow);
            if (_local_3 != null)
            {
            };
            var _local_1:IDisplayObjectWrapper = (_window.findChildByName("image") as IDisplayObjectWrapper);
            if (_local_1 != null)
            {
                _local_4 = _local_1.height;
                _window.scale(0, -(_local_4));
            };
            return (true);
        }

        private function clickHandler(_arg_1:Event):void
        {
            if (_SafeStr_3370 != "")
            {
                HabboWebTools.openWebPage(_SafeStr_3370);
            };
        }


    }
}

