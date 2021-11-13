package com.sulake.habbo.session.handler
{
    import com.sulake.habbo.communication.messages.incoming.room.furniture.PresentOpenedMessageEvent;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.session.IRoomHandlerListener;
    import com.sulake.habbo.communication.messages.parser.room.furniture.PresentOpenedMessageParser;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.habbo.session.events.RoomSessionPresentEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

    public class PresentHandler extends BaseHandler 
    {

        public function PresentHandler(_arg_1:IConnection, _arg_2:IRoomHandlerListener)
        {
            super(_arg_1, _arg_2);
            if (_arg_1 == null)
            {
                return;
            };
            _arg_1.addMessageEvent(new PresentOpenedMessageEvent(onPresentOpened));
        }

        private function onPresentOpened(_arg_1:IMessageEvent):void
        {
            var _local_2:PresentOpenedMessageParser = (_arg_1 as PresentOpenedMessageEvent).getParser();
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
                listener.events.dispatchEvent(new RoomSessionPresentEvent("RSPE_PRESENT_OPENED", _local_3, _local_2.classId, _local_2.itemType, _local_2.productCode, _local_2.placedItemId, _local_2.placedItemType, _local_2.placedInRoom, _local_2.petFigureString));
            };
        }


    }
}

