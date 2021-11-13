package com.sulake.core.window.utils.tablet
{
    import com.sulake.core.window.utils.MouseEventProcessor;
    import com.sulake.core.window.WindowController;
    import com.sulake.core.window.utils.EventProcessorState;
    import com.sulake.core.window.utils.IEventQueue;

    public class TabletEventProcessor extends MouseEventProcessor 
    {

        private var _SafeStr_1192:String = "";


        override public function process(_arg_1:EventProcessorState, _arg_2:IEventQueue):void
        {
            if (_arg_2.length == 0)
            {
                return;
            };
            _SafeStr_1193 = _arg_1.desktop;
            _SafeStr_1194 = (_arg_1._SafeStr_643 as WindowController);
            _SafeStr_1195 = (_arg_1.lastClickTarget as WindowController);
            _SafeStr_1196 = _arg_1.renderer;
            _eventTrackers = _arg_1.eventTrackers;
            _arg_2.begin();
            _arg_2.end();
            _arg_1.desktop = _SafeStr_1193;
            _arg_1._SafeStr_643 = _SafeStr_1194;
            _arg_1.lastClickTarget = _SafeStr_1195;
            _arg_1.renderer = _SafeStr_1196;
            _arg_1.eventTrackers = _eventTrackers;
        }


    }
}

