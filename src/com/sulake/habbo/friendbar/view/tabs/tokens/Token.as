package com.sulake.habbo.friendbar.view.tabs.tokens
{
    import com.sulake.core.runtime.IDisposable;
    import flash.geom.Rectangle;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.game.IHabboGameManager;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.friendbar.data.IFriendNotification;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
    import com.sulake.core.window.motion.Motions;
    import com.sulake.core.window.motion.DropBounce;

    public class Token implements IDisposable 
    {

        protected static const TITLE:String = "title";
        protected static const MESSAGE:String = "message";
        protected static const ICON_RECTANGLE:Rectangle = new Rectangle(0, 0, 25, 25);

        protected static var _WINDOW_MANAGER:IHabboWindowManager;
        protected static var _SafeStr_2401:IAssetLibrary;
        protected static var _GAMES:IHabboGameManager;

        protected var _icon:IRegionWindow;
        protected var _window:IWindowContainer;
        protected var _disposed:Boolean;
        protected var _notification:IFriendNotification;

        public function Token(_arg_1:IFriendNotification)
        {
            _notification = _arg_1;
        }

        public static function set WINDOWING(_arg_1:IHabboWindowManager):void
        {
            _WINDOW_MANAGER = _arg_1;
        }

        public static function set ASSETS(_arg_1:IAssetLibrary):void
        {
            _SafeStr_2401 = _arg_1;
        }

        public static function set GAMES(_arg_1:IHabboGameManager):void
        {
            _GAMES = _arg_1;
        }


        public function get typeCode():int
        {
            return (_notification.typeCode);
        }

        public function get viewOnce():Boolean
        {
            return (_notification.viewOnce);
        }

        public function get notification():IFriendNotification
        {
            return (_notification);
        }

        public function get iconElement():IWindow
        {
            return (_icon);
        }

        public function get windowElement():IWindow
        {
            return (_window);
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function dispose():void
        {
            if (_window)
            {
                _window.dispose();
                _window = null;
            };
            if (_icon)
            {
                _icon.dispose();
                _icon = null;
            };
            _notification = null;
            _disposed = true;
        }

        protected function prepare(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:String):void
        {
            _window = (_WINDOW_MANAGER.buildFromXML((_SafeStr_2401.getAssetByName(_arg_3).content as XML)) as IWindowContainer);
            _window.findChildByName("title").caption = _arg_1;
            _window.findChildByName("message").caption = ((_arg_2) ? _arg_2 : "");
            _icon = (_WINDOW_MANAGER.create(("ICON_" + typeCode), 5, 0, 1, Token.ICON_RECTANGLE) as IRegionWindow);
            _icon.mouseThreshold = 0;
            var _local_5:IStaticBitmapWrapperWindow = (_WINDOW_MANAGER.create(("BITMAP_" + typeCode), 23, 0, 0, Token.ICON_RECTANGLE) as IStaticBitmapWrapperWindow);
            _local_5.assetUri = _arg_4;
            _icon.addChild(_local_5);
            if (Motions.getMotionByTarget(_icon) == null)
            {
                Motions.runMotion(new DropBounce(_icon, 600, 32));
            };
        }


    }
}

