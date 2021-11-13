package com.sulake.habbo.ui.widget.roomqueue
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.runtime.ICoreConfiguration;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.ui.widget.events.RoomWidgetRoomQueueUpdateEvent;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components._SafeStr_101;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetRoomQueueMessage;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class RoomQueueWidget extends RoomWidgetBase 
    {

        private var _window:IFrameWindow;
        private var _config:ICoreConfiguration;
        private var _queuePosition:int;
        private var _SafeStr_4279:Boolean;
        private var _SafeStr_4280:String;
        private var _SafeStr_4281:Boolean;
        private var _SafeStr_4282:Boolean;

        public function RoomQueueWidget(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary, _arg_4:IHabboLocalizationManager, _arg_5:ICoreConfiguration)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
            _config = _arg_5;
        }

        override public function dispose():void
        {
            removeWindow();
            _config = null;
            super.dispose();
        }

        override public function registerUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            _arg_1.addEventListener("RWRQUE_VISITOR_QUEUE_STATUS", onQueueStatus);
            _arg_1.addEventListener("RWRQUE_SPECTATOR_QUEUE_STATUS", onQueueStatus);
            super.registerUpdateEvents(_arg_1);
        }

        override public function unregisterUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            _arg_1.removeEventListener("RWRQUE_VISITOR_QUEUE_STATUS", onQueueStatus);
            _arg_1.removeEventListener("RWRQUE_SPECTATOR_QUEUE_STATUS", onQueueStatus);
        }

        private function removeWindow():void
        {
            if (_window != null)
            {
                _window.dispose();
                _window = null;
            };
        }

        private function onQueueStatus(_arg_1:RoomWidgetRoomQueueUpdateEvent):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            if (_arg_1.isActive)
            {
                _SafeStr_4280 = _arg_1.type;
                _SafeStr_4281 = false;
                _queuePosition = _arg_1.position;
            }
            else
            {
                _SafeStr_4281 = true;
            };
            _SafeStr_4279 = _arg_1.hasHabboClub;
            _SafeStr_4282 = _arg_1.isClubQueue;
            localizations.registerParameter("room.queue.position", "position", _queuePosition.toString());
            localizations.registerParameter("room.queue.position.hc", "position", _queuePosition.toString());
            localizations.registerParameter("room.queue.spectator.position", "position", _queuePosition.toString());
            localizations.registerParameter("room.queue.spectator.position.hc", "position", _queuePosition.toString());
            showInterface();
        }

        private function createWindow():Boolean
        {
            if (_window != null)
            {
                return (true);
            };
            var _local_2:XmlAsset = (assets.getAssetByName("room_queue") as XmlAsset);
            _window = (windowManager.buildFromXML((_local_2.content as XML)) as IFrameWindow);
            if (_window == null)
            {
                return (false);
            };
            _window.visible = false;
            var _local_1:IWindow = _window.findChildByTag("close");
            if (_local_1 != null)
            {
                _local_1.addEventListener("WME_CLICK", exitQueue);
            };
            _local_1 = _window.findChildByName("cancel_button");
            if (_local_1 != null)
            {
                _local_1.addEventListener("WME_CLICK", exitQueue);
            };
            _local_1 = _window.findChildByName("link_text");
            if (_local_1 != null)
            {
                _local_1.addEventListener("WME_CLICK", openLink);
            };
            _local_1 = _window.findChildByName("change_button");
            if (_local_1 != null)
            {
                _local_1.addEventListener("WME_CLICK", changeQueue);
            };
            _window.center();
            return (true);
        }

        private function showInterface():void
        {
            if (!createWindow())
            {
                return;
            };
            var _local_3:ITextWindow = (_window.findChildByName("info_text") as ITextWindow);
            var _local_4:_SafeStr_101 = (_window.findChildByName("change_button") as _SafeStr_101);
            var _local_2:IWindow = _window.findChildByName("spectator_info");
            if ((((!(_local_3 == null)) && (!(_local_4 == null))) && (!(_local_2 == null))))
            {
                switch (_SafeStr_4280)
                {
                    case "RWRQUE_VISITOR_QUEUE_STATUS":
                        _local_3.caption = ((_SafeStr_4282) ? "${room.queue.position.hc}" : "${room.queue.position}");
                        _local_4.caption = "${room.queue.spectatormode}";
                        _local_2.visible = _SafeStr_4281;
                        break;
                    case "RWRQUE_SPECTATOR_QUEUE_STATUS":
                        _local_3.caption = ((_SafeStr_4282) ? "${room.queue.spectator.position.hc}" : "${room.queue.spectator.position}");
                        _local_4.caption = "${room.queue.back}";
                        _local_2.visible = false;
                };
                _local_4.visible = _SafeStr_4281;
            };
            var _local_1:IWindowContainer = (_window.findChildByName("club_container") as IWindowContainer);
            if (_local_1 != null)
            {
                _local_1.visible = (!(_SafeStr_4279));
            };
            _window.visible = true;
        }

        private function exitQueue(_arg_1:WindowMouseEvent):void
        {
            if (messageListener == null)
            {
                return;
            };
            var _local_2:RoomWidgetRoomQueueMessage = new RoomWidgetRoomQueueMessage("RWRQM_EXIT_QUEUE");
            messageListener.processWidgetMessage(_local_2);
            removeWindow();
        }

        private function openLink(_arg_1:WindowMouseEvent):void
        {
            messageListener.processWidgetMessage(new RoomWidgetRoomQueueMessage("RWRQM_CLUB_LINK"));
        }

        private function changeQueue(_arg_1:WindowMouseEvent):void
        {
            var _local_2:RoomWidgetRoomQueueMessage;
            if (messageListener == null)
            {
                return;
            };
            if (_SafeStr_4280 == "RWRQUE_VISITOR_QUEUE_STATUS")
            {
                _local_2 = new RoomWidgetRoomQueueMessage("RWRQM_CHANGE_TO_SPECTATOR_QUEUE");
            }
            else
            {
                _local_2 = new RoomWidgetRoomQueueMessage("RWRQM_CHANGE_TO_VISITOR_QUEUE");
            };
            messageListener.processWidgetMessage(_local_2);
            removeWindow();
        }


    }
}

