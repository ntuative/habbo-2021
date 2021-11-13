package com.sulake.habbo.ui.widget.poll
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.ui.widget.events.RoomWidgetPollUpdateEvent;
    import flash.events.Event;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.core.window.events.WindowEvent;

    public class PollWidget extends RoomWidgetBase
    {

        private var _SafeStr_4236:Map;

        public function PollWidget(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary=null, _arg_4:IHabboLocalizationManager=null)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
            _SafeStr_4236 = new Map();
        }

        override public function dispose():void
        {
            var _local_2:int;
            var _local_3:int;
            var _local_1:PollSession;
            if (disposed)
            {
                return;
            };
            if (_SafeStr_4236 != null)
            {
                _local_2 = _SafeStr_4236.length;
                _local_3 = 0;
                while (_local_3 < _local_2)
                {
                    _local_1 = (_SafeStr_4236.getWithIndex(0) as PollSession);
                    if (_local_1 != null)
                    {
                        _local_1.dispose();
                    };
                    _local_3++;
                };
                _SafeStr_4236.dispose();
                _SafeStr_4236 = null;
            };
            super.dispose();
        }

        override public function registerUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            _arg_1.addEventListener("RWPUW_OFFER", showPollOffer);
            _arg_1.addEventListener("RWPUW_ERROR", showPollError);
            _arg_1.addEventListener("RWPUW_CONTENT", showPollContent);
            super.registerUpdateEvents(_arg_1);
        }

        override public function unregisterUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            _arg_1.removeEventListener("RWPUW_OFFER", showPollOffer);
            _arg_1.removeEventListener("RWPUW_ERROR", showPollError);
            _arg_1.removeEventListener("RWPUW_CONTENT", showPollContent);
        }

        private function showPollOffer(_arg_1:Event):void
        {
            var _local_4:int = RoomWidgetPollUpdateEvent(_arg_1).id;
            var _local_3:PollSession = (_SafeStr_4236.getValue(_local_4) as PollSession);
            var _local_2:String = RoomWidgetPollUpdateEvent(_arg_1).summary;
            var _local_5:String = RoomWidgetPollUpdateEvent(_arg_1).headline;
            if (!_local_3)
            {
                _local_3 = new PollSession(_local_4, this);
                _SafeStr_4236.add(_local_4, _local_3);
                _local_3.showOffer(_local_5, _local_2);
            }
            else
            {
                Logger.log("Poll with given id already exists!");
                _local_3.showOffer(_local_5, _local_2);
            };
        }

        private function showPollError(_arg_1:Event):void
        {
            var e:Event = _arg_1;
            windowManager.alert("${win_error}", RoomWidgetPollUpdateEvent(e).summary, 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
            {
                _arg_1.dispose();
            });
        }

        private function showPollContent(_arg_1:Event):void
        {
            var _local_4:int;
            var _local_2:PollSession;
            var _local_3:RoomWidgetPollUpdateEvent = (_arg_1 as RoomWidgetPollUpdateEvent);
            if (_local_3 != null)
            {
                _local_4 = _local_3.id;
                _local_2 = (_SafeStr_4236.getValue(_local_4) as PollSession);
                if (_local_2 != null)
                {
                    _local_2.showContent(_local_3.startMessage, _local_3.endMessage, _local_3.questionArray, _local_3.npsPoll);
                };
            };
        }

        public function pollFinished(_arg_1:int):void
        {
            var _local_2:PollSession = (_SafeStr_4236.getValue(_arg_1) as PollSession);
            if (_local_2 != null)
            {
                _local_2.showThanks();
                _local_2.dispose();
                _SafeStr_4236.remove(_arg_1);
            };
        }

        public function pollCancelled(_arg_1:int):void
        {
            var _local_2:PollSession = (_SafeStr_4236.getValue(_arg_1) as PollSession);
            if (_local_2 != null)
            {
                _local_2.dispose();
                _SafeStr_4236.remove(_arg_1);
            };
        }


    }
}