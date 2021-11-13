package com.sulake.habbo.friendbar.view.tabs
{
    import com.sulake.habbo.friendbar.data.IHabboFriendBarData;
    import com.sulake.habbo.friendlist.IHabboFriendList;
    import com.sulake.habbo.game.IHabboGameManager;
    import com.sulake.habbo.friendbar.view.IHabboFriendBarView;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.tracking.IHabboTracking;
    import com.sulake.habbo.friendbar.view.utils.TextCropper;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.events.WindowMouseEvent;
    import flash.geom.Point;

    public class Tab implements ITab 
    {

        protected static const _SafeStr_2428:Boolean = false;
        protected static const _MOTION_TIME:int = 80;
        protected static const _SafeStr_2429:int = 3;

        public static var WIDTH:int = 127;
        public static var HEIGHT:int = 36;
        public static var DATA:IHabboFriendBarData;
        public static var FRIENDS:IHabboFriendList;
        public static var GAMES:IHabboGameManager;
        public static var VIEW:IHabboFriendBarView;
        public static var ASSETS:IAssetLibrary;
        public static var WINDOWING:IHabboWindowManager;
        public static var _SafeStr_624:IHabboLocalizationManager;
        public static var TRACKING:IHabboTracking;
        public static var CROPPER:TextCropper;

        protected var _window:IWindowContainer;
        protected var _SafeStr_1037:Boolean;
        private var _exposed:Boolean;
        private var _selected:Boolean;
        private var _disposed:Boolean;


        public function get window():IWindowContainer
        {
            return (_window);
        }

        public function get selected():Boolean
        {
            return (_selected);
        }

        public function get recycled():Boolean
        {
            return (_SafeStr_1037);
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        protected function get exposed():Boolean
        {
            return (_exposed);
        }

        public function select(_arg_1:Boolean):void
        {
            conceal();
            _selected = true;
        }

        public function deselect(_arg_1:Boolean):void
        {
            _selected = false;
        }

        public function recycle():void
        {
            conceal();
            _SafeStr_1037 = true;
        }

        public function dispose():void
        {
            if (!_disposed)
            {
                if (_window)
                {
                    _window.dispose();
                    _window = null;
                };
                _disposed = true;
            };
        }

        protected function expose():void
        {
            _exposed = true;
        }

        protected function conceal():void
        {
            _exposed = false;
        }

        protected function onMouseClick(_arg_1:WindowMouseEvent):void
        {
            if (((disposed) || (recycled)))
            {
                return;
            };
            if (selected)
            {
                VIEW.deSelect(true);
            }
            else
            {
                VIEW.selectTab(this, true);
            };
        }

        protected function onMouseOver(_arg_1:WindowMouseEvent):void
        {
            if (((disposed) || (recycled)))
            {
                return;
            };
            if (!selected)
            {
                expose();
            };
        }

        protected function onMouseOut(_arg_1:WindowMouseEvent):void
        {
            if ((((disposed) || (recycled)) || (_window == null)))
            {
                return;
            };
            if (!selected)
            {
                if (!_window.hitTestGlobalPoint(new Point(_arg_1.stageX, _arg_1.stageY)))
                {
                    conceal();
                };
            };
        }


    }
}

