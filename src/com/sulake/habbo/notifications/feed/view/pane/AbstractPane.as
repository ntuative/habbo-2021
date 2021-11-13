package com.sulake.habbo.notifications.feed.view.pane
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.notifications.feed.NotificationView;
    import com.sulake.core.runtime.exceptions.Exception;

    public class AbstractPane implements IPane 
    {

        public static const PANE_VIEW_LEVEL_BASE:int = 0;
        public static const PANE_VIEW_LEVEL_FEED:int = 1;
        public static const PANE_VIEW_LEVEL_MODAL:int = 2;

        protected var _SafeStr_1381:Boolean;
        protected var _SafeStr_3009:Boolean;
        private var _paneLevel:int;
        protected var _window:IWindowContainer;
        protected var _SafeStr_461:NotificationView;
        protected var _name:String;

        public function AbstractPane(_arg_1:String, _arg_2:NotificationView, _arg_3:IWindowContainer, _arg_4:int)
        {
            if (_arg_3 == null)
            {
                throw (new Exception(("Window was null for feed pane: " + _arg_1)));
            };
            _name = _arg_1;
            _SafeStr_461 = _arg_2;
            _paneLevel = _arg_4;
            _window = _arg_3;
        }

        public function dispose():void
        {
            _SafeStr_1381 = true;
        }

        public function get disposed():Boolean
        {
            return (_SafeStr_1381);
        }

        public function get name():String
        {
            return (_name);
        }

        public function get paneLevel():int
        {
            return (_paneLevel);
        }

        public function set isVisible(_arg_1:Boolean):void
        {
            _SafeStr_3009 = _arg_1;
            _window.visible = _SafeStr_3009;
        }

        public function get isVisible():Boolean
        {
            return (_SafeStr_3009);
        }


    }
}

