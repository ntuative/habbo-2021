package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.furniture.RequestSpamWallPostItMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.furniture.RequestSpamWallPostItMessageParser;
    import com.sulake.habbo.inventory.items.IFurnitureItem;
    import com.sulake.habbo.ui.widget.events.RoomWidgetSpamWallPostItEditEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetSpamWallPostItFinishEditingMessage;
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.AddSpamWallPostItMessageComposer;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import flash.events.Event;

    public class SpamWallPostItWidgetHandler implements IRoomWidgetHandler 
    {

        private var _disposed:Boolean = false;
        private var _container:IRoomWidgetHandlerContainer;
        private var _connection:IConnection = null;
        private var _SafeStr_3877:IMessageEvent;


        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get type():String
        {
            return ("RWE_SPAMWALL_POSTIT_WIDGET");
        }

        public function set container(_arg_1:IRoomWidgetHandlerContainer):void
        {
            _container = _arg_1;
        }

        public function set connection(_arg_1:IConnection):void
        {
            _SafeStr_3877 = new RequestSpamWallPostItMessageEvent(onSpamWallPostItRequest);
            _connection = _arg_1;
            _connection.addMessageEvent(_SafeStr_3877);
        }

        public function dispose():void
        {
            if (!_disposed)
            {
                _disposed = true;
                _connection.removeMessageEvent(_SafeStr_3877);
                _connection = null;
            };
        }

        private function onSpamWallPostItRequest(_arg_1:RequestSpamWallPostItMessageEvent):void
        {
            var _local_7:String;
            if (_arg_1 == null)
            {
                return;
            };
            var _local_5:RequestSpamWallPostItMessageParser = _arg_1.getParser();
            var _local_2:int = _local_5.itemId;
            var _local_6:String = _local_5.location;
            var _local_3:String = "post_it";
            var _local_4:IFurnitureItem;
            if (_container.inventory != null)
            {
                _local_4 = _container.inventory.getWallItemById(_local_2);
            };
            if (((!(_local_4 == null)) && (!(_container.roomEngine == null))))
            {
                _local_7 = _container.roomEngine.getWallItemType(_local_4.type);
                if (_local_7.match("post_it_"))
                {
                    _local_3 = _local_7;
                };
            };
            if (_container != null)
            {
                if (_container.events != null)
                {
                    _container.events.dispatchEvent(new RoomWidgetSpamWallPostItEditEvent("RWSWPUE_OPEN_EDITOR", _local_2, _local_6, _local_3));
                };
            };
        }

        public function getWidgetMessages():Array
        {
            return (["RWSWPUE_OPEN_EDITOR", "RWSWPFEE_SEND_POSTIT_DATA"]);
        }

        public function processWidgetMessage(_arg_1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            var _local_2:RoomWidgetSpamWallPostItFinishEditingMessage;
            var _local_3:AddSpamWallPostItMessageComposer;
            switch (_arg_1.type)
            {
                case "RWSWPFEE_SEND_POSTIT_DATA":
                    _local_2 = (_arg_1 as RoomWidgetSpamWallPostItFinishEditingMessage);
                    if (_local_2 != null)
                    {
                        if (_connection != null)
                        {
                            _local_3 = new AddSpamWallPostItMessageComposer(_local_2.objectId, _local_2.location, _local_2.colorHex, _local_2.text);
                            _connection.send(_local_3);
                        };
                    };
            };
            return (null);
        }

        public function getProcessedEvents():Array
        {
            return ([]);
        }

        public function processEvent(_arg_1:Event):void
        {
        }

        public function update():void
        {
        }


    }
}

