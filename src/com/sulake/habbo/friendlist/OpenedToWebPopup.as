package com.sulake.habbo.friendlist
{
    import com.sulake.core.window.IWindowContainer;
    import flash.utils.Timer;
    import flash.events.Event;

    public class OpenedToWebPopup 
    {

        private var _friendList:HabboFriendList;
        private var _SafeStr_2466:IWindowContainer;
        private var _SafeStr_1163:Timer;

        public function OpenedToWebPopup(_arg_1:HabboFriendList)
        {
            _friendList = _arg_1;
        }

        public function show(_arg_1:int, _arg_2:int):void
        {
            if (_SafeStr_2466 != null)
            {
                close(null);
            };
            _SafeStr_2466 = getOpenedToWebAlert();
            if (_SafeStr_1163 != null)
            {
                _SafeStr_1163.stop();
            };
            _SafeStr_1163 = new Timer(2000, 1);
            _SafeStr_1163.addEventListener("timer", close);
            _SafeStr_1163.start();
            _SafeStr_2466.x = _arg_1;
            _SafeStr_2466.y = _arg_2;
        }

        private function close(_arg_1:Event):void
        {
            _SafeStr_2466.destroy();
            _SafeStr_2466 = null;
        }

        private function getOpenedToWebAlert():IWindowContainer
        {
            var _local_1:IWindowContainer = IWindowContainer(_friendList.getXmlWindow("opened_to_web_popup"));
            _friendList.refreshButton(_local_1, "opened_to_web", true, null, 0);
            return (_local_1);
        }


    }
}

