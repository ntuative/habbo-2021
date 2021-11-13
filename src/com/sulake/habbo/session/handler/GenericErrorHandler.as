package com.sulake.habbo.session.handler
{
    import com.sulake.habbo.communication.messages.incoming.handshake.GenericErrorEvent;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.session.IRoomHandlerListener;
    import com.sulake.habbo.communication.messages.parser.handshake.GenericErrorParser;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.habbo.session.events.RoomSessionErrorMessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

    public class GenericErrorHandler extends BaseHandler 
    {

        public function GenericErrorHandler(_arg_1:IConnection, _arg_2:IRoomHandlerListener)
        {
            super(_arg_1, _arg_2);
            if (_arg_1 == null)
            {
                return;
            };
            _arg_1.addMessageEvent(new GenericErrorEvent(onGenericError));
        }

        private function onGenericError(_arg_1:IMessageEvent):void
        {
            var _local_4:String;
            var _local_2:GenericErrorParser = (_arg_1 as GenericErrorEvent).getParser();
            if (_local_2 == null)
            {
                return;
            };
            var _local_3:IRoomSession = listener.getSession(_SafeStr_586);
            if (_local_3 == null)
            {
                return;
            };
            switch (_local_2.errorCode)
            {
                case 4008:
                    _local_4 = "RSEME_KICKED";
                    break;
                default:
                    return;
            };
            if (((listener) && (listener.events)))
            {
                listener.events.dispatchEvent(new RoomSessionErrorMessageEvent(_local_4, _local_3));
            };
        }


    }
}

