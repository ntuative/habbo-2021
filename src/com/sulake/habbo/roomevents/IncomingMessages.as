package com.sulake.habbo.roomevents
{
    import com.sulake.core.runtime.IDisposable;
    import __AS3__.vec.Vector;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.WiredValidationErrorEvent;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.WiredFurniTriggerEvent;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.WiredFurniConditionEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectRemoveMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.WiredRewardResultMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.WiredFurniActionEvent;
    import com.sulake.habbo.communication.messages.parser.room.session.CloseConnectionMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.UserObjectEvent;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.WiredSaveSuccessEvent;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.OpenEvent;
    import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.OpenMessageParser;
    import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.OpenMessageComposer;
    import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.WiredFurniTriggerMessageParser;
    import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.WiredFurniActionMessageParser;
    import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.WiredFurniConditionMessageParser;
    import com.sulake.habbo.communication.messages.parser.handshake.UserObjectMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.engine.ObjectRemoveMessageParser;
    import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.WiredRewardResultMessageParser;
    import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.WiredValidationErrorParser;

        public class IncomingMessages implements IDisposable 
    {

        private var _roomEvents:HabboUserDefinedRoomEvents;
        private var _messageEvents:Vector.<IMessageEvent>;

        public function IncomingMessages(_arg_1:HabboUserDefinedRoomEvents)
        {
            _roomEvents = _arg_1;
            _messageEvents = new Vector.<IMessageEvent>(0);
            var _local_2:IHabboCommunicationManager = _roomEvents.communication;
            addMessageEvent(new WiredValidationErrorEvent(onValidationError));
            addMessageEvent(new WiredFurniTriggerEvent(onTrigger));
            addMessageEvent(new WiredFurniConditionEvent(onCondition));
            addMessageEvent(new ObjectRemoveMessageEvent(onObjectRemove));
            addMessageEvent(new WiredRewardResultMessageEvent(onRewardFailed));
            addMessageEvent(new WiredFurniActionEvent(onAction));
            addMessageEvent(new CloseConnectionMessageEvent(onRoomExit));
            addMessageEvent(new UserObjectEvent(onUserObject));
            addMessageEvent(new WiredSaveSuccessEvent(onSaveSuccess));
            addMessageEvent(new OpenEvent(onOpen));
        }

        private function addMessageEvent(_arg_1:IMessageEvent):void
        {
            _messageEvents.push(_roomEvents.communication.addHabboConnectionMessageEvent(_arg_1));
        }

        private function onOpen(_arg_1:IMessageEvent):void
        {
            var _local_2:OpenMessageParser = (_arg_1 as OpenEvent).getParser();
            _roomEvents.send(new OpenMessageComposer(_local_2.stuffId));
        }

        private function onTrigger(_arg_1:IMessageEvent):void
        {
            var _local_2:WiredFurniTriggerMessageParser = (_arg_1 as WiredFurniTriggerEvent).getParser();
            _roomEvents.userDefinedRoomEventsCtrl.prepareForUpdate(_local_2.def);
        }

        private function onAction(_arg_1:IMessageEvent):void
        {
            var _local_2:WiredFurniActionMessageParser = (_arg_1 as WiredFurniActionEvent).getParser();
            _roomEvents.userDefinedRoomEventsCtrl.prepareForUpdate(_local_2.def);
        }

        private function onCondition(_arg_1:IMessageEvent):void
        {
            var _local_2:WiredFurniConditionMessageParser = (_arg_1 as WiredFurniConditionEvent).getParser();
            _roomEvents.userDefinedRoomEventsCtrl.prepareForUpdate(_local_2.def);
        }

        private function onUserObject(_arg_1:IMessageEvent):void
        {
            var _local_2:UserObjectMessageParser = (_arg_1 as UserObjectEvent).getParser();
            _roomEvents.userName = _local_2.name;
        }

        private function onRoomExit(_arg_1:IMessageEvent):void
        {
            _roomEvents.userDefinedRoomEventsCtrl.close();
        }

        private function onObjectRemove(_arg_1:IMessageEvent):void
        {
            var _local_2:ObjectRemoveMessageParser = (_arg_1 as ObjectRemoveMessageEvent).getParser();
            Logger.log(((("Received object remove event: " + _local_2.id) + ", ") + _local_2.isExpired));
            _roomEvents.userDefinedRoomEventsCtrl.stuffRemoved(_local_2.id);
        }

        private function onRewardFailed(_arg_1:IMessageEvent):void
        {
            var _local_2:WiredRewardResultMessageParser = WiredRewardResultMessageEvent(_arg_1).getParser();
            if (_local_2.reason == 6)
            {
                _roomEvents.windowManager.alert(_roomEvents.localization.getLocalization("wiredfurni.rewardsuccess.title"), _roomEvents.localization.getLocalization("wiredfurni.rewardsuccess.body"), 0, null);
            }
            else
            {
                if (_local_2.reason == 7)
                {
                    _roomEvents.windowManager.alert(_roomEvents.localization.getLocalization("wiredfurni.badgereceived.title"), _roomEvents.localization.getLocalization("wiredfurni.badgereceived.body"), 0, null);
                }
                else
                {
                    _roomEvents.windowManager.alert(_roomEvents.localization.getLocalization("wiredfurni.rewardfailed.title"), _roomEvents.localization.getLocalization(("wiredfurni.rewardfailed.reason." + _local_2.reason)), 0, null);
                };
            };
        }

        private function onValidationError(_arg_1:IMessageEvent):void
        {
            var _local_2:WiredValidationErrorParser = WiredValidationErrorEvent(_arg_1).getParser();
            _roomEvents.windowManager.alert("Update failed", _local_2.info, 0, null);
        }

        private function onSaveSuccess(_arg_1:IMessageEvent):void
        {
            _roomEvents.userDefinedRoomEventsCtrl.close();
        }

        public function dispose():void
        {
            if (disposed)
            {
                return;
            };
            var _local_2:IHabboCommunicationManager = _roomEvents.communication;
            if (((!(_messageEvents == null)) && (!(_local_2 == null))))
            {
                for each (var _local_1:IMessageEvent in _messageEvents)
                {
                    _local_2.removeHabboConnectionMessageEvent(_local_1);
                };
            };
            _roomEvents = null;
        }

        public function get disposed():Boolean
        {
            return (_roomEvents == null);
        }


    }
}

