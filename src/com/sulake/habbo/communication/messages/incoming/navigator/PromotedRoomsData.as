package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class PromotedRoomsData implements IDisposable, _SafeStr_78 
    {

        private var _entries:Array = [];
        private var _disposed:Boolean;

        public function PromotedRoomsData(_arg_1:IMessageDataWrapper)
        {
            var _local_3:int;
            super();
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _entries.push(new PromotedRoomCategoryData(_arg_1));
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
            if (_entries != null)
            {
                for each (var _local_1:PromotedRoomCategoryData in _entries)
                {
                    _local_1.dispose();
                };
            };
            _entries = null;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get entries():Array
        {
            return (_entries);
        }


    }
}

