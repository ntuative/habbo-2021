package com.sulake.habbo.session.handler
{
    import com.sulake.habbo.communication.messages.parser.room.permissions.YouAreControllerMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.permissions.YouAreNotControllerMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.permissions.YouAreOwnerMessageEvent;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.session.IRoomHandlerListener;
    import com.sulake.habbo.communication.messages.parser.room.permissions.YouAreControllerMessageParser;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.permissions.YouAreNotControllerMessageParser;

    public class RoomPermissionsHandler extends BaseHandler 
    {

        public function RoomPermissionsHandler(_arg_1:IConnection, _arg_2:IRoomHandlerListener)
        {
            super(_arg_1, _arg_2);
            if (_arg_1 == null)
            {
                return;
            };
            _arg_1.addMessageEvent(new YouAreControllerMessageEvent(onYouAreController));
            _arg_1.addMessageEvent(new YouAreNotControllerMessageEvent(onYouAreNotController));
            _arg_1.addMessageEvent(new YouAreOwnerMessageEvent(onYouAreOwner));
        }

        private function onYouAreController(_arg_1:IMessageEvent):void
        {
            var _local_4:YouAreControllerMessageEvent = (_arg_1 as YouAreControllerMessageEvent);
            if (_local_4 == null)
            {
                return;
            };
            var _local_2:YouAreControllerMessageParser = _local_4.getParser();
            if (_local_2 == null)
            {
                return;
            };
            var _local_3:IRoomSession = listener.getSession(_local_2.flatId);
            if (_local_3 == null)
            {
                return;
            };
            _local_3.roomControllerLevel = _local_2.roomControllerLevel;
        }

        private function onYouAreNotController(_arg_1:IMessageEvent):void
        {
            var _local_4:YouAreNotControllerMessageEvent = (_arg_1 as YouAreNotControllerMessageEvent);
            if (_local_4 == null)
            {
                return;
            };
            var _local_2:YouAreNotControllerMessageParser = _local_4.getParser();
            if (_local_2 == null)
            {
                return;
            };
            var _local_3:IRoomSession = listener.getSession(_local_2.flatId);
            if (_local_3 == null)
            {
                return;
            };
            _local_3.roomControllerLevel = 0;
        }

        private function onYouAreOwner(_arg_1:IMessageEvent):void
        {
            var _local_3:YouAreOwnerMessageEvent = (_arg_1 as YouAreOwnerMessageEvent);
            if (_local_3 == null)
            {
                return;
            };
            var _local_2:IRoomSession = listener.getSession(_SafeStr_586);
            if (_local_2 == null)
            {
                return;
            };
            _local_2.isRoomOwner = true;
        }


    }
}

