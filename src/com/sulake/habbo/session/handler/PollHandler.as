package com.sulake.habbo.session.handler
{
    import com.sulake.habbo.communication.messages.parser.poll.PollContentsEvent;
    import com.sulake.habbo.communication.messages.parser.poll.PollOfferEvent;
    import com.sulake.habbo.communication.messages.parser.poll.PollErrorEvent;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.session.IRoomHandlerListener;
    import com.sulake.habbo.session.events.RoomSessionPollEvent;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.habbo.communication.messages.parser.poll.PollOfferParser;
    import com.sulake.habbo.communication.messages.parser.poll._SafeStr_58;
    import com.sulake.habbo.communication.messages.parser.poll.PollContentsParser;

    public class PollHandler extends BaseHandler 
    {

        public function PollHandler(_arg_1:IConnection, _arg_2:IRoomHandlerListener)
        {
            super(_arg_1, _arg_2);
            if (!_arg_1)
            {
                return;
            };
            _arg_1.addMessageEvent(new PollContentsEvent(onPollContentsEvent));
            _arg_1.addMessageEvent(new PollOfferEvent(onPollOfferEvent));
            _arg_1.addMessageEvent(new PollErrorEvent(onPollErrorEvent));
        }

        private function onPollOfferEvent(_arg_1:PollOfferEvent):void
        {
            var _local_4:RoomSessionPollEvent;
            if (!_arg_1)
            {
                return;
            };
            var _local_3:IRoomSession = listener.getSession(_SafeStr_586);
            if (_local_3 == null)
            {
                return;
            };
            var _local_2:PollOfferParser = _arg_1.getParser();
            _local_4 = new RoomSessionPollEvent("RSPE_POLL_OFFER", _local_3, _local_2.id);
            _local_4.summary = _local_2.headline;
            _local_4.summary = _local_2.summary;
            listener.events.dispatchEvent(_local_4);
        }

        private function onPollErrorEvent(_arg_1:PollErrorEvent):void
        {
            var _local_4:RoomSessionPollEvent;
            if (!_arg_1)
            {
                return;
            };
            var _local_3:IRoomSession = listener.getSession(_SafeStr_586);
            if (_local_3 == null)
            {
                return;
            };
            var _local_2:_SafeStr_58 = _arg_1.getParser();
            _local_4 = new RoomSessionPollEvent("RSPE_POLL_ERROR", _local_3, -1);
            _local_4.headline = "???";
            _local_4.summary = "???";
            listener.events.dispatchEvent(_local_4);
        }

        private function onPollContentsEvent(_arg_1:PollContentsEvent):void
        {
            var _local_4:RoomSessionPollEvent;
            if (!_arg_1)
            {
                return;
            };
            var _local_3:IRoomSession = listener.getSession(_SafeStr_586);
            if (_local_3 == null)
            {
                return;
            };
            var _local_2:PollContentsParser = _arg_1.getParser();
            _local_4 = new RoomSessionPollEvent("RSPE_POLL_CONTENT", _local_3, _local_2.id);
            _local_4.startMessage = _local_2.startMessage;
            _local_4.endMessage = _local_2.endMessage;
            _local_4.numQuestions = _local_2.numQuestions;
            _local_4.questionArray = _local_2.questionArray;
            _local_4.npsPoll = _local_2.npsPoll;
            listener.events.dispatchEvent(_local_4);
        }


    }
}

