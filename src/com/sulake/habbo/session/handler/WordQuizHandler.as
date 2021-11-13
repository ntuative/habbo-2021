package com.sulake.habbo.session.handler
{
    import com.sulake.habbo.communication.messages.parser.poll.QuestionEvent;
    import com.sulake.habbo.communication.messages.parser.poll.QuestionAnsweredEvent;
    import com.sulake.habbo.communication.messages.parser.poll.QuestionFinishedEvent;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.session.IRoomHandlerListener;
    import com.sulake.habbo.session.events.RoomSessionWordQuizEvent;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.habbo.communication.messages.parser.poll.QuestionParser;
    import com.sulake.habbo.communication.messages.parser.poll.QuestionAnsweredParser;
    import com.sulake.habbo.communication.messages.parser.poll.QuestionFinishedParser;

    public class WordQuizHandler extends BaseHandler 
    {

        public function WordQuizHandler(_arg_1:IConnection, _arg_2:IRoomHandlerListener)
        {
            super(_arg_1, _arg_2);
            if (!_arg_1)
            {
                return;
            };
            _arg_1.addMessageEvent(new QuestionEvent(onQuestionStatus));
            _arg_1.addMessageEvent(new QuestionAnsweredEvent(onQuestionAnsweredEvent));
            _arg_1.addMessageEvent(new QuestionFinishedEvent(onQuestionFinishedEvent));
        }

        private function onQuestionStatus(_arg_1:QuestionEvent):void
        {
            var _local_4:RoomSessionWordQuizEvent;
            if (!_arg_1)
            {
                return;
            };
            var _local_3:IRoomSession = listener.getSession(_SafeStr_586);
            if (_local_3 == null)
            {
                return;
            };
            var _local_2:QuestionParser = _arg_1.getParser();
            _local_4 = new RoomSessionWordQuizEvent("RWPUW_NEW_QUESTION", _local_3, _local_2.pollId);
            _local_4.question = _local_2.question;
            _local_4.duration = _local_2.duration;
            _local_4.pollType = _local_2.pollType;
            _local_4.questionId = _local_2.questionId;
            _local_4.pollId = _local_2.pollId;
            listener.events.dispatchEvent(_local_4);
        }

        private function onQuestionAnsweredEvent(_arg_1:QuestionAnsweredEvent):void
        {
            var _local_4:RoomSessionWordQuizEvent;
            if (!_arg_1)
            {
                return;
            };
            var _local_3:IRoomSession = listener.getSession(_SafeStr_586);
            if (_local_3 == null)
            {
                return;
            };
            var _local_2:QuestionAnsweredParser = _arg_1.getParser();
            _local_4 = new RoomSessionWordQuizEvent("RWPUW_QUESTION_ANSWERED", _local_3, _local_2.userId);
            _local_4.value = _local_2.value;
            _local_4.userId = _local_2.userId;
            _local_4.answerCounts = _local_2.answerCounts;
            listener.events.dispatchEvent(_local_4);
        }

        private function onQuestionFinishedEvent(_arg_1:QuestionFinishedEvent):void
        {
            var _local_4:RoomSessionWordQuizEvent;
            if (!_arg_1)
            {
                return;
            };
            var _local_3:IRoomSession = listener.getSession(_SafeStr_586);
            if (_local_3 == null)
            {
                return;
            };
            var _local_2:QuestionFinishedParser = _arg_1.getParser();
            _local_4 = new RoomSessionWordQuizEvent("RWPUW_QUESION_FINSIHED", _local_3);
            _local_4.questionId = _local_2.questionId;
            _local_4.answerCounts = _local_2.answerCounts;
            listener.events.dispatchEvent(_local_4);
        }


    }
}

