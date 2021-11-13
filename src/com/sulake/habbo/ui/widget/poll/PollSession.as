package com.sulake.habbo.ui.widget.poll
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.core.window.events.WindowEvent;

    public class PollSession implements IDisposable 
    {

        private var _id:int = -1;
        private var _SafeStr_4233:PollWidget;
        private var _SafeStr_4234:IPollDialog;
        private var _SafeStr_4235:IPollDialog;
        private var _endMessage:String = "";
        private var _disposed:Boolean = false;

        public function PollSession(_arg_1:int, _arg_2:PollWidget)
        {
            _id = _arg_1;
            _SafeStr_4233 = _arg_2;
        }

        public function get id():int
        {
            return (_id);
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function dispose():void
        {
            if (_disposed)
            {
                return;
            };
            _disposed = true;
            if (_SafeStr_4234 != null)
            {
                _SafeStr_4234.dispose();
                _SafeStr_4234 = null;
            };
            if (_SafeStr_4235 != null)
            {
                _SafeStr_4235.dispose();
                _SafeStr_4235 = null;
            };
            _SafeStr_4233 = null;
            _disposed = true;
        }

        public function showOffer(_arg_1:String, _arg_2:String):void
        {
            hideOffer();
            _SafeStr_4234 = new PollOfferDialog(_id, _arg_1, _arg_2, _SafeStr_4233);
            _SafeStr_4234.start();
        }

        public function hideOffer():void
        {
            if ((_SafeStr_4234 is PollOfferDialog))
            {
                if (!_SafeStr_4234.disposed)
                {
                    _SafeStr_4234.dispose();
                };
                _SafeStr_4234 = null;
            };
        }

        public function showContent(_arg_1:String, _arg_2:String, _arg_3:Array, _arg_4:Boolean):void
        {
            hideOffer();
            hideContent();
            _endMessage = _arg_2;
            _SafeStr_4235 = new PollContentDialog(_id, _arg_1, _arg_3, _SafeStr_4233, _arg_4);
            _SafeStr_4235.start();
        }

        public function hideContent():void
        {
            if ((_SafeStr_4235 is PollContentDialog))
            {
                if (!_SafeStr_4235.disposed)
                {
                    _SafeStr_4235.dispose();
                };
                _SafeStr_4235 = null;
            };
        }

        public function showThanks():void
        {
            _SafeStr_4233.windowManager.alert("${poll_thanks_title}", _endMessage, 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
            {
                _arg_1.dispose();
            });
        }


    }
}

