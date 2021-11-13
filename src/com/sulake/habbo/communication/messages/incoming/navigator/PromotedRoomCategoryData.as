package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class PromotedRoomCategoryData implements IDisposable 
    {

        private var _code:String;
        private var _leaderFigure:String;
        private var _bestRoom:GuestRoomData;
        private var _rooms:Array = [];
        private var _open:Boolean;
        private var _figurePending:Boolean;
        private var _disposed:Boolean;

        public function PromotedRoomCategoryData(_arg_1:IMessageDataWrapper)
        {
            var _local_3:int;
            super();
            _code = _arg_1.readString();
            _leaderFigure = _arg_1.readString();
            var _local_2:int = _arg_1.readInteger();
            _bestRoom = new GuestRoomData(_arg_1);
            _local_3 = 1;
            while (_local_3 < _local_2)
            {
                _rooms.push(new GuestRoomData(_arg_1));
                _local_3++;
            };
        }

        public function dispose():void
        {
            if (_disposed)
            {
                return;
            };
            _disposed = true;
            if (_bestRoom)
            {
                _bestRoom.dispose();
                _bestRoom = null;
            };
            for each (var _local_1:GuestRoomData in rooms)
            {
                _local_1.dispose();
            };
            _rooms = null;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get code():String
        {
            return (_code);
        }

        public function get leaderFigure():String
        {
            return (_leaderFigure);
        }

        public function get rooms():Array
        {
            return (_rooms);
        }

        public function get open():Boolean
        {
            return (_open);
        }

        public function set open(_arg_1:Boolean):void
        {
            _open = _arg_1;
        }

        public function toggleOpen():void
        {
            _open = (!(_open));
        }

        public function get bestRoom():GuestRoomData
        {
            return (_bestRoom);
        }

        public function get figurePending():Boolean
        {
            return (_figurePending);
        }

        public function set figurePending(_arg_1:Boolean):void
        {
            _figurePending = _arg_1;
        }


    }
}