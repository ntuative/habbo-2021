package com.sulake.habbo.window.widgets
{
    import flash.utils.Timer;
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.habbo.window.HabboWindowManagerComponent;
    import com.sulake.core.window.components.ILabelWindow;
    import flash.geom.Rectangle;
    import com.sulake.core.window.iterators.EmptyIterator;
    import com.sulake.core.window.utils.IIterator;
    import com.sulake.habbo.utils.FriendlyTime;
    import flash.events.TimerEvent;

    public class UpdatingTimeStampWidget implements IUpdatingTimeStampWidget 
    {

        public static const TYPE:String = "updating_timestamp";
        private static const UPDATE_TIMER:Timer = new Timer(60000);

        private var _disposed:Boolean;
        private var _SafeStr_4407:IWidgetWindow;
        private var _windowManager:HabboWindowManagerComponent;
        private var _SafeStr_1165:ILabelWindow;
        private var _timeStamp:Number;

        {
            UPDATE_TIMER.start();
        }

        public function UpdatingTimeStampWidget(_arg_1:IWidgetWindow, _arg_2:HabboWindowManagerComponent)
        {
            _SafeStr_4407 = _arg_1;
            _windowManager = _arg_2;
            _SafeStr_1165 = (_windowManager.create("", 12, 100, 16, new Rectangle()) as ILabelWindow);
            _SafeStr_1165.textColor = 0x555555;
            _SafeStr_4407.rootWindow = _SafeStr_1165;
            UPDATE_TIMER.addEventListener("timer", onTimerTick);
            reset();
        }

        public function reset():void
        {
            _timeStamp = new Date().getTime();
            onTimerTick();
        }

        public function get properties():Array
        {
            return ([]);
        }

        public function set properties(_arg_1:Array):void
        {
        }

        public function set align(_arg_1:String):void
        {
            _SafeStr_1165.defaultTextFormat.align = _arg_1;
        }

        public function dispose():void
        {
            if (!_disposed)
            {
                UPDATE_TIMER.removeEventListener("timer", onTimerTick);
                if (_SafeStr_1165 != null)
                {
                    _SafeStr_1165.dispose();
                    _SafeStr_1165 = null;
                };
                if (_SafeStr_4407 != null)
                {
                    _SafeStr_4407.rootWindow = null;
                    _SafeStr_4407 = null;
                };
                _windowManager = null;
                _disposed = true;
            };
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get iterator():IIterator
        {
            return (EmptyIterator.INSTANCE);
        }

        public function get timeStamp():Number
        {
            return (_timeStamp);
        }

        public function set timeStamp(_arg_1:Number):void
        {
            _timeStamp = _arg_1;
            onTimerTick();
        }

        private function onTimerTick(_arg_1:TimerEvent=null):void
        {
            if (((((_disposed) || (!(_SafeStr_1165))) || (!(_windowManager))) || (!(_windowManager.localization))))
            {
                return;
            };
            _SafeStr_1165.caption = FriendlyTime.getFriendlyTime(_windowManager.localization, ((new Date().getTime() - Math.abs(_timeStamp)) / 1000), ".ago", 1);
        }


    }
}

