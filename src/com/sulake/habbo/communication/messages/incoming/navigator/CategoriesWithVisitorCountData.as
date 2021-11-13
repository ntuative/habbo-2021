package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.utils.Map;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class CategoriesWithVisitorCountData implements IDisposable, _SafeStr_78 
    {

        private var _categoryToCurrentUserCountMap:Map = new Map();
        private var _categoryToMaxUserCountMap:Map = new Map();
        private var _disposed:Boolean;

        public function CategoriesWithVisitorCountData(_arg_1:IMessageDataWrapper)
        {
            var _local_5:int;
            var _local_6:int;
            var _local_3:int;
            var _local_2:int;
            super();
            var _local_4:int = _arg_1.readInteger();
            _local_5 = 0;
            while (_local_5 < _local_4)
            {
                _local_6 = _arg_1.readInteger();
                _local_3 = _arg_1.readInteger();
                _local_2 = _arg_1.readInteger();
                _categoryToCurrentUserCountMap.add(_local_6, _local_3);
                _categoryToMaxUserCountMap.add(_local_6, _local_2);
                _local_5++;
            };
        }

        public function dispose():void
        {
            if (_disposed)
            {
                return;
            };
            _disposed = true;
            this._categoryToCurrentUserCountMap = null;
            this._categoryToMaxUserCountMap = null;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get categoryToCurrentUserCountMap():Map
        {
            return (_categoryToCurrentUserCountMap);
        }

        public function get categoryToMaxUserCountMap():Map
        {
            return (_categoryToMaxUserCountMap);
        }


    }
}

