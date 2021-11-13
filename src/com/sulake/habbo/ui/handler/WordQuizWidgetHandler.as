package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetWordQuizUpdateEvent;
    import com.sulake.habbo.session.IUserData;
    import com.sulake.habbo.session.events.RoomSessionWordQuizEvent;
    import com.sulake.habbo.avatar.enum.AvatarAction;
    import flash.events.Event;

    public class WordQuizWidgetHandler implements IRoomWidgetHandler 
    {

        private var _disposed:Boolean = false;
        private var _container:IRoomWidgetHandlerContainer = null;


        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get type():String
        {
            return ("RWE_WORD_QUIZZ");
        }

        public function set container(_arg_1:IRoomWidgetHandlerContainer):void
        {
            _container = _arg_1;
        }

        public function dispose():void
        {
            _disposed = true;
            _container = null;
        }

        public function get container():IRoomWidgetHandlerContainer
        {
            return (_container);
        }

        public function get roomSession():IRoomSession
        {
            return ((_container) ? _container.roomSession : null);
        }

        public function get roomEngine():IRoomEngine
        {
            return ((_container) ? _container.roomEngine : null);
        }

        public function getWidgetMessages():Array
        {
            return (["RWPUW_QUESTION_ANSWERED", "RWPUW_QUESION_FINSIHED", "RWPUW_NEW_QUESTION"]);
        }

        public function processWidgetMessage(_arg_1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            return (null);
        }

        public function getProcessedEvents():Array
        {
            var _local_1:Array = [];
            _local_1.push("RWPUW_QUESTION_ANSWERED");
            _local_1.push("RWPUW_QUESION_FINSIHED");
            _local_1.push("RWPUW_NEW_QUESTION");
            return (_local_1);
        }

        public function processEvent(_arg_1:Event):void
        {
            var _local_4:RoomWidgetWordQuizUpdateEvent;
            var _local_3:IUserData;
            if ((((_container == null) || (_container.events == null)) || (_container.roomSession == null)))
            {
                return;
            };
            var _local_2:RoomSessionWordQuizEvent = (_arg_1 as RoomSessionWordQuizEvent);
            if (_local_2 == null)
            {
                return;
            };
            switch (_arg_1.type)
            {
                case "RWPUW_QUESTION_ANSWERED":
                    _local_4 = new RoomWidgetWordQuizUpdateEvent(_local_2.id, "RWPUW_QUESTION_ANSWERED");
                    _local_4.value = _local_2.value;
                    _local_4.userId = _local_2.userId;
                    _local_4.answerCounts = _local_2.answerCounts;
                    _local_3 = _container.roomSession.userDataManager.getUserData(_local_2.userId);
                    if (!_local_3)
                    {
                        return;
                    };
                    if (_local_4.value == "0")
                    {
                        _container.roomEngine.updateObjectUserGesture(_container.roomSession.roomId, _local_3.roomObjectId, AvatarAction.getGestureId("sad"));
                    }
                    else
                    {
                        _container.roomEngine.updateObjectUserGesture(_container.roomSession.roomId, _local_3.roomObjectId, AvatarAction.getGestureId("sml"));
                    };
                    break;
                case "RWPUW_QUESION_FINSIHED":
                    _local_4 = new RoomWidgetWordQuizUpdateEvent(_local_2.id, "RWPUW_QUESION_FINSIHED");
                    _local_4.pollId = _local_2.pollId;
                    _local_4.questionId = _local_2.questionId;
                    _local_4.answerCounts = _local_2.answerCounts;
                    break;
                case "RWPUW_NEW_QUESTION":
                    _local_4 = new RoomWidgetWordQuizUpdateEvent(_local_2.id, "RWPUW_NEW_QUESTION");
                    _local_4.question = _local_2.question;
                    _local_4.duration = _local_2.duration;
                    _local_4.pollType = _local_2.pollType;
                    _local_4.questionId = _local_2.questionId;
                    _local_4.pollId = _local_2.pollId;
            };
            if (_local_4 == null)
            {
                return;
            };
            _container.events.dispatchEvent(_local_4);
        }

        public function update():void
        {
        }


    }
}