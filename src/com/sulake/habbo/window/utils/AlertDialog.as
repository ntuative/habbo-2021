package com.sulake.habbo.window.utils
{
    import com.sulake.core.window.utils.INotify;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IInteractiveWindow;
    import com.sulake.core.window.components.ITextWindow;

    public class AlertDialog implements IAlertDialog, INotify 
    {

        protected static const LIST_BUTTONS:String = "_alert_button_list";
        protected static const _SafeStr_4379:String = "_alert_button_ok";
        protected static const _SafeStr_4380:String = "_alert_button_cancel";
        protected static const BUTTON_CUSTOM:String = "_alert_button_custom";
        protected static const _SafeStr_2420:String = "header_button_close";
        protected static const _SafeStr_4377:String = "_alert_text_summary";

        private static var _SafeStr_795:uint = 0;

        protected var _SafeStr_906:String = "";
        protected var _SafeStr_4395:String = "";
        protected var _disposed:Boolean = false;
        protected var _callback:Function = null;
        protected var _window:IFrameWindow;
        protected var _SafeStr_1665:IModalDialog;

        public function AlertDialog(_arg_1:IHabboWindowManager, _arg_2:XML, _arg_3:String, _arg_4:String, _arg_5:uint, _arg_6:Function, _arg_7:Boolean)
        {
            super();
            var _local_8:IWindow = null;
            _SafeStr_795++;
            if (_arg_7)
            {
                _SafeStr_1665 = _arg_1.buildModalDialogFromXML(_arg_2);
                _window = (_SafeStr_1665.rootWindow as IFrameWindow);
            }
            else
            {
                _window = (_arg_1.buildFromXML(_arg_2, 2) as IFrameWindow);
            };
            if (_arg_5 == 0)
            {
                _arg_5 = ((0x10 | 0x01) | 0x02);
            };
            var _local_9:IItemListWindow = (_window.findChildByName("_alert_button_list") as IItemListWindow);
            if (_local_9)
            {
                if (!(_arg_5 & 0x10))
                {
                    _local_8 = _local_9.getListItemByName("_alert_button_ok");
                    _local_8.dispose();
                };
                if (!(_arg_5 & 0x20))
                {
                    _local_8 = _local_9.getListItemByName("_alert_button_cancel");
                    _local_8.dispose();
                };
                if (!(_arg_5 & 0x40))
                {
                    _local_8 = _local_9.getListItemByName("_alert_button_custom");
                    _local_8.dispose();
                };
            };
            _window.procedure = dialogEventProc;
            _window.center();
            this.title = _arg_3;
            this.summary = _arg_4;
            this.callback = _arg_6;
        }

        public function dispose():void
        {
            if (!_disposed)
            {
                if (((_SafeStr_1665) && (!(_SafeStr_1665.disposed))))
                {
                    _SafeStr_1665.dispose();
                    _SafeStr_1665 = null;
                    _window = null;
                };
                if (((_window) && (!(_window.disposed))))
                {
                    _window.dispose();
                    _window = null;
                };
                _callback = null;
                _disposed = true;
            };
        }

        protected function dialogEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:WindowEvent;
            if (_arg_1.type == "WME_CLICK")
            {
                switch (_arg_2.name)
                {
                    case "_alert_button_ok":
                        if (_callback != null)
                        {
                            _local_3 = WindowEvent.allocate("WE_OK", null, null);
                            (_callback(this, _local_3));
                            _local_3.recycle();
                        }
                        else
                        {
                            dispose();
                        };
                        return;
                    case "header_button_close":
                    case "_alert_button_cancel":
                        if (_callback != null)
                        {
                            _local_3 = WindowEvent.allocate("WE_CANCEL", null, null);
                            (_callback(this, _local_3));
                            _local_3.recycle();
                        }
                        else
                        {
                            dispose();
                        };
                        return;
                };
            };
        }

        public function getButtonCaption(_arg_1:int):ICaption
        {
            var _local_2:IInteractiveWindow;
            if (!_disposed)
            {
                switch (_arg_1)
                {
                    case 16:
                        _local_2 = (_window.findChildByName("_alert_button_ok") as IInteractiveWindow);
                        break;
                    case 32:
                        _local_2 = (_window.findChildByName("_alert_button_cancel") as IInteractiveWindow);
                        break;
                    case 64:
                        _local_2 = (_window.findChildByName("_alert_button_custom") as IInteractiveWindow);
                };
            };
            return ((_local_2) ? new AlertDialogCaption(_local_2.caption, _local_2.toolTipCaption, _local_2.visible) : null);
        }

        public function setButtonCaption(_arg_1:int, _arg_2:ICaption):void
        {
            var _local_3:IInteractiveWindow;
            if (!_disposed)
            {
                switch (_arg_1)
                {
                    case 16:
                        _local_3 = (_window.findChildByName("_alert_button_ok") as IInteractiveWindow);
                        break;
                    case 32:
                        _local_3 = (_window.findChildByName("_alert_button_cancel") as IInteractiveWindow);
                        break;
                    case 64:
                        _local_3 = (_window.findChildByName("_alert_button_custom") as IInteractiveWindow);
                };
            };
            if (_local_3)
            {
                _local_3.caption = _arg_2.text;
            };
        }

        public function set title(_arg_1:String):void
        {
            _SafeStr_906 = _arg_1;
            if (_window)
            {
                _window.caption = _SafeStr_906;
            };
        }

        public function get title():String
        {
            return (_SafeStr_906);
        }

        public function set summary(_arg_1:String):void
        {
            _SafeStr_4395 = _arg_1;
            if (_window)
            {
                ITextWindow(_window.findChildByTag("DESCRIPTION")).text = _SafeStr_4395;
            };
        }

        public function get summary():String
        {
            return (_SafeStr_4395);
        }

        public function set callback(_arg_1:Function):void
        {
            _callback = _arg_1;
        }

        public function get callback():Function
        {
            return (_callback);
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }


    }
}

