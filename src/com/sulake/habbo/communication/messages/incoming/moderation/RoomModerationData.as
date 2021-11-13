package com.sulake.habbo.communication.messages.incoming.moderation
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class RoomModerationData implements IDisposable 
    {

        private var _flatId:int;
        private var _userCount:int;
        private var _ownerInRoom:Boolean;
        private var _ownerId:int;
        private var _ownerName:String;
        private var _room:RoomData;
        private var _disposed:Boolean;

        public function RoomModerationData(_arg_1:IMessageDataWrapper)
        {
            _flatId = _arg_1.readInteger();
            _userCount = _arg_1.readInteger();
            _ownerInRoom = _arg_1.readBoolean();
            _ownerId = _arg_1.readInteger();
            _ownerName = _arg_1.readString();
            _room = new RoomData(_arg_1);
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function dispose():void
        {
            if (_disposed)
            {
                return;
            };
            _disposed = true;
            if (_room != null)
            {
                _room.dispose();
                _room = null;
            };
        }

        public function get flatId():int
        {
            return (_flatId);
        }

        public function get userCount():int
        {
            return (_userCount);
        }

        public function get ownerInRoom():Boolean
        {
            return (_ownerInRoom);
        }

        public function get ownerId():int
        {
            return (_ownerId);
        }

        public function get ownerName():String
        {
            return (_ownerName);
        }

        public function get room():RoomData
        {
            return (_room);
        }


    }
}