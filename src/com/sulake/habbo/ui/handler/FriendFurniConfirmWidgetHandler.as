package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.habbo.ui.widget.furniture.friendfurni.FriendFurniConfirmWidget;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.friendfurni.FriendFurniStartConfirmationMessageEvent;
    import com.sulake.habbo.communication.messages.parser.friendfurni.FriendFurniOtherLockConfirmedMessageEvent;
    import com.sulake.habbo.communication.messages.parser.friendfurni.FriendFurniCancelLockMessageEvent;
    import com.sulake.habbo.communication.messages.outgoing.friendfurni.FriendFurniConfirmLockMessageComposer;
    import flash.events.Event;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;

    public class FriendFurniConfirmWidgetHandler implements IRoomWidgetHandler 
    {

        private var _disposed:Boolean = false;
        private var _container:IRoomWidgetHandlerContainer = null;
        private var _SafeStr_1324:FriendFurniConfirmWidget;
        private var _connection:IConnection;
        private var _SafeStr_3861:IMessageEvent = null;
        private var _SafeStr_3862:IMessageEvent = null;
        private var _SafeStr_3863:IMessageEvent = null;


        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function set container(_arg_1:IRoomWidgetHandlerContainer):void
        {
            _container = _arg_1;
        }

        public function set widget(_arg_1:FriendFurniConfirmWidget):void
        {
            _SafeStr_1324 = _arg_1;
        }

        public function dispose():void
        {
            if (!_disposed)
            {
                if (((_connection) && (_SafeStr_3861)))
                {
                    _connection.removeMessageEvent(_SafeStr_3861);
                    _connection.removeMessageEvent(_SafeStr_3862);
                    _connection.removeMessageEvent(_SafeStr_3863);
                    _connection = null;
                };
                _SafeStr_1324 = null;
                _container = null;
                _disposed = true;
            };
        }

        public function set connection(_arg_1:IConnection):void
        {
            _connection = _arg_1;
            if (!_SafeStr_3861)
            {
                _SafeStr_3861 = new FriendFurniStartConfirmationMessageEvent(onStartConfirmation);
                _SafeStr_3862 = new FriendFurniOtherLockConfirmedMessageEvent(onOtherLockConfirmed);
                _SafeStr_3863 = new FriendFurniCancelLockMessageEvent(onCancelLock);
                _connection.addMessageEvent(_SafeStr_3861);
                _connection.addMessageEvent(_SafeStr_3862);
                _connection.addMessageEvent(_SafeStr_3863);
            };
        }

        public function sendLockConfirm(_arg_1:int, _arg_2:Boolean):void
        {
            _connection.send(new FriendFurniConfirmLockMessageComposer(_arg_1, _arg_2));
        }

        private function onStartConfirmation(_arg_1:FriendFurniStartConfirmationMessageEvent):void
        {
            _SafeStr_1324.open(_arg_1.getParser().stuffId, _arg_1.getParser().isOwner);
        }

        private function onOtherLockConfirmed(_arg_1:FriendFurniOtherLockConfirmedMessageEvent):void
        {
            _SafeStr_1324.otherConfirmed(_arg_1.getParser().stuffId);
        }

        private function onCancelLock(_arg_1:FriendFurniCancelLockMessageEvent):void
        {
            _SafeStr_1324.close(_arg_1.getParser().stuffId);
        }

        public function get type():String
        {
            return ("");
        }

        public function getProcessedEvents():Array
        {
            return (null);
        }

        public function processEvent(_arg_1:Event):void
        {
        }

        public function getWidgetMessages():Array
        {
            return ([]);
        }

        public function processWidgetMessage(_arg_1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            return (null);
        }

        public function update():void
        {
        }


    }
}

