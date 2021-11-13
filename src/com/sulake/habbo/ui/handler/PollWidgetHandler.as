package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetPollMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetPollUpdateEvent;
    import com.sulake.habbo.session.events.RoomSessionPollEvent;
    import flash.events.Event;

    public class PollWidgetHandler implements IRoomWidgetHandler 
    {

        private var _disposed:Boolean = false;
        private var _container:IRoomWidgetHandlerContainer = null;


        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get type():String
        {
            return ("RWE_ROOM_POLL");
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

        public function getWidgetMessages():Array
        {
            return (["RWPM_ANSWER", "RWPM_REJECT", "RWPM_START"]);
        }

        public function processWidgetMessage(_arg_1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            var _local_2:RoomWidgetPollMessage = (_arg_1 as RoomWidgetPollMessage);
            if (_local_2 == null)
            {
                return (null);
            };
            switch (_arg_1.type)
            {
                case "RWPM_START":
                    _container.roomSession.sendPollStartMessage(_local_2.id);
                    break;
                case "RWPM_REJECT":
                    _container.roomSession.sendPollRejectMessage(_local_2.id);
                    break;
                case "RWPM_ANSWER":
                    _container.roomSession.sendPollAnswerMessage(_local_2.id, _local_2.questionId, _local_2.answers);
            };
            return (null);
        }

        public function getProcessedEvents():Array
        {
            var _local_1:Array = [];
            _local_1.push("RSPE_POLL_OFFER");
            _local_1.push("RSPE_POLL_ERROR");
            _local_1.push("RSPE_POLL_CONTENT");
            return (_local_1);
        }

        public function processEvent(_arg_1:Event):void
        {
            var _local_2:RoomWidgetPollUpdateEvent;
            if (((_container == null) || (_container.events == null)))
            {
                return;
            };
            var _local_3:RoomSessionPollEvent = (_arg_1 as RoomSessionPollEvent);
            if (_local_3 == null)
            {
                return;
            };
            switch (_arg_1.type)
            {
                case "RSPE_POLL_OFFER":
                    _local_2 = new RoomWidgetPollUpdateEvent(_local_3.id, "RWPUW_OFFER");
                    _local_2.summary = _local_3.summary;
                    _local_2.headline = _local_3.headline;
                    break;
                case "RSPE_POLL_ERROR":
                    _local_2 = new RoomWidgetPollUpdateEvent(_local_3.id, "RWPUW_ERROR");
                    _local_2.summary = _local_3.summary;
                    _local_2.headline = _local_3.headline;
                    break;
                case "RSPE_POLL_CONTENT":
                    _local_2 = new RoomWidgetPollUpdateEvent(_local_3.id, "RWPUW_CONTENT");
                    _local_2.startMessage = _local_3.startMessage;
                    _local_2.endMessage = _local_3.endMessage;
                    _local_2.numQuestions = _local_3.numQuestions;
                    _local_2.questionArray = _local_3.questionArray;
                    _local_2.npsPoll = _local_3.npsPoll;
            };
            if (_local_2 == null)
            {
                return;
            };
            _container.events.dispatchEvent(_local_2);
        }

        public function update():void
        {
        }


    }
}