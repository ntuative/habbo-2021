package com.sulake.room.object.logic
{
    import flash.events.IEventDispatcher;
    import com.sulake.room.object.IRoomObjectController;
    import com.sulake.room.events.RoomSpriteMouseEvent;
    import com.sulake.room.utils.IRoomGeometry;
    import com.sulake.room.messages.RoomObjectUpdateMessage;

    public class ObjectLogicBase implements IRoomObjectEventHandler 
    {

        private var _eventDispatcher:IEventDispatcher;
        private var _object:IRoomObjectController;


        public function get eventDispatcher():IEventDispatcher
        {
            return (_eventDispatcher);
        }

        public function set eventDispatcher(_arg_1:IEventDispatcher):void
        {
            _eventDispatcher = _arg_1;
        }

        public function getEventTypes():Array
        {
            return ([]);
        }

        protected function getAllEventTypes(_arg_1:Array, _arg_2:Array):Array
        {
            var _local_3:Array = _arg_1.concat();
            for each (var _local_4:String in _arg_2)
            {
                if (_local_3.indexOf(_local_4) < 0)
                {
                    _local_3.push(_local_4);
                };
            };
            return (_local_3);
        }

        public function dispose():void
        {
            _object = null;
        }

        public function set object(_arg_1:IRoomObjectController):void
        {
            if (_object == _arg_1)
            {
                return;
            };
            if (_object != null)
            {
                _object.setEventHandler(null);
            };
            if (_arg_1 == null)
            {
                dispose();
                _object = null;
            }
            else
            {
                _object = _arg_1;
                _object.setEventHandler(this);
            };
        }

        public function get object():IRoomObjectController
        {
            return (_object);
        }

        public function mouseEvent(_arg_1:RoomSpriteMouseEvent, _arg_2:IRoomGeometry):void
        {
        }

        public function initialize(_arg_1:XML):void
        {
        }

        public function update(_arg_1:int):void
        {
        }

        public function processUpdateMessage(_arg_1:RoomObjectUpdateMessage):void
        {
            if (_arg_1 != null)
            {
                if (_object != null)
                {
                    _object.setLocation(_arg_1.loc);
                    _object.setDirection(_arg_1.dir);
                };
            };
        }

        public function useObject():void
        {
        }

        public function tearDown():void
        {
        }

        public function get widget():String
        {
            return (null);
        }

        public function get contextMenu():String
        {
            return (null);
        }


    }
}