package com.sulake.habbo.session.handler
{
    import com.sulake.habbo.communication.messages.incoming.room.furniture.OpenPetPackageRequestedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.furniture.OpenPetPackageResultMessageEvent;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.session.IRoomHandlerListener;
    import com.sulake.habbo.communication.messages.parser.room.furniture.OpenPetPackageRequestedMessageParser;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.habbo.session.events.RoomSessionPetPackageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.furniture.OpenPetPackageResultMessageParser;

    public class PetPackageHandler extends BaseHandler 
    {

        public function PetPackageHandler(_arg_1:IConnection, _arg_2:IRoomHandlerListener)
        {
            super(_arg_1, _arg_2);
            if (_arg_1 == null)
            {
                return;
            };
            _arg_1.addMessageEvent(new OpenPetPackageRequestedMessageEvent(onOpenPetPackageRequested));
            _arg_1.addMessageEvent(new OpenPetPackageResultMessageEvent(onOpenPetPackageResult));
        }

        private function onOpenPetPackageRequested(_arg_1:IMessageEvent):void
        {
            var _local_2:OpenPetPackageRequestedMessageParser = (_arg_1 as OpenPetPackageRequestedMessageEvent).getParser();
            if (_local_2 == null)
            {
                return;
            };
            var _local_3:IRoomSession = listener.getSession(_SafeStr_586);
            if (_local_3 == null)
            {
                return;
            };
            if (((listener) && (listener.events)))
            {
                listener.events.dispatchEvent(new RoomSessionPetPackageEvent("RSOPPE_OPEN_PET_PACKAGE_REQUESTED", _local_3, _local_2.objectId, _local_2.figureData, 0, null));
            };
        }

        private function onOpenPetPackageResult(_arg_1:IMessageEvent):void
        {
            var _local_2:OpenPetPackageResultMessageParser = (_arg_1 as OpenPetPackageResultMessageEvent).getParser();
            if (_local_2 == null)
            {
                return;
            };
            var _local_3:IRoomSession = listener.getSession(_SafeStr_586);
            if (_local_3 == null)
            {
                return;
            };
            if (((listener) && (listener.events)))
            {
                listener.events.dispatchEvent(new RoomSessionPetPackageEvent("RSOPPE_OPEN_PET_PACKAGE_RESULT", _local_3, _local_2.objectId, null, _local_2.nameValidationStatus, _local_2.nameValidationInfo));
            };
        }


    }
}

