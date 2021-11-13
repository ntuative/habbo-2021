package com.sulake.habbo.window.utils
{
    import com.sulake.habbo.window.HabboWindowManagerComponent;
    import com.sulake.habbo.communication.messages.incoming.notifications.ElementPointerMessageEvent;

    public class ElementPointerHandler 
    {

        private var _windowManager:HabboWindowManagerComponent;
        private var _SafeStr_4397:ElementPointerMessageEvent;

        public function ElementPointerHandler(_arg_1:HabboWindowManagerComponent)
        {
            _windowManager = _arg_1;
            if (_windowManager.communication != null)
            {
                _SafeStr_4397 = new ElementPointerMessageEvent(onElementPointerMessage);
                _windowManager.communication.addHabboConnectionMessageEvent(_SafeStr_4397);
            };
        }

        private function onElementPointerMessage(_arg_1:ElementPointerMessageEvent):void
        {
            var _local_2:String = _arg_1.getParser().key;
            if (((_local_2 == null) || (_local_2 == "")))
            {
                _windowManager.hideHint();
            }
            else
            {
                _windowManager.showHint(_local_2);
            };
        }

        public function dispose():void
        {
            if (_windowManager.communication != null)
            {
                _windowManager.communication.removeHabboConnectionMessageEvent(_SafeStr_4397);
            };
            _windowManager = null;
        }


    }
}

