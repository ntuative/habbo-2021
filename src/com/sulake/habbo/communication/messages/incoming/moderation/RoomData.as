package com.sulake.habbo.communication.messages.incoming.moderation
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class RoomData implements IDisposable 
    {

        private var _exists:Boolean;
        private var _name:String;
        private var _desc:String;
        private var _tags:Array = [];
        private var _disposed:Boolean;

        public function RoomData(_arg_1:IMessageDataWrapper)
        {
            var _local_3:int;
            super();
            _exists = _arg_1.readBoolean();
            if (!exists)
            {
                return;
            };
            _name = _arg_1.readString();
            _desc = _arg_1.readString();
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _tags.push(_arg_1.readString());
                _local_3++;
            };
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
            _tags = null;
        }

        public function get name():String
        {
            return (_name);
        }

        public function get desc():String
        {
            return (_desc);
        }

        public function get tags():Array
        {
            return (_tags);
        }

        public function get exists():Boolean
        {
            return (_exists);
        }


    }
}