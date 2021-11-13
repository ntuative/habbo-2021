package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class PopularRoomTagsData implements IDisposable, _SafeStr_78 
    {

        private var _tags:Array = [];
        private var _disposed:Boolean;

        public function PopularRoomTagsData(_arg_1:IMessageDataWrapper)
        {
            var _local_3:int;
            super();
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _tags.push(new PopularTagData(_arg_1));
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
            this._tags = null;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get tags():Array
        {
            return (_tags);
        }


    }
}

